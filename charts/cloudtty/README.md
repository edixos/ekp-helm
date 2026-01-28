# cloudtty

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.8.9](https://img.shields.io/badge/AppVersion-0.8.9-informational?style=flat-square) 





## Prerequisites

- Helm v3
- Config Connector installed (v1.6.0)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://cloudtty.github.io/cloudtty | cloudtty(cloudtty) | 0.8.9 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| hamzatalbi | <hamzatalbi831@gmail.com> | <https://github.com/TalbiHamza> |

## Description

A Helm chart for Kubernetes



## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cloudtty.affinity | object | `{}` |  |
| cloudtty.cloudshell.image.registry | string | `"ghcr.io"` |  |
| cloudtty.cloudshell.image.repository | string | `"cloudtty/cloudshell"` |  |
| cloudtty.cloudshell.image.tag | string | `"v0.8.9"` |  |
| cloudtty.cloudshell.nodeSelector | object | `{}` |  |
| cloudtty.cloudshell.resources | object | `{}` |  |
| cloudtty.coreWorkerLimit | int | `5` |  |
| cloudtty.global.imagePullSecrets | list | `[]` |  |
| cloudtty.global.imageRegistry | string | `""` |  |
| cloudtty.image.pullPolicy | string | `"IfNotPresent"` |  |
| cloudtty.image.pullSecrets | list | `[]` |  |
| cloudtty.image.registry | string | `"ghcr.io"` |  |
| cloudtty.image.repository | string | `"cloudtty/cloudshell-operator"` |  |
| cloudtty.image.tag | string | `"v0.8.9"` |  |
| cloudtty.installCRDs | bool | `true` |  |
| cloudtty.labels | object | `{}` |  |
| cloudtty.livenessProbe.enabled | bool | `false` |  |
| cloudtty.maxWorkerLimit | int | `10` |  |
| cloudtty.nodeSelector | object | `{}` |  |
| cloudtty.podAnnotations | object | `{}` |  |
| cloudtty.podLabels | object | `{}` |  |
| cloudtty.readinessProbe.enabled | bool | `false` |  |
| cloudtty.replicaCount | int | `1` |  |
| cloudtty.resources | object | `{}` |  |
| cloudtty.tolerations | object | `{}` |  |

## Installing the Chart

### With Helm

To install the chart with the release name `my-release`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/cloudtty
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: cloudtty
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.0"
    chart: cloudtty
    path: ''
    helm:
      values: |

  destination:
    server: https://kubernetes.default.svc
    namespace: "cnrm-system"
  syncPolicy:
    automated:
      prune: true
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
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/cloudtty --config /charts/charts/cloudtty/ct.yaml
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template cloudtty . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```

