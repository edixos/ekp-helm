# multus

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.16.0](https://img.shields.io/badge/AppVersion-1.16.0-informational?style=flat-square)

**Homepage:** <https://github.com/k8snetworkplumbingwg/multus-cni>

## Prerequisites

- Helm v3
- Kubernetes 1.19+
- An existing CNI plugin installed (e.g., Calico, Flannel, Weave)

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| hamzatalbi | <hamzatalbi831@gmail.com> | <https://github.com/TalbiHamza> |

## Description

A Helm chart for Multus CNI - enabling multiple network interfaces for Kubernetes pods

## Source Code

* <https://github.com/k8snetworkplumbingwg/multus-cni>

## Features

- **Dual Plugin Mode Support**: Choose between thick (with metrics) or thin (lightweight) plugin modes
- **Prometheus Metrics**: Built-in metrics endpoint with optional ServiceMonitor
- **Flexible Configuration**: Support for multiple Kubernetes distributions (standard, GKE, etc.)

## Installing the Chart

### Quick Start

```bash
# Install with default values (thick mode, metrics enabled)
helm install multus-cni ./multus \
  --namespace kube-system \
  --create-namespace
```

### With Helm Repository

To install the chart with the release name `multus-cni`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm repo update
helm install multus-cni ekp-helm/multus\
  --namespace kube-system \
  --create-namespace
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: multus
  namespace: argocd
spec:
  project: networking
 
  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.0"
    chart: multus
    path: ''
    helm:
      values: |
        pluginMode: "thick"
       
        daemon:
          config:
            metricsPort: 9091
       
        metrics:
          enabled: true
          prometheusRules:
            enabled: true
            labels:
              prometheus: kube-prometheus
          grafanaDashboard:
            enabled: true
       
        hostPaths:
          cniBinDir: "/opt/cni/bin"
       
        global:
          enableArgocdAnnotations: true
 
  destination:
    server: https://kubernetes.default.svc
    namespace: "kube-system"
 
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
      - CreateNamespace=true
```

## Configuration

### Critical Configuration Parameters

#### CNI Binary Directory

**IMPORTANT**: For thick mode, the CNI binary path must match your Kubernetes distribution:

```yaml
hostPaths:
  # Standard Kubernetes
  cniBinDir: "/opt/cni/bin"
 
  # GKE (if available at this path)
  # cniBinDir: "/home/kubernetes/bin"
```

#### Cluster Network

Must point to your existing primary CNI configuration:

```yaml
# For Calico
config:
  clusterNetwork: "/etc/cni/net.d/10-calico.conflist"

# For Flannel
config:
  clusterNetwork: "/etc/cni/net.d/10-flannel.conflist"

# For GKE
config:
  clusterNetwork: "/etc/cni/net.d/10-gke-ptp.conflist"
```

### Plugin Modes

#### Thick Mode (Recommended)

```yaml
pluginMode: "thick"
image:
  tag: "snapshot-thick"

daemon:
  config:
    metricsPort: 9091  # Enable metrics
```

**Features**: Prometheus metrics, better observability, enhanced logging

#### Thin Mode (Legacy)

```yaml
pluginMode: "thin"
image:
  tag: "snapshot"
```

**Features**: Lower resource usage, no metrics support

```
## Develop

### Update Documentation

Chart documentation is generated with [helm-docs](https://github.com/norwoodj/helm-docs) from `values.yaml` file. After file modification, regenerate README.md with command:

```bash
docker run --rm -it -v $(pwd):/helm --workdir /helm jnorwood/helm-docs:v1.14.2 helm-docs
```

### Run Linter

```bash
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 \
  ct lint --charts /charts/charts/multus --config /charts/charts/multus/ct.yaml
```

### Test Prometheus Rules

```bash
# Install promtool
wget https://github.com/prometheus/prometheus/releases/download/v2.45.0/prometheus-2.45.0.linux-amd64.tar.gz
tar xvf prometheus-2.45.0.linux-amd64.tar.gz

# Run tests
./prometheus-2.45.0.linux-amd64/promtool test rules monitoring/multus-prometheus-rules-test.yaml
```

### Run Pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```bash
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 \
  template multus . -f tests/pluto/values.yaml --output-dir /pluto

docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 \
  detect-files -d /data -o yaml --ignore-deprecations \
  -t "k8s=v1.31.0" -o wide

docker volume rm pluto
```

