#!/usr/bin/env bash
set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Configuration variables
CHART_UPDATES=()
DRY_RUN=${DRY_RUN:-false}          # Set to true to skip actual changes
SKIP_PR=${SKIP_PR:-true}          # Set to true to skip PR creation
VERBOSE=${VERBOSE:-true}          # Set to true for verbose output
UPDATE_VALUES=${UPDATE_VALUES:-true} # Set to false to skip updating values.yaml

log() {
  echo -e "${GREEN}[INFO]${NC} $1"
}

verbose() {
  if [[ "$VERBOSE" == "true" ]]; then
    echo -e "${CYAN}[DEBUG]${NC} $1"
  fi
}

warn() {
  echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
  echo -e "${RED}[ERROR]${NC} $1"
  return 1
}

# Find all Helm charts (including nested ones)
find_charts() {
  log "Finding all Helm charts in repository..."
  
  if [[ ! -d "./charts" ]]; then
    warn "No charts directory found in the repository"
    return 1
  fi
  
  # Find all Chart.yaml files and extract their directories
  find "./charts" -name "Chart.yaml" -type f | xargs -L1 dirname 2>/dev/null || echo ""
}

# Get helm repo name from URL with robust handling
get_helm_repo_name() {
  local repo_url=$1
  repo_url="${repo_url%/}"  # Remove trailing slash if any
  
  # Try to find an exact match first
  local repo_name
  repo_name=$(helm repo list -o json | jq -r --arg url "$repo_url" '.[] | select(.url == $url) | .name' 2>/dev/null)
  
  # If no exact match, try with trailing slash removed
  if [[ -z "$repo_name" ]]; then
    repo_name=$(helm repo list -o json | jq -r --arg url "$repo_url" '.[] | select(.url | rtrimstr("/") == $url) | .name' 2>/dev/null)
  fi
  
  # If still no match, try to extract a name from the URL
  if [[ -z "$repo_name" ]]; then
    # Try to extract a name from the URL
    local extracted_name
    extracted_name=$(echo "$repo_url" | awk -F/ '{print $3}' | awk -F. '{print $1}')
    if [[ -n "$extracted_name" ]]; then
      verbose "No repo found for $repo_url, using extracted name: $extracted_name"
      echo "$extracted_name"
      return
    fi
  fi
  
  echo "$repo_name"
}

# Better values.yaml update with preserving structure and comments
update_values_yaml() {
  local chart_dir=$1
  local name=$2
  local version=$3
  local repo_name=$4
  local alias=${5:-$name}  # Use alias if provided, otherwise use name
  
  if [[ "$UPDATE_VALUES" != "true" ]]; then
    verbose "Skipping values update for $name ($alias) as UPDATE_VALUES=$UPDATE_VALUES"
    return 0
  fi
  
  log "Updating values for $name ($alias) to version $version"
  
  # Get upstream values
  local values_content
  values_content=$(helm show values "$repo_name/$name" --version "$version" 2>/dev/null)
  if [[ $? -ne 0 ]]; then
    warn "Could not fetch values for $name:$version"
    return 1
  fi
  
  if [[ -z "$values_content" ]]; then
    verbose "No values content available for $name:$version"
    return 0
  fi
  
  # Create values file if it doesn't exist
  local values_file="$chart_dir/values.yaml"
  if [[ ! -f "$values_file" ]]; then
    log "Creating values.yaml file"
    touch "$values_file"
  fi
  
  # Create a temporary file for the values content
  local temp_values_file
  temp_values_file=$(mktemp)
  echo "$values_content" > "$temp_values_file"
  
  if [[ "$DRY_RUN" == "true" ]]; then
    log "[DRY RUN] Would update $alias values in $values_file"
    rm -f "$temp_values_file"
    return 0
  fi
  
  # Update or add the values section for this dependency
  if command -v yq &> /dev/null; then
    # Create a temporary file for the updated values
    local updated_values_file
    updated_values_file=$(mktemp)
    
    # Try to preserve comments and formatting by loading the existing file first
    if [[ -s "$values_file" ]]; then
      cat "$values_file" > "$updated_values_file"
      
      # Check if the key already exists
      if yq e "has(\"$alias\")" "$values_file" | grep -q 'true'; then
        verbose "Key $alias exists, updating it"
        # Update existing key with new values while attempting to preserve formatting
        yq e ".$alias = load_str(\"$temp_values_file\")" -i "$updated_values_file"
      else
        verbose "Key $alias does not exist, adding it"
        # Add the new key with proper formatting
        echo -e "\n# Values for $name (version: $version)" >> "$updated_values_file"
        echo "$alias: |" >> "$updated_values_file"
        sed 's/^/  /' "$temp_values_file" >> "$updated_values_file"
      fi
    else
      # If the file is empty, create a new structure
      echo "# Values for $name (version: $version)" > "$updated_values_file"
      echo "$alias: |" >> "$updated_values_file"
      sed 's/^/  /' "$temp_values_file" >> "$updated_values_file"
    fi
    
    # Replace the original file
    mv "$updated_values_file" "$values_file"
    log "Updated $alias values in $values_file"
  else
    warn "yq is not installed. Cannot update values.yaml properly with preserved formatting"
    return 1
  fi
  
  # Clean up temp file
  rm -f "$temp_values_file"
}

