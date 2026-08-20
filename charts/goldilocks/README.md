# goldilocks

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v4.16.1](https://img.shields.io/badge/AppVersion-v4.16.1-informational?style=flat-square)

## Prerequisites

- Helm v3
- Config Connector installed (v1.6.0)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.fairwinds.com/stable | goldilocks | 11.0.0 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| hamzatalbi | <hamzatalbi831@gmail.com> | <https://github.com/TalbiHamza> |

## Description

Goldilocks packaged for the Edixos Kubernetes Platform.

## Source Code

* <https://github.com/FairwindsOps/goldilocks>
* <https://github.com/FairwindsOps/charts/tree/master/stable/goldilocks>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| externalSecrets | list | `[]` | List of ExternalSecrets to deploy. Goldilocks holds no credentials of its own; use this for the Secrets a release only references, such as an image pull secret named in `goldilocks.imagePullSecrets` or the TLS secret named in `goldilocks.dashboard.ingress.tls`. Each entry takes `name`, an optional `namespace`, `labels`, `annotations`, and the ExternalSecret `spec` verbatim. |
| goldilocks.controller.affinity | object | `{}` |  |
| goldilocks.controller.deployment.additionalLabels | object | `{}` |  |
| goldilocks.controller.deployment.annotations | object | `{}` |  |
| goldilocks.controller.deployment.extraVolumeMounts | list | `[]` |  |
| goldilocks.controller.deployment.extraVolumes | list | `[]` |  |
| goldilocks.controller.deployment.podAnnotations | object | `{}` |  |
| goldilocks.controller.enabled | bool | `true` |  |
| goldilocks.controller.flags | object | `{}` |  |
| goldilocks.controller.logVerbosity | string | `"2"` |  |
| goldilocks.controller.nodeSelector | object | `{}` |  |
| goldilocks.controller.podSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| goldilocks.controller.rbac.create | bool | `true` |  |
| goldilocks.controller.rbac.enableArgoproj | bool | `true` |  |
| goldilocks.controller.rbac.extraClusterRoleBindings | list | `[]` |  |
| goldilocks.controller.rbac.extraRules | list | `[]` |  |
| goldilocks.controller.resources.limits | object | `{}` |  |
| goldilocks.controller.resources.requests.cpu | string | `"25m"` |  |
| goldilocks.controller.resources.requests.memory | string | `"256Mi"` |  |
| goldilocks.controller.revisionHistoryLimit | int | `10` |  |
| goldilocks.controller.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| goldilocks.controller.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| goldilocks.controller.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| goldilocks.controller.securityContext.runAsNonRoot | bool | `true` |  |
| goldilocks.controller.securityContext.runAsUser | int | `10324` |  |
| goldilocks.controller.serviceAccount.create | bool | `true` |  |
| goldilocks.controller.serviceAccount.name | string | `nil` |  |
| goldilocks.controller.tolerations | list | `[]` |  |
| goldilocks.controller.topologySpreadConstraints | list | `[]` |  |
| goldilocks.dashboard.affinity | object | `{}` |  |
| goldilocks.dashboard.basePath | string | `nil` |  |
| goldilocks.dashboard.deployment.additionalLabels | object | `{}` |  |
| goldilocks.dashboard.deployment.annotations | object | `{}` |  |
| goldilocks.dashboard.deployment.extraVolumeMounts | list | `[]` |  |
| goldilocks.dashboard.deployment.extraVolumes | list | `[]` |  |
| goldilocks.dashboard.deployment.podAnnotations | object | `{}` |  |
| goldilocks.dashboard.enabled | bool | `true` |  |
| goldilocks.dashboard.excludeContainers | string | `"linkerd-proxy,istio-proxy"` |  |
| goldilocks.dashboard.flags | object | `{}` |  |
| goldilocks.dashboard.healthCheckPolicy.enabled | bool | `false` |  |
| goldilocks.dashboard.healthCheckPolicy.requestPath | string | `"/health"` |  |
| goldilocks.dashboard.httpRoute.annotations | object | `{}` |  |
| goldilocks.dashboard.httpRoute.enabled | bool | `false` |  |
| goldilocks.dashboard.httpRoute.hostnames | list | `[]` |  |
| goldilocks.dashboard.httpRoute.labels | object | `{}` |  |
| goldilocks.dashboard.httpRoute.matches[0].path.type | string | `"PathPrefix"` |  |
| goldilocks.dashboard.httpRoute.matches[0].path.value | string | `"/"` |  |
| goldilocks.dashboard.httpRoute.parentRefs | list | `[]` |  |
| goldilocks.dashboard.ingress.annotations | object | `{}` |  |
| goldilocks.dashboard.ingress.enabled | bool | `false` |  |
| goldilocks.dashboard.ingress.hosts[0].host | string | `"chart-example.local"` |  |
| goldilocks.dashboard.ingress.hosts[0].paths[0].path | string | `"/"` |  |
| goldilocks.dashboard.ingress.hosts[0].paths[0].type | string | `"ImplementationSpecific"` |  |
| goldilocks.dashboard.ingress.ingressClassName | string | `nil` |  |
| goldilocks.dashboard.ingress.tls | list | `[]` |  |
| goldilocks.dashboard.logVerbosity | string | `"2"` |  |
| goldilocks.dashboard.nodeSelector | object | `{}` |  |
| goldilocks.dashboard.podSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| goldilocks.dashboard.rbac.create | bool | `true` |  |
| goldilocks.dashboard.rbac.enableArgoproj | bool | `true` |  |
| goldilocks.dashboard.rbac.extraClusterRoleBindings | list | `[]` |  |
| goldilocks.dashboard.rbac.extraRules | list | `[]` |  |
| goldilocks.dashboard.replicaCount | int | `2` |  |
| goldilocks.dashboard.resources.limits | object | `{}` |  |
| goldilocks.dashboard.resources.requests.cpu | string | `"25m"` |  |
| goldilocks.dashboard.resources.requests.memory | string | `"256Mi"` |  |
| goldilocks.dashboard.revisionHistoryLimit | int | `10` |  |
| goldilocks.dashboard.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| goldilocks.dashboard.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| goldilocks.dashboard.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| goldilocks.dashboard.securityContext.runAsNonRoot | bool | `true` |  |
| goldilocks.dashboard.securityContext.runAsUser | int | `10324` |  |
| goldilocks.dashboard.service.annotations | object | `{}` |  |
| goldilocks.dashboard.service.port | int | `80` |  |
| goldilocks.dashboard.service.type | string | `"ClusterIP"` |  |
| goldilocks.dashboard.serviceAccount.create | bool | `true` |  |
| goldilocks.dashboard.serviceAccount.name | string | `nil` |  |
| goldilocks.dashboard.tolerations | list | `[]` |  |
| goldilocks.dashboard.topologySpreadConstraints | list | `[]` |  |
| goldilocks.fullnameOverride | string | `""` |  |
| goldilocks.image.pullPolicy | string | `"Always"` |  |
| goldilocks.image.repository | string | `"us-docker.pkg.dev/fairwinds-ops/oss/goldilocks"` |  |
| goldilocks.image.tag | string | `"v4.16.1"` |  |
| goldilocks.imagePullSecrets | list | `[]` |  |
| goldilocks.metrics-server.apiService.create | bool | `true` |  |
| goldilocks.metrics-server.enabled | bool | `false` |  |
| goldilocks.nameOverride | string | `""` |  |
| goldilocks.uninstallVPA | bool | `false` |  |
| goldilocks.vpa.enabled | bool | `false` |  |
| goldilocks.vpa.updater.enabled | bool | `false` |  |

## Installing the Chart

### With Helm

To install the chart with the release name `my-release`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/goldilocks
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: goldilocks
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.0"
    chart: goldilocks
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
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/goldilocks --config /charts/charts/goldilocks/ct.yaml
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template goldilocks . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```

