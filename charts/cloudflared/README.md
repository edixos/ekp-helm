# cloudflared

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2026.10.0](https://img.shields.io/badge/AppVersion-2026.10.0-informational?style=flat-square)

**Homepage:** <https://developers.cloudflare.com/cloudflare-one/networks/connectors/cloudflare-tunnel/>

## Prerequisites

- Helm v3
- A **remotely-managed** Cloudflare Tunnel (created in the Cloudflare One dashboard or API) and its token
- External Secrets Operator, if the token Secret is delivered through `externalSecrets`

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| hamzatalbi | <hamzatalbi831@gmail.com> | <https://github.com/TalbiHamza> |

## Description

Cloudflare Tunnel connector (cloudflared) for a remotely-managed tunnel, with its token delivered by External Secrets

The chart runs `cloudflared tunnel run` for a tunnel whose configuration lives in
Cloudflare. It holds no tunnel routes of its own: public hostnames, private
network (CIDR) routes and private hostname routes are all managed on the tunnel
in Cloudflare. The token is read from an existing Secret and is never a chart
value.

## Source Code

* <https://github.com/cloudflare/cloudflared>

## Installing the Chart

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm repo update
kubectl -n infra-cloudflared create secret generic cloudflared-tunnel-token --from-literal=token=<tunnel token>
helm install cloudflared ekp-helm/cloudflared --namespace infra-cloudflared
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Affinity |
| externalSecrets | list | `[]` | ExternalSecrets rendered in the release namespace, typically the one that writes `tunnelToken.secretName`. Each item: { name, namespace?, spec }. |
| extraArgs | list | `[]` | Extra `cloudflared tunnel` flags, inserted before `run` (e.g. ["--protocol", "quic"]). |
| fullnameOverride | string | `""` | Override the full resource names (takes precedence over nameOverride) |
| hostAliases | list | `[]` | Static /etc/hosts entries (Pod `hostAliases`). cloudflared resolves the destination of private hostname routes with the pod resolver, so this is where such a hostname can be pointed at an in-cluster address. |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.repository | string | `"cloudflare/cloudflared"` | cloudflared image repository |
| image.tag | string | `""` | Image tag. Defaults to the chart appVersion; never use `latest`. |
| logLevel | string | `"info"` | cloudflared log level (debug, info, warn, error, fatal) |
| metrics.port | int | `2000` | Port of the metrics server. It also serves /ready, used by the probes, which returns 200 only while the connector holds an edge connection. |
| nameOverride | string | `""` | Override the chart name used in resource names |
| networkPolicies | object | `{}` | NetworkPolicies for the connector pods, keyed by name. Each value: { spec }. The tunnel's routes live in Cloudflare, outside Git review, so egress limited to the edge and the intended origins keeps a mis-added route from reaching the rest of the cluster network. |
| nodeSelector | object | `{}` | Node selector |
| podAnnotations | object | `{}` | Extra pod annotations |
| podDisruptionBudget.enabled | bool | `true` | Create a PodDisruptionBudget (only rendered with more than one replica, where it cannot block a node drain) |
| podDisruptionBudget.minAvailable | int | `1` | Minimum connectors kept during voluntary disruptions |
| podLabels | object | `{}` | Extra pod labels |
| podSecurityContext | object | `{"runAsGroup":65532,"runAsNonRoot":true,"runAsUser":65532,"seccompProfile":{"type":"RuntimeDefault"}}` | Pod security context. The image runs as the distroless `nonroot` user. |
| priorityClassName | string | `""` | Pod priority class |
| replicaCount | int | `2` | Connector replicas. Every replica runs the same tunnel (4 edge connections each); two keep the tunnel up through a node drain or a rollout. |
| resources | object | `{}` | Container resources |
| securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"readOnlyRootFilesystem":true}` | Container security context |
| serviceAccount.name | string | `""` | Name of the ServiceAccount (defaults to the fullname). cloudflared never calls the Kubernetes API, so no token is mounted. |
| tolerations | list | `[]` | Tolerations |
| topologySpreadConstraints | list | `[]` | Topology spread constraints |
| tunnelToken.secretKey | string | `"token"` | Key in that Secret |
| tunnelToken.secretName | string | `"cloudflared-tunnel-token"` | Name of the Secret holding the tunnel token |

## Develop

### Update Documentation

```bash
docker run --rm -it -v $(pwd):/helm --workdir /helm jnorwood/helm-docs:v1.14.2 helm-docs
```

### Run Pluto

```bash
helm template cloudflared . -f tests/pluto/values.yaml --output-dir /tmp/pluto
pluto detect-files -d /tmp/pluto -o wide -t "k8s=v1.31.0"
```
