#!/usr/bin/env bash
# ekp-chart.sh - Scaffold a new helm chart with ekp-helm conventions using external template files.
#
# Usage:
#   ./ekp-chart.sh create --name <chartName> --dependency-url <url> --dependency-chart-name <depChartName> --dependency-chart-version <depChartVersion> [--dependency-alias <alias>]
#
# Example:
#   ./ekp-chart.sh create --name kube-prometheus-stack \
#     --dependency-url https://prometheus-community.github.io/helm-charts \
#     --dependency-chart-name kube-prometheus-stack \
#     --dependency-chart-version 69.8.0 \
#     --dependency-alias kps
#
# In the above example, the dependency values will be rendered under "kps" instead of "kube-prometheus-stack".

set -euo pipefail

# Determine the directory where the script is located.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CHART_DIR="$SCRIPT_DIR/../charts"

# Determine which sed to use.
if [[ "$(uname)" == "Darwin" ]]; then
  if ! command -v gsed >/dev/null 2>&1; then
    echo "gsed is required on macOS. Please install it using: brew install gnu-sed"
    exit 1
  fi
  SED=gsed
else
  SED=sed
fi

usage() {
  echo "Usage: $0 create --name <chartName> --dependency-url <url> --dependency-chart-name <depChartName> --dependency-chart-version <depChartVersion> [--dependency-alias <alias>]"
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
DEP_ALIAS=""

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
    --dependency-alias)
      DEP_ALIAS="$2"
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
if [[ -n "$DEP_ALIAS" ]]; then
  echo "Using dependency alias: $DEP_ALIAS"
fi

# --- Step 1: Create Chart ---
helm create "$CHART_DIR/$CHART_NAME" || { echo "helm create failed"; exit 1; }

# --- Step 2: Remove default templates ---
TEMPLATE_DIR="$CHART_DIR/$CHART_NAME/templates"
rm -rf "$TEMPLATE_DIR"/*

# --- Step 3: Update Chart.yaml ---
CHART_YAML="$CHART_DIR/$CHART_NAME/Chart.yaml"
# Append dependency section. If a dependency alias is provided, include it.
cat <<EOF >> "$CHART_YAML"
dependencies:
  - name: ${DEP_CHART_NAME}
    version: ${DEP_CHART_VERSION}
    repository: "${DEP_URL}"
EOF

if [[ -n "$DEP_ALIAS" ]]; then
  echo "    alias: ${DEP_ALIAS}" >> "$CHART_YAML"
fi

# --- Step 4: Copy external template files ---
# Copy README template
if [ -f "$SCRIPT_DIR/templates/README.md.gotmpl" ]; then
  cp "$SCRIPT_DIR/templates/README.md.gotmpl" "$CHART_DIR/$CHART_NAME/README.md.gotmpl"
else
  echo "Error: README template file not found in $SCRIPT_DIR/templates"
  exit 1
fi

# Process ct.yaml template: substitute placeholders with actual dependency values using $SED.
if [ -f "$SCRIPT_DIR/templates/ct.yaml" ]; then
  $SED -e "s|{{DEP_CHART_NAME}}|${DEP_CHART_NAME}|g" \
       -e "s|{{DEP_URL}}|${DEP_URL}|g" \
       "$SCRIPT_DIR/templates/ct.yaml" > "$CHART_DIR/$CHART_NAME/ct.yaml"
else
  echo "Error: ct.yaml template file not found in $SCRIPT_DIR/templates"
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

# --- Step 6: Write values.yaml with an alias key if provided ---
{
  if [[ -n "$DEP_ALIAS" ]]; then
    echo "# Default values for ${DEP_ALIAS}."
    echo "${DEP_ALIAS}:"
  else
    echo "# Default values for ${DEP_CHART_NAME}."
    echo "${DEP_CHART_NAME}:"
  fi
  if [ -n "$DEFAULT_VALUES" ]; then
    # Remove trailing whitespace and indent each line by two spaces
    printf "%s\n" "$DEFAULT_VALUES" | $SED -e 's/[[:space:]]\+$//' -e 's/^/  /'
  fi
} > "$CHART_DIR/$CHART_NAME/values.yaml"

# --- Step 7: Build helm dependencies ---
(
  cd "$CHART_DIR/$CHART_NAME" || { echo "Failed to change directory to $CHART_NAME"; exit 1; }
  helm dependency build
)

# --- Step 8: Create tests/pluto/values.yaml (empty file) ---
mkdir -p "$CHART_DIR/$CHART_NAME/tests/pluto"
: > "$CHART_DIR/$CHART_NAME/tests/pluto/values.yaml"

# --- Step 9: Generate Documentation with helm-docs ---
if command -v helm-docs >/dev/null 2>&1; then
  helm-docs "$CHART_DIR/$CHART_NAME"
else
  echo "helm-docs is not installed. Please install helm-docs to generate chart documentation."
fi

echo "Chart '$CHART_DIR/$CHART_NAME' created successfully."