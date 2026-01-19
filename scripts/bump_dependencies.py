#!/usr/bin/env python3

import os
import re
import sys
import json
import logging
import requests
import semver
import subprocess
import textwrap
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
            
            if not self._run_chart_tools(chart_path, chart_name):
                logger.warning(f"Chart {chart_name} failed linting, will not be committed")
                return False
            
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
                lines = f.readlines()
            for dep in updated_deps:
                formatted_values = self._get_upstream_values(dep['repo_name'], dep['name'], dep['version'], dep['alias'])
                if not formatted_values: 
                    continue
                formatted_values = "\n".join(
                    line for line in formatted_values.splitlines()
                    if line.strip() not in ("---", "...")
                )
                alias = dep['alias']
                alias_line_index = -1
                end_index = -1
                indentation = None
                for i, line in enumerate(lines):
                    stripped_line = line.rstrip()
                    if stripped_line == f"{alias}:" or stripped_line.startswith(f"{alias}:"):
                        alias_line_index = i
                        if i+1 < len(lines) and lines[i+1].strip() and lines[i+1][0].isspace():
                            indentation = len(lines[i+1]) - len(lines[i+1].lstrip())
                        break                
                if alias_line_index >= 0 and indentation is not None:
                    end_index = len(lines)
                    for i in range(alias_line_index + 1, len(lines)):
                        if not lines[i].strip():
                            continue
                        if not lines[i].startswith(' ' * indentation):
                            end_index = i
                            break                
                new_content = []
                if alias_line_index >= 0:
                    new_content.extend(lines[:alias_line_index+1])
                    for value_line in formatted_values.split('\n'):
                        new_content.append(f"{value_line}\n")
                    new_content.extend(lines[end_index:])
                else:
                    new_content = lines
                    if new_content and new_content[-1].strip():
                        new_content.append('\n')
                    new_content.append(f"{alias}:\n")
                    for value_line in formatted_values.split('\n'):
                        new_content.append(f"{value_line}\n")                
                with open(values_path, 'w') as f:
                    f.writelines(new_content)                
                lines = new_content
                logger.info(f"Updated values for {dep['alias']}")
        except Exception as e:
            logger.error(f"Error updating values.yaml: {str(e)}")

    def _get_upstream_values(self, repo_name, chart_name, version, alias):
        try:
            output = self.run_command(f"helm show values {repo_name}/{chart_name} --version {version}")
            if not output: return ""
            lines = output.split('\n')
            formatted_lines = []
            start_idx = 1 if lines and not lines[0].strip() else 0
            for i, line in enumerate(lines[start_idx:], start=start_idx):
                if line.strip():
                    formatted_lines.append(f"  {line}")
                else:
                    formatted_lines.append("")
            return '\n'.join(formatted_lines)
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
        lint_success = self._run_helm_lint(chart_path, chart_name)        
        if not lint_success:
            return False
        prom_rules_success = self._check_prometheus_rules(chart_path, chart_name)
        if not prom_rules_success:
            return False
        prom_tests_success = self._test_prometheus_rules(chart_path, chart_name)
        if not prom_tests_success:
            return False
        pluto_success = self._run_pluto_check(chart_path, chart_name)
        if not pluto_success:
            return False        
        return True

    def _run_fix_lint(self, chart_path, chart_name):
        fix_lint_script = "./scripts/fix-lint.sh"

        if not os.path.exists(fix_lint_script):
            logger.warning("fix-lint.sh script not found")
            return

        files_to_fix = ["values.yaml", "Chart.yaml"]

        for filename in files_to_fix:
            file_path = os.path.join(chart_path, filename)

            if os.path.exists(file_path):
                if self.run_command(f"bash {fix_lint_script} {file_path}"):
                    logger.info(f"Fixed lint for {chart_name}/{filename}")
                else:
                    logger.warning(f"Failed to fix lint for {chart_name}/{filename}")
            else:
                logger.warning(f"No {filename} found for {chart_name}")

    def _run_helm_docs(self, chart_path, chart_name):
        logger.info(f"Running helm-docs for {chart_name}")        
        if self.run_command("helm-docs", cwd=chart_path):
            readme_path = os.path.join(chart_path, "README.md")
            if os.path.exists(readme_path):
                logger.info(f"README.md exists at {readme_path}")
            else:
                logger.warning(f"README.md was not created at {readme_path}")

    def _run_helm_lint(self, chart_path, chart_name):
        chart_dir = os.path.dirname(os.path.dirname(chart_path))
        rel_chart_path = os.path.relpath(chart_path, chart_dir)                
        global_ct_config = os.path.join(chart_dir, ".github/configs/ct.yaml")
        global_lint_config = os.path.join(chart_dir, ".github/configs/lintconf.yaml")
        local_ct_config = os.path.join(chart_path, "ct.yaml")        
        config_param = ""
        if os.path.exists(global_ct_config):
            config_param = f"--config {os.path.relpath(global_ct_config, chart_dir)}"
        elif os.path.exists(local_ct_config):
            config_param = f"--config {os.path.relpath(local_ct_config, chart_dir)}"        
        lint_param = ""
        if os.path.exists(global_lint_config):
            lint_param = f"--lint-conf {os.path.relpath(global_lint_config, chart_dir)}"        
        ct_cmd = f"ct lint --charts {rel_chart_path} {config_param} {lint_param}"
        try:
            result = subprocess.run(ct_cmd, cwd=chart_dir, check=True, 
                                capture_output=True, text=True, shell=isinstance(ct_cmd, str))
            logger.info(f"Linting completed for {chart_name}")
            return True
        except subprocess.CalledProcessError as e:
            error_message = e.stderr or e.stdout
            logger.warning(f"Linting failed for {chart_name}, skipping this chart")
            logger.warning(f"Error: {error_message}")            
            self.chart_updates = [update for update in self.chart_updates if update['chart'] != chart_name]            
            self.create_github_issue(chart_name, error_message)
            return False

    def _run_pluto_check(self, chart_path, chart_name):
        """Run Pluto to check for deprecated API versions"""
        logger.info(f"Running Pluto checks for {chart_name}")
        try:
            volume_name = f"pluto-{chart_name.replace('/', '-')}"            
            render_cmd = f"docker run --rm -v {os.path.abspath(chart_path)}:/apps -v {volume_name}:/pluto alpine/helm:3.17 template {chart_name} /apps -f /apps/tests/pluto/values.yaml --output-dir /pluto"
            result = self.run_command(render_cmd)
            if result is None:
                logger.warning(f"Helm template rendering failed for {chart_name}, skipping this chart")
                self.chart_updates = [update for update in self.chart_updates if update['chart'] != chart_name]
                try:
                    cmd_result = subprocess.run(render_cmd, shell=True, capture_output=True, text=True)
                    error_message = cmd_result.stderr or cmd_result.stdout
                except Exception:
                    error_message = "Failed to render Helm templates for Pluto check"
                self.create_github_issue(
                    chart_name,
                    f"Helm template rendering failed for Pluto check:\n\n```\n{error_message}\n```"
                )
                try:
                    self.run_command(f"docker volume rm {volume_name}")
                except:
                    pass
                
                return False                
            pluto_cmd = f"docker run --rm -v {volume_name}:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t \"k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0\" -o wide"
            result = subprocess.run(pluto_cmd, shell=True, check=True, capture_output=True, text=True)            
            self.run_command(f"docker volume rm {volume_name}")            
            if "Deprecated APIs:" in result.stdout and "No deprecated resource" not in result.stdout:
                logger.warning(f"Pluto found deprecated APIs in {chart_name}")                
                self.chart_updates = [update for update in self.chart_updates if update['chart'] != chart_name]                
                self.create_github_issue(
                    chart_name,
                    f"Pluto detected deprecated Kubernetes APIs:\n\n```\n{result.stdout}\n```"
                )
                return False
            logger.info(f"Pluto checks passed for {chart_name}")
            return True
        except subprocess.CalledProcessError as e:
            error_message = e.stderr or e.stdout
            logger.warning(f"Pluto checks failed for {chart_name}, skipping this chart")
            logger.warning(f"Error: {error_message}")            
            try:
                volume_name = f"pluto-{chart_name.replace('/', '-')}"
                self.run_command(f"docker volume rm {volume_name}")
            except:
                pass            
            self.chart_updates = [update for update in self.chart_updates if update['chart'] != chart_name]            
            self.create_github_issue(
                chart_name,
                f"Pluto checks failed:\n\n```\n{error_message}\n```"
            )
            return False

    def _check_prometheus_rules(self, chart_path, chart_name):
        """Check Prometheus rules for validity"""
        rules_dir = os.path.join(chart_path, "resources/prometheus-rules")
        if not os.path.exists(rules_dir) or not os.listdir(rules_dir):
            logger.info(f"No Prometheus rules found for {chart_name}, skipping check")
            return True
        logger.info(f"Checking Prometheus rules for {chart_name}")
        try:
            cmd = f"docker run --rm --entrypoint /bin/sh -v {os.path.abspath(chart_path)}:/workdir -w /workdir prom/prometheus -c -- \"promtool check rules resources/prometheus-rules/*\""
            result = subprocess.run(cmd, shell=True, check=True, capture_output=True, text=True)
            logger.info(f"Prometheus rules check passed for {chart_name}")
            return True
        except subprocess.CalledProcessError as e:
            error_message = e.stderr or e.stdout
            logger.warning(f"Prometheus rules check failed for {chart_name}, skipping this chart")
            logger.warning(f"Error: {error_message}")
            self.chart_updates = [update for update in self.chart_updates if update['chart'] != chart_name]            
            self.create_github_issue(
                chart_name, 
                f"Prometheus rules check failed:\n\n```\n{error_message}\n```"
            )
            return False

    def _test_prometheus_rules(self, chart_path, chart_name):
        """Run tests for Prometheus rules"""
        tests_dir = os.path.join(chart_path, "tests/prometheus")
        if not os.path.exists(tests_dir) or not os.listdir(tests_dir):
            logger.info(f"No Prometheus tests found for {chart_name}, skipping tests")
            return True
        logger.info(f"Testing Prometheus rules for {chart_name}")
        try:
            cmd = f"docker run --rm --entrypoint /bin/sh -v {os.path.abspath(chart_path)}:/workdir -w /workdir prom/prometheus -c -- \"promtool test rules tests/prometheus/*\""
            result = subprocess.run(cmd, shell=True, check=True, capture_output=True, text=True)
            logger.info(f"Prometheus tests passed for {chart_name}")
            return True
        except subprocess.CalledProcessError as e:
            error_message = e.stderr or e.stdout
            logger.warning(f"Prometheus tests failed for {chart_name}, skipping this chart")
            logger.warning(f"Error: {error_message}")            
            self.chart_updates = [update for update in self.chart_updates if update['chart'] != chart_name]            
            self.create_github_issue(
                chart_name, 
                f"Prometheus rule tests failed:\n\n```\n{error_message}\n```"
            )
            return False

    def create_github_issue(self, chart_name, error_message):
        """Create or update a GitHub issue for a chart that failed linting."""
        if self.dry_run:
            logger.info(f"DRY RUN: Would create/update GitHub issue for failed chart {chart_name}")
            return
        github_token = os.getenv('GH_TOKEN') or os.getenv('GITHUB_TOKEN')
        if not github_token:
            logger.error("Neither GH_TOKEN nor GITHUB_TOKEN environment variables are set, cannot create issue")
            return
        try:
            remote_url = self.run_command("git config --get remote.origin.url")
            if remote_url:
                if remote_url.startswith('git@github.com:'):
                    remote_url = remote_url.replace('git@github.com:', '')
                elif remote_url.startswith('https://github.com/'):
                    remote_url = remote_url.replace('https://github.com/', '')
                if remote_url.endswith('.git'):
                    remote_url = remote_url[:-4]  
                owner, repo = remote_url.split('/')
            else:
                owner = "edixos"
                repo = "ekp-helm"                
            headers = {
                "Authorization": f"token {github_token}",
                "Accept": "application/vnd.github.v3+json"
            }
            search_params = {
                "q": f"repo:{owner}/{repo} is:issue is:open in:title Chart linting failed: {chart_name}"
            }
            search_response = requests.get(
                "https://api.github.com/search/issues",
                headers=headers,
                params=search_params
            )
            search_response.raise_for_status()
            existing_issues = search_response.json().get("items", [])                
            title = f"Chart linting failed: {chart_name}"            
            body = textwrap.dedent(f"""
            ## Chart Linting Failed

            The Helm chart **{chart_name}** failed linting during the automated dependency update process.

            ### Error Details
            ```yaml
            {error_message}
            ```

            This issue was automatically created by the dependency update workflow.
            Please investigate and fix the issue to ensure the chart can be properly updated in the future.
            """).strip()
            
            comment_body = textwrap.dedent(f"""
            ### ⚠️ New Failure Detected on {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}

            ```yaml
            {error_message}
            ```

            The chart failed checking again in the latest automation run.
            """).strip()

            if existing_issues:
                issue = existing_issues[0]
                issue_number = issue["number"]
                issue_url = issue["html_url"]
                
                comment_url = f"https://api.github.com/repos/{owner}/{repo}/issues/{issue_number}/comments"
                requests.post(
                    comment_url,
                    headers=headers,
                    json={"body": comment_body}
                ).raise_for_status()
                logger.info(f"Updated existing issue #{issue_number}: {issue_url}")
            else:
                issue_url = f"https://api.github.com/repos/{owner}/{repo}/issues"
                response = requests.post(
                    issue_url,
                    headers=headers,
                    json={"title": title, "body": body}
                )
                response.raise_for_status()
                issue_data = response.json()
                logger.info(f"Created new issue #{issue_data['number']}: {issue_data['html_url']}")
        except Exception as e:
            logger.error(f"Failed to create/update GitHub issue: {str(e)}")
            return None

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
        current_branch = self.run_command('git branch --show-current')
        if current_branch == "main":
            return self.run_command(f'git checkout -b {self.branch_name}') is not None        
        self.run_command('git add -A')
        self.run_command('git stash')        
        self.run_command('git checkout main')
        result = self.run_command(f'git checkout -b {self.branch_name}') is not None        
        self.run_command('git stash pop')
        return result
    
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
        if os.path.exists('CHANGELOG.md'):
            os.remove('CHANGELOG.md')
        self.run_command('git rm -f --cached CHANGELOG.md 2>/dev/null || true')
        self.run_command('touch .gitignore')
        self.run_command('echo "CHANGELOG.md" >> .gitignore')
        self.run_command('git reset -- etc/')
        self.run_command('git checkout -- etc/ || true')
        for chart_name, updates in chart_updates.items():
            chart_path = os.path.join(charts_dir, chart_name)
            for filename in ["Chart.yaml", "values.yaml", "README.md"]:
                filepath = os.path.join(chart_path, filename)
                if os.path.exists(filepath): self.run_command(f'git add {filepath}')
            dep_dir = os.path.join(chart_path, "charts")
            if os.path.isdir(dep_dir): self.run_command(f'git add {dep_dir}')
            lock_file = os.path.join(chart_path, "Chart.lock")
            if os.path.exists(lock_file): self.run_command(f'git add {lock_file}')
            deps = [f"{u['dependency']} ({u['from_version']} → {u['to_version']})" for u in updates]
            commit_msg = f"chore(helm): update {chart_name} dependencies\n\nUpdates: {', '.join(deps)}"
            if self.run_command(f'git commit -m "{commit_msg}"') is None:
                all_commits_succeeded = False
        self.run_command("git checkout -- .gitignore || true")
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