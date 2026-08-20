# metrics-server

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.9.0](https://img.shields.io/badge/AppVersion-0.9.0-informational?style=flat-square)

## Prerequisites

- Helm v3
- Config Connector installed (v1.6.0)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://kubernetes-sigs.github.io/metrics-server/ | metrics-server | 3.14.0 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| hamzatalbi | <hamzatalbi831@gmail.com> | <https://github.com/TalbiHamza> |

## Description

Metrics Server, packaged for the Edixos Kubernetes Platform. Wraps the upstream kubernetes-sigs chart — which serves the resource metrics API (metrics.k8s.io) that `kubectl top`, the HorizontalPodAutoscaler and the VerticalPodAutoscaler read from — and adds the platform extensions it does not provide: curated PrometheusRule alerts covering availability, kubelet scraping, metric freshness and the collection loop, plus a Grafana dashboard shipped as a sidecar-discoverable ConfigMap. The upstream chart already renders the ServiceMonitor, so enable it under `metrics-server.serviceMonitor`. Every extension is optional and driven entirely by values.

## Source Code

* <https://github.com/kubernetes-sigs/metrics-server>
* <https://github.com/kubernetes-sigs/metrics-server/tree/master/charts/metrics-server>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.enableArgocdAnnotations | bool | `false` | Annotate the platform extension resources with Argo CD sync options, so Argo CD does not dry-run them against CRDs that are not installed yet |
| metrics-server.addonResizer.enabled | bool | `false` |  |
| metrics-server.addonResizer.image.repository | string | `"registry.k8s.io/autoscaling/addon-resizer"` |  |
| metrics-server.addonResizer.image.tag | string | `"1.8.23"` |  |
| metrics-server.addonResizer.nanny.cpu | string | `"0m"` |  |
| metrics-server.addonResizer.nanny.extraCpu | string | `"1m"` |  |
| metrics-server.addonResizer.nanny.extraMemory | string | `"2Mi"` |  |
| metrics-server.addonResizer.nanny.memory | string | `"0Mi"` |  |
| metrics-server.addonResizer.nanny.minClusterSize | int | `100` |  |
| metrics-server.addonResizer.nanny.pollPeriod | int | `300000` |  |
| metrics-server.addonResizer.nanny.threshold | int | `5` |  |
| metrics-server.addonResizer.resources.limits.cpu | string | `"40m"` |  |
| metrics-server.addonResizer.resources.limits.memory | string | `"25Mi"` |  |
| metrics-server.addonResizer.resources.requests.cpu | string | `"40m"` |  |
| metrics-server.addonResizer.resources.requests.memory | string | `"25Mi"` |  |
| metrics-server.addonResizer.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| metrics-server.addonResizer.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| metrics-server.addonResizer.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| metrics-server.addonResizer.securityContext.runAsNonRoot | bool | `true` |  |
| metrics-server.addonResizer.securityContext.runAsUser | int | `1000` |  |
| metrics-server.addonResizer.securityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| metrics-server.affinity | object | `{}` |  |
| metrics-server.apiService.annotations | object | `{}` |  |
| metrics-server.apiService.caBundle | string | `""` |  |
| metrics-server.apiService.create | bool | `true` |  |
| metrics-server.apiService.insecureSkipTLSVerify | bool | `true` |  |
| metrics-server.args | list | `[]` |  |
| metrics-server.commonLabels | object | `{}` |  |
| metrics-server.containerPort | int | `10250` |  |
| metrics-server.defaultArgs[0] | string | `"--cert-dir=/tmp"` |  |
| metrics-server.defaultArgs[1] | string | `"--kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname"` |  |
| metrics-server.defaultArgs[2] | string | `"--kubelet-use-node-status-port"` |  |
| metrics-server.defaultArgs[3] | string | `"--metric-resolution=15s"` |  |
| metrics-server.deploymentAnnotations | object | `{}` |  |
| metrics-server.dnsConfig | object | `{}` |  |
| metrics-server.extraVolumeMounts | list | `[]` |  |
| metrics-server.extraVolumes | list | `[]` |  |
| metrics-server.fullnameOverride | string | `""` |  |
| metrics-server.hostNetwork.enabled | bool | `false` |  |
| metrics-server.hostUsers | string | `nil` |  |
| metrics-server.image.pullPolicy | string | `"IfNotPresent"` |  |
| metrics-server.image.repository | string | `"registry.k8s.io/metrics-server/metrics-server"` |  |
| metrics-server.image.tag | string | `""` |  |
| metrics-server.imagePullSecrets | list | `[]` |  |
| metrics-server.livenessProbe.failureThreshold | int | `3` |  |
| metrics-server.livenessProbe.httpGet.path | string | `"/livez"` |  |
| metrics-server.livenessProbe.httpGet.port | string | `"https"` |  |
| metrics-server.livenessProbe.httpGet.scheme | string | `"HTTPS"` |  |
| metrics-server.livenessProbe.initialDelaySeconds | int | `0` |  |
| metrics-server.livenessProbe.periodSeconds | int | `10` |  |
| metrics-server.metrics.enabled | bool | `false` |  |
| metrics-server.nameOverride | string | `""` |  |
| metrics-server.namespaceOverride | string | `""` |  |
| metrics-server.nodeSelector | object | `{}` |  |
| metrics-server.podAnnotations | object | `{}` |  |
| metrics-server.podDisruptionBudget.enabled | bool | `false` |  |
| metrics-server.podDisruptionBudget.maxUnavailable | string | `nil` |  |
| metrics-server.podDisruptionBudget.minAvailable | string | `nil` |  |
| metrics-server.podDisruptionBudget.unhealthyPodEvictionPolicy | string | `nil` |  |
| metrics-server.podLabels | object | `{}` |  |
| metrics-server.podSecurityContext | object | `{}` |  |
| metrics-server.priorityClassName | string | `"system-cluster-critical"` |  |
| metrics-server.rbac.create | bool | `true` |  |
| metrics-server.rbac.pspEnabled | bool | `false` |  |
| metrics-server.readinessProbe.failureThreshold | int | `3` |  |
| metrics-server.readinessProbe.httpGet.path | string | `"/readyz"` |  |
| metrics-server.readinessProbe.httpGet.port | string | `"https"` |  |
| metrics-server.readinessProbe.httpGet.scheme | string | `"HTTPS"` |  |
| metrics-server.readinessProbe.initialDelaySeconds | int | `20` |  |
| metrics-server.readinessProbe.periodSeconds | int | `10` |  |
| metrics-server.replicas | int | `1` |  |
| metrics-server.resources.requests.cpu | string | `"100m"` |  |
| metrics-server.resources.requests.memory | string | `"200Mi"` |  |
| metrics-server.revisionHistoryLimit | string | `nil` |  |
| metrics-server.schedulerName | string | `""` |  |
| metrics-server.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| metrics-server.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| metrics-server.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| metrics-server.securityContext.runAsNonRoot | bool | `true` |  |
| metrics-server.securityContext.runAsUser | int | `1000` |  |
| metrics-server.securityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| metrics-server.service.annotations | object | `{}` |  |
| metrics-server.service.labels | object | `{}` |  |
| metrics-server.service.port | int | `443` |  |
| metrics-server.service.type | string | `"ClusterIP"` |  |
| metrics-server.serviceAccount.annotations | object | `{}` |  |
| metrics-server.serviceAccount.create | bool | `true` |  |
| metrics-server.serviceAccount.name | string | `""` |  |
| metrics-server.serviceAccount.secrets | list | `[]` |  |
| metrics-server.serviceMonitor.additionalLabels | object | `{}` |  |
| metrics-server.serviceMonitor.enabled | bool | `false` |  |
| metrics-server.serviceMonitor.interval | string | `"1m"` |  |
| metrics-server.serviceMonitor.metricRelabelings | list | `[]` |  |
| metrics-server.serviceMonitor.relabelings | list | `[]` |  |
| metrics-server.serviceMonitor.scrapeTimeout | string | `"10s"` |  |
| metrics-server.tls.certManager.addInjectorAnnotations | bool | `true` |  |
| metrics-server.tls.certManager.annotations | object | `{}` |  |
| metrics-server.tls.certManager.duration | string | `""` |  |
| metrics-server.tls.certManager.existingIssuer.enabled | bool | `false` |  |
| metrics-server.tls.certManager.existingIssuer.kind | string | `"Issuer"` |  |
| metrics-server.tls.certManager.existingIssuer.name | string | `"my-issuer"` |  |
| metrics-server.tls.certManager.labels | object | `{}` |  |
| metrics-server.tls.certManager.renewBefore | string | `""` |  |
| metrics-server.tls.clusterDomain | string | `"cluster.local"` |  |
| metrics-server.tls.existingSecret.lookup | bool | `true` |  |
| metrics-server.tls.existingSecret.name | string | `""` |  |
| metrics-server.tls.helm.certDurationDays | int | `365` |  |
| metrics-server.tls.helm.lookup | bool | `true` |  |
| metrics-server.tls.type | string | `"metrics-server"` |  |
| metrics-server.tmpVolume.emptyDir | object | `{}` |  |
| metrics-server.tolerations | list | `[]` |  |
| metrics-server.topologySpreadConstraints | list | `[]` |  |
| metrics-server.updateStrategy | object | `{}` |  |
| prometheus.enabled | bool | `false` | Enables Prometheus Operator monitoring resources |
| prometheus.grafanaDashboard.enabled | bool | `true` | Add grafana dashboard as a configmap |
| prometheus.grafanaDashboard.label | object | `{"grafana_dashboard":"1"}` | Label to apply to the config map. Used by the Grafana sidecar to automatically install the dashboard |
| prometheus.rules.enabled | bool | `true` | Enables prometheus operator rules |
| prometheus.rules.labels | object | `{"prometheus":"prometheus-operator-prometheus"}` | Labels to affect to the Prometheus Rules |

## Installing the Chart

### With Helm

To install the chart with the release name `my-release`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/metrics-server
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: metrics-server
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.0"
    chart: metrics-server
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
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/metrics-server --config /charts/charts/metrics-server/ct.yaml
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template metrics-server . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```

