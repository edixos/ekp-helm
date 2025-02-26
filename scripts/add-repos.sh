#!/usr/bin/env bash
set -euo pipefail

CONFIG_FILE=".github/configs/ct.yaml"

# Check if the configuration file exists
if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "Error: Configuration file '$CONFIG_FILE' not found!"
  exit 1
fi

# Ensure yq is installed (https://github.com/mikefarah/yq)
if ! command -v yq &> /dev/null; then
  echo "Error: 'yq' is not installed. Please install it to parse the YAML file."
  exit 1
fi

# Extract the chart repositories from the YAML file.
# It will output entries like "dex=https://charts.dexidp.io"
repos=$(yq e '.["chart-repos"][]' "$CONFIG_FILE")

echo "Adding helm repositories from $CONFIG_FILE..."
# Iterate over each repository entry and add it using helm repo add.
while IFS= read -r repo_entry; do
  # Split the entry at '=' into a name and URL.
  repo_name="${repo_entry%%=*}"
  repo_url="${repo_entry#*=}"
  echo "Adding repo: $repo_name -> $repo_url"
  helm repo add "$repo_name" "$repo_url"
done <<< "$repos"

echo "All helm repositories added successfully."