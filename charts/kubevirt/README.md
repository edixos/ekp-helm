# kubevirt
![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square) 

**Homepage:** <https://kubevirt.io>

----
[[_TOC_]]
----

## Prerequisites

- Helm ≥ 3.8
- Kubernetes 1.23+ (recommended 1.27+ for best KubeVirt compatibility)
- Sufficient nodes with KVM hardware virtualization enabled
- (Optional but recommended) [Prometheus Operator](https://github.com/prometheus-operator/prometheus-operator) or kube-prometheus-stack for monitoring


## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| hamzatalbi | <hamzatalbi831@gmail.com> | <https://github.com/TalbiHamza> |

## Description

A Helm chart for KubeVirt - Virtual Machine Management on Kubernetes

This chart deploys **KubeVirt** — a Kubernetes add-on that allows running and managing virtual machines (VMs) as native Kubernetes resources.

## Source Code

* <https://github.com/kubevirt/kubevirt>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| commonAnnotations | object | `{}` | Additional annotations to add to all resources |
| commonLabels | object | `{}` | Additional labels to add to all resources |
| fullnameOverride | string | `""` | Override the full name of the chart |
| kubevirt | object | `{"certificateRotateStrategy":{},"configuration":{},"infra":{"nodePlacement":{"affinity":{},"nodeSelector":{"kubernetes.io/os":"linux"},"tolerations":[{"effect":"NoSchedule","key":"klastro.io/lab","operator":"Exists"}]}},"name":"kubevirt","workloads":{"nodePlacement":{"affinity":{"nodeAffinity":{"preferredDuringSchedulingIgnoredDuringExecution":[{"preference":{"matchExpressions":[{"key":"kubernetes.io/os","operator":"In","values":["linux"]}]},"weight":100}]}},"nodeSelector":{},"tolerations":[]}}}` | KubeVirt CR configuration |
| kubevirt.certificateRotateStrategy | object | `{}` | Certificate rotation strategy |
| kubevirt.configuration | object | `{}` | Developer configuration |
| kubevirt.infra | object | `{"nodePlacement":{"affinity":{},"nodeSelector":{"kubernetes.io/os":"linux"},"tolerations":[{"effect":"NoSchedule","key":"klastro.io/lab","operator":"Exists"}]}}` | Infrastructure components placement (controllers, webhooks, etc.) |
| kubevirt.infra.nodePlacement | object | `{"affinity":{},"nodeSelector":{"kubernetes.io/os":"linux"},"tolerations":[{"effect":"NoSchedule","key":"klastro.io/lab","operator":"Exists"}]}` | Node placement configuration for infrastructure components |
| kubevirt.infra.nodePlacement.affinity | object | `{}` | Affinity rules for infrastructure components |
| kubevirt.infra.nodePlacement.nodeSelector | object | `{"kubernetes.io/os":"linux"}` | Node selector for infrastructure components |
| kubevirt.infra.nodePlacement.tolerations | list | `[{"effect":"NoSchedule","key":"klastro.io/lab","operator":"Exists"}]` | Tolerations for infrastructure components |
| kubevirt.name | string | `"kubevirt"` | Name of the KubeVirt CR |
| kubevirt.workloads | object | `{"nodePlacement":{"affinity":{"nodeAffinity":{"preferredDuringSchedulingIgnoredDuringExecution":[{"preference":{"matchExpressions":[{"key":"kubernetes.io/os","operator":"In","values":["linux"]}]},"weight":100}]}},"nodeSelector":{},"tolerations":[]}}` | Workload VM placement configuration |
| kubevirt.workloads.nodePlacement | object | `{"affinity":{"nodeAffinity":{"preferredDuringSchedulingIgnoredDuringExecution":[{"preference":{"matchExpressions":[{"key":"kubernetes.io/os","operator":"In","values":["linux"]}]},"weight":100}]}},"nodeSelector":{},"tolerations":[]}` | Node placement configuration for VM workloads |
| kubevirt.workloads.nodePlacement.affinity | object | `{"nodeAffinity":{"preferredDuringSchedulingIgnoredDuringExecution":[{"preference":{"matchExpressions":[{"key":"kubernetes.io/os","operator":"In","values":["linux"]}]},"weight":100}]}}` | Affinity rules for VM workloads |
| kubevirt.workloads.nodePlacement.nodeSelector | object | `{}` | Node selector for VM workloads |
| kubevirt.workloads.nodePlacement.tolerations | list | `[]` | Tolerations for VM workloads |
| monitoring | object | `{"enabled":true,"serviceMonitor":{"enabled":true,"interval":"30s","labels":{"release":"kube-prometheus-stack"},"namespace":"","scrapeTimeout":"10s"}}` | Monitoring configuration |
| monitoring.enabled | bool | `true` | Enable Prometheus monitoring |
| monitoring.serviceMonitor | object | `{"enabled":true,"interval":"30s","labels":{"release":"kube-prometheus-stack"},"namespace":"","scrapeTimeout":"10s"}` | ServiceMonitor configuration (requires prometheus-operator) |
| monitoring.serviceMonitor.enabled | bool | `true` | Create ServiceMonitor resource |
| monitoring.serviceMonitor.interval | string | `"30s"` | Scrape interval |
| monitoring.serviceMonitor.labels | object | `{"release":"kube-prometheus-stack"}` | Additional labels for ServiceMonitor |
| monitoring.serviceMonitor.namespace | string | `""` | ServiceMonitor namespace (defaults to release namespace) |
| monitoring.serviceMonitor.scrapeTimeout | string | `"10s"` | Scrape timeout |
| nameOverride | string | `""` | Override the name of the chart |
| namespace | object | `{"create":true,"labels":{"kubevirt.io":"","pod-security.kubernetes.io/enforce":"privileged"},"name":"kubevirt"}` | Namespace configuration |
| namespace.create | bool | `true` | Create namespace |
| namespace.labels | object | `{"kubevirt.io":"","pod-security.kubernetes.io/enforce":"privileged"}` | Namespace labels |
| namespace.name | string | `"kubevirt"` | Namespace name |
| operator | object | `{"affinity":{"podAntiAffinity":{"preferredDuringSchedulingIgnoredDuringExecution":[{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"kubevirt.io","operator":"In","values":["virt-operator"]}]},"topologyKey":"kubernetes.io/hostname"},"weight":1}]}},"image":{"pullPolicy":"IfNotPresent","repository":"quay.io/kubevirt/virt-operator","tag":""},"nodeSelector":{"kubernetes.io/os":"linux"},"replicas":2,"resources":{"requests":{"cpu":"10m","memory":"450Mi"}},"tolerations":[{"key":"CriticalAddonsOnly","operator":"Exists"}]}` | Operator configuration |
| operator.affinity | object | `{"podAntiAffinity":{"preferredDuringSchedulingIgnoredDuringExecution":[{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"kubevirt.io","operator":"In","values":["virt-operator"]}]},"topologyKey":"kubernetes.io/hostname"},"weight":1}]}}` | Affinity rules for operator pods (pod anti-affinity enabled by default) |
| operator.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| operator.image.repository | string | `"quay.io/kubevirt/virt-operator"` | Operator image repository |
| operator.image.tag | string | `""` | Operator image tag (overrides version if set) |
| operator.nodeSelector | object | `{"kubernetes.io/os":"linux"}` | Node selector for operator pods |
| operator.replicas | int | `2` | Number of operator replicas |
| operator.resources.requests.cpu | string | `"10m"` | CPU request for operator |
| operator.resources.requests.memory | string | `"450Mi"` | Memory request for operator |
| operator.tolerations | list | `[{"key":"CriticalAddonsOnly","operator":"Exists"}]` | Tolerations for operator pods |
| podSecurityContext | object | `{"runAsNonRoot":true,"seccompProfile":{"type":"RuntimeDefault"}}` | Security context for operator pod |
| priorityClass | object | `{"create":true,"description":"This priority class should be used for core kubevirt components only.","globalDefault":false,"name":"kubevirt-cluster-critical","value":1000000000}` | Priority class configuration |
| priorityClass.create | bool | `true` | Create priority class |
| priorityClass.description | string | `"This priority class should be used for core kubevirt components only."` | Priority class description |
| priorityClass.globalDefault | bool | `false` | Set as global default |
| priorityClass.name | string | `"kubevirt-cluster-critical"` | Priority class name |
| priorityClass.value | int | `1000000000` | Priority value (higher = more important) |
| prometheus.enabled | bool | `false` | Enables prometheus operator resources |
| prometheus.grafanaDashboard.enabled | bool | `false` | If `true`, deploy grafana dashboard |
| prometheus.grafanaDashboard.label | object | `{"grafana_dashboard":"1"}` | Labels to apply to dashboard configmap |
| prometheus.rules.labels | object | `{"prometheus":"prometheus-operator-prometheus"}` | Labels to affect to the Prometheus Rules |
| prometheus.serviceMonitor.annotations | object | `{}` | Map of annotations to apply to the ServiceMonitor |
| prometheus.serviceMonitor.bearerTokenFile | string | `nil` |  |
| prometheus.serviceMonitor.enabled | bool | `false` | Enables prometheus operator service monitor |
| prometheus.serviceMonitor.interval | string | `""` | Scrape interval. If not set, the Prometheus default scrape interval is used. dd |
| prometheus.serviceMonitor.labels | object | `{"prometheus":"prometheus-operator-prometheus"}` | Map of labels to apply to the servicemonitor |
| prometheus.serviceMonitor.metricRelabelings | list | `[]` | metric relabel configs to apply to samples before ingestion. |
| prometheus.serviceMonitor.relabelings | list | `[]` | Relabel configs to apply to samples before ingestion. |
| prometheus.serviceMonitor.scheme | string | `""` | HTTP scheme to use for scraping. Can be used with `tlsConfig` for example if using istio mTLS. |
| prometheus.serviceMonitor.tlsConfig | object | `{}` | TLS configuration to use when scraping the endpoint. For example if using istio mTLS. Of type: https://github.com/prometheus-operator/prometheus-operator/blob/master/Documentation/api.md#tlsconfig |
| rbac | object | `{"create":true}` | RBAC configuration |
| rbac.create | bool | `true` | Create RBAC resources |
| securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"seccompProfile":{"type":"RuntimeDefault"}}` | Security context for operator container |
| serviceAccount | object | `{"annotations":{},"create":true,"name":"kubevirt-operator"}` | Service account configuration |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Create service account |
| serviceAccount.name | string | `"kubevirt-operator"` | Service account name |
| version | string | `"v1.5.2"` | KubeVirt version |

## Installing the Chart

### With Helm

Add the repository and install with default values:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm repo update

helm install my-kubevirt ekp-helm/kubevirt \
  --namespace kubevirt \
  --create-namespace

### With Helm
helm install my-kubevirt ekp-helm/kubevirt \
  --namespace kubevirt \
  --create-namespace \
  -f values.yaml

### With ArgoCD

#### Cluster k8s with access to public registry

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: kubevirt
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.0"
    chart: kubevirt
    path: ''

    helm:

      values: |
        ""

  destination:
    server: https://kubernetes.default.svc
    namespace: "infra-monitoring"

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
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/kubevirt --config /charts/charts/kubevirt/ct.yaml
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

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template kubevirt . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```