# Compare semantic versions (returns true if v1 is less than v2)
version_lt() {
  local v1="$1"
  local v2="$2"
  
  # Remove any non-numeric prefix (e.g., "v" in "v1.2.3")
  v1="${v1#[vV]}"
  v2="${v2#[vV]}"
  
  # Handle simple equality case
  if [[ "$v1" == "$v2" ]]; then
    return 1  # v1 is not less than v2
  fi
  
  # Compare components
  IFS='.' read -r -a v1_parts <<< "$v1"
  IFS='.' read -r -a v2_parts <<< "$v2"
  
  # Get the number of components to compare
  local max_idx=$(( ${#v1_parts[@]} > ${#v2_parts[@]} ? ${#v1_parts[@]} : ${#v2_parts[@]} ))
  
  for (( i=0; i<max_idx; i++ )); do
    local v1_component="${v1_parts[$i]:-0}"
    local v2_component="${v2_parts[$i]:-0}"
    
    # Handle numeric components
    if [[ "$v1_component" =~ ^[0-9]+$ && "$v2_component" =~ ^[0-9]+$ ]]; then
      # Numeric comparison
      if (( v1_component < v2_component )); then
        return 0  # v1 is less than v2
      elif (( v1_component > v2_component )); then
        return 1  # v1 is greater than v2
      fi
    else
      # String comparison as fallback
      if [[ "$v1_component" < "$v2_component" ]]; then
        return 0  # v1 is less than v2
      elif [[ "$v1_component" > "$v2_component" ]]; then
        return 1  # v1 is greater than v2
      fi
    fi
  done
  
  # If we get here, they're equal up to the common length
  return 1  # Consider them equal
}

# Bump patch version of a semver string
bump_patch_version() {
  local version="$1"
  
  # Remove any non-numeric prefix (e.g., "v" in "v1.2.3")
  local prefix=""
  if [[ "$version" =~ ^[vV] ]]; then
    prefix="${version:0:1}"
    version="${version:1}"
  fi
  
  IFS='.' read -r -a parts <<< "$version"
  
  # Ensure we have at least 3 components
  while [[ ${#parts[@]} -lt 3 ]]; do
    parts+=("0")
  done
  
  # Increment patch version
  parts[2]=$((parts[2] + 1))
  
  # Reassemble version string
  local new_version="${parts[0]}.${parts[1]}.${parts[2]}"
  
  # Add any prerelease or build metadata back
  if [[ "$version" == *"-"* ]]; then
    local remainder="${version#*.*.*.}"
    remainder="${remainder#*.*.}"
    new_version="$new_version-$remainder"
  fi
  
  echo "$prefix$new_version"
}

# Check if a new version is available for a dependency with better tracking
check_for_updates() {
  local chart_dir=$1
  local changed=false
  local update_details=()
  
  if [[ ! -f "$chart_dir/Chart.yaml" ]]; then
    warn "No Chart.yaml found in $chart_dir"
    return 1
  fi
  
  local chart_name=$(basename "$chart_dir")
  log "Checking dependencies in $chart_name"
  
  # Use yq to extract dependencies
  if ! command -v yq &> /dev/null; then
    error "yq is not installed. Cannot parse Chart.yaml"
    return 1
  fi
  
  local deps_count=$(yq e '.dependencies | length // 0' "$chart_dir/Chart.yaml")
  
  if [[ $deps_count -eq 0 ]]; then
    log "No dependencies found in $chart_name"
    return 1
  fi
  
  verbose "Found $deps_count dependencies in $chart_name"
  
  for i in $(seq 0 $((deps_count-1))); do
    local name=$(yq e ".dependencies[$i].name" "$chart_dir/Chart.yaml")
    local current_version=$(yq e ".dependencies[$i].version" "$chart_dir/Chart.yaml")
    local repo_url=$(yq e ".dependencies[$i].repository" "$chart_dir/Chart.yaml")
    local alias=$(yq e ".dependencies[$i].alias // \"$name\"" "$chart_dir/Chart.yaml")
    
    verbose "Checking dependency '$name' (currently $current_version) from $repo_url"
    
    # Get the helm repo name
    local repo_name=$(get_helm_repo_name "$repo_url")
    
    if [[ -z "$repo_name" ]]; then
      # Extract repo name from URL as fallback
      repo_name=$(echo "$repo_url" | sed -E 's|^https?://||' | sed -E 's|/.*$||' | sed 's/\./-/g')
      verbose "Using derived repo name: $repo_name"
    fi
    
    # Try to add the repo if it doesn't exist or isn't properly set up
    if ! helm repo list | grep -q "$repo_name"; then
      log "Adding Helm repo $repo_name: $repo_url"
      if ! helm repo add "$repo_name" "$repo_url" >/dev/null 2>&1; then
        warn "Could not add repo $repo_name ($repo_url), skipping dependency $name"
        continue
      fi
      helm repo update >/dev/null
    fi
    
    # Double check that the repo is properly set up
    if ! helm repo list | grep -q "$repo_name"; then
      warn "Repo $repo_name was not properly added, skipping dependency $name"
      continue
    fi
    
    # Get latest version available with more specific search
    local latest_version=""
    
    # Try an exact search with repo/chart format first
    verbose "Searching for chart '$repo_name/$name'"
    if helm search repo "$repo_name/$name" --output json | grep -q "version"; then
      latest_version=$(helm search repo "$repo_name/$name" --output json | jq -r '.[0].version // ""')
      verbose "Found chart via exact search: $repo_name/$name with version $latest_version"
    else
      verbose "No results for exact search: $repo_name/$name, trying broader search"
      
      # Try a broader search and filter by repository
      local search_results
      search_results=$(helm search repo "$name" --output json)
      
      if [[ -n "$search_results" && "$search_results" != "[]" ]]; then
        # Find entries matching our repository
        local filtered_results
        filtered_results=$(echo "$search_results" | jq -c --arg repo "$repo_name" '[.[] | select(.repository == $repo or .name | startswith($repo))]')
        
        if [[ "$filtered_results" != "[]" && -n "$filtered_results" ]]; then
          latest_version=$(echo "$filtered_results" | jq -r '.[0].version // ""')
          verbose "Found chart via filtered search with version $latest_version"
        else
          warn "No chart found matching repository $repo_name in search results"
        fi
      else
        warn "No results found when searching for $name"
      fi
    fi
    
    # If we still don't have a version, try other variations
    if [[ -z "$latest_version" ]]; then
      # Try chart name variations
      for variation in "$name" "${name}-chart" "charts/$name"; do
        verbose "Trying variation: $repo_name/$variation"
        if helm search repo "$repo_name/$variation" --output json | grep -q "version"; then
          latest_version=$(helm search repo "$repo_name/$variation" --output json | jq -r '.[0].version // ""')
          verbose "Found chart via variation search: $repo_name/$variation with version $latest_version"
          break
        fi
      done
    fi
    
    # If we still couldn't find it, give up
    if [[ -z "$latest_version" ]]; then
      warn "Could not find any version for chart '$name' in repository $repo_name, skipping"
      continue
    fi
    
    # Get latest appVersion (only for informational purposes)
    local latest_app_version=""
    latest_app_version=$(helm show chart "$repo_name/$name" --version "$latest_version" 2>/dev/null | 
                        yq e '.appVersion // ""' 2>/dev/null || echo "")
    
    if [[ -z "$latest_app_version" ]]; then
      verbose "No appVersion found for $name:$latest_version"
    else
      verbose "Found appVersion $latest_app_version for $name:$latest_version"
    fi
    
    # Properly compare semantic versions to ensure we're not downgrading
    if [[ "$current_version" != "$latest_version" ]]; then
      if version_lt "$current_version" "$latest_version"; then
        log "${BLUE}Update available for dependency $name: $current_version -> $latest_version${NC}"
        
        update_details+=("$name:$current_version→$latest_version")
        
        if [[ "$DRY_RUN" != "true" ]]; then
          # Update the version in Chart.yaml
          yq e ".dependencies[$i].version = \"$latest_version\"" -i "$chart_dir/Chart.yaml"
          
          # Update values.yaml with upstream default values
          update_values_yaml "$chart_dir" "$name" "$latest_version" "$repo_name" "$alias"
        else
          log "[DRY RUN] Would update $name to version $latest_version"
        fi
        
        changed=true
      else
        verbose "Current dependency version $current_version is newer than upstream $latest_version, not downgrading"
      fi
    else
      verbose "Dependency $name is already at the latest version ($current_version)"
    fi
  done
  
  # If dependencies were updated, bump the chart's own version
  if [[ "$changed" == "true" ]]; then
    local current_chart_version=$(yq e '.version' "$chart_dir/Chart.yaml")
    local new_chart_version=$(bump_patch_version "$current_chart_version")
    
    log "Bumping $chart_name version from $current_chart_version to $new_chart_version"
    
    if [[ "$DRY_RUN" != "true" ]]; then
      yq e ".version = \"$new_chart_version\"" -i "$chart_dir/Chart.yaml"
    else
      log "[DRY RUN] Would bump chart version to $new_chart_version"
    fi
    
    # Store the update details for later use in commit messages
    CHART_UPDATES+=("$chart_name:${update_details[*]}")
    return 0
  else
    return 1
  fi
}

# Run fix-lint.sh with better error handling - only for changed charts
run_fix_lint() {
  local repo_root="$1"
  local chart_dir="$2"
  local fix_lint_script="${repo_root}/scripts/fix-lint.sh"
  
  if [[ "$DRY_RUN" == "true" ]]; then
    log "[DRY RUN] Would run fix-lint.sh for $(basename "$chart_dir")"
    return 0
  fi
  
  if [[ -f "$fix_lint_script" ]]; then
    log "Running fix-lint.sh script for $(basename "$chart_dir")"
    if bash "$fix_lint_script" --auto --pattern "$chart_dir/*.yaml" > /dev/null 2>&1; then
      log "fix-lint.sh completed successfully for $(basename "$chart_dir")"
    else
      warn "fix-lint.sh exited with errors for $(basename "$chart_dir")"
    fi
  else
    warn "fix-lint.sh script not found at $fix_lint_script"
  fi
}

# Run helm lint for a specific chart
run_helm_lint() {
  local chart_dir="$1"
  local chart_name=$(basename "$chart_dir")
  
  if [[ "$DRY_RUN" == "true" ]]; then
    log "[DRY RUN] Would run helm lint for $chart_name"
    return 0
  fi
  
  log "Running helm lint for $chart_name"
  if helm lint "$chart_dir"; then
    log "helm lint passed for $chart_name"
  else
    warn "helm lint found issues in $chart_name"
  fi
}

# Run helm-docs only for specified chart
run_helm_docs_for_chart() {
  local chart_dir="$1"
  local chart_name=$(basename "$chart_dir")
  
  if [[ "$DRY_RUN" == "true" ]]; then
    log "[DRY RUN] Would run helm-docs for $chart_name"
    return 0
  fi
  
  if command -v helm-docs &> /dev/null; then
    log "Running helm-docs to update documentation for $chart_name"
    if helm-docs --chart-search-root "$chart_dir" --sort-values-order file; then
      log "helm-docs completed successfully for $chart_name"
    else
      warn "helm-docs exited with errors for $chart_name"
    fi
  else
    warn "helm-docs is not installed. Skipping documentation update for $chart_name"
  fi
}

# Generate a more detailed and structured changelog
generate_changelog() {
  local chart_updates=("$@")
  local changelog=""
  local date_formatted=$(date +"%Y-%m-%d")
  local time_formatted=$(date +"%H:%M:%S")
  
  changelog+="# Helm Dependencies Update ($date_formatted)\n\n"
  changelog+="This PR updates chart dependencies to their latest versions.\n\n"
  
  if [[ ${#chart_updates[@]} -eq 0 ]]; then
    changelog+="*No charts were updated.*\n\n"
    echo -e "$changelog"
    return 0
  fi
  
  changelog+="## Summary\n\n"
  changelog+="| Chart | Dependencies Updated |\n"
  changelog+="| ----- | ------------------- |\n"
  
  for update in "${chart_updates[@]}"; do
    IFS=':' read -r chart_name deps_updated <<< "$update"
    changelog+="| **$chart_name** | $deps_updated |\n"
  done  # Changed from "end" to "done"
  
  changelog+="\n## Detailed Changes\n\n"
  
  for update in "${chart_updates[@]}"; do
    IFS=':' read -r chart_name deps_updated <<< "$update"
    local chart_dir="./charts/$chart_name"
    
    if [[ ! -f "$chart_dir/Chart.yaml" ]]; then
      continue
    fi
    
    local chart_version=$(yq e '.version' "$chart_dir/Chart.yaml")
    local chart_appversion=$(yq e '.appVersion // "N/A"' "$chart_dir/Chart.yaml")
    local chart_description=$(yq e '.description // "No description provided"' "$chart_dir/Chart.yaml")
    
    changelog+="\n### 📊 $chart_name (v$chart_version)\n\n"
    changelog+="**App Version:** $chart_appversion\n\n"
    changelog+="**Description:** $chart_description\n\n"
    
    changelog+="#### Updated Dependencies\n\n"
    changelog+="| Dependency | Previous Version | New Version | Repository |\n"
    changelog+="| ---------- | ---------------- | ---------- | ---------- |\n"
    
    # Extract dependency information
    local deps_count=$(yq e '.dependencies | length // 0' "$chart_dir/Chart.yaml")
    for i in $(seq 0 $((deps_count-1))); do
      local name=$(yq e ".dependencies[$i].name" "$chart_dir/Chart.yaml")
      local version=$(yq e ".dependencies[$i].version" "$chart_dir/Chart.yaml")
      local repo=$(yq e ".dependencies[$i].repository" "$chart_dir/Chart.yaml")
      
      # Try to get the previous version from git history
      local prev_version
      prev_version=$(git show HEAD:"$chart_dir/Chart.yaml" 2>/dev/null | 
                     yq e ".dependencies[] | select(.name == \"$name\") | .version" 2>/dev/null || 
                     echo "unknown")
      
      # Only include dependencies that were updated
      if [[ "$prev_version" != "$version" && "$prev_version" != "unknown" ]]; then
        changelog+="| $name | $prev_version | $version | $repo |\n"
      elif [[ "$prev_version" == "unknown" ]]; then
        changelog+="| $name | (new) | $version | $repo |\n"
      fi
    done
    changelog+="\n"
  done
  
  changelog+="\n## 📝 Documentation Updates\n\n"
  changelog+="- Documentation has been automatically updated using helm-docs\n"
  changelog+="- Values documentation reflects the latest upstream defaults\n"
  changelog+="- Charts' README.md files have been regenerated\n"
  
  changelog+="\n## 🔍 Testing Checklist\n\n"
  changelog+="- [ ] Verify that charts deploy successfully with updated dependencies\n"
  changelog+="- [ ] Check that all features function correctly\n"
  changelog+="- [ ] Confirm that documentation accurately reflects the changes\n\n"
  
  changelog+="*Automated update generated on $date_formatted at $time_formatted*"
  
  echo -e "$changelog"
}

# Generate a dynamic commit message based on what was updated
generate_commit_message() {
  local chart_updates=("$@")
  
  if [[ ${#chart_updates[@]} -eq 0 ]]; then
    echo "chore: no helm dependency updates needed"
    return 0
  elif [[ ${#chart_updates[@]} -eq 1 ]]; then
    # For a single chart update, make a more specific message
    IFS=':' read -r chart_name deps_updated <<< "${chart_updates[0]}"
    echo "chore: update $chart_name helm dependencies ($deps_updated)"
  else
    # For multiple charts, summarize
    echo "chore: update helm dependencies for ${#chart_updates[@]} charts"
  fi
}

# Setup git config for commits
setup_git() {
  log "Setting up git user"
  git config --global user.name "GitHub Actions"
  git config --global user.email "actions@github.com"
}

main() {
  log "Starting Helm dependency update process"
  
  # Initialize variables
  CHART_UPDATES=()  # This will store chart:dependency update info
  ANY_UPDATES=false
  
  # Branch name for the PR
  BRANCH_NAME=${BRANCH_NAME:-"chore/bump-helm-deps-$(date +%Y-%m-%d)"}
  REPO_ROOT=$(git rev-parse --show-toplevel || echo ".")
  CHARTS_DIR="$REPO_ROOT/charts"
  
  # Print configuration
  verbose "Configuration:"
  verbose "  DRY_RUN: $DRY_RUN"
  verbose "  SKIP_PR: $SKIP_PR"
  verbose "  VERBOSE: $VERBOSE"
  verbose "  UPDATE_VALUES: $UPDATE_VALUES"
  verbose "  BRANCH_NAME: $BRANCH_NAME"
  verbose "  CHARTS_DIR: $CHARTS_DIR"
  
  # Find and process all charts
  log "Searching for charts in the repository"
  CHART_DIRS=$(find_charts)
  
  if [[ -z "$CHART_DIRS" ]]; then
    log "No Helm charts found in the repository. Nothing to update."
    echo "updated=false" >> $GITHUB_OUTPUT
    exit 0
  fi
  
  # Process each chart
  IFS=$'\n'
  for dir in $CHART_DIRS; do
    if [[ -z "$dir" ]]; then 
      continue
    fi
    
    verbose "Processing chart in $dir"
    
    # Check for updates in Chart.yaml
    if check_for_updates "$dir"; then
      local chart_name=$(basename "$dir")
      log "Updates found for $chart_name, running helm dependency update"
      
      if [[ "$DRY_RUN" != "true" ]]; then
        (cd "$dir" && helm dependency update) || warn "Helm dependency update failed for $chart_name"
        
        # Run fix-lint script for this chart
        run_fix_lint "$REPO_ROOT" "$dir"
        
        # Run helm lint for this chart
        run_helm_lint "$dir"
        
        # Run helm-docs for this chart
        run_helm_docs_for_chart "$dir"
      else
        log "[DRY RUN] Would run helm dependency update for $chart_name"
      fi
      ANY_UPDATES=true
    fi
  done
  unset IFS
  
  # Show update summary
  log "Updates found: $ANY_UPDATES, Charts updated: ${#CHART_UPDATES[@]}"
  for update in "${CHART_UPDATES[@]}"; do
    log "  $update"
  done
  
  # Run additional tooling if any updates were made
  if [[ "$ANY_UPDATES" == "true" ]]; then
    # Generate and save changelog
    CHANGELOG=$(generate_changelog "${CHART_UPDATES[@]}")
    echo "$CHANGELOG" > /tmp/helm_changelog.md
    
    # Generate commit message
    COMMIT_MSG=$(generate_commit_message "${CHART_UPDATES[@]}")
    
    # Only perform git operations if not skipping push
    if [[ "${SKIP_PUSH}" != "true" && "$DRY_RUN" != "true" ]]; then
      # Setup git and create a branch for the changes
      setup_git
      
      # Create a new branch
      log "Creating branch $BRANCH_NAME"
      git checkout -b "$BRANCH_NAME"
      
      # Commit the changes
      log "Committing changes with message: $COMMIT_MSG"
      git add .
      git commit -m "$COMMIT_MSG"
      
      # Push the branch
      log "Pushing branch $BRANCH_NAME"
      git push origin "$BRANCH_NAME"
      
      # Create PR if not disabled
      if [[ "${SKIP_PR}" != "true" ]]; then
        log "PR creation will be handled by GitHub Actions"
      else
        log "Skipping PR creation (SKIP_PR=$SKIP_PR)"
      fi
    elif [[ "$DRY_RUN" == "true" ]]; then
      log "[DRY RUN] Would commit and push changes with message: $COMMIT_MSG"
    else
      log "Skipping git operations (SKIP_PUSH=$SKIP_PUSH)"
    fi
    
    # Set output for GitHub Actions
    echo "updated=true" >> $GITHUB_OUTPUT
    echo "branch_name=$BRANCH_NAME" >> $GITHUB_OUTPUT
    echo "commit_message=$COMMIT_MSG" >> $GITHUB_OUTPUT
  else
    echo "updated=false" >> $GITHUB_OUTPUT
    log "No updates found for any charts"
  fi
  
  if [[ "$DRY_RUN" == "true" ]]; then
    log "Completed DRY RUN - no actual changes were made"
  else
    log "Helm dependency update process completed successfully"
  fi
}

main "$@"
