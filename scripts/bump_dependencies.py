#!/usr/bin/env python3

import os
import re
import sys
import json
import logging
import semver
import subprocess
from datetime import datetime
from ruamel.yaml import YAML

logging.basicConfig(level=logging.INFO, format='%(levelname)s: %(message)s')
logger = logging.getLogger(__name__)

yaml = YAML()
yaml.preserve_quotes = True
yaml.indent(mapping=2, sequence=4, offset=2)
yaml.width = 120

class HelmChartUpdater:
    def __init__(self, dry_run=False, skip_pr=True, update_values=True):
        self.dry_run = dry_run
        self.skip_pr = skip_pr
        self.update_values = update_values
        self.chart_updates = []
        self.repo_cache = {}
        self.branch_name = f"chore/bump-helm-deps-{datetime.now().strftime('%Y-%m-%d')}"
        logger.info(f"Running with: dry_run={dry_run}, skip_pr={skip_pr}, update_values={update_values}")
        
    def run_command(self, cmd, cwd=None):
        try:
            result = subprocess.run(cmd, cwd=cwd, check=True, capture_output=True, text=True, shell=isinstance(cmd, str))
            return result.stdout.strip()
        except subprocess.CalledProcessError as e:
            logger.error(f"Command failed: {cmd}\nError: {e.stderr}")
            return None
    
    # STEP 1: Add Helm repository and cache it
    def add_helm_repo(self, repo_url):
        if repo_url in self.repo_cache:
            return self.repo_cache[repo_url]
        
        clean_url = repo_url.replace('https://', '').replace('http://', '').rstrip('/')
        repo_name = clean_url.split('/')[0].replace('.', '-').lower()
        
        logger.info(f"Adding Helm repo {repo_name}: {repo_url}")
        if self.run_command(f"helm repo add {repo_name} {repo_url} --force-update"):
            self.run_command("helm repo update")
            self.repo_cache[repo_url] = repo_name
            return repo_name
        return None
    
    # STEP 2: Get latest version of a chart
    def get_latest_version(self, repo_name, chart_name):
        result = self.run_command(f"helm search repo {repo_name}/{chart_name} -o json")
        if not result: return None
        
        try:
            search_results = json.loads(result)
            return search_results[0]['version'] if search_results else None
        except (json.JSONDecodeError, IndexError, KeyError) as e:
            logger.error(f"Error parsing helm search results: {e}")
            return None
    
    # STEP 3: Main chart update processing
    def update_single_chart(self, chart_path):
        chart_yaml_path = os.path.join(chart_path, 'Chart.yaml')
        if not os.path.exists(chart_yaml_path): return False
        
        with open(chart_yaml_path) as f:
            chart_data = yaml.load(f)
        
        if 'dependencies' not in chart_data: return False
        
        chart_name = os.path.basename(chart_path)
        logger.info(f"Checking dependencies for {chart_name}")
        chart_updated, updated_deps = self._check_and_update_dependencies(chart_data, chart_name)
        
        if chart_updated and not self.dry_run:
            self._bump_chart_version(chart_data, chart_name)
            self._save_chart_yaml(chart_data, chart_yaml_path, chart_name)
            self._update_chart_dependencies(chart_path, chart_name)
            
            if self.update_values and updated_deps:
                self._update_dependency_values(chart_path, updated_deps)
            self._run_chart_tools(chart_path, chart_name)
        return chart_updated

    # STEP 4: Check and update each dependency
    def _check_and_update_dependencies(self, chart_data, chart_name):
        chart_updated = False
        updated_deps = []
        
        for dep in chart_data['dependencies']:
            name = dep['name']
            current_version = dep['version']
            repo_url = dep['repository']
            alias = dep.get('alias', name)
            
            repo_name = self.add_helm_repo(repo_url)
            if not repo_name: continue
                
            latest_version = self.get_latest_version(repo_name, name)
            if not latest_version:
                logger.warning(f"Could not find latest version for {name}")
                continue
            
            try:
                compare_current = current_version.lstrip('v')
                compare_latest = latest_version.lstrip('v')
                
                if semver.compare(compare_latest, compare_current) > 0:
                    logger.info(f"Update available for {name}: {current_version} → {latest_version}")
                    
                    if not self.dry_run:
                        dep['version'] = latest_version
                        chart_updated = True
                        self.chart_updates.append({
                            'chart': chart_name,
                            'dependency': name,
                            'from_version': current_version,
                            'to_version': latest_version
                        })
                        updated_deps.append({
                            'name': name,
                            'alias': alias,
                            'version': latest_version,
                            'repo_name': repo_name
                        })
                    else:
                        logger.info(f"DRY RUN: Would update {name} from {current_version} to {latest_version}")
            except ValueError:
                logger.warning(f"Invalid semver comparison: {current_version} vs {latest_version}")
        return chart_updated, updated_deps

    # STEP 5: Bump chart version
    def _bump_chart_version(self, chart_data, chart_name):
        if 'version' not in chart_data: return
            
        current_version = chart_data['version']
        version_parts = current_version.split('.')
        
        if len(version_parts) >= 3:
            try:
                patch = int(version_parts[-1])
                version_parts[-1] = str(patch + 1)
                new_version = '.'.join(version_parts)
                chart_data['version'] = new_version
                logger.info(f"Bumped chart version: {current_version} → {new_version}")
            except ValueError:
                logger.warning(f"Could not bump version for {chart_name}: non-numeric patch")

    # STEP 6: Update values.yaml with upstream defaults
    def _update_dependency_values(self, chart_path, updated_deps):
        values_path = os.path.join(chart_path, 'values.yaml')
        
        if not os.path.exists(values_path):
            with open(values_path, 'w') as f:
                f.write("# Default values\n")
        
        try:
            with open(values_path, 'r') as f:
                original_content = f.read()
            
            with open(values_path, 'r') as f:
                values_data = yaml.load(f) or {}
                
            for dep in updated_deps:
                formatted_values = self._get_upstream_values(dep['repo_name'], dep['name'], dep['version'], dep['alias'])
                if not formatted_values: continue
                    
                merged_content = original_content
                try:
                    alias_pattern = re.compile(f"^{re.escape(dep['alias'])}:.*?(?=^\\S|$)", re.DOTALL | re.MULTILINE)
                    replacement = f"{dep['alias']}:\n{formatted_values}"
                    merged_content = alias_pattern.sub(lambda m: replacement, merged_content)
                except Exception:
                    lines = original_content.split('\n')
                    alias_found = False
                    alias_start = -1
                    alias_end = -1
                    
                    for i, line in enumerate(lines):
                        if line.strip() == f"{dep['alias']}:" and not alias_found:
                            alias_start = i
                            alias_found = True
                        elif alias_found and line and not line.startswith(' ') and alias_end == -1:
                            alias_end = i
                            break
                    
                    if alias_found and alias_end == -1:
                        alias_end = len(lines)
                    
                    if alias_found:
                        new_lines = lines[:alias_start] + [f"{dep['alias']}:"] + formatted_values.split('\n') + lines[alias_end:]
                        merged_content = '\n'.join(new_lines)
                    else:
                        merged_content += f"\n{dep['alias']}:\n{formatted_values}"
                
                with open(values_path, 'w') as f:
                    f.write(merged_content)
                logger.info(f"Updated values for {dep['alias']}")
            
        except Exception as e:
            logger.error(f"Error updating values.yaml: {str(e)}")

    def _get_upstream_values(self, repo_name, chart_name, version, alias):
        try:
            output = self.run_command(f"helm show values {repo_name}/{chart_name} --version {version}")
            if not output: return ""
            return '\n'.join([f"  {line}" for line in output.split('\n') if line.strip() or output.split('\n').index(line) > 0])
        except Exception as e:
            logger.error(f"Error formatting upstream values for {chart_name}: {str(e)}")
            return ""

    def _save_chart_yaml(self, chart_data, chart_path, chart_name):
        with open(chart_path, 'w') as f:
            yaml.dump(chart_data, f)
        logger.info(f"Updated Chart.yaml for {chart_name}")
    
    def _update_chart_dependencies(self, chart_path, chart_name):
        logger.info(f"Running helm dependency update for {chart_name}")
        if self.run_command("helm dependency update", cwd=chart_path):
            logger.info(f"Successfully updated dependencies for {chart_name}")
    
    def _run_chart_tools(self, chart_path, chart_name):
        self._run_fix_lint(chart_path, chart_name)
        self._run_helm_docs(chart_path, chart_name)
    
    def _run_fix_lint(self, chart_path, chart_name):
        fix_lint_script = "./scripts/fix-lint.sh"
        if os.path.exists(fix_lint_script):
            pattern = f"{chart_path}/*.yaml"
            if self.run_command(f"bash {fix_lint_script} --auto --pattern '{pattern}'"):
                logger.info(f"Linting completed for {chart_name}")

    def _run_helm_docs(self, chart_path, chart_name):
        logger.info(f"Running helm-docs for {chart_name}")        
        if self.run_command("helm-docs", cwd=chart_path):
            readme_path = os.path.join(chart_path, "README.md")
            if os.path.exists(readme_path):
                logger.info(f"README.md exists at {readme_path}")
            else:
                logger.warning(f"README.md was not created at {readme_path}")
    
    def generate_pr_body(self):
        """Generate a detailed PR body with tables showing version changes."""
        if not self.chart_updates:
            return None
        chart_updates = {}
        for update in self.chart_updates:
            chart_name = update['chart']
            if chart_name not in chart_updates:
                chart_updates[chart_name] = []
            chart_updates[chart_name].append(update)
        try:
            remote_url = self.run_command("git config --get remote.origin.url")
            if remote_url:
                if remote_url.startswith('git@github.com:'):
                    remote_url = remote_url.replace('git@github.com:', 'https://github.com/')
                if remote_url.endswith('.git'):
                    remote_url = remote_url[:-4]
            else:
                remote_url = "https://github.com/edixos/ekp-helm"
        except Exception:
            remote_url = "https://github.com/edixos/ekp-helm"

        pr_body = "## Automated Helm Chart Dependency Updates\n\n"
        pr_body += "This PR was automatically generated to update Helm chart dependencies to their latest versions.\n\n"
        pr_body += "### Updated Charts\n\n"

        for chart_name, updates in chart_updates.items():
            pr_body += f"#### {chart_name}\n\n"
            pr_body += "| Dependency | Previous Version | New Version | Commit |\n"
            pr_body += "|------------|-----------------|------------|--------|\n"

            commit_hash = self.run_command(f"git log -n 1 --pretty=format:%H -- charts/{chart_name}")            
            for update in updates:
                dep_name = update['dependency']
                from_ver = update['from_version']
                to_ver = update['to_version']
                if commit_hash:
                    commit_short = commit_hash[:7]
                    commit_url = f"{remote_url}/commit/{commit_hash}"
                    pr_body += f"| {dep_name} | {from_ver} | {to_ver} | [{commit_short}]({commit_url}) |\n"
                else:
                    pr_body += f"| {dep_name} | {from_ver} | {to_ver} | - |\n"
            pr_body += "\n"
        pr_body += "Auto-generated by the [Auto Bump Helm Dependencies](.github/workflows/auto-bump-helm-deps.yml) workflow."
        return pr_body

    # STEP 7: Process all charts in directory
    def process_all_charts(self):
        charts_dir = "./charts"
        if not os.path.exists(charts_dir):
            logger.error("Charts directory not found")
            return False
        
        updates_found = False
        for chart_name in os.listdir(charts_dir):
            chart_path = os.path.join(charts_dir, chart_name)
            if os.path.isdir(chart_path) and self.update_single_chart(chart_path):
                updates_found = True
        return updates_found
    
    # STEP 8: Handle Git operations
    def create_git_changes(self, updates_found):
        if not updates_found or self.dry_run:
            logger.info("Skipping git operations")
            return False
        
        self._setup_git_config()
        if not self._create_branch(): return False
        
        if self._commit_changes() and self._push_branch():
            logger.info(f"Successfully pushed branch {self.branch_name}")
            return True
        return False
    
    def _setup_git_config(self):
        self.run_command('git config --global user.name "GitHub Actions"')
        self.run_command('git config --global user.email "actions@github.com"')
    
    def _create_branch(self):
        self.run_command('git checkout main')
        return self.run_command(f'git checkout -b {self.branch_name}') is not None
    
    def _commit_changes(self):
        if not self.chart_updates: return False
        chart_updates = {}
        for update in self.chart_updates:
            chart_name = update['chart']
            if chart_name not in chart_updates:
                chart_updates[chart_name] = []
            chart_updates[chart_name].append(update)
        charts_dir = "./charts"
        all_commits_succeeded = True
        # Create a commit for each chart
        for chart_name, updates in chart_updates.items():
            chart_path = os.path.join(charts_dir, chart_name)
            for filename in ["Chart.yaml", "values.yaml", "README.md"]:
                filepath = os.path.join(chart_path, filename)
                if os.path.exists(filepath): self.run_command(f'git add {filepath}')
            dep_dir = os.path.join(chart_path, "charts")
            if os.path.isdir(dep_dir): self.run_command(f'git add {dep_dir}')
            lock_file = os.path.join(chart_path, "Chart.lock")
            if os.path.exists(lock_file): self.run_command(f'git add {lock_file}')
            # Create chart-specific commit message
            deps = [f"{u['dependency']} ({u['from_version']} → {u['to_version']})" for u in updates]
            commit_msg = f"chore(helm): update {chart_name} dependencies\n\nUpdates: {', '.join(deps)}"
            # Commit changes for this chart
            if self.run_command(f'git commit -m "{commit_msg}"') is None:
                all_commits_succeeded = False

        return all_commits_succeeded

    def _push_branch(self):
        return self.run_command(f'git push -u origin {self.branch_name}') is not None

def main():
    dry_run = os.getenv('DRY_RUN', 'false').lower() == 'true'
    skip_pr = os.getenv('SKIP_PR', 'true').lower() == 'true'
    update_values = os.getenv('UPDATE_VALUES', 'true').lower() == 'true'
    
    updater = HelmChartUpdater(dry_run, skip_pr, update_values)
    updates_found = updater.process_all_charts()
    
    if updates_found:
        updater.create_git_changes(updates_found)
        pr_body = updater.generate_pr_body()
    else:
        pr_body = None
    
    if 'GITHUB_OUTPUT' in os.environ:
        with open(os.environ['GITHUB_OUTPUT'], 'a') as f:
            f.write(f"updated={str(updates_found).lower()}\n")
            if updates_found:
                f.write(f"commit_message=chore: update helm dependencies\n")
                f.write(f"branch={updater.branch_name}\n")
                if pr_body:
                    escaped_body = pr_body.replace('%', '%25').replace('\n', '%0A').replace('\r', '%0D')
                    f.write(f"pr_body={escaped_body}\n")

if __name__ == "__main__":
    main()
