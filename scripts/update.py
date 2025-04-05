#!/usr/bin/env python3
import sys
import yaml
import subprocess
from datetime import datetime
from pathlib import Path


def run_command(cmd):
    """Run a command and return stdout as a string, or raise an exception."""
    return subprocess.check_output(cmd, universal_newlines=True).strip()


def get_latest_chart_version(helm_repo_name, chart_name):
    """
    Run "helm show chart <helm_repo_name>/<chart_name>" to get the upstream chart info.
    Return the version string.
    """
    try:
        output = run_command(["helm", "show", "chart", f"{helm_repo_name}/{chart_name}"])
        chart_info = yaml.safe_load(output)
        return chart_info.get("version")
    except Exception as e:
        print(f"Error fetching chart info for {helm_repo_name}/{chart_name}: {e}")
        return None


def get_default_values(helm_repo_name, chart_name, version):
    """
    Run "helm show values <helm_repo_name>/<chart_name> --version <version>" to get default values.
    Return a dict.
    """
    try:
        output = run_command(["helm", "show", "values", f"{helm_repo_name}/{chart_name}", "--version", version])
        return yaml.safe_load(output)
    except Exception as e:
        print(f"Error fetching default values for {helm_repo_name}/{chart_name} version {version}: {e}")
        return None


def get_helm_repo_name(repo_url):
    """
    Look up the helm repository name (as added locally) that matches the given repository URL.
    This function reads the output of 'helm repo list --output yaml' and returns the repo name
    whose URL (after stripping trailing slashes) matches the provided repo_url.
    """
    try:
        output = run_command(["helm", "repo", "list", "--output", "yaml"])
        repos = yaml.safe_load(output)
        repo_url = repo_url.rstrip("/")
        for repo in repos:
            if repo.get("url", "").rstrip("/") == repo_url:
                return repo.get("name")
        print(f"Could not find a helm repo with URL '{repo_url}'.")
        return None
    except Exception as e:
        print(f"Error fetching helm repo list: {e}")
        return None


def update_chart(chart_dir: Path):
    chart_yaml_path = chart_dir / "Chart.yaml"
    values_yaml_path = chart_dir / "values.yaml"

    with chart_yaml_path.open("r") as f:
        chart_yaml = yaml.safe_load(f)

    updated = False
    dependencies = chart_yaml.get("dependencies", [])
    for dep in dependencies:
        dep_name = dep.get("name")
        current_version = dep.get("version")
        repo_url = dep.get("repository")
        # Use the alias if provided; otherwise, use the dependency name.
        dep_alias = dep.get("alias", dep_name)
        if not repo_url:
            print(f"Skipping dependency {dep_name} because repository URL is missing.")
            continue

        helm_repo_name = get_helm_repo_name(repo_url)
        if not helm_repo_name:
            print(f"Skipping dependency {dep_name} because no matching helm repo was found for URL {repo_url}.")
            continue

        print(f"Checking dependency {dep_name} (helm repo: {helm_repo_name}) ...")
        latest_version = get_latest_chart_version(helm_repo_name, dep_name)
        if not latest_version:
            print(f"Could not get latest version for {dep_name}. Skipping.")
            continue

        if latest_version != current_version:
            print(f"Updating {dep_name}: {current_version} -> {latest_version}")
            dep["version"] = latest_version
            updated = True

            # Get upstream default values for the new version.
            new_defaults = get_default_values(helm_repo_name, dep_name, latest_version)
            if new_defaults is not None:
                # Load existing values.yaml if exists; otherwise, start with an empty dict.
                if values_yaml_path.exists():
                    with values_yaml_path.open("r") as vf:
                        values_yaml = yaml.safe_load(vf) or {}
                else:
                    values_yaml = {}

                # Update values.yaml under the key corresponding to the dependency alias.
                values_yaml[dep_alias] = new_defaults

                # Write updated values.yaml.
                with values_yaml_path.open("w") as vf:
                    yaml.dump(values_yaml, vf, default_flow_style=False)
            else:
                print(f"Warning: Could not update default values for {dep_name}")
        else:
            print(f"No update needed for dependency {dep_name} (version {current_version})")

    if updated:
        # Write back the updated Chart.yaml.
        with chart_yaml_path.open("w") as f:
            yaml.dump(chart_yaml, f, default_flow_style=False)
        print(f"Updated Chart.yaml in {chart_dir}")
    else:
        print(f"No dependency updates found in {chart_dir}")

    return updated


def process_all_charts(charts_dir: Path):
    charts_updated = False
    for chart in charts_dir.iterdir():
        if chart.is_dir() and (chart / "Chart.yaml").exists():
            print(f"\nProcessing chart: {chart.name}")
            if update_chart(chart):
                charts_updated = True
    return charts_updated


def run_fix_lint(repo_root: Path):
    fix_lint_path = repo_root / "scripts" / "fix-lint.sh"
    if not fix_lint_path.exists():
        print(f"Error: {fix_lint_path} does not exist.")
        sys.exit(1)
    try:
        print("Running fix-lint.sh ...")
        subprocess.run([str(fix_lint_path), "--auto", "--pattern", "*.yaml"], check=True)
    except subprocess.CalledProcessError as e:
        print("Error running fix-lint.sh:", e)
        sys.exit(1)


def run_helm_docs(repo_root: Path):
    charts_path = repo_root / "charts"
    try:
        print("Running helm-docs ...")
        subprocess.run(["helm-docs", str(charts_path)], check=True)
    except subprocess.CalledProcessError as e:
        print("Error running helm-docs:", e)
        sys.exit(1)


def commit_and_create_pr():
    try:
        status = subprocess.check_output(["git", "status", "--porcelain"], universal_newlines=True).strip()
        if status:
            branch = f"update-charts-{datetime.now().strftime('%Y%m%d')}"
            print(f"Creating branch: {branch}")
            subprocess.run(["git", "checkout", "-b", branch], check=True)
            subprocess.run(["git", "add", "."], check=True)
            subprocess.run(["git", "commit", "-m", "Automated update of chart dependencies and default values"],
                           check=True)
            subprocess.run(["git", "push", "origin", branch], check=True)
            subprocess.run(["gh", "pr", "create", "--title", "Automated Chart Dependency Update", "--body",
                            "This PR updates chart dependencies automatically."], check=True)
        else:
            print("No changes detected; no PR will be created.")
    except subprocess.CalledProcessError as e:
        print("Error committing changes or creating PR:", e)
        sys.exit(1)


def main():
    # Determine the repository root relative to this script.
    script_dir = Path(__file__).resolve().parent
    repo_root = script_dir.parent  # Assuming 'scripts' is a subdirectory of the repo root.
    charts_dir = repo_root / "charts"
    if not charts_dir.is_dir():
        print(f"Error: charts directory '{charts_dir}' not found.")
        sys.exit(1)
    print("Starting update process for charts in", charts_dir)
    updated = process_all_charts(charts_dir)
    if updated:
        print("Some charts were updated. Running post-update steps...")
        run_fix_lint(repo_root)
        run_helm_docs(repo_root)
        commit_and_create_pr()
    else:
        print("No updates were necessary.")


if __name__ == "__main__":
    main()