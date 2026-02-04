# kyverno

![Version: 0.1.4](https://img.shields.io/badge/Version-0.1.4-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.17.0](https://img.shields.io/badge/AppVersion-v1.17.0-informational?style=flat-square)

## Prerequisites

- Helm v3
- Config Connector installed (v1.6.0)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://kyverno.github.io/kyverno/ | kyverno | 3.7.0 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| wiemaouadi | <wiem.aouadi3@gmail.com> | <https://github.com/wiemaouadi> |
| smileisak | <ikaboubi@gmail.com> | <https://github.com/smileisak> |

## Description

A Helm chart for kyverno

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| kyverno.admissionController.annotations | object | `{}` | Deployment annotations. |
| kyverno.admissionController.antiAffinity.enabled | bool | `true` | Pod antiAffinities toggle. Enabled by default but can be disabled if you want to schedule pods to the same node. |
| kyverno.admissionController.apiPriorityAndFairness | bool | `false` | Change `apiPriorityAndFairness` to `true` if you want to insulate the API calls made by Kyverno admission controller activities. This will help ensure Kyverno stability in busy clusters. Ref: https://kubernetes.io/docs/concepts/cluster-administration/flow-control/ |
| kyverno.admissionController.autoscaling.behavior | object | `{}` | Configurable scaling behavior |
| kyverno.admissionController.autoscaling.enabled | bool | `false` | Enable horizontal pod autoscaling |
| kyverno.admissionController.autoscaling.maxReplicas | int | `10` | Maximum number of pods |
| kyverno.admissionController.autoscaling.minReplicas | int | `1` | Minimum number of pods |
| kyverno.admissionController.autoscaling.targetCPUUtilizationPercentage | int | `80` | Target CPU utilization percentage |
| kyverno.admissionController.caCertificates.data | string | `nil` | CA certificates to use with Kyverno deployments This value is expected to be one large string of CA certificates |
| kyverno.admissionController.caCertificates.volume | object | `{}` | Volume to be mounted for CA certificates Not used when `.Values.admissionController.caCertificates.data` is defined |
| kyverno.admissionController.certManager | object | `{"algorithm":"RSA","ca":{"duration":"87600h","renewBefore":"720h"},"createSelfSignedIssuer":true,"enabled":false,"issuerRef":{"group":"cert-manager.io","kind":"ClusterIssuer","name":""},"size":2048,"tls":{"duration":"8760h","renewBefore":"720h"}}` | Configure cert-manager to manage TLS certificates. When enabled, cert-manager Certificate resources will be created to provision the TLS certificates for the admission controller. Requires cert-manager to be installed in the cluster. Takes precedence over createSelfSignedCert when enabled. |
| kyverno.admissionController.certManager.algorithm | string | `"RSA"` | Key algorithm for certificates (RSA, ECDSA, Ed25519) |
| kyverno.admissionController.certManager.ca | object | `{"duration":"87600h","renewBefore":"720h"}` | CA certificate configuration |
| kyverno.admissionController.certManager.ca.duration | string | `"87600h"` | Duration of the CA certificate (default 10 years) |
| kyverno.admissionController.certManager.ca.renewBefore | string | `"720h"` | Time before expiry to renew the CA certificate (default 30 days) |
| kyverno.admissionController.certManager.createSelfSignedIssuer | bool | `true` | Create a self-signed ClusterIssuer for CA generation. Set to false if you want to use an existing issuer specified in issuerRef. |
| kyverno.admissionController.certManager.enabled | bool | `false` | Enable cert-manager integration for certificate management |
| kyverno.admissionController.certManager.issuerRef | object | `{"group":"cert-manager.io","kind":"ClusterIssuer","name":""}` | Reference to an existing issuer for signing CA certificates. Only used when createSelfSignedIssuer is false. |
| kyverno.admissionController.certManager.issuerRef.group | string | `"cert-manager.io"` | Group of the issuer |
| kyverno.admissionController.certManager.issuerRef.kind | string | `"ClusterIssuer"` | Kind of the issuer (ClusterIssuer or Issuer) |
| kyverno.admissionController.certManager.issuerRef.name | string | `""` | Name of the issuer |
| kyverno.admissionController.certManager.size | int | `2048` | Key size for RSA (2048, 4096) or ECDSA (256, 384). Ignored for Ed25519. |
| kyverno.admissionController.certManager.tls | object | `{"duration":"8760h","renewBefore":"720h"}` | TLS certificate configuration |
| kyverno.admissionController.certManager.tls.duration | string | `"8760h"` | Duration of the TLS certificate (default 1 year) |
| kyverno.admissionController.certManager.tls.renewBefore | string | `"720h"` | Time before expiry to renew the TLS certificate (default 30 days) |
| kyverno.admissionController.container.extraArgs | object | `{}` | Additional container args. |
| kyverno.admissionController.container.extraEnvVars | list | `[]` | Additional container environment variables. |
| kyverno.admissionController.container.image.defaultRegistry | string | `"reg.kyverno.io"` |  |
| kyverno.admissionController.container.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| kyverno.admissionController.container.image.registry | string | `nil` | Image registry |
| kyverno.admissionController.container.image.repository | string | `"kyverno/kyverno"` | Image repository |
| kyverno.admissionController.container.image.tag | string | `nil` | Image tag Defaults to appVersion in Chart.yaml if omitted |
| kyverno.admissionController.container.resources.limits | object | `{"memory":"384Mi"}` | Pod resource limits |
| kyverno.admissionController.container.resources.requests | object | `{"cpu":"100m","memory":"128Mi"}` | Pod resource requests |
| kyverno.admissionController.container.securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"privileged":false,"readOnlyRootFilesystem":true,"runAsNonRoot":true,"seccompProfile":{"type":"RuntimeDefault"}}` | Container security context |
| kyverno.admissionController.crdWatcher | bool | `false` | Enable/Disable custom resource watcher to invalidate cache |
| kyverno.admissionController.createSelfSignedCert | bool | `false` | Create self-signed certificates at deployment time. The certificates won't be automatically renewed if this is set to `true`. |
| kyverno.admissionController.dnsConfig | object | `{}` | `dnsConfig` allows to specify DNS configuration for the pod. For further reference: https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#pod-dns-config. |
| kyverno.admissionController.dnsPolicy | string | `"ClusterFirst"` | `dnsPolicy` determines the manner in which DNS resolution happens in the cluster. In case of `hostNetwork: true`, usually, the `dnsPolicy` is suitable to be `ClusterFirstWithHostNet`. For further reference: https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#pod-s-dns-policy. |
| kyverno.admissionController.extraContainers | list | `[]` | Array of extra containers to run alongside kyverno |
| kyverno.admissionController.extraInitContainers | list | `[]` | Array of extra init containers |
| kyverno.admissionController.featuresOverride | object | `{"admissionReports":{"backPressureThreshold":1000}}` | Overrides features defined at the root level |
| kyverno.admissionController.featuresOverride.admissionReports.backPressureThreshold | int | `1000` | Max number of admission reports allowed in flight until the admission controller stops creating new ones |
| kyverno.admissionController.hostNetwork | bool | `false` | Change `hostNetwork` to `true` when you want the pod to share its host's network namespace. Useful for situations like when you end up dealing with a custom CNI over Amazon EKS. Update the `dnsPolicy` accordingly as well to suit the host network mode. |
| kyverno.admissionController.imagePullSecrets | list | `[]` | Image pull secrets |
| kyverno.admissionController.initContainer.extraArgs | object | `{}` | Additional container args. |
| kyverno.admissionController.initContainer.extraEnvVars | list | `[]` | Additional container environment variables. |
| kyverno.admissionController.initContainer.image.defaultRegistry | string | `"reg.kyverno.io"` |  |
| kyverno.admissionController.initContainer.image.pullPolicy | string | `nil` | Image pull policy If missing, defaults to image.pullPolicy |
| kyverno.admissionController.initContainer.image.registry | string | `nil` | Image registry |
| kyverno.admissionController.initContainer.image.repository | string | `"kyverno/kyvernopre"` | Image repository |
| kyverno.admissionController.initContainer.image.tag | string | `nil` | Image tag If missing, defaults to image.tag |
| kyverno.admissionController.initContainer.resources.limits | object | `{"cpu":"100m","memory":"256Mi"}` | Pod resource limits |
| kyverno.admissionController.initContainer.resources.requests | object | `{"cpu":"10m","memory":"64Mi"}` | Pod resource requests |
| kyverno.admissionController.initContainer.securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"privileged":false,"readOnlyRootFilesystem":true,"runAsNonRoot":true,"seccompProfile":{"type":"RuntimeDefault"}}` | Container security context |
| kyverno.admissionController.livenessProbe | object | See [values.yaml](values.yaml) | Liveness probe. The block is directly forwarded into the deployment, so you can use whatever livenessProbe configuration you want. ref: https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/ |
| kyverno.admissionController.metering.collector | string | `""` | Otel collector endpoint |
| kyverno.admissionController.metering.config | string | `"prometheus"` | Otel configuration, can be `prometheus` or `grpc` |
| kyverno.admissionController.metering.creds | string | `""` | Otel collector credentials |
| kyverno.admissionController.metering.disabled | bool | `false` | Disable metrics export |
| kyverno.admissionController.metering.port | int | `8000` | Prometheus endpoint port |
| kyverno.admissionController.metricsService.annotations | object | `{}` | Service annotations. |
| kyverno.admissionController.metricsService.create | bool | `true` | Create service. |
| kyverno.admissionController.metricsService.nodePort | string | `nil` | Service node port. Only used if `type` is `NodePort`. |
| kyverno.admissionController.metricsService.port | int | `8000` | Service port. Kyverno's metrics server will be exposed at this port. |
| kyverno.admissionController.metricsService.trafficDistribution | string | `nil` | Service traffic distribution policy. Set to `PreferClose` to route traffic to nearby endpoints, reducing latency and cross-zone costs. |
| kyverno.admissionController.metricsService.type | string | `"ClusterIP"` | Service type. |
| kyverno.admissionController.networkPolicy.enabled | bool | `false` | When true, use a NetworkPolicy to allow ingress to the webhook This is useful on clusters using Calico and/or native k8s network policies in a default-deny setup. |
| kyverno.admissionController.networkPolicy.ingressFrom | list | `[]` | A list of valid from selectors according to https://kubernetes.io/docs/concepts/services-networking/network-policies. |
| kyverno.admissionController.nodeAffinity | object | `{}` | Node affinity constraints. |
| kyverno.admissionController.nodeSelector | object | `{"kubernetes.io/os":"linux"}` | Node labels for pod assignment |
| kyverno.admissionController.podAffinity | object | `{}` | Pod affinity constraints. |
| kyverno.admissionController.podAnnotations | object | `{}` | Additional annotations to add to each pod |
| kyverno.admissionController.podAntiAffinity | object | See [values.yaml](values.yaml) | Pod anti affinity constraints. |
| kyverno.admissionController.podDisruptionBudget.enabled | bool | `false` | Enable PodDisruptionBudget. Will always be enabled if replicas > 1. This non-declarative behavior should ideally be avoided, but changing it now would be breaking. |
| kyverno.admissionController.podDisruptionBudget.maxUnavailable | string | `nil` | Configures the maximum unavailable pods for disruptions. Cannot be used if `minAvailable` is set. |
| kyverno.admissionController.podDisruptionBudget.minAvailable | int | `1` | Configures the minimum available pods for disruptions. Cannot be used if `maxUnavailable` is set. |
| kyverno.admissionController.podDisruptionBudget.unhealthyPodEvictionPolicy | string | `nil` | Unhealthy pod eviction policy to be used. Possible values are `IfHealthyBudget` or `AlwaysAllow`. |
| kyverno.admissionController.podLabels | object | `{}` | Additional labels to add to each pod |
| kyverno.admissionController.podSecurityContext | object | `{}` | Security context for the pod |
| kyverno.admissionController.priorityClassName | string | `""` | Optional priority class |
| kyverno.admissionController.priorityLevelConfigurationSpec | object | See [values.yaml](values.yaml) | Priority level configuration. The block is directly forwarded into the priorityLevelConfiguration, so you can use whatever specification you want. ref: https://kubernetes.io/docs/concepts/cluster-administration/flow-control/#prioritylevelconfiguration |
| kyverno.admissionController.profiling.enabled | bool | `false` | Enable profiling |
| kyverno.admissionController.profiling.nodePort | string | `nil` | Service node port. Only used if `type` is `NodePort`. |
| kyverno.admissionController.profiling.port | int | `6060` | Profiling endpoint port |
| kyverno.admissionController.profiling.serviceType | string | `"ClusterIP"` | Service type. |
| kyverno.admissionController.rbac.clusterRole.extraResources | list | `[]` | Extra resource permissions to add in the cluster role |
| kyverno.admissionController.rbac.coreClusterRole.extraResources | list | See [values.yaml](values.yaml) | Extra resource permissions to add in the core cluster role. This was introduced to avoid breaking change in the chart but should ideally be moved in `clusterRole.extraResources`. |
| kyverno.admissionController.rbac.create | bool | `true` | Create RBAC resources |
| kyverno.admissionController.rbac.createViewRoleBinding | bool | `true` | Create rolebinding to view role |
| kyverno.admissionController.rbac.serviceAccount.annotations | object | `{}` | Annotations for the ServiceAccount |
| kyverno.admissionController.rbac.serviceAccount.automountServiceAccountToken | bool | `true` | Toggle automounting of the ServiceAccount |
| kyverno.admissionController.rbac.serviceAccount.name | string | `nil` | The ServiceAccount name |
| kyverno.admissionController.rbac.viewRoleName | string | `"view"` | The view role to use in the rolebinding |
| kyverno.admissionController.readinessProbe | object | See [values.yaml](values.yaml) | Readiness Probe. The block is directly forwarded into the deployment, so you can use whatever readinessProbe configuration you want. ref: https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/ |
| kyverno.admissionController.replicas | int | `nil` | Desired number of pods |
| kyverno.admissionController.resyncPeriod | string | `"15m"` | Resync period for informers |
| kyverno.admissionController.revisionHistoryLimit | int | `10` | The number of revisions to keep |
| kyverno.admissionController.service.annotations | object | `{}` | Service annotations. |
| kyverno.admissionController.service.nodePort | string | `nil` | Service node port. Only used if `type` is `NodePort`. |
| kyverno.admissionController.service.port | int | `443` | Service port. |
| kyverno.admissionController.service.trafficDistribution | string | `nil` | Service traffic distribution policy. Set to `PreferClose` to route traffic to nearby endpoints, reducing latency and cross-zone costs. |
| kyverno.admissionController.service.type | string | `"ClusterIP"` | Service type. |
| kyverno.admissionController.serviceMonitor.additionalAnnotations | object | `{}` | Additional annotations |
| kyverno.admissionController.serviceMonitor.additionalLabels | object | `{}` | Additional labels |
| kyverno.admissionController.serviceMonitor.enabled | bool | `false` | Create a `ServiceMonitor` to collect Prometheus metrics. |
| kyverno.admissionController.serviceMonitor.interval | string | `"30s"` | Interval to scrape metrics |
| kyverno.admissionController.serviceMonitor.metricRelabelings | list | `[]` | MetricRelabelConfigs to apply to samples before ingestion. |
| kyverno.admissionController.serviceMonitor.namespace | string | `nil` | Override namespace |
| kyverno.admissionController.serviceMonitor.relabelings | list | `[]` | RelabelConfigs to apply to samples before scraping |
| kyverno.admissionController.serviceMonitor.scrapeTimeout | string | `"25s"` | Timeout if metrics can't be retrieved in given time interval |
| kyverno.admissionController.serviceMonitor.secure | bool | `false` | Is TLS required for endpoint |
| kyverno.admissionController.serviceMonitor.tlsConfig | object | `{}` | TLS Configuration for endpoint |
| kyverno.admissionController.sigstoreVolume | object | `{"emptyDir":{}}` | Volume to be mounted in pods for TUF/cosign work. |
| kyverno.admissionController.startupProbe | object | See [values.yaml](values.yaml) | Startup probe. The block is directly forwarded into the deployment, so you can use whatever startupProbes configuration you want. ref: https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/ |
| kyverno.admissionController.tlsKeyAlgorithm | string | `"RSA"` | Key algorithm for self-signed TLS certificates. Supported values: RSA, ECDSA, Ed25519 Only used when createSelfSignedCert is false (Kyverno-managed certificates). |
| kyverno.admissionController.tolerations | list | `[]` | List of node taints to tolerate |
| kyverno.admissionController.topologySpreadConstraints | list | `[]` | Topology spread constraints. |
| kyverno.admissionController.tracing.address | string | `nil` | Traces receiver address |
| kyverno.admissionController.tracing.creds | string | `""` | Traces receiver credentials |
| kyverno.admissionController.tracing.enabled | bool | `false` | Enable tracing |
| kyverno.admissionController.tracing.port | string | `nil` | Traces receiver port |
| kyverno.admissionController.tufRootMountPath | string | `"/.sigstore"` | A writable volume to use for the TUF root initialization. |
| kyverno.admissionController.updateStrategy | object | See [values.yaml](values.yaml) | Deployment update strategy. Ref: https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy |
| kyverno.admissionController.webhookServer | object | `{"port":9443}` | admissionController webhook server port in case you are using hostNetwork: true, you might want to change the port the webhookServer is listening to |
| kyverno.apiVersionOverride.podDisruptionBudget | string | `nil` | Override api version used to create `PodDisruptionBudget`` resources. When not specified the chart will check if `policy/v1/PodDisruptionBudget` is available to determine the api version automatically. |
| kyverno.backgroundController.annotations | object | `{}` | Deployment annotations. |
| kyverno.backgroundController.antiAffinity.enabled | bool | `true` | Pod antiAffinities toggle. Enabled by default but can be disabled if you want to schedule pods to the same node. |
| kyverno.backgroundController.caCertificates.data | string | `nil` | CA certificates to use with Kyverno deployments This value is expected to be one large string of CA certificates |
| kyverno.backgroundController.caCertificates.volume | object | `{}` | Volume to be mounted for CA certificates Not used when `.Values.backgroundController.caCertificates.data` is defined |
| kyverno.backgroundController.dnsConfig | object | `{}` | `dnsConfig` allows to specify DNS configuration for the pod. For further reference: https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#pod-dns-config. |
| kyverno.backgroundController.dnsPolicy | string | `"ClusterFirst"` | `dnsPolicy` determines the manner in which DNS resolution happens in the cluster. In case of `hostNetwork: true`, usually, the `dnsPolicy` is suitable to be `ClusterFirstWithHostNet`. For further reference: https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#pod-s-dns-policy. |
| kyverno.backgroundController.enabled | bool | `true` | Enable background controller. |
| kyverno.backgroundController.extraArgs | object | `{}` | Extra arguments passed to the container on the command line |
| kyverno.backgroundController.extraEnvVars | list | `[]` | Additional container environment variables. |
| kyverno.backgroundController.featuresOverride | object | `{}` | Overrides features defined at the root level |
| kyverno.backgroundController.hostNetwork | bool | `false` | Change `hostNetwork` to `true` when you want the pod to share its host's network namespace. Useful for situations like when you end up dealing with a custom CNI over Amazon EKS. Update the `dnsPolicy` accordingly as well to suit the host network mode. |
| kyverno.backgroundController.image.defaultRegistry | string | `"reg.kyverno.io"` |  |
| kyverno.backgroundController.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| kyverno.backgroundController.image.registry | string | `nil` | Image registry |
| kyverno.backgroundController.image.repository | string | `"kyverno/background-controller"` | Image repository |
| kyverno.backgroundController.image.tag | string | `nil` | Image tag Defaults to appVersion in Chart.yaml if omitted |
| kyverno.backgroundController.imagePullSecrets | list | `[]` | Image pull secrets |
| kyverno.backgroundController.metering.collector | string | `""` | Otel collector endpoint |
| kyverno.backgroundController.metering.config | string | `"prometheus"` | Otel configuration, can be `prometheus` or `grpc` |
| kyverno.backgroundController.metering.creds | string | `""` | Otel collector credentials |
| kyverno.backgroundController.metering.disabled | bool | `false` | Disable metrics export |
| kyverno.backgroundController.metering.port | int | `8000` | Prometheus endpoint port |
| kyverno.backgroundController.metricsService.annotations | object | `{}` | Service annotations. |
| kyverno.backgroundController.metricsService.create | bool | `true` | Create service. |
| kyverno.backgroundController.metricsService.nodePort | string | `nil` | Service node port. Only used if `metricsService.type` is `NodePort`. |
| kyverno.backgroundController.metricsService.port | int | `8000` | Service port. Metrics server will be exposed at this port. |
| kyverno.backgroundController.metricsService.trafficDistribution | string | `nil` | Service traffic distribution policy. Set to `PreferClose` to route traffic to nearby endpoints, reducing latency and cross-zone costs. |
| kyverno.backgroundController.metricsService.type | string | `"ClusterIP"` | Service type. |
| kyverno.backgroundController.networkPolicy.enabled | bool | `false` | When true, use a NetworkPolicy to allow ingress to the webhook This is useful on clusters using Calico and/or native k8s network policies in a default-deny setup. |
| kyverno.backgroundController.networkPolicy.ingressFrom | list | `[]` | A list of valid from selectors according to https://kubernetes.io/docs/concepts/services-networking/network-policies. |
| kyverno.backgroundController.nodeAffinity | object | `{}` | Node affinity constraints. |
| kyverno.backgroundController.nodeSelector | object | `{"kubernetes.io/os":"linux"}` | Node labels for pod assignment |
| kyverno.backgroundController.podAffinity | object | `{}` | Pod affinity constraints. |
| kyverno.backgroundController.podAnnotations | object | `{}` | Additional annotations to add to each pod |
| kyverno.backgroundController.podAntiAffinity | object | See [values.yaml](values.yaml) | Pod anti affinity constraints. |
| kyverno.backgroundController.podDisruptionBudget.enabled | bool | `false` | Enable PodDisruptionBudget. Will always be enabled if replicas > 1. This non-declarative behavior should ideally be avoided, but changing it now would be breaking. |
| kyverno.backgroundController.podDisruptionBudget.maxUnavailable | string | `nil` | Configures the maximum unavailable pods for disruptions. Cannot be used if `minAvailable` is set. |
| kyverno.backgroundController.podDisruptionBudget.minAvailable | int | `1` | Configures the minimum available pods for disruptions. Cannot be used if `maxUnavailable` is set. |
| kyverno.backgroundController.podDisruptionBudget.unhealthyPodEvictionPolicy | string | `nil` | Unhealthy pod eviction policy to be used. Possible values are `IfHealthyBudget` or `AlwaysAllow`. |
| kyverno.backgroundController.podLabels | object | `{}` | Additional labels to add to each pod |
| kyverno.backgroundController.podSecurityContext | object | `{}` | Security context for the pod |
| kyverno.backgroundController.priorityClassName | string | `""` | Optional priority class |
| kyverno.backgroundController.profiling.enabled | bool | `false` | Enable profiling |
| kyverno.backgroundController.profiling.nodePort | string | `nil` | Service node port. Only used if `type` is `NodePort`. |
| kyverno.backgroundController.profiling.port | int | `6060` | Profiling endpoint port |
| kyverno.backgroundController.profiling.serviceType | string | `"ClusterIP"` | Service type. |
| kyverno.backgroundController.rbac.clusterRole.extraResources | list | `[]` | Extra resource permissions to add in the cluster role |
| kyverno.backgroundController.rbac.coreClusterRole.extraResources | list | See [values.yaml](values.yaml) | Extra resource permissions to add in the core cluster role. This was introduced to avoid breaking change in the chart but should ideally be moved in `clusterRole.extraResources`. |
| kyverno.backgroundController.rbac.create | bool | `true` | Create RBAC resources |
| kyverno.backgroundController.rbac.createViewRoleBinding | bool | `true` | Create rolebinding to view role |
| kyverno.backgroundController.rbac.serviceAccount.annotations | object | `{}` | Annotations for the ServiceAccount |
| kyverno.backgroundController.rbac.serviceAccount.automountServiceAccountToken | bool | `true` | Toggle automounting of the ServiceAccount |
| kyverno.backgroundController.rbac.serviceAccount.name | string | `nil` | Service account name |
| kyverno.backgroundController.rbac.viewRoleName | string | `"view"` | The view role to use in the rolebinding |
| kyverno.backgroundController.replicas | int | `nil` | Desired number of pods |
| kyverno.backgroundController.resources.limits | object | `{"memory":"128Mi"}` | Pod resource limits |
| kyverno.backgroundController.resources.requests | object | `{"cpu":"100m","memory":"64Mi"}` | Pod resource requests |
| kyverno.backgroundController.resyncPeriod | string | `"15m"` | Resync period for informers |
| kyverno.backgroundController.revisionHistoryLimit | int | `10` | The number of revisions to keep |
| kyverno.backgroundController.securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"privileged":false,"readOnlyRootFilesystem":true,"runAsNonRoot":true,"seccompProfile":{"type":"RuntimeDefault"}}` | Security context for the containers |
| kyverno.backgroundController.server | object | `{"port":9443}` | backgroundController server port in case you are using hostNetwork: true, you might want to change the port the backgroundController is listening to |
| kyverno.backgroundController.serviceMonitor.additionalAnnotations | object | `{}` | Additional annotations |
| kyverno.backgroundController.serviceMonitor.additionalLabels | object | `{}` | Additional labels |
| kyverno.backgroundController.serviceMonitor.enabled | bool | `false` | Create a `ServiceMonitor` to collect Prometheus metrics. |
| kyverno.backgroundController.serviceMonitor.interval | string | `"30s"` | Interval to scrape metrics |
| kyverno.backgroundController.serviceMonitor.metricRelabelings | list | `[]` | MetricRelabelConfigs to apply to samples before ingestion. |
| kyverno.backgroundController.serviceMonitor.namespace | string | `nil` | Override namespace |
| kyverno.backgroundController.serviceMonitor.relabelings | list | `[]` | RelabelConfigs to apply to samples before scraping |
| kyverno.backgroundController.serviceMonitor.scrapeTimeout | string | `"25s"` | Timeout if metrics can't be retrieved in given time interval |
| kyverno.backgroundController.serviceMonitor.secure | bool | `false` | Is TLS required for endpoint |
| kyverno.backgroundController.serviceMonitor.tlsConfig | object | `{}` | TLS Configuration for endpoint |
| kyverno.backgroundController.tolerations | list | `[]` | List of node taints to tolerate |
| kyverno.backgroundController.topologySpreadConstraints | list | `[]` | Topology spread constraints. |
| kyverno.backgroundController.tracing.address | string | `nil` | Traces receiver address |
| kyverno.backgroundController.tracing.creds | string | `""` | Traces receiver credentials |
| kyverno.backgroundController.tracing.enabled | bool | `false` | Enable tracing |
| kyverno.backgroundController.tracing.port | string | `nil` | Traces receiver port |
| kyverno.backgroundController.updateStrategy | object | See [values.yaml](values.yaml) | Deployment update strategy. Ref: https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy |
| kyverno.cleanupController.annotations | object | `{}` | Deployment annotations. |
| kyverno.cleanupController.antiAffinity.enabled | bool | `true` | Pod antiAffinities toggle. Enabled by default but can be disabled if you want to schedule pods to the same node. |
| kyverno.cleanupController.certManager | object | `{"algorithm":"RSA","ca":{"duration":"87600h","renewBefore":"720h"},"createSelfSignedIssuer":true,"enabled":false,"issuerRef":{"group":"cert-manager.io","kind":"ClusterIssuer","name":""},"size":2048,"tls":{"duration":"8760h","renewBefore":"720h"}}` | Configure cert-manager to manage TLS certificates. When enabled, cert-manager Certificate resources will be created to provision the TLS certificates for the cleanup controller. Requires cert-manager to be installed in the cluster. Takes precedence over createSelfSignedCert when enabled. |
| kyverno.cleanupController.certManager.algorithm | string | `"RSA"` | Key algorithm for certificates (RSA, ECDSA, Ed25519) |
| kyverno.cleanupController.certManager.ca | object | `{"duration":"87600h","renewBefore":"720h"}` | CA certificate configuration |
| kyverno.cleanupController.certManager.ca.duration | string | `"87600h"` | Duration of the CA certificate (default 10 years) |
| kyverno.cleanupController.certManager.ca.renewBefore | string | `"720h"` | Time before expiry to renew the CA certificate (default 30 days) |
| kyverno.cleanupController.certManager.createSelfSignedIssuer | bool | `true` | Create a self-signed ClusterIssuer for CA generation. Set to false if you want to use an existing issuer specified in issuerRef. |
| kyverno.cleanupController.certManager.enabled | bool | `false` | Enable cert-manager integration for certificate management |
| kyverno.cleanupController.certManager.issuerRef | object | `{"group":"cert-manager.io","kind":"ClusterIssuer","name":""}` | Reference to an existing issuer for signing CA certificates. Only used when createSelfSignedIssuer is false. |
| kyverno.cleanupController.certManager.issuerRef.group | string | `"cert-manager.io"` | Group of the issuer |
| kyverno.cleanupController.certManager.issuerRef.kind | string | `"ClusterIssuer"` | Kind of the issuer (ClusterIssuer or Issuer) |
| kyverno.cleanupController.certManager.issuerRef.name | string | `""` | Name of the issuer |
| kyverno.cleanupController.certManager.size | int | `2048` | Key size for RSA (2048, 4096) or ECDSA (256, 384). Ignored for Ed25519. |
| kyverno.cleanupController.certManager.tls | object | `{"duration":"8760h","renewBefore":"720h"}` | TLS certificate configuration |
| kyverno.cleanupController.certManager.tls.duration | string | `"8760h"` | Duration of the TLS certificate (default 1 year) |
| kyverno.cleanupController.certManager.tls.renewBefore | string | `"720h"` | Time before expiry to renew the TLS certificate (default 30 days) |
| kyverno.cleanupController.createSelfSignedCert | bool | `false` | Create self-signed certificates at deployment time. The certificates won't be automatically renewed if this is set to `true`. |
| kyverno.cleanupController.dnsConfig | object | `{}` | `dnsConfig` allows to specify DNS configuration for the pod. For further reference: https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#pod-dns-config. |
| kyverno.cleanupController.dnsPolicy | string | `"ClusterFirst"` | `dnsPolicy` determines the manner in which DNS resolution happens in the cluster. In case of `hostNetwork: true`, usually, the `dnsPolicy` is suitable to be `ClusterFirstWithHostNet`. For further reference: https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#pod-s-dns-policy. |
| kyverno.cleanupController.enabled | bool | `true` | Enable cleanup controller. |
| kyverno.cleanupController.extraArgs | object | `{}` | Extra arguments passed to the container on the command line |
| kyverno.cleanupController.extraEnvVars | list | `[]` | Additional container environment variables. |
| kyverno.cleanupController.featuresOverride | object | `{}` | Overrides features defined at the root level |
| kyverno.cleanupController.hostNetwork | bool | `false` | Change `hostNetwork` to `true` when you want the pod to share its host's network namespace. Useful for situations like when you end up dealing with a custom CNI over Amazon EKS. Update the `dnsPolicy` accordingly as well to suit the host network mode. |
| kyverno.cleanupController.image.defaultRegistry | string | `"reg.kyverno.io"` |  |
| kyverno.cleanupController.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| kyverno.cleanupController.image.registry | string | `nil` | Image registry |
| kyverno.cleanupController.image.repository | string | `"kyverno/cleanup-controller"` | Image repository |
| kyverno.cleanupController.image.tag | string | `nil` | Image tag Defaults to appVersion in Chart.yaml if omitted |
| kyverno.cleanupController.imagePullSecrets | list | `[]` | Image pull secrets |
| kyverno.cleanupController.livenessProbe | object | See [values.yaml](values.yaml) | Liveness probe. The block is directly forwarded into the deployment, so you can use whatever livenessProbe configuration you want. ref: https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/ |
| kyverno.cleanupController.metering.collector | string | `""` | Otel collector endpoint |
| kyverno.cleanupController.metering.config | string | `"prometheus"` | Otel configuration, can be `prometheus` or `grpc` |
| kyverno.cleanupController.metering.creds | string | `""` | Otel collector credentials |
| kyverno.cleanupController.metering.disabled | bool | `false` | Disable metrics export |
| kyverno.cleanupController.metering.port | int | `8000` | Prometheus endpoint port |
| kyverno.cleanupController.metricsService.annotations | object | `{}` | Service annotations. |
| kyverno.cleanupController.metricsService.create | bool | `true` | Create service. |
| kyverno.cleanupController.metricsService.nodePort | string | `nil` | Service node port. Only used if `metricsService.type` is `NodePort`. |
| kyverno.cleanupController.metricsService.port | int | `8000` | Service port. Metrics server will be exposed at this port. |
| kyverno.cleanupController.metricsService.trafficDistribution | string | `nil` | Service traffic distribution policy. Set to `PreferClose` to route traffic to nearby endpoints, reducing latency and cross-zone costs. |
| kyverno.cleanupController.metricsService.type | string | `"ClusterIP"` | Service type. |
| kyverno.cleanupController.networkPolicy.enabled | bool | `false` | When true, use a NetworkPolicy to allow ingress to the webhook This is useful on clusters using Calico and/or native k8s network policies in a default-deny setup. |
| kyverno.cleanupController.networkPolicy.ingressFrom | list | `[]` | A list of valid from selectors according to https://kubernetes.io/docs/concepts/services-networking/network-policies. |
| kyverno.cleanupController.nodeAffinity | object | `{}` | Node affinity constraints. |
| kyverno.cleanupController.nodeSelector | object | `{"kubernetes.io/os":"linux"}` | Node labels for pod assignment |
| kyverno.cleanupController.podAffinity | object | `{}` | Pod affinity constraints. |
| kyverno.cleanupController.podAnnotations | object | `{}` | Additional annotations to add to each pod |
| kyverno.cleanupController.podAntiAffinity | object | See [values.yaml](values.yaml) | Pod anti affinity constraints. |
| kyverno.cleanupController.podDisruptionBudget.enabled | bool | `false` | Enable PodDisruptionBudget. Will always be enabled if replicas > 1. This non-declarative behavior should ideally be avoided, but changing it now would be breaking. |
| kyverno.cleanupController.podDisruptionBudget.maxUnavailable | string | `nil` | Configures the maximum unavailable pods for disruptions. Cannot be used if `minAvailable` is set. |
| kyverno.cleanupController.podDisruptionBudget.minAvailable | int | `1` | Configures the minimum available pods for disruptions. Cannot be used if `maxUnavailable` is set. |
| kyverno.cleanupController.podDisruptionBudget.unhealthyPodEvictionPolicy | string | `nil` | Unhealthy pod eviction policy to be used. Possible values are `IfHealthyBudget` or `AlwaysAllow`. |
| kyverno.cleanupController.podLabels | object | `{}` | Additional labels to add to each pod |
| kyverno.cleanupController.podSecurityContext | object | `{}` | Security context for the pod |
| kyverno.cleanupController.priorityClassName | string | `""` | Optional priority class |
| kyverno.cleanupController.profiling.enabled | bool | `false` | Enable profiling |
| kyverno.cleanupController.profiling.nodePort | string | `nil` | Service node port. Only used if `type` is `NodePort`. |
| kyverno.cleanupController.profiling.port | int | `6060` | Profiling endpoint port |
| kyverno.cleanupController.profiling.serviceType | string | `"ClusterIP"` | Service type. |
| kyverno.cleanupController.rbac.clusterRole.extraResources | list | `[]` | Extra resource permissions to add in the cluster role |
| kyverno.cleanupController.rbac.create | bool | `true` | Create RBAC resources |
| kyverno.cleanupController.rbac.serviceAccount.annotations | object | `{}` | Annotations for the ServiceAccount |
| kyverno.cleanupController.rbac.serviceAccount.automountServiceAccountToken | bool | `true` | Toggle automounting of the ServiceAccount |
| kyverno.cleanupController.rbac.serviceAccount.name | string | `nil` | Service account name |
| kyverno.cleanupController.readinessProbe | object | See [values.yaml](values.yaml) | Readiness Probe. The block is directly forwarded into the deployment, so you can use whatever readinessProbe configuration you want. ref: https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/ |
| kyverno.cleanupController.replicas | int | `nil` | Desired number of pods |
| kyverno.cleanupController.resources.limits | object | `{"memory":"128Mi"}` | Pod resource limits |
| kyverno.cleanupController.resources.requests | object | `{"cpu":"100m","memory":"64Mi"}` | Pod resource requests |
| kyverno.cleanupController.resyncPeriod | string | `"15m"` | Resync period for informers |
| kyverno.cleanupController.revisionHistoryLimit | int | `10` | The number of revisions to keep |
| kyverno.cleanupController.securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"privileged":false,"readOnlyRootFilesystem":true,"runAsNonRoot":true,"seccompProfile":{"type":"RuntimeDefault"}}` | Security context for the containers |
| kyverno.cleanupController.server | object | `{"port":9443}` | cleanupController server port in case you are using hostNetwork: true, you might want to change the port the cleanupController is listening to |
| kyverno.cleanupController.service.annotations | object | `{}` | Service annotations. |
| kyverno.cleanupController.service.nodePort | string | `nil` | Service node port. Only used if `service.type` is `NodePort`. |
| kyverno.cleanupController.service.port | int | `443` | Service port. |
| kyverno.cleanupController.service.trafficDistribution | string | `nil` | Service traffic distribution policy. Set to `PreferClose` to route traffic to nearby endpoints, reducing latency and cross-zone costs. |
| kyverno.cleanupController.service.type | string | `"ClusterIP"` | Service type. |
| kyverno.cleanupController.serviceMonitor.additionalAnnotations | object | `{}` | Additional annotations |
| kyverno.cleanupController.serviceMonitor.additionalLabels | object | `{}` | Additional labels |
| kyverno.cleanupController.serviceMonitor.enabled | bool | `false` | Create a `ServiceMonitor` to collect Prometheus metrics. |
| kyverno.cleanupController.serviceMonitor.interval | string | `"30s"` | Interval to scrape metrics |
| kyverno.cleanupController.serviceMonitor.metricRelabelings | list | `[]` | MetricRelabelConfigs to apply to samples before ingestion. |
| kyverno.cleanupController.serviceMonitor.namespace | string | `nil` | Override namespace |
| kyverno.cleanupController.serviceMonitor.relabelings | list | `[]` | RelabelConfigs to apply to samples before scraping |
| kyverno.cleanupController.serviceMonitor.scrapeTimeout | string | `"25s"` | Timeout if metrics can't be retrieved in given time interval |
| kyverno.cleanupController.serviceMonitor.secure | bool | `false` | Is TLS required for endpoint |
| kyverno.cleanupController.serviceMonitor.tlsConfig | object | `{}` | TLS Configuration for endpoint |
| kyverno.cleanupController.startupProbe | object | See [values.yaml](values.yaml) | Startup probe. The block is directly forwarded into the deployment, so you can use whatever startupProbes configuration you want. ref: https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/ |
| kyverno.cleanupController.tlsKeyAlgorithm | string | `"RSA"` | Key algorithm for self-signed TLS certificates. Supported values: RSA, ECDSA, Ed25519 Only used when createSelfSignedCert is false (Kyverno-managed certificates). |
| kyverno.cleanupController.tolerations | list | `[]` | List of node taints to tolerate |
| kyverno.cleanupController.topologySpreadConstraints | list | `[]` | Topology spread constraints. |
| kyverno.cleanupController.tracing.address | string | `nil` | Traces receiver address |
| kyverno.cleanupController.tracing.creds | string | `""` | Traces receiver credentials |
| kyverno.cleanupController.tracing.enabled | bool | `false` | Enable tracing |
| kyverno.cleanupController.tracing.port | string | `nil` | Traces receiver port |
| kyverno.cleanupController.updateStrategy | object | See [values.yaml](values.yaml) | Deployment update strategy. Ref: https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy |
| kyverno.config.annotations | object | `{}` | Additional annotations to add to the configmap. |
| kyverno.config.create | bool | `true` | Create the configmap. |
| kyverno.config.defaultRegistry | string | `"docker.io"` | The registry hostname used for the image mutation. |
| kyverno.config.enableDefaultRegistryMutation | bool | `true` | Enable registry mutation for container images. Enabled by default. |
| kyverno.config.excludeClusterRoles | list | `[]` | Exclude roles |
| kyverno.config.excludeGroups | list | `["system:nodes"]` | Exclude groups |
| kyverno.config.excludeKyvernoNamespace | bool | `true` | Exclude Kyverno namespace Determines if default Kyverno namespace exclusion is enabled for webhooks and resourceFilters |
| kyverno.config.excludeRoles | list | `[]` | Exclude roles |
| kyverno.config.excludeUsernames | list | `[]` | Exclude usernames |
| kyverno.config.generateSuccessEvents | bool | `false` | Generate success events. |
| kyverno.config.matchConditions | list | `[]` | Defines match conditions to set on webhook configurations (requires Kubernetes 1.27+). |
| kyverno.config.maxContextSize | string | 2Mi | Maximum cumulative size of context data during policy evaluation. Supports Kubernetes quantity format (e.g., 100Mi, 2Gi) or plain bytes (e.g., 2097152). Limits memory used by context variables to prevent unbounded growth. Increase if policies legitimately need large context data (e.g., processing large ConfigMaps). Set to 0 to disable the limit (not recommended for production). |
| kyverno.config.name | string | `nil` | The configmap name (required if `create` is `false`). |
| kyverno.config.preserve | bool | `true` | Preserve the configmap settings during upgrade. |
| kyverno.config.resourceFilters | list | See [values.yaml](values.yaml) | Resource types to be skipped by the Kyverno policy engine. Make sure to surround each entry in quotes so that it doesn't get parsed as a nested YAML list. These are joined together without spaces, run through `tpl`, and the result is set in the config map. |
| kyverno.config.resourceFiltersExclude | list | `[]` | resourceFilters exclude list Items to exclude from config.resourceFilters |
| kyverno.config.resourceFiltersExcludeNamespaces | list | `[]` | resourceFilter namespace exclude Namespaces to exclude from the default resourceFilters |
| kyverno.config.resourceFiltersInclude | list | `[]` | resourceFilters include list Items to include to config.resourceFilters |
| kyverno.config.resourceFiltersIncludeNamespaces | list | `[]` | resourceFilter namespace include Namespaces to include to the default resourceFilters |
| kyverno.config.updateRequestThreshold | int | `1000` | Sets the threshold for the total number of UpdateRequests generated for mutateExisitng and generate policies. |
| kyverno.config.webhookAnnotations | object | `{"admissions.enforcer/disabled":"true"}` | Defines annotations to set on webhook configurations. |
| kyverno.config.webhookLabels | object | `{}` | Defines labels to set on webhook configurations. |
| kyverno.config.webhooks | object | `{"namespaceSelector":{"matchExpressions":[{"key":"kubernetes.io/metadata.name","operator":"NotIn","values":["kube-system"]}]}}` | Defines the `namespaceSelector`/`objectSelector` in the webhook configurations. The Kyverno namespace is excluded if `excludeKyvernoNamespace` is `true` (default) |
| kyverno.crds.annotations | object | `{}` | Additional CRDs annotations |
| kyverno.crds.customLabels | object | `{}` | Additional CRDs labels |
| kyverno.crds.groups.kyverno | object | `{"cleanuppolicies":true,"clustercleanuppolicies":true,"clusterpolicies":true,"globalcontextentries":true,"policies":true,"policyexceptions":true,"updaterequests":true}` | Install CRDs in group `kyverno.io` |
| kyverno.crds.groups.policies | object | `{"deletingpolicies":true,"generatingpolicies":true,"imagevalidatingpolicies":true,"mutatingpolicies":true,"namespaceddeletingpolicies":true,"namespacedimagevalidatingpolicies":true,"namespacedmutatingpolicies":true,"namespacedvalidatingpolicies":true,"policyexceptions":true,"validatingpolicies":true}` | Install CRDs in group `policies.kyverno.io` |
| kyverno.crds.groups.reports | object | `{"clusterephemeralreports":true,"ephemeralreports":true}` | Install CRDs in group `reports.kyverno.io` |
| kyverno.crds.groups.wgpolicyk8s | object | `{"clusterpolicyreports":true,"policyreports":true}` | Install CRDs in group `wgpolicyk8s.io` |
| kyverno.crds.install | bool | `true` | Whether to have Helm install the Kyverno CRDs, if the CRDs are not installed by Helm, they must be added before policies can be created |
| kyverno.crds.migration.enabled | bool | `true` | Enable CRDs migration using helm post upgrade hook |
| kyverno.crds.migration.image.defaultRegistry | string | `"reg.kyverno.io"` |  |
| kyverno.crds.migration.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| kyverno.crds.migration.image.registry | string | `nil` | Image registry |
| kyverno.crds.migration.image.repository | string | `"kyverno/kyverno-cli"` | Image repository |
| kyverno.crds.migration.image.tag | string | `nil` | Image tag Defaults to appVersion in Chart.yaml if omitted |
| kyverno.crds.migration.imagePullSecrets | list | `[]` | Image pull secrets |
| kyverno.crds.migration.nodeAffinity | object | `{}` | Node affinity constraints. |
| kyverno.crds.migration.nodeSelector | object | `{}` | Node labels for pod assignment |
| kyverno.crds.migration.podAffinity | object | `{}` | Pod affinity constraints. |
| kyverno.crds.migration.podAnnotations | object | `{}` | Pod annotations. |
| kyverno.crds.migration.podAntiAffinity | object | `{}` | Pod anti affinity constraints. |
| kyverno.crds.migration.podLabels | object | `{}` | Pod labels. |
| kyverno.crds.migration.podResources.limits | object | `{"cpu":"100m","memory":"256Mi"}` | Pod resource limits |
| kyverno.crds.migration.podResources.requests | object | `{"cpu":"10m","memory":"64Mi"}` | Pod resource requests |
| kyverno.crds.migration.podSecurityContext | object | `{}` | Security context for the pod |
| kyverno.crds.migration.resources | list | `["cleanuppolicies.kyverno.io","clustercleanuppolicies.kyverno.io","clusterpolicies.kyverno.io","globalcontextentries.kyverno.io","policies.kyverno.io","policyexceptions.kyverno.io","updaterequests.kyverno.io","deletingpolicies.policies.kyverno.io","generatingpolicies.policies.kyverno.io","imagevalidatingpolicies.policies.kyverno.io","mutatingpolicies.policies.kyverno.io","namespaceddeletingpolicies.policies.kyverno.io","namespacedgeneratingpolicies.policies.kyverno.io","namespacedimagevalidatingpolicies.policies.kyverno.io","namespacedmutatingpolicies.policies.kyverno.io","namespacedvalidatingpolicies.policies.kyverno.io","policyexceptions.policies.kyverno.io","validatingpolicies.policies.kyverno.io"]` | Resources to migrate |
| kyverno.crds.migration.securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"privileged":false,"readOnlyRootFilesystem":true,"runAsGroup":65534,"runAsNonRoot":true,"runAsUser":65534,"seccompProfile":{"type":"RuntimeDefault"}}` | Security context for the hook containers |
| kyverno.crds.migration.serviceAccount.automountServiceAccountToken | bool | `true` | Toggle automounting of the ServiceAccount |
| kyverno.crds.migration.tolerations | list | `[]` | List of node taints to tolerate |
| kyverno.crds.reportsServer.enabled | bool | `false` | Kyverno reports-server is used in your cluster |
| kyverno.customLabels | object | `{}` | Additional labels |
| kyverno.existingImagePullSecrets | list | `[]` | Existing Image pull secrets for image verification policies, this will define the `--imagePullSecrets` argument |
| kyverno.features.admissionReports.enabled | bool | `true` | Enables the feature |
| kyverno.features.aggregateReports.enabled | bool | `true` | Enables the feature |
| kyverno.features.autoUpdateWebhooks.enabled | bool | `true` | Enables the feature |
| kyverno.features.backgroundScan.backgroundScanInterval | string | `"1h"` | Background scan interval |
| kyverno.features.backgroundScan.backgroundScanWorkers | int | `2` | Number of background scan workers |
| kyverno.features.backgroundScan.enabled | bool | `true` | Enables the feature |
| kyverno.features.backgroundScan.skipResourceFilters | bool | `true` | Skips resource filters in background scan |
| kyverno.features.configMapCaching.enabled | bool | `true` | Enables the feature |
| kyverno.features.controllerRuntimeMetrics.bindAddress | string | `":8080"` | Bind address for controller-runtime metrics (use "0" to disable it) |
| kyverno.features.deferredLoading.enabled | bool | `true` | Enables the feature |
| kyverno.features.dumpPatches.enabled | bool | `false` | Enables the feature |
| kyverno.features.dumpPayload.enabled | bool | `false` | Enables the feature |
| kyverno.features.forceFailurePolicyIgnore.enabled | bool | `false` | Enables the feature |
| kyverno.features.generateMutatingAdmissionPolicy.enabled | bool | `false` | Enables the feature |
| kyverno.features.generateValidatingAdmissionPolicy.enabled | bool | `true` | Enables the feature |
| kyverno.features.globalContext.maxApiCallResponseLength | int | `2000000` | Maximum allowed response size from API Calls. A value of 0 bypasses checks (not recommended) |
| kyverno.features.logging.format | string | `"text"` | Logging format |
| kyverno.features.logging.verbosity | int | `2` | Logging verbosity |
| kyverno.features.mutatingAdmissionPolicyReports.enabled | bool | `false` | Enables the feature |
| kyverno.features.omitEvents.eventTypes | list | `["PolicyApplied","PolicySkipped"]` | Events which should not be emitted (possible values `PolicyViolation`, `PolicyApplied`, `PolicyError`, and `PolicySkipped`) |
| kyverno.features.policyExceptions.enabled | bool | `false` | Enables the feature |
| kyverno.features.policyExceptions.namespace | string | `""` | Restrict policy exceptions to a single namespace Set to "*" to allow exceptions in all namespaces |
| kyverno.features.policyReports.enabled | bool | `true` | Enables the feature |
| kyverno.features.protectManagedResources.enabled | bool | `false` | Enables the feature |
| kyverno.features.registryClient.allowInsecure | bool | `false` | Allow insecure registry |
| kyverno.features.registryClient.credentialHelpers | list | `["default","google","amazon","azure","github"]` | Enable registry client helpers |
| kyverno.features.reporting.generate | bool | `true` | Enables the feature |
| kyverno.features.reporting.imageVerify | bool | `true` | Enables the feature |
| kyverno.features.reporting.mutate | bool | `true` | Enables the feature |
| kyverno.features.reporting.mutateExisting | bool | `true` | Enables the feature |
| kyverno.features.reporting.validate | bool | `true` | Enables the feature |
| kyverno.features.ttlController.reconciliationInterval | string | `"1m"` | Reconciliation interval for the label based cleanup manager |
| kyverno.features.tuf.enabled | bool | `false` | Enables the feature |
| kyverno.features.tuf.mirror | string | `nil` | Tuf mirror |
| kyverno.features.tuf.root | string | `nil` | Path to Tuf root |
| kyverno.features.tuf.rootRaw | string | `nil` | Raw Tuf root |
| kyverno.features.validatingAdmissionPolicyReports.enabled | bool | `true` | Enables the feature |
| kyverno.fullnameOverride | string | `nil` | Override the expanded name of the chart |
| kyverno.global.caCertificates.data | string | `nil` | Global CA certificates to use with Kyverno deployments This value is expected to be one large string of CA certificates Individual controller values will override this global value |
| kyverno.global.caCertificates.volume | object | `{}` | Global value to set single volume to be mounted for CA certificates for all deployments. Not used when `.Values.global.caCertificates.data` is defined Individual  controller values will override this global value |
| kyverno.global.crdWatcher | bool | `false` | Enable/Disable custom resource watcher to invalidate cache |
| kyverno.global.extraEnvVars | list | `[]` | Additional container environment variables to apply to all containers and init containers |
| kyverno.global.image.registry | string | `nil` | Global value that allows to set a single image registry across all deployments. When set, it will override any values set under `.image.registry` across the chart. |
| kyverno.global.imagePullSecrets | list | `[]` | Global list of Image pull secrets When set, it will override any values set under `imagePullSecrets` under different components across the chart. |
| kyverno.global.nodeSelector | object | `{}` | Global node labels for pod assignment. Non-global values will override the global value. |
| kyverno.global.resyncPeriod | string | `"15m"` | Resync period for informers |
| kyverno.global.tolerations | list | `[]` | Global List of node taints to tolerate. Non-global values will override the global value. |
| kyverno.grafana.annotations | object | `{}` | Grafana dashboard configmap annotations. |
| kyverno.grafana.configMapName | string | `"{{ include \"kyverno.fullname\" . }}-grafana"` | Configmap name template. |
| kyverno.grafana.enabled | bool | `false` | Enable grafana dashboard creation. |
| kyverno.grafana.grafanaDashboard | object | `{"allowCrossNamespaceImport":true,"create":false,"folder":"kyverno","matchLabels":{"dashboards":"grafana"}}` | create GrafanaDashboard custom resource referencing to the configMap. according to https://grafana-operator.github.io/grafana-operator/docs/examples/dashboard_from_configmap/readme/ |
| kyverno.grafana.labels | object | `{"grafana_dashboard":"1"}` | Grafana dashboard configmap labels |
| kyverno.grafana.namespace | string | `nil` | Namespace to create the grafana dashboard configmap. If not set, it will be created in the same namespace where the chart is deployed. |
| kyverno.imagePullSecrets | object | `{}` | Image pull secrets for image verification policies, this will define the `--imagePullSecrets` argument |
| kyverno.metricsConfig.annotations | object | `{}` | Additional annotations to add to the configmap. |
| kyverno.metricsConfig.bucketBoundaries | list | `[0.005,0.01,0.025,0.05,0.1,0.25,0.5,1,2.5,5,10,15,20,25,30]` | Configures the bucket boundaries for all Histogram metrics, changing this configuration requires restart of the kyverno admission controller |
| kyverno.metricsConfig.create | bool | `true` | Create the configmap. |
| kyverno.metricsConfig.metricsExposure | map | `{"kyverno_admission_requests_total":{"disabledLabelDimensions":["resource_namespace"]},"kyverno_admission_review_duration_seconds":{"disabledLabelDimensions":["resource_namespace"]},"kyverno_cleanup_controller_deletedobjects_total":{"disabledLabelDimensions":["resource_namespace","policy_namespace"]},"kyverno_generating_policy_execution_duration_seconds":{"disabledLabelDimensions":["resource_namespace","resource_request_operation"]},"kyverno_image_validating_policy_execution_duration_seconds":{"disabledLabelDimensions":["resource_namespace","resource_request_operation"]},"kyverno_mutating_policy_execution_duration_seconds":{"disabledLabelDimensions":["resource_namespace","resource_request_operation"]},"kyverno_policy_execution_duration_seconds":{"disabledLabelDimensions":["resource_namespace","resource_request_operation"]},"kyverno_policy_results_total":{"disabledLabelDimensions":["resource_namespace","policy_namespace"]},"kyverno_policy_rule_info_total":{"disabledLabelDimensions":["resource_namespace","policy_namespace"]},"kyverno_validating_policy_execution_duration_seconds":{"disabledLabelDimensions":["resource_namespace","resource_request_operation"]}}` | Configures the exposure of individual metrics, by default all metrics and all labels are exported, changing this configuration requires restart of the kyverno admission controller |
| kyverno.metricsConfig.metricsRefreshInterval | string | `nil` | Rate at which metrics should reset so as to clean up the memory footprint of kyverno metrics, if you might be expecting high memory footprint of Kyverno's metrics. Default: 0, no refresh of metrics. WARNING: This flag is not working since Kyverno 1.8.0 |
| kyverno.metricsConfig.name | string | `nil` | The configmap name (required if `create` is `false`). |
| kyverno.metricsConfig.namespaces.exclude | list | `[]` | list of namespaces to NOT capture metrics for. |
| kyverno.metricsConfig.namespaces.include | list | `[]` | List of namespaces to capture metrics for. |
| kyverno.nameOverride | string | `nil` | Override the name of the chart |
| kyverno.namespaceOverride | string | `nil` | Override the namespace the chart deploys to |
| kyverno.openreports.enabled | bool | `false` | Enable OpenReports feature in controllers |
| kyverno.openreports.installCrds | bool | `false` | Whether to install CRDs from the upstream OpenReports chart. Setting this to true requires enabled to also be true. |
| kyverno.rbac.roles.aggregate | object | `{"admin":true,"view":true}` | Aggregate ClusterRoles to Kubernetes default user-facing roles. For more information, see [User-facing roles](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#user-facing-roles) |
| kyverno.reportsController.annotations | object | `{}` | Deployment annotations. |
| kyverno.reportsController.antiAffinity.enabled | bool | `true` | Pod antiAffinities toggle. Enabled by default but can be disabled if you want to schedule pods to the same node. |
| kyverno.reportsController.apiPriorityAndFairness | bool | `false` | Change `apiPriorityAndFairness` to `true` if you want to insulate the API calls made by Kyverno reports controller activities. This will help ensure Kyverno reports stability in busy clusters. Ref: https://kubernetes.io/docs/concepts/cluster-administration/flow-control/ |
| kyverno.reportsController.caCertificates.data | string | `nil` | CA certificates to use with Kyverno deployments This value is expected to be one large string of CA certificates |
| kyverno.reportsController.caCertificates.volume | object | `{}` | Volume to be mounted for CA certificates Not used when `.Values.reportsController.caCertificates.data` is defined |
| kyverno.reportsController.dnsConfig | object | `{}` | `dnsConfig` allows to specify DNS configuration for the pod. For further reference: https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#pod-dns-config. |
| kyverno.reportsController.dnsPolicy | string | `"ClusterFirst"` | `dnsPolicy` determines the manner in which DNS resolution happens in the cluster. In case of `hostNetwork: true`, usually, the `dnsPolicy` is suitable to be `ClusterFirstWithHostNet`. For further reference: https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#pod-s-dns-policy. |
| kyverno.reportsController.enabled | bool | `true` | Enable reports controller. |
| kyverno.reportsController.extraArgs | object | `{}` | Extra arguments passed to the container on the command line |
| kyverno.reportsController.extraEnvVars | list | `[]` | Additional container environment variables. |
| kyverno.reportsController.featuresOverride | object | `{}` | Overrides features defined at the root level |
| kyverno.reportsController.hostNetwork | bool | `false` | Change `hostNetwork` to `true` when you want the pod to share its host's network namespace. Useful for situations like when you end up dealing with a custom CNI over Amazon EKS. Update the `dnsPolicy` accordingly as well to suit the host network mode. |
| kyverno.reportsController.image.defaultRegistry | string | `"reg.kyverno.io"` |  |
| kyverno.reportsController.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| kyverno.reportsController.image.registry | string | `nil` | Image registry |
| kyverno.reportsController.image.repository | string | `"kyverno/reports-controller"` | Image repository |
| kyverno.reportsController.image.tag | string | `nil` | Image tag Defaults to appVersion in Chart.yaml if omitted |
| kyverno.reportsController.imagePullSecrets | list | `[]` | Image pull secrets |
| kyverno.reportsController.metering.collector | string | `nil` | Otel collector endpoint |
| kyverno.reportsController.metering.config | string | `"prometheus"` | Otel configuration, can be `prometheus` or `grpc` |
| kyverno.reportsController.metering.creds | string | `nil` | Otel collector credentials |
| kyverno.reportsController.metering.disabled | bool | `false` | Disable metrics export |
| kyverno.reportsController.metering.port | int | `8000` | Prometheus endpoint port |
| kyverno.reportsController.metricsService.annotations | object | `{}` | Service annotations. |
| kyverno.reportsController.metricsService.create | bool | `true` | Create service. |
| kyverno.reportsController.metricsService.nodePort | string | `nil` | Service node port. Only used if `type` is `NodePort`. |
| kyverno.reportsController.metricsService.port | int | `8000` | Service port. Metrics server will be exposed at this port. |
| kyverno.reportsController.metricsService.trafficDistribution | string | `nil` | Service traffic distribution policy. Set to `PreferClose` to route traffic to nearby endpoints, reducing latency and cross-zone costs. |
| kyverno.reportsController.metricsService.type | string | `"ClusterIP"` | Service type. |
| kyverno.reportsController.networkPolicy.enabled | bool | `false` | When true, use a NetworkPolicy to allow ingress to the webhook This is useful on clusters using Calico and/or native k8s network policies in a default-deny setup. |
| kyverno.reportsController.networkPolicy.ingressFrom | list | `[]` | A list of valid from selectors according to https://kubernetes.io/docs/concepts/services-networking/network-policies. |
| kyverno.reportsController.nodeAffinity | object | `{}` | Node affinity constraints. |
| kyverno.reportsController.nodeSelector | object | `{"kubernetes.io/os":"linux"}` | Node labels for pod assignment |
| kyverno.reportsController.podAffinity | object | `{}` | Pod affinity constraints. |
| kyverno.reportsController.podAnnotations | object | `{}` | Additional annotations to add to each pod |
| kyverno.reportsController.podAntiAffinity | object | See [values.yaml](values.yaml) | Pod anti affinity constraints. |
| kyverno.reportsController.podDisruptionBudget.enabled | bool | `false` | Enable PodDisruptionBudget. Will always be enabled if replicas > 1. This non-declarative behavior should ideally be avoided, but changing it now would be breaking. |
| kyverno.reportsController.podDisruptionBudget.maxUnavailable | string | `nil` | Configures the maximum unavailable pods for disruptions. Cannot be used if `minAvailable` is set. |
| kyverno.reportsController.podDisruptionBudget.minAvailable | int | `1` | Configures the minimum available pods for disruptions. Cannot be used if `maxUnavailable` is set. |
| kyverno.reportsController.podDisruptionBudget.unhealthyPodEvictionPolicy | string | `nil` | Unhealthy pod eviction policy to be used. Possible values are `IfHealthyBudget` or `AlwaysAllow`. |
| kyverno.reportsController.podLabels | object | `{}` | Additional labels to add to each pod |
| kyverno.reportsController.podSecurityContext | object | `{}` | Security context for the pod |
| kyverno.reportsController.priorityClassName | string | `""` | Optional priority class |
| kyverno.reportsController.priorityLevelConfigurationSpec | object | See [values.yaml](values.yaml) | Priority level configuration. The block is directly forwarded into the priorityLevelConfiguration, so you can use whatever specification you want. ref: https://kubernetes.io/docs/concepts/cluster-administration/flow-control/#prioritylevelconfiguration |
| kyverno.reportsController.profiling.enabled | bool | `false` | Enable profiling |
| kyverno.reportsController.profiling.nodePort | string | `nil` | Service node port. Only used if `type` is `NodePort`. |
| kyverno.reportsController.profiling.port | int | `6060` | Profiling endpoint port |
| kyverno.reportsController.profiling.serviceType | string | `"ClusterIP"` | Service type. |
| kyverno.reportsController.rbac.clusterRole.extraResources | list | `[]` | Extra resource permissions to add in the cluster role |
| kyverno.reportsController.rbac.coreClusterRole.extraResources | list | See [values.yaml](values.yaml) | Extra resource permissions to add in the core cluster role. This was introduced to avoid breaking change in the chart but should ideally be moved in `clusterRole.extraResources`. |
| kyverno.reportsController.rbac.create | bool | `true` | Create RBAC resources |
| kyverno.reportsController.rbac.createViewRoleBinding | bool | `true` | Create rolebinding to view role |
| kyverno.reportsController.rbac.serviceAccount.annotations | object | `{}` | Annotations for the ServiceAccount |
| kyverno.reportsController.rbac.serviceAccount.automountServiceAccountToken | bool | `true` | Toggle automounting of the ServiceAccount |
| kyverno.reportsController.rbac.serviceAccount.name | string | `nil` | Service account name |
| kyverno.reportsController.rbac.viewRoleName | string | `"view"` | The view role to use in the rolebinding |
| kyverno.reportsController.replicas | int | `nil` | Desired number of pods |
| kyverno.reportsController.resources.limits | object | `{"memory":"128Mi"}` | Pod resource limits |
| kyverno.reportsController.resources.requests | object | `{"cpu":"100m","memory":"64Mi"}` | Pod resource requests |
| kyverno.reportsController.resyncPeriod | string | `"15m"` | Resync period for informers |
| kyverno.reportsController.revisionHistoryLimit | int | `10` | The number of revisions to keep |
| kyverno.reportsController.sanityChecks | bool | `true` | Enable sanity check for reports CRDs |
| kyverno.reportsController.securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"privileged":false,"readOnlyRootFilesystem":true,"runAsNonRoot":true,"seccompProfile":{"type":"RuntimeDefault"}}` | Security context for the containers |
| kyverno.reportsController.server | object | `{"port":9443}` | reportsController server port in case you are using hostNetwork: true, you might want to change the port the reportsController is listening to |
| kyverno.reportsController.serviceMonitor.additionalAnnotations | object | `{}` | Additional annotations |
| kyverno.reportsController.serviceMonitor.additionalLabels | object | `{}` | Additional labels |
| kyverno.reportsController.serviceMonitor.enabled | bool | `false` | Create a `ServiceMonitor` to collect Prometheus metrics. |
| kyverno.reportsController.serviceMonitor.interval | string | `"30s"` | Interval to scrape metrics |
| kyverno.reportsController.serviceMonitor.metricRelabelings | list | `[]` | MetricRelabelConfigs to apply to samples before ingestion. |
| kyverno.reportsController.serviceMonitor.namespace | string | `nil` | Override namespace |
| kyverno.reportsController.serviceMonitor.relabelings | list | `[]` | RelabelConfigs to apply to samples before scraping |
| kyverno.reportsController.serviceMonitor.scrapeTimeout | string | `"25s"` | Timeout if metrics can't be retrieved in given time interval |
| kyverno.reportsController.serviceMonitor.secure | bool | `false` | Is TLS required for endpoint |
| kyverno.reportsController.serviceMonitor.tlsConfig | object | `{}` | TLS Configuration for endpoint |
| kyverno.reportsController.sigstoreVolume | object | `{"emptyDir":{}}` | Volume to be mounted in pods for TUF/cosign work. |
| kyverno.reportsController.tolerations | list | `[]` | List of node taints to tolerate |
| kyverno.reportsController.topologySpreadConstraints | list | `[]` | Topology spread constraints. |
| kyverno.reportsController.tracing.address | string | `nil` | Traces receiver address |
| kyverno.reportsController.tracing.creds | string | `nil` | Traces receiver credentials |
| kyverno.reportsController.tracing.enabled | bool | `false` | Enable tracing |
| kyverno.reportsController.tracing.port | string | `nil` | Traces receiver port |
| kyverno.reportsController.tufRootMountPath | string | `"/.sigstore"` | A writable volume to use for the TUF root initialization. |
| kyverno.reportsController.updateStrategy | object | See [values.yaml](values.yaml) | Deployment update strategy. Ref: https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy |
| kyverno.reportsServer.enabled | bool | `false` | Enable reports-server deployment alongside Kyverno |
| kyverno.reportsServer.readinessTimeout | int | `300` | Timeout for waiting for reports-server readiness (in seconds) |
| kyverno.reportsServer.waitForReady | bool | `true` | Wait for reports-server to be ready before starting Kyverno components |
| kyverno.test.automountServiceAccountToken | bool | `true` | Toggle automounting of the ServiceAccount |
| kyverno.test.image.pullPolicy | string | `nil` | Image pull policy Defaults to image.pullPolicy if omitted |
| kyverno.test.image.registry | string | `"ghcr.io"` | Image registry |
| kyverno.test.image.repository | string | `"kyverno/readiness-checker"` | Image repository |
| kyverno.test.image.tag | string | `"v0.1.0"` | Image tag Defaults to `latest` if omitted |
| kyverno.test.imagePullSecrets | list | `[]` | Image pull secrets |
| kyverno.test.nodeSelector | object | `{}` | Node labels for pod assignment |
| kyverno.test.podAnnotations | object | `{}` | Additional Pod annotations |
| kyverno.test.resources.limits | object | `{"cpu":"100m","memory":"256Mi"}` | Pod resource limits |
| kyverno.test.resources.requests | object | `{"cpu":"10m","memory":"64Mi"}` | Pod resource requests |
| kyverno.test.securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"privileged":false,"readOnlyRootFilesystem":true,"runAsGroup":65534,"runAsNonRoot":true,"runAsUser":65534,"seccompProfile":{"type":"RuntimeDefault"}}` | Security context for the test containers |
| kyverno.test.sleep | int | `20` | Sleep time before running test |
| kyverno.test.tolerations | list | `[]` | List of node taints to tolerate |
| kyverno.upgrade.fromV2 | bool | `false` | Upgrading from v2 to v3 is not allowed by default, set this to true once changes have been reviewed. |
| kyverno.webhooksCleanup.autoDeleteWebhooks.enabled | bool | `false` | Allow webhooks controller to delete webhooks using finalizers |
| kyverno.webhooksCleanup.enabled | bool | `true` | Create a helm pre-delete hook to cleanup webhooks. |
| kyverno.webhooksCleanup.image.pullPolicy | string | `nil` | Image pull policy Defaults to image.pullPolicy if omitted |
| kyverno.webhooksCleanup.image.registry | string | `"registry.k8s.io"` | Image registry |
| kyverno.webhooksCleanup.image.repository | string | `"kubectl"` | Image repository |
| kyverno.webhooksCleanup.image.tag | string | `"v1.34.3"` | Image tag Defaults to `latest` if omitted |
| kyverno.webhooksCleanup.imagePullSecrets | list | `[]` | Image pull secrets |
| kyverno.webhooksCleanup.nodeAffinity | object | `{}` | Node affinity constraints. |
| kyverno.webhooksCleanup.nodeSelector | object | `{}` | Node labels for pod assignment |
| kyverno.webhooksCleanup.podAffinity | object | `{}` | Pod affinity constraints. |
| kyverno.webhooksCleanup.podAnnotations | object | `{}` | Pod annotations. |
| kyverno.webhooksCleanup.podAntiAffinity | object | `{}` | Pod anti affinity constraints. |
| kyverno.webhooksCleanup.podLabels | object | `{}` | Pod labels. |
| kyverno.webhooksCleanup.podSecurityContext | object | `{}` | Security context for the pod |
| kyverno.webhooksCleanup.resources.limits | object | `{"cpu":"100m","memory":"256Mi"}` | Pod resource limits |
| kyverno.webhooksCleanup.resources.requests | object | `{"cpu":"10m","memory":"64Mi"}` | Pod resource requests |
| kyverno.webhooksCleanup.securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"privileged":false,"readOnlyRootFilesystem":true,"runAsGroup":65534,"runAsNonRoot":true,"runAsUser":65534,"seccompProfile":{"type":"RuntimeDefault"}}` | Security context for the hook containers |
| kyverno.webhooksCleanup.serviceAccount.automountServiceAccountToken | bool | `true` | Toggle automounting of the ServiceAccount |
| kyverno.webhooksCleanup.tolerations | list | `[]` | List of node taints to tolerate |
| prometheus.enabled | bool | `false` | Enables Prometheus Operator monitoring |
| prometheus.grafanaDashboard.enabled | bool | `true` | Add grafana dashboard as a configmap |
| prometheus.grafanaDashboard.label | object | `{"grafana_dashboard":"1"}` | label to apply to the config map. Used by Grafana sidecar to automatically install the dashboard |
| prometheus.rules.enabled | bool | `true` | Enables prometheus operator rules |
| prometheus.rules.labels | object | `{"prometheus":"prometheus-operator-prometheus"}` | Labels to affect to the Prometheus Rules |

## Installing the Chart

### With Helm

To install the chart with the release name `my-release`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/kyverno
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: kyverno
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.4"
    chart: kyverno
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
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/kyverno --config /charts/charts/kyverno/ct.yaml
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template kyverno . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```

