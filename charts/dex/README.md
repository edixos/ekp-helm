# dex

![Version: 0.1.3](https://img.shields.io/badge/Version-0.1.3-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.42.0](https://img.shields.io/badge/AppVersion-2.42.0-informational?style=flat-square)

## Prerequisites

- Helm v3
- Config Connector installed (v1.6.0)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.dexidp.io | dex(dex) | 0.23.0 |
| https://edixos.github.io/ekp-helm | iamPolicyMembers(gcp-iam-policy-members) | 0.1.2 |
| https://edixos.github.io/ekp-helm | workloadIdentity(gcp-workload-identity) | 0.1.1 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| wiemaouadi | <wiem.aouadi3@gmail.com> | <https://github.com/wiemaouadi> |
| smileisak | <ikaboubi@gmail.com> | <https://github.com/smileisak> |

## Description

A Helm chart for Dex - OpenID Connect Identity (OIDC) and OAuth 2.0 Provider with Pluggable Connectors

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| dex.affinity | object | `{}` | [Affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity) configuration. See the [API reference](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#scheduling) for details. |
| dex.autoscaling | object | Disabled by default. | Autoscaling configuration (see [values.yaml](values.yaml) for details). |
| dex.commonLabels | object | `{}` | Labels to apply to all resources and selectors. |
| dex.config | object | `{}` | Application configuration. See the [official documentation](https://dexidp.io/docs/). |
| dex.configSecret.create | bool | `true` | Enable creating a secret from the values passed to `config`. If set to false, name must point to an existing secret. |
| dex.configSecret.name | string | `""` | The name of the secret to mount as configuration in the pod. If not set and create is true, a name is generated using the fullname template. Must point to secret that contains at least a `config.yaml` key. |
| dex.deploymentAnnotations | object | `{}` | Annotations to be added to deployment. |
| dex.deploymentLabels | object | `{}` | Labels to be added to deployment. |
| dex.env | object | `{}` | Additional environment variables passed directly to containers. See the [API reference](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#environment-variables) for details. |
| dex.envFrom | list | `[]` | Additional environment variables mounted from [secrets](https://kubernetes.io/docs/concepts/configuration/secret/#using-secrets-as-environment-variables) or [config maps](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/#configure-all-key-value-pairs-in-a-configmap-as-container-environment-variables). See the [API reference](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#environment-variables) for details. |
| dex.envVars | list | `[]` | Similar to env but with support for all possible configurations. See the [API reference](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#environment-variables) for details. |
| dex.fullnameOverride | string | `"test"` | A name to substitute for the full names of resources. |
| dex.grpc.enabled | bool | `false` | Enable the gRPC endpoint. Read more in the [documentation](https://dexidp.io/docs/api/). |
| dex.hostAliases | list | `[]` | A list of hosts and IPs that will be injected into the pod's hosts file if specified. See the [API reference](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#hostname-and-name-resolution) |
| dex.https.enabled | bool | `false` | Enable the HTTPS endpoint. |
| dex.image.pullPolicy | string | `"IfNotPresent"` | [Image pull policy](https://kubernetes.io/docs/concepts/containers/images/#updating-images) for updating already existing images on a node. |
| dex.image.repository | string | `"ghcr.io/dexidp/dex"` | Name of the image repository to pull the container image from. |
| dex.image.tag | string | `""` | Image tag override for the default value (chart appVersion). |
| dex.imagePullSecrets | list | `[]` | Reference to one or more secrets to be used when [pulling images](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/#create-a-pod-that-uses-your-secret) (from private registries). |
| dex.ingress.annotations | object | `{}` | Annotations to be added to the ingress. |
| dex.ingress.className | string | `""` | Ingress [class name](https://kubernetes.io/docs/concepts/services-networking/ingress/#ingress-class). |
| dex.ingress.enabled | bool | `false` | Enable [ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/). |
| dex.ingress.hosts | list | See [values.yaml](values.yaml). | Ingress host configuration. |
| dex.ingress.tls | list | See [values.yaml](values.yaml). | Ingress TLS configuration. |
| dex.nameOverride | string | `""` | A name in place of the chart name for `app:` labels. |
| dex.namespaceOverride | string | `""` | A namespace in place of the release namespace for all resources. |
| dex.networkPolicy.egressRules | list | `[]` | A list of network policy egress rules |
| dex.networkPolicy.enabled | bool | `false` | Create [Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/) |
| dex.nodeSelector | object | `{}` | [Node selector](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector) configuration. |
| dex.podAnnotations | object | `{}` | Annotations to be added to pods. |
| dex.podDisruptionBudget.enabled | bool | `false` | Enable a [pod distruption budget](https://kubernetes.io/docs/tasks/run-application/configure-pdb/) to help dealing with [disruptions](https://kubernetes.io/docs/concepts/workloads/pods/disruptions/). It is **highly recommended** for webhooks as disruptions can prevent launching new pods. |
| dex.podDisruptionBudget.maxUnavailable | int/percentage | `nil` | Number or percentage of pods that can be unavailable. |
| dex.podDisruptionBudget.minAvailable | int/percentage | `nil` | Number or percentage of pods that must remain available. |
| dex.podLabels | object | `{}` | Labels to be added to pods. |
| dex.podSecurityContext | object | `{}` | Pod [security context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod). See the [API reference](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#security-context) for details. |
| dex.priorityClassName | string | `""` | Specify a priority class name to set [pod priority](https://kubernetes.io/docs/concepts/scheduling-eviction/pod-priority-preemption/#pod-priority). |
| dex.rbac.create | bool | `true` | Specifies whether RBAC resources should be created. If disabled, the operator is responsible for creating the necessary resources based on the templates. |
| dex.rbac.createClusterScoped | bool | `true` | Specifies which RBAC resources should be created. If disabled, the operator is responsible for creating the necessary resources (ClusterRole and RoleBinding or CRD's) |
| dex.replicaCount | int | `1` | Number of replicas (pods) to launch. |
| dex.resources | object | No requests or limits. | Container resource [requests and limits](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/). See the [API reference](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#resources) for details. |
| dex.revisionHistoryLimit | int | `10` | Define the [count of deployment revisions](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#clean-up-policy) to be kept. May be set to 0 in case of GitOps deployment approach. |
| dex.securityContext | object | `{}` | Container [security context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container). See the [API reference](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#security-context-1) for details. |
| dex.service.annotations | object | `{}` | Annotations to be added to the service. |
| dex.service.clusterIP | string | `""` | Internal cluster service IP (when applicable) |
| dex.service.loadBalancerIP | string | `""` | Load balancer service IP (when applicable) |
| dex.service.ports.grpc.nodePort | int | `nil` | gRPC node port (when applicable) |
| dex.service.ports.grpc.port | int | `5557` | gRPC service port |
| dex.service.ports.http.nodePort | int | `nil` | HTTP node port (when applicable) |
| dex.service.ports.http.port | int | `5556` | HTTP service port |
| dex.service.ports.https.nodePort | int | `nil` | HTTPS node port (when applicable) |
| dex.service.ports.https.port | int | `5554` | HTTPS service port |
| dex.service.type | string | `"ClusterIP"` | Kubernetes [service type](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types). |
| dex.serviceAccount.annotations | object | `{}` | Annotations to be added to the service account. |
| dex.serviceAccount.create | bool | `true` | Enable service account creation. |
| dex.serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template. |
| dex.serviceMonitor.annotations | object | `{}` | Annotations to be added to the ServiceMonitor. # ref: https://github.com/coreos/prometheus-operator/blob/master/Documentation/api.md#prometheusspec |
| dex.serviceMonitor.bearerTokenFile | string | `nil` | Prometheus scrape bearerTokenFile |
| dex.serviceMonitor.enabled | bool | `false` | Enable Prometheus ServiceMonitor. See the [documentation](https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/design.md#servicemonitor) and the [API reference](https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/api.md#servicemonitor) for details. |
| dex.serviceMonitor.honorLabels | bool | `false` | HonorLabels chooses the metric's labels on collisions with target labels. |
| dex.serviceMonitor.interval | duration | `nil` | Prometheus scrape interval. |
| dex.serviceMonitor.labels | object | `{}` | Labels to be added to the ServiceMonitor. # ref: https://github.com/coreos/prometheus-operator/blob/master/Documentation/api.md#prometheusspec |
| dex.serviceMonitor.metricRelabelings | list | `[]` | Prometheus scrape metric relabel configs to apply to samples before ingestion. # [Metric Relabeling](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs) |
| dex.serviceMonitor.namespace | string | Release namespace. | Namespace where the ServiceMonitor resource should be deployed. |
| dex.serviceMonitor.path | string | `"/metrics"` | HTTP path to scrape for metrics. |
| dex.serviceMonitor.relabelings | list | `[]` | Relabel configs to apply to samples before ingestion. # [Relabeling](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config) |
| dex.serviceMonitor.scheme | string | `""` | HTTP scheme to use for scraping. Can be used with `tlsConfig` for example if using istio mTLS. |
| dex.serviceMonitor.scrapeTimeout | duration | `nil` | Prometheus scrape timeout. |
| dex.serviceMonitor.tlsConfig | object | `{}` | TLS configuration to use when scraping the endpoint. For example if using istio mTLS. # Of type: https://github.com/coreos/prometheus-operator/blob/master/Documentation/api.md#tlsconfig |
| dex.strategy | object | `{}` | Deployment [strategy](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy) configuration. |
| dex.tolerations | list | `[]` | [Tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/) for node taints. See the [API reference](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#scheduling) for details. |
| dex.topologySpreadConstraints | list | `[]` | [TopologySpreadConstraints](https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/) configuration. See the [API reference](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#scheduling) for details. |
| dex.volumeMounts | list | `[]` | Additional [volume mounts](https://kubernetes.io/docs/tasks/configure-pod-container/configure-volume-storage/). See the [API reference](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#volumes-1) for details. |
| dex.volumes | list | `[]` | Additional storage [volumes](https://kubernetes.io/docs/concepts/storage/volumes/). See the [API reference](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#volumes-1) for details. |
| iamPolicyMembers.members[0].member | string | `""` |  |
| iamPolicyMembers.members[0].name | string | `"ekp-dex-groups-reader"` |  |
| iamPolicyMembers.members[0].resourceRef.external | string | `""` |  |
| iamPolicyMembers.members[0].resourceRef.kind | string | `"Project"` |  |
| iamPolicyMembers.members[0].role | string | `"roles/iam.serviceAccountTokenCreator"` | Roles to apply to dex google service account |
| prometheus.enabled | bool | `false` | Enables Prometheus Operator monitoring |
| prometheus.grafanaDashboard.enabled | bool | `true` | Add grafana dashboard as a configmap |
| prometheus.grafanaDashboard.label | object | `{"grafana_dashboard":"1"}` | label to apply to the config map. Used by Grafana sidecar to automatically install the dashboard |
| prometheus.rules.enabled | bool | `true` | Enables prometheus operator rules |
| prometheus.rules.labels | object | `{"prometheus":"prometheus-operator-prometheus"}` | Labels to affect to the Prometheus Rules |
| tags.configConnector | bool | `false` | Enables Config Connector features |
| workloadIdentity.global.gsa.create | bool | `true` |  |
| workloadIdentity.global.gsa.name | string | `"wi-dex"` |  |
| workloadIdentity.global.gsa.project | string | `""` |  |
| workloadIdentity.global.ksa.name | string | `"default"` |  |
| workloadIdentity.global.ksa.namespace | string | `""` |  |

## Installing the Chart

### With Helm

To install the chart with the release name `my-release`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/dex
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: dex
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.3"
    chart: dex
    path: ''

    helm:

      values: |
        name: mysa

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
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/dex --config /charts/charts/dex/ct.yaml
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template dex . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```

