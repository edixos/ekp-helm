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

# Setup logging with clear formatting
logging.basicConfig(level=logging.INFO, format='%(levelname)s: %(message)s')
logger = logging.getLogger(__name__)

# Initialize YAML handler that preserves comments
yaml = YAML()
yaml.preserve_quotes = True
yaml.indent(mapping=2, sequence=4, offset=2)
yaml.width = 120

class HelmChartUpdater:
    """Updates Helm chart dependencies to their latest versions."""
    
    def __init__(self, dry_run=False, skip_pr=True, update_values=True):
        """Initialize with configuration options."""
        self.dry_run = dry_run
        self.skip_pr = skip_pr
        self.update_values = update_values
        self.chart_updates = []
        self.repo_cache = {}
        self.branch_name = os.getenv('BRANCH_NAME', f"chore/bump-helm-deps-{datetime.now().strftime('%Y-%m-%d')}")
        
        logger.info(f"Running with: dry_run={dry_run}, skip_pr={skip_pr}, update_values={update_values}")
        
    def run_command(self, cmd, cwd=None):
        """Execute a shell command and return its output."""
        try:
            result = subprocess.run(
                cmd, cwd=cwd, check=True, capture_output=True, 
                text=True, shell=isinstance(cmd, str)
            )
            return result.stdout.strip()
        except subprocess.CalledProcessError as e:
            logger.error(f"Command failed: {cmd}")
            logger.error(f"Error: {e.stderr}")
            return None
    
    def add_helm_repo(self, repo_url):
        """Add a Helm repository and return its name."""
        # Return cached repo name if available
        if repo_url in self.repo_cache:
            return self.repo_cache[repo_url]
        
        # Generate a unique, valid repo name from the URL
        clean_url = repo_url.replace('https://', '').replace('http://', '').rstrip('/')
        repo_name = clean_url.split('/')[0].replace('.', '-').lower()
        
        # Add repo and update index
        logger.info(f"Adding Helm repo {repo_name}: {repo_url}")
        if self.run_command(f"helm repo add {repo_name} {repo_url} --force-update"):
            self.run_command("helm repo update")
            self.repo_cache[repo_url] = repo_name
            return repo_name
        
        return None
    
    def get_latest_version(self, repo_name, chart_name):
        """Get latest version of a chart from a repository."""
        result = self.run_command(f"helm search repo {repo_name}/{chart_name} -o json")
        if not result:
            return None
        
        try:
            search_results = json.loads(result)
            return search_results[0]['version'] if search_results else None
        except (json.JSONDecodeError, IndexError, KeyError) as e:
            logger.error(f"Error parsing helm search results: {e}")
            return None
    
    def update_single_chart(self, chart_path):
        """Update dependencies for a single chart."""
        chart_yaml_path = os.path.join(chart_path, 'Chart.yaml')
        if not os.path.exists(chart_yaml_path):
            return False
        
        # Load chart data
        with open(chart_yaml_path) as f:
            chart_data = yaml.load(f)
        
        if 'dependencies' not in chart_data:
            return False
        
        chart_name = os.path.basename(chart_path)
        logger.info(f"Checking dependencies for {chart_name}")
        chart_updated, updated_deps = self._check_and_update_dependencies(chart_data, chart_name)
        
        # Apply changes if updates were found
        if chart_updated and not self.dry_run:
            self._bump_chart_version(chart_data, chart_name)
            self._save_chart_yaml(chart_data, chart_yaml_path, chart_name)
            self._update_chart_dependencies(chart_path, chart_name)
            
            # Update default values from upstream for updated dependencies
            if self.update_values and updated_deps:
                self._update_dependency_values(chart_path, updated_deps)
                
            self._run_chart_tools(chart_path, chart_name)
        
        return chart_updated

    def _check_and_update_dependencies(self, chart_data, chart_name):
        """Check for dependency updates and apply them if needed."""
        chart_updated = False
        updated_deps = []
        
        for dep in chart_data['dependencies']:
            name = dep['name']
            current_version = dep['version']
            repo_url = dep['repository']
            alias = dep.get('alias', name)  # Get alias if available, otherwise use name
            
            # Get repo and latest version
            repo_name = self.add_helm_repo(repo_url)
            if not repo_name:
                continue
                
            latest_version = self.get_latest_version(repo_name, name)
            if not latest_version:
                logger.warning(f"Could not find latest version for {name}")
                continue
            
            # Compare versions
            try:
                # Handle v-prefixed versions
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

    def _bump_chart_version(self, chart_data, chart_name):
        """Increment chart version by 0.0.1."""
        if 'version' not in chart_data:
            return
            
        current_version = chart_data['version']
        version_parts = current_version.split('.')
        
        # Only bump if we have a proper semver
        if len(version_parts) >= 3:
            try:
                patch = int(version_parts[-1])
                version_parts[-1] = str(patch + 1)
                new_version = '.'.join(version_parts)
                chart_data['version'] = new_version
                logger.info(f"Bumped chart version: {current_version} → {new_version}")
            except ValueError:
                logger.warning(f"Could not bump version for {chart_name}: non-numeric patch")

    def _update_dependency_values(self, chart_path, updated_deps):
        """Update values.yaml with upstream default values for updated dependencies."""
        values_path = os.path.join(chart_path, 'values.yaml')
        
        # Create values file if it doesn't exist
        if not os.path.exists(values_path):
            logger.info(f"Creating values.yaml for {os.path.basename(chart_path)}")
            with open(values_path, 'w') as f:
                f.write("# Default values\n")
        
        try:
            # First, read the file as text to preserve exact formatting
            with open(values_path, 'r') as f:
                original_content = f.read()
            
            # Load existing values while preserving comments
            with open(values_path, 'r') as f:
                values_data = yaml.load(f) or {}
                
            # Process each dependency
            for dep in updated_deps:
                name = dep['name']
                alias = dep['alias']
                version = dep['version']
                repo_name = dep['repo_name']
                
                logger.info(f"Updating default values for {name} (alias: {alias}) to version {version}")
                
                # Get upstream values as formatted text
                formatted_values = self._get_upstream_values(repo_name, name, version, alias)
                if not formatted_values:
                    continue
                    
                # More robust method to handle special regex characters in the values
                merged_content = original_content
                
                try:
                    # Find and replace the alias section
                    if alias in values_data:
                        # Use a literal string pattern to find the alias section
                        import re
                        alias_pattern = re.compile(f"^{re.escape(alias)}:.*?(?=^\\S|$)", re.DOTALL | re.MULTILINE)
                        
                        # Use a raw string for the replacement to avoid escape sequence issues
                        replacement = f"{alias}:\n{formatted_values}"
                        
                        # Handle potential regex escape sequences in the replacement
                        merged_content = alias_pattern.sub(lambda m: replacement, merged_content)
                    else:
                        # If the alias doesn't exist, append it to the end
                        merged_content += f"\n{alias}:\n{formatted_values}"
                    
                except Exception as e:
                    logger.error(f"Error in regex replacement for {alias}: {str(e)}")
                    logger.error("Falling back to manual section replacement")
                    
                    # If regex fails, fall back to a manual search/replace approach
                    lines = original_content.split('\n')
                    alias_found = False
                    alias_start = -1
                    alias_end = -1
                    
                    # Find the start and end of the alias section
                    for i, line in enumerate(lines):
                        if line.strip() == f"{alias}:" and not alias_found:
                            alias_start = i
                            alias_found = True
                        elif alias_found and line and not line.startswith(' ') and alias_end == -1:
                            alias_end = i
                            break
                    
                    # Handle the case where the alias section is at the end of the file
                    if alias_found and alias_end == -1:
                        alias_end = len(lines)
                    
                    if alias_found:
                        # Replace the section
                        new_lines = lines[:alias_start] + [f"{alias}:"] + formatted_values.split('\n') + lines[alias_end:]
                        merged_content = '\n'.join(new_lines)
                    else:
                        # Append to the end
                        merged_content += f"\n{alias}:\n{formatted_values}"
                
                # Write the merged content back
                with open(values_path, 'w') as f:
                    f.write(merged_content)
                
                logger.info(f"Updated values for {alias}")
            
            logger.info(f"Updated values.yaml with default values from dependencies")
        
        except Exception as e:
            logger.error(f"Error updating values.yaml: {str(e)}")
            logger.error(f"Exception details: {type(e).__name__}")
            import traceback
            logger.error(traceback.format_exc())

    def _get_upstream_values(self, repo_name, chart_name, version, alias):
        """Get properly formatted upstream values with correct indentation."""
        try:
            # Get raw upstream values
            output = self.run_command(f"helm show values {repo_name}/{chart_name} --version {version}")
            if not output:
                return ""
                
            # Process the output line by line to indent properly
            formatted_lines = []
            for line in output.split('\n'):
                # Skip empty lines at the beginning
                if not line.strip() and not formatted_lines:
                    continue
                # Add two spaces at the beginning of each line for proper indentation
                formatted_lines.append(f"  {line}")
            
            return '\n'.join(formatted_lines)
        
        except Exception as e:
            logger.error(f"Error formatting upstream values for {chart_name}: {str(e)}")
            return ""

    def _save_chart_yaml(self, chart_data, chart_path, chart_name):
        """Save updated Chart.yaml file while preserving comments."""
        with open(chart_path, 'w') as f:
            yaml.dump(chart_data, f)
        logger.info(f"Updated Chart.yaml for {chart_name}")
    
    def _update_chart_dependencies(self, chart_path, chart_name):
        """Run helm dependency update for a chart."""
        logger.info(f"Running helm dependency update for {chart_name}")
        result = self.run_command("helm dependency update", cwd=chart_path)
        if result:
            logger.info(f"Successfully updated dependencies for {chart_name}")
    
    def _run_chart_tools(self, chart_path, chart_name):
        """Run additional tools (fix-lint and helm-docs) for a chart."""
        self._run_fix_lint(chart_path, chart_name)
        self._run_helm_docs(chart_path, chart_name)
    
    def _run_fix_lint(self, chart_path, chart_name):
        """Run fix-lint.sh script for a chart."""
        fix_lint_script = "./scripts/fix-lint.sh"
        if not os.path.exists(fix_lint_script):
            return
            
        logger.info(f"Running fix-lint for {chart_name}")
        pattern = f"{chart_path}/*.yaml"
        if self.run_command(f"bash {fix_lint_script} --auto --pattern '{pattern}'"):
            logger.info(f"Linting completed for {chart_name}")

    def _run_helm_docs(self, chart_path, chart_name):
        """Generate documentation for a chart."""
        logger.info(f"Running helm-docs for {chart_name}")        
        result = self.run_command("helm-docs", cwd=chart_path)
        if result:
            logger.info(f"Documentation updated for {chart_name}")
            # Verify README.md was actually updated
            readme_path = os.path.join(chart_path, "README.md")
            if os.path.exists(readme_path):
                logger.info(f"README.md exists at {readme_path}")
            else:
                logger.warning(f"README.md was not created at {readme_path}")
            return True
        else:
            logger.error(f"Failed to update documentation for {chart_name}")
            return False
    
    def process_all_charts(self):
        """Process all charts in the repository."""
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
    
    def create_git_changes(self, updates_found):
        """Create git branch, commit and push changes."""
        if not updates_found or self.dry_run:
            logger.info("Skipping git operations (no updates or dry run)")
            return False
        
        # Setup git and create branch
        self._setup_git_config()
        if not self._create_branch():
            return False
        
        # Commit and push changes
        if self._commit_changes() and self._push_branch():
            logger.info(f"Successfully created and pushed branch {self.branch_name}")
            return True
            
        return False
    
    def _setup_git_config(self):
        """Configure Git user for commits."""
        logger.info("Setting up Git configuration")
        self.run_command('git config --global user.name "GitHub Actions"')
        self.run_command('git config --global user.email "actions@github.com"')
    
    def _create_branch(self):
        """Create and checkout a new branch."""
        logger.info(f"Creating branch: {self.branch_name}")
        self.run_command('git checkout main')
        return self.run_command(f'git checkout -b {self.branch_name}') is not None
    
    def _commit_changes(self):
        """Commit all changes with a descriptive message."""
        if not self.chart_updates:
            return False
        
        # Create a concise summary of changes
        updates = [f"{u['dependency']} ({u['from_version']} → {u['to_version']})" 
                for u in self.chart_updates[:5]]
        summary = ", ".join(updates)
        
        if len(self.chart_updates) > 5:
            summary += f" and {len(self.chart_updates) - 5} more"

        # Explicitly add only the expected modified files/dirs within charts
        logger.info("Staging specific changes...")
        charts_dir = "./charts" 
        changed_charts = set(u['chart'] for u in self.chart_updates)

        for chart_name in changed_charts:
            chart_path = os.path.join(charts_dir, chart_name)
            # Add Chart.yaml, values.yaml, README.md if they exist and were potentially modified
            for filename in ["Chart.yaml", "values.yaml", "README.md"]:
                 filepath = os.path.join(chart_path, filename)
                 if os.path.exists(filepath):
                     self.run_command(f'git add {filepath}')
            # Add the charts directory containing downloaded dependencies
            dep_dir = os.path.join(chart_path, "charts")
            if os.path.isdir(dep_dir):
                 self.run_command(f'git add {dep_dir}')
            # Add Chart.lock if it exists
            lock_file = os.path.join(chart_path, "Chart.lock")
            if os.path.exists(lock_file):
                self.run_command(f'git add {lock_file}')

        # Optional: Add a check for staged files before committing
        status_output = self.run_command('git status --porcelain')
        if not status_output:
            logger.warning("No changes were staged. Skipping commit.")
            return False
        logger.info(f"Staged files:\n{status_output}")

        # Commit changes
        commit_msg = f"chore: update helm dependencies\n\nUpdates: {summary}"
        logger.info(f"Committing changes")
        return self.run_command(f'git commit -m "{commit_msg}"') is not None
    
    def _push_branch(self):
        """Push the branch to the remote repository."""
        logger.info(f"Pushing branch {self.branch_name}")
        return self.run_command(f'git push -u origin {self.branch_name}') is not None

def main():
    """Main entry point."""
    # Parse environment variables
    dry_run = os.getenv('DRY_RUN', 'false').lower() == 'true'
    skip_pr = os.getenv('SKIP_PR', 'true').lower() == 'true'
    update_values = os.getenv('UPDATE_VALUES', 'true').lower() == 'true'
    
    # Run the update process
    updater = HelmChartUpdater(dry_run, skip_pr, update_values)
    updates_found = updater.process_all_charts()
    
    # Handle git operations and set GitHub outputs
    if updates_found:
        updater.create_git_changes(updates_found)
    
    # Set GitHub Actions outputs
    if 'GITHUB_OUTPUT' in os.environ:
        with open(os.environ['GITHUB_OUTPUT'], 'a') as f:
            f.write(f"updated={str(updates_found).lower()}\n")
            if updates_found:
                f.write(f"commit_message=chore: update helm dependencies\n")

if __name__ == "__main__":
    main()
