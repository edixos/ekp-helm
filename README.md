# ekp-helm

ekp-helm is the official Helm chart repository for the Edixos Kubernetes Platform. This repository repackages and extends popular cloud native charts by adding extra features such as robust secrets management and enhanced observability.

## Overview

The ekp-helm project provides a set of Helm charts designed to streamline the deployment and management of Kubernetes applications on the Edixos Kubernetes Platform. Our charts are built as extensions of well-known community charts, incorporating additional functionality tailored for enterprise-grade deployments.

Key improvements include:
- **Secrets Management:** Securely manage sensitive data with built-in support for external secret stores.
- **Observability:** Integrated templates for monitoring and logging to give you better insights into your application’s health and performance.
- **Enhanced Customization:** Easily configure and customize charts using extended values and templating.

## Features

- **Repackaged Community Charts:** Leverage the power and community support of existing charts while benefiting from additional enterprise features.
- **Secrets Management Integration:** Simplify the management of sensitive configurations using supported secrets backends.
- **Built-In Observability:** Out-of-the-box support for observability with pre-configured metrics and logging templates.
- **Chart Scaffolding Tool:** Use our custom scaffolding script to quickly generate new charts with all the extra features enabled.
- **Automated Documentation:** Generate chart documentation automatically with [helm-docs](https://github.com/norwoodj/helm-docs).

## Getting Started


### Installing a Chart

To install a chart from ekp-helm, first add the repository:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm repo update
```

Then install a chart with:

```bash
helm install my-release ekp-helm/<chart-name>
```

Replace `<chart-name>` with the desired chart from the repository.

## Usage

ekp-helm charts are built to be flexible and easy to configure. You can override default values using your own values file:

```bash
helm install my-release ekp-helm/<chart-name> -f my-values.yaml
```

For detailed configuration options, refer to the auto-generated README (documentation) for each chart.

## Development

### Prerequisites

- **Helm:** Ensure you have Helm installed ([Helm installation guide](https://helm.sh/docs/intro/install/)).
- **Kubernetes Cluster:** A working Kubernetes cluster.
- **helm-docs:** (Optional) For generating documentation, install helm-docs:
  ```bash
  brew install helm-docs  # on macOS (or use your package manager)
  ```
- **gsed:** (macOS only) Install GNU sed if not already installed:
  ```bash
  brew install gnu-sed
  ```


### Chart Scaffolding

The repository includes a custom shell script (`ekp-chart.sh`) to scaffold new charts. This tool automates the process of:
- Creating a new Helm chart.
- Removing default templates.
- Updating `Chart.yaml` with dependency details (including optional alias support).
- Rendering default values and external templates.
- Building Helm dependencies.
- Generating documentation with helm-docs.

Example usage:

```bash
./scripts/ekp-chart.sh create 
  --name my-new-chart 
  --dependency-url https://charts.example.com 
  --dependency-chart-name example-chart 
  --dependency-chart-version 1.2.3 
  --dependency-alias exchart
```

### Linting and Testing

We use [Chart Testing](https://github.com/helm/chart-testing) to ensure our charts follow best practices. To lint a chart, run:

```bash
docker run --rm -it -w /charts -v $(pwd)/../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/<chart-name> --config /charts/charts/<chart-name>/ct.yaml
```

### Documentation Generation

Documentation is automatically generated from chart annotations using helm-docs. To manually generate documentation:

```bash
helm-docs /path/to/charts/<chart-name>
```

## Contributing

We welcome contributions! Please check out our [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on how to contribute to ekp-helm.

## License

ekp-helm is licensed under the [Apache License 2.0](LICENSE).

## Contact

For questions or support, please reach out to the Edixos Kubernetes Platform team or open an issue on GitHub.