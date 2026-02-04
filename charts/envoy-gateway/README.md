# envoy-gateway

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.6.3](https://img.shields.io/badge/AppVersion-v1.6.3-informational?style=flat-square) 





## Prerequisites

- Helm v3
- Config Connector installed (v1.6.0)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| oci://docker.io/envoyproxy | envoy-gateway(gateway-helm) | 1.6.3 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| hamzatalbi | <hamzatalbi831@gmail.com> | <https://github.com/TalbiHamza> |

## Description

Helm chart to deploy Envoy Gateway on Kubernetes



## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| envoy-gateway.certgen | object | `{"job":{"affinity":{},"annotations":{},"args":[],"nodeSelector":{},"pod":{"annotations":{},"labels":{}},"resources":{},"securityContext":{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"privileged":false,"readOnlyRootFilesystem":true,"runAsGroup":65532,"runAsNonRoot":true,"runAsUser":65532,"seccompProfile":{"type":"RuntimeDefault"}},"tolerations":[],"ttlSecondsAfterFinished":30},"rbac":{"annotations":{},"labels":{}}}` | Certgen is used to generate the certificates required by EnvoyGateway. If you want to construct a custom certificate, you can generate a custom certificate through Cert-Manager before installing EnvoyGateway. Certgen will not overwrite the custom certificate. Please do not manually modify `values.yaml` to disable certgen, it may cause EnvoyGateway OIDC,OAuth2,etc. to not work as expected. |
| envoy-gateway.config.envoyGateway | object | `{"extensionApis":{},"gateway":{"controllerName":"gateway.envoyproxy.io/gatewayclass-controller"},"logging":{"level":{"default":"info"}},"provider":{"type":"Kubernetes"}}` | EnvoyGateway configuration. Visit https://gateway.envoyproxy.io/docs/api/extension_types/#envoygateway to view all options. |
| envoy-gateway.createNamespace | bool | `false` |  |
| envoy-gateway.deployment.annotations | object | `{}` |  |
| envoy-gateway.deployment.envoyGateway.image.repository | string | `""` |  |
| envoy-gateway.deployment.envoyGateway.image.tag | string | `""` |  |
| envoy-gateway.deployment.envoyGateway.imagePullPolicy | string | `""` |  |
| envoy-gateway.deployment.envoyGateway.imagePullSecrets | list | `[]` |  |
| envoy-gateway.deployment.envoyGateway.resources.limits.memory | string | `"1024Mi"` |  |
| envoy-gateway.deployment.envoyGateway.resources.requests.cpu | string | `"100m"` |  |
| envoy-gateway.deployment.envoyGateway.resources.requests.memory | string | `"256Mi"` |  |
| envoy-gateway.deployment.envoyGateway.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| envoy-gateway.deployment.envoyGateway.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| envoy-gateway.deployment.envoyGateway.securityContext.privileged | bool | `false` |  |
| envoy-gateway.deployment.envoyGateway.securityContext.runAsGroup | int | `65532` |  |
| envoy-gateway.deployment.envoyGateway.securityContext.runAsNonRoot | bool | `true` |  |
| envoy-gateway.deployment.envoyGateway.securityContext.runAsUser | int | `65532` |  |
| envoy-gateway.deployment.envoyGateway.securityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| envoy-gateway.deployment.pod.affinity | object | `{}` |  |
| envoy-gateway.deployment.pod.annotations."prometheus.io/port" | string | `"19001"` |  |
| envoy-gateway.deployment.pod.annotations."prometheus.io/scrape" | string | `"true"` |  |
| envoy-gateway.deployment.pod.labels | object | `{}` |  |
| envoy-gateway.deployment.pod.nodeSelector | object | `{}` |  |
| envoy-gateway.deployment.pod.tolerations | list | `[]` |  |
| envoy-gateway.deployment.pod.topologySpreadConstraints | list | `[]` |  |
| envoy-gateway.deployment.ports[0].name | string | `"grpc"` |  |
| envoy-gateway.deployment.ports[0].port | int | `18000` |  |
| envoy-gateway.deployment.ports[0].targetPort | int | `18000` |  |
| envoy-gateway.deployment.ports[1].name | string | `"ratelimit"` |  |
| envoy-gateway.deployment.ports[1].port | int | `18001` |  |
| envoy-gateway.deployment.ports[1].targetPort | int | `18001` |  |
| envoy-gateway.deployment.ports[2].name | string | `"wasm"` |  |
| envoy-gateway.deployment.ports[2].port | int | `18002` |  |
| envoy-gateway.deployment.ports[2].targetPort | int | `18002` |  |
| envoy-gateway.deployment.ports[3].name | string | `"metrics"` |  |
| envoy-gateway.deployment.ports[3].port | int | `19001` |  |
| envoy-gateway.deployment.ports[3].targetPort | int | `19001` |  |
| envoy-gateway.deployment.priorityClassName | string | `nil` |  |
| envoy-gateway.deployment.replicas | int | `1` |  |
| envoy-gateway.global.imagePullSecrets | list | `[]` | Global override for image pull secrets |
| envoy-gateway.global.imageRegistry | string | `""` | Global override for image registry |
| envoy-gateway.global.images.envoyGateway.image | string | `"docker.io/envoyproxy/gateway:v1.6.3"` |  |
| envoy-gateway.global.images.envoyGateway.pullPolicy | string | `"IfNotPresent"` |  |
| envoy-gateway.global.images.envoyGateway.pullSecrets | list | `[]` |  |
| envoy-gateway.global.images.ratelimit.image | string | `"docker.io/envoyproxy/ratelimit:3fb70258"` |  |
| envoy-gateway.global.images.ratelimit.pullPolicy | string | `"IfNotPresent"` |  |
| envoy-gateway.global.images.ratelimit.pullSecrets | list | `[]` |  |
| envoy-gateway.hpa.behavior | object | `{}` |  |
| envoy-gateway.hpa.enabled | bool | `false` |  |
| envoy-gateway.hpa.maxReplicas | int | `1` |  |
| envoy-gateway.hpa.metrics | list | `[]` |  |
| envoy-gateway.hpa.minReplicas | int | `1` |  |
| envoy-gateway.kubernetesClusterDomain | string | `"cluster.local"` |  |
| envoy-gateway.podDisruptionBudget.minAvailable | int | `0` |  |
| envoy-gateway.service.annotations | object | `{}` |  |
| envoy-gateway.service.trafficDistribution | string | `""` |  |
| envoy-gateway.service.type | string | `"ClusterIP"` |  |
| envoy-gateway.topologyInjector.annotations | object | `{}` |  |
| envoy-gateway.topologyInjector.enabled | bool | `true` |  |
| prometheus.enabled | bool | `false` | Enables prometheus operator resources |
| prometheus.grafanaDashboard.enabled | bool | `false` | If `true`, deploy grafana dashboard |
| prometheus.grafanaDashboard.label | object | `{"grafana_dashboard":"1"}` | Labels to apply to dashboard configmap |
| prometheus.rules.labels | object | `{"prometheus":"prometheus-operator-prometheus"}` | Labels to affect to the Prometheus Rules |
| prometheus.serviceMonitor.annotations | object | `{}` | Map of annotations to apply to the ServiceMonitor |
| prometheus.serviceMonitor.bearerTokenFile | string | `""` | Bearer token file to use when scraping the endpoint |
| prometheus.serviceMonitor.enabled | bool | `false` | Enables prometheus operator service monitor |
| prometheus.serviceMonitor.interval | string | `"30s"` | Scrape interval. If not set, the Prometheus default scrape interval is used. |
| prometheus.serviceMonitor.labels | object | `{"release":"kube-prometheus-stack"}` | Map of labels to apply to the servicemonitor |
| prometheus.serviceMonitor.metricRelabelings | list | `[]` | metric relabel configs to apply to samples before ingestion. |
| prometheus.serviceMonitor.relabelings | list | `[]` | Relabel configs to apply to samples before ingestion. |
| prometheus.serviceMonitor.scheme | string | `""` | HTTP scheme to use for scraping. Can be used with `tlsConfig` for example if using istio mTLS. |
| prometheus.serviceMonitor.scrapeTimeout | string | `"10s"` | Scrape timeout. If not set, the Prometheus default scrape timeout is used. |
| prometheus.serviceMonitor.tlsConfig | object | `{}` | TLS configuration to use when scraping the endpoint. For example if using istio mTLS. Of type: https://github.com/prometheus-operator/prometheus-operator/blob/master/Documentation/api.md#tlsconfig |

## Installing the Chart

### With Helm

To install the chart with the release name `my-release`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/envoy-gateway
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: envoy-gateway
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.0"
    chart: envoy-gateway
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
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/envoy-gateway --config /charts/charts/envoy-gateway/ct.yaml
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template envoy-gateway . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```

