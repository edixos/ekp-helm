#!/bin/bash
# This script runs the chart-testing tool locally. It simulates the linting that is also done by the github action. Run this without any errors before pushing.
# Reference: https://github.com/helm/chart-testing

set -eux

SRCROOT="$(cd "$(dirname "$0")/.." && pwd)"
echo $SRCROOT

echo -e "\n-- Linting all Helm Charts --\n"
docker run -it --rm \
  -v "$SRCROOT:/workdir" \
  --workdir /workdir \
  quay.io/helmpack/chart-testing:v3.12.0 \
  /bin/bash -c "git config --global --add safe.directory /workdir && ct lint --config .github/configs/ct.yaml --lint-conf .github/configs/lintconf.yaml --debug"