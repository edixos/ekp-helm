# karma

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.134](https://img.shields.io/badge/AppVersion-0.134-informational?style=flat-square)

**Homepage:** <https://github.com/prymitive/karma>

## Prerequisites

- Helm v3
- An Alertmanager reachable from the release namespace
- An authenticating proxy in front of karma: it has no login of its own

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| smileisak | <ikaboubi@gmail.com> | <https://github.com/smileisak> |

## Description

Karma, a dashboard for Alertmanager alerts, configured from chart values

No upstream chart is published, so this chart holds the Deployment itself. The
`config` value is written verbatim to karma's config file.

## Source Code

* <https://github.com/prymitive/karma>

## Installing the Chart

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm repo update
helm install karma ekp-helm/karma --namespace monitoring
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Affinity |
| config | object | `{"alertmanager":{"servers":[]}}` | karma configuration, written verbatim to its config file. See https://github.com/prymitive/karma/blob/main/docs/CONFIGURATION.md. karma has no login of its own: without `authentication`, anyone reaching the Service can read alerts and manage silences, so keep it behind an authenticating proxy and restrict the Service with `networkPolicies`. |
| externalSecrets | list | `[]` | ExternalSecrets rendered in the release namespace. Each item: { name, namespace?, spec }. |
| fullnameOverride | string | `""` | Override the full resource names (takes precedence over nameOverride) |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.repository | string | `"ghcr.io/prymitive/karma"` | karma image repository |
| image.tag | string | `""` | Image tag. Defaults to `v` + the chart appVersion; never use `latest`. |
| nameOverride | string | `""` | Override the chart name used in resource names |
| networkPolicies | object | `{}` | NetworkPolicies for the karma pods, keyed by name. Each value: { spec }. |
| nodeSelector | object | `{}` | Node selector |
| podAnnotations | object | `{}` | Extra pod annotations |
| podDisruptionBudget.enabled | bool | `false` | Create a PodDisruptionBudget (only rendered with more than one replica, where it cannot block a node drain) |
| podDisruptionBudget.minAvailable | int | `1` | Minimum replicas kept during voluntary disruptions |
| podLabels | object | `{}` | Extra pod labels |
| podSecurityContext | object | `{"runAsGroup":65532,"runAsNonRoot":true,"runAsUser":65532,"seccompProfile":{"type":"RuntimeDefault"}}` | Pod security context. The image is distroless and sets no user. |
| port | int | `8080` | Port karma listens on |
| priorityClassName | string | `""` | Pod priority class |
| replicaCount | int | `1` | Replicas. karma keeps no state of its own: alerts and silences are read from Alertmanager on every refresh. |
| resources | object | `{}` | Container resources |
| securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"readOnlyRootFilesystem":true}` | Container security context |
| service.port | int | `8080` | Service port |
| service.type | string | `"ClusterIP"` | Service type |
| serviceAccount.name | string | `""` | Name of the ServiceAccount (defaults to the fullname). karma never calls the Kubernetes API, so no token is mounted. |
| tolerations | list | `[]` | Tolerations |
| topologySpreadConstraints | list | `[]` | Topology spread constraints |

## Develop

### Update Documentation

```bash
docker run --rm -it -v $(pwd):/helm --workdir /helm jnorwood/helm-docs:v1.14.2 helm-docs
```

### Run Pluto

```bash
helm template karma . --output-dir /tmp/pluto
pluto detect-files -d /tmp/pluto -o wide -t "k8s=v1.31.0"
```
