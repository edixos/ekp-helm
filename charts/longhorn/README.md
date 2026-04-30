# longhorn
![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.11.1](https://img.shields.io/badge/AppVersion-1.11.1-informational?style=flat-square)

----
[[_TOC_]]
----

## Prerequisites

- Helm ≥ 3.8
- Kubernetes 1.21+
- `open-iscsi` installed on all nodes
- `util-linux` installed on all nodes

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.longhorn.io | longhorn(longhorn) | 1.11.1 |

## Description

A Helm chart for Longhorn

This chart deploys **Longhorn** — a highly available, distributed block storage system for Kubernetes.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| longhorn.csi.attacherReplicaCount | int | `3` |  |
| longhorn.csi.kubeletRootDir | string | `"/var/lib/kubelet"` |  |
| longhorn.csi.provisionerReplicaCount | int | `3` |  |
| longhorn.csi.resizerReplicaCount | int | `3` |  |
| longhorn.csi.snapshotterReplicaCount | int | `3` |  |
| longhorn.defaultSettings.createDefaultDiskLabeledNodes | bool | `true` |  |
| longhorn.defaultSettings.defaultDataPath | string | `"/var/lib/longhorn"` |  |
| longhorn.defaultSettings.replicaCount | int | `3` |  |
| longhorn.ingress.enabled | bool | `false` |  |
| longhorn.ingress.host | string | `"longhorn.local"` |  |
| longhorn.ingress.ingressClassName | string | `"nginx"` |  |
| longhorn.ingress.tls | bool | `false` |  |
| longhorn.persistence.defaultClass | bool | `true` |  |
| longhorn.persistence.defaultClassReplicaCount | int | `3` |  |
| storageClasses | list | `[]` | List of StorageClasses to deploy |
| volumeSnapshotClasses | list | `[]` | List of VolumeSnapshotClasses to deploy |

## Installing the Chart

### With Helm

Add the repository and install with default values:

```bash
helm repo add ekp-helm [https://edixos.github.io/ekp-helm](https://edixos.github.io/ekp-helm)
helm repo update

helm install my-longhorn ekp-helm/longhorn \
  --namespace longhorn-system \
  --create-namespace
```

Or install with custom values:

```bash
helm install my-longhorn ekp-helm/longhorn \
  --namespace longhorn-system \
  --create-namespace \
  -f values.yaml
```

### With ArgoCD

#### Cluster k8s with access to public registry

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: longhorn
spec:
  project: infra

  source:
    repoURL: "[https://edixos.github.io/ekp-helm](https://edixos.github.io/ekp-helm)"
    targetRevision: "0.1.0"
    chart: longhorn
    path: ''

    helm:
      values: |
        ""

  destination:
    server: [https://kubernetes.default.svc](https://kubernetes.default.svc)
    namespace: "longhorn-system"

  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

## Develop

### Update documentation

Chart documentation is generated with [helm-docs](https://github.com/norwoodj/helm-docs) from `values.yaml` file.
After file modification, regenerate README.md with command:

```bash
docker run --rm -it -v $(pwd):/helm --workdir /helm jnorwood/helm-docs:v1.14.2 helm-docs
```

### Run linter

```bash
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/longhorn --config /charts/charts/longhorn/ct.yaml
```

### Prometheus Rules

Check rules:

```bash
docker run --rm --entrypoint /bin/sh -v $(pwd):/workdir -w /workdir prom/prometheus -c -- "promtool check rules resources/prometheus-rules/*"
```

Test rules:

```bash
docker run --rm --entrypoint /bin/sh -v $(pwd):/workdir -w /workdir prom/prometheus -c -- "promtool test rules tests/prometheus/*"
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```bash
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template longhorn . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```