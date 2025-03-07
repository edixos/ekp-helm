#!/usr/bin/env bash
# ekp-chart.sh - Scaffold a new helm chart with ekp-helm conventions using external template files.
#
# Usage:
#   ./ekp-chart.sh create --name <chartName> --dependency-url <url> --dependency-chart-name <depChartName> --dependency-chart-version <depChartVersion>
#
# Example:
#   ./ekp-chart.sh create --name dex --dependency-url https://charts.dexidp.io --dependency-chart-name dex --dependency-chart-version 0.22.0

set -euo pipefail

# Determine the directory where the script is located.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

usage() {
  echo "Usage: $0 create --name <chartName> --dependency-url <url> --dependency-chart-name <depChartName> --dependency-chart-version <depChartVersion>"
  exit 1
}

# --- Argument Parsing ---
if [ "$#" -lt 9 ]; then
  usage
fi

command="$1"
shift

if [ "$command" != "create" ]; then
  echo "Unsupported command: $command"
  usage
fi

# Initialize variables
CHART_NAME=""
DEP_URL=""
DEP_CHART_NAME=""
DEP_CHART_VERSION=""

# Parse options
while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --name)
      CHART_NAME="$2"
      shift 2
      ;;
    --dependency-url)
      DEP_URL="$2"
      shift 2
      ;;
    --dependency-chart-name)
      DEP_CHART_NAME="$2"
      shift 2
      ;;
    --dependency-chart-version)
      DEP_CHART_VERSION="$2"
      shift 2
      ;;
    *)
      echo "Unknown parameter: $1"
      usage
      ;;
  esac
done

# Validate required parameters
if [[ -z "$CHART_NAME" || -z "$DEP_URL" || -z "$DEP_CHART_NAME" || -z "$DEP_CHART_VERSION" ]]; then
  usage
fi

echo "Creating chart '$CHART_NAME' with dependency '$DEP_CHART_NAME' ($DEP_CHART_VERSION) from '$DEP_URL'..."

# --- Step 1: Create Chart ---
helm create "$CHART_NAME" || { echo "helm create failed"; exit 1; }

# --- Step 2: Remove default templates ---
TEMPLATE_DIR="$CHART_NAME/templates"
rm -rf "$TEMPLATE_DIR"/*

# --- Step 3: Update Chart.yaml ---
CHART_YAML="$CHART_NAME/Chart.yaml"
# Append dependency section (you may enhance this to merge or replace as needed)
cat <<EOF >> "$CHART_YAML"
dependencies:
  - name: ${DEP_CHART_NAME}
    version: ${DEP_CHART_VERSION}
    repository: "${DEP_URL}"
EOF

# --- Step 4: Copy external template files ---
# Copy README template
if [ -f "$SCRIPT_DIR/templates/README.md.gotmpl" ]; then
  cp "$SCRIPT_DIR/templates/README.md.gotmpl" "$CHART_NAME/README.md.gotmpl"
else
  echo "Error: README template file not found in $SCRIPT_DIR"
  exit 1
fi

# Copy ct.yaml template
if [ -f "$SCRIPT_DIR/templates/ct.yaml" ]; then
  cp "$SCRIPT_DIR/templates/ct.yaml" "$CHART_NAME/ct.yaml"
else
  echo "Error: ct.yaml template file not found in $SCRIPT_DIR"
  exit 1
fi

# --- Step 5: Fetch default values from the dependency chart ---
# Add dependency repository (ignore error if already added)
helm repo add "${DEP_CHART_NAME}" "${DEP_URL}" 2>/dev/null || true
helm repo update

# Try to fetch default values from the dependency chart.
DEFAULT_VALUES=$(helm show values "${DEP_CHART_NAME}/${DEP_CHART_NAME}" --version "${DEP_CHART_VERSION}" 2>/dev/null || true)
if [ -z "$DEFAULT_VALUES" ]; then
  echo "Warning: Unable to fetch default values for ${DEP_CHART_NAME} from ${DEP_URL}."
fi

# Write values.yaml with an alias for the dependency
{
  echo "# Default values for ${DEP_CHART_NAME}."
  echo "${DEP_CHART_NAME}:"
  if [ -n "$DEFAULT_VALUES" ]; then
    # Indent each line of default values by two spaces
    printf "%s\n" "$DEFAULT_VALUES" | sed 's/^/  /'
  fi
} > "$CHART_NAME/values.yaml"

# --- Step 6: Build helm dependencies ---
(
  cd "$CHART_NAME" || { echo "Failed to change directory to $CHART_NAME"; exit 1; }
  helm dependency build
)

# --- Step 7: Create tests/pluto/values.yaml (empty file) ---
mkdir -p "$CHART_NAME/tests/pluto"
: > "$CHART_NAME/tests/pluto/values.yaml"

echo "Chart '$CHART_NAME' created successfully."