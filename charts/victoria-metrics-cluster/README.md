# victoria-metrics-cluster

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.148.0](https://img.shields.io/badge/AppVersion-v1.148.0-informational?style=flat-square)

## Prerequisites

- Helm v3
- Config Connector installed (v1.6.0)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://victoriametrics.github.io/helm-charts/ | vmcluster(victoria-metrics-cluster) | 0.47.0 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| mo-hamedaziz | <aziz@edixos.com> |  |

## Description

VictoriaMetrics in cluster mode (vmselect / vminsert / vmstorage / vmauth), packaged for the Edixos Kubernetes Platform. Wraps the upstream VictoriaMetrics cluster chart and adds the platform extensions it does not provide: ExternalSecrets for the credentials the components consume (enterprise license, vmauth config, vmbackupmanager object storage), curated PrometheusRule alerts for cluster and process health, and the official VictoriaMetrics cluster Grafana dashboard shipped as a sidecar-discoverable ConfigMap. Every extension is optional and driven entirely by values.

## Source Code

* <https://github.com/VictoriaMetrics/helm-charts/tree/master/charts/victoria-metrics-cluster>
* <https://docs.victoriametrics.com/helm/victoria-metrics-cluster/>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| externalSecrets | list | `[]` | ExternalSecrets rendered for the VictoriaMetrics components, e.g. the enterprise `license.key`, the vmauth config Secret, or the object storage credentials consumed by `vmcluster.vmstorage.vmbackupmanager`. Each entry takes `name`, `namespace`, an optional `syncWave` and the ExternalSecret `spec` verbatim. |
| global.enableArgocdAnnotations | bool | `false` | Annotate the platform extension resources with Argo CD sync options, so Argo CD does not dry-run them against CRDs that are not installed yet |
| prometheus.enabled | bool | `false` | Enables Prometheus Operator monitoring resources |
| prometheus.grafanaDashboard.enabled | bool | `true` | Add grafana dashboard as a configmap |
| prometheus.grafanaDashboard.label | object | `{"grafana_dashboard":"1"}` | Label to apply to the config map. Used by the Grafana sidecar to automatically install the dashboard |
| prometheus.rules.enabled | bool | `true` | Enables prometheus operator rules |
| prometheus.rules.labels | object | `{"prometheus":"prometheus-operator-prometheus"}` | Labels to affect to the Prometheus Rules |
| vmcluster.autoDiscovery | bool | `false` | use SRV discovery for storageNode and selectNode flags for enterprise version |
| vmcluster.common.image | object | `{"tag":""}` | common for all components image configuration |
| vmcluster.extraObjects | list | `[]` | Add extra specs dynamically to this chart |
| vmcluster.extraSecrets | list | `[]` |  |
| vmcluster.global.cluster | object | `{"dnsDomain":"cluster.local."}` | k8s cluster domain suffix, uses for building storage pods' FQDN. Details are [here](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/) |
| vmcluster.global.compatibility | object | `{"openshift":{"adaptSecurityContext":"auto"}}` | Openshift security context compatibility configuration |
| vmcluster.global.extraAnnotations | object | `{}` | Annotations added to all resources |
| vmcluster.global.extraLabels | object | `{}` | Labels added to all resources |
| vmcluster.global.image.registry | string | `""` | Image registry, that can be shared across multiple helm charts |
| vmcluster.global.image.vm.tag | string | `""` | Image tag for all vm charts |
| vmcluster.global.imagePullSecrets | list | `[]` | Image pull secrets, that can be shared across multiple helm charts |
| vmcluster.license | object | `{"key":"","secret":{"key":"","name":""}}` | Enterprise license key configuration for VictoriaMetrics enterprise. Required only for VictoriaMetrics enterprise. Check docs [here](https://docs.victoriametrics.com/victoriametrics/enterprise/), for more information, visit [site](https://victoriametrics.com/products/enterprise/). Request a trial license [here](https://victoriametrics.com/products/enterprise/trial/) Supported starting from VictoriaMetrics v1.94.0 |
| vmcluster.license.key | string | `""` | License key |
| vmcluster.license.secret | object | `{"key":"","name":""}` | Use existing secret with license key |
| vmcluster.license.secret.key | string | `""` | Key in secret with license key |
| vmcluster.license.secret.name | string | `""` | Existing secret name |
| vmcluster.nameOverride | string | `""` | Override chart name |
| vmcluster.printNotes | bool | `true` | Print information after deployment |
| vmcluster.serviceAccount.annotations | object | `{}` | Service account annotations |
| vmcluster.serviceAccount.automountToken | bool | `true` | mount API token to pod directly |
| vmcluster.serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| vmcluster.serviceAccount.extraLabels | object | `{}` | Service account labels |
| vmcluster.serviceAccount.name | string | `nil` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| vmcluster.vmauth.affinity | object | `{}` | Pod affinity |
| vmcluster.vmauth.annotations | object | `{}` | VMAuth annotations |
| vmcluster.vmauth.command | list | `[]` | Override default container command. Use when the VictoriaMetrics binary is available at a custom path |
| vmcluster.vmauth.config | object | `{}` | VMAuth configuration object.  It's possible to use given below predefined variables in config: * `{{ .vm.read }}` - parsed vmselect URL * `{{ .vm.write }}` - parsed vminsert URL  Example config:   unauthorized_user:     url_map:      - src_paths:          - '{{ .vm.read.path }}/.*'        url_prefix:          - '{{ urlJoin (omit .vm.read "path") }}/' |
| vmcluster.vmauth.configSecretName | string | `""` | VMAuth configuration secret name |
| vmcluster.vmauth.containerWorkingDir | string | `""` | Container workdir |
| vmcluster.vmauth.enabled | bool | `false` | Enable deployment of vmauth component. With vmauth enabled please set `service.clusterIP: None` and `service.type: ClusterIP` for `vminsert` and `vmselect` to use vmauth balancing benefits. |
| vmcluster.vmauth.env | list | `[]` | Additional environment variables (ex.: secret tokens, flags). Check [here](https://docs.victoriametrics.com/victoriametrics/#environment-variables) for details |
| vmcluster.vmauth.envFrom | list | `[]` | Specify alternative source for env variables |
| vmcluster.vmauth.extraArgs | object | `{"envflag.enable":true,"envflag.prefix":"VM_","loggerFormat":"json"}` | Extra command line arguments for vmauth component |
| vmcluster.vmauth.extraContainers | list | `[]` | Extra containers to run in a pod with vmauth |
| vmcluster.vmauth.extraLabels | object | `{}` | VMAuth additional labels |
| vmcluster.vmauth.extraVolumeMounts | list | `[]` | Extra Volume Mounts for the container |
| vmcluster.vmauth.extraVolumes | list | `[]` | Extra Volumes for the pod |
| vmcluster.vmauth.fullnameOverride | string | `""` | Overrides the full name of vmauth component |
| vmcluster.vmauth.horizontalPodAutoscaler | object | `{"behavior":{},"enabled":false,"maxReplicas":10,"metrics":[],"minReplicas":2}` | Horizontal Pod Autoscaler |
| vmcluster.vmauth.horizontalPodAutoscaler.behavior | object | `{}` | Behavior settings for scaling by the HPA |
| vmcluster.vmauth.horizontalPodAutoscaler.enabled | bool | `false` | Use HPA for vmauth component |
| vmcluster.vmauth.horizontalPodAutoscaler.maxReplicas | int | `10` | Maximum replicas for HPA to use to to scale the vmauth component |
| vmcluster.vmauth.horizontalPodAutoscaler.metrics | list | `[]` | Metric for HPA to use to scale the vmauth component |
| vmcluster.vmauth.horizontalPodAutoscaler.minReplicas | int | `2` | Minimum replicas for HPA to use to scale the vmauth component |
| vmcluster.vmauth.http | list | `[{"mtls":false,"mtlsCAFile":"","name":"http","primary":true,"tls":false,"tlsAutocertCacheDir":"","tlsAutocertEmail":"","tlsAutocertHosts":"","tlsCertFile":"","tlsKeyFile":"","tlsMinVersion":"","value":":8427"}]` | HTTP listen address configuration. See https://docs.victoriametrics.com/helm/victoria-metrics-cluster/#http-listen-address for details. |
| vmcluster.vmauth.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| vmcluster.vmauth.image.registry | string | `""` | Image registry |
| vmcluster.vmauth.image.repository | string | `"victoriametrics/vmauth"` | Image repository |
| vmcluster.vmauth.image.tag | string | `""` | Image tag override Chart.AppVersion |
| vmcluster.vmauth.image.variant | string | `""` | Variant of the image to use. e.g. cluster, enterprise-cluster |
| vmcluster.vmauth.ingress.annotations | object | `{}` | Ingress annotations |
| vmcluster.vmauth.ingress.enabled | bool | `false` | Enable deployment of ingress for vmauth component |
| vmcluster.vmauth.ingress.extraLabels | object | `{}` |  |
| vmcluster.vmauth.ingress.hosts | list | `[{"name":"vmauth.local","path":["/insert"],"port":"http"}]` | Array of host objects |
| vmcluster.vmauth.ingress.pathType | string | `"Prefix"` | pathType is only for k8s >= 1.1= |
| vmcluster.vmauth.ingress.tls | list | `[]` | Array of TLS objects |
| vmcluster.vmauth.initContainers | list | `[]` | Init containers for vmauth |
| vmcluster.vmauth.lifecycle | object | `{}` | Specify pod lifecycle |
| vmcluster.vmauth.name | string | `""` | Override default `app` label name |
| vmcluster.vmauth.nodeSelector | object | `{}` | Pod's node selector. Details are [here](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector) |
| vmcluster.vmauth.podAnnotations | object | `{}` | Pod's annotations |
| vmcluster.vmauth.podDisruptionBudget | object | `{"enabled":false,"labels":{},"maxUnavailable":0,"minAvailable":0,"unhealthyPodEvictionPolicy":null}` | See `kubectl explain poddisruptionbudget.spec` for more. Details are [here](https://kubernetes.io/docs/tasks/run-application/configure-pdb/) |
| vmcluster.vmauth.podDisruptionBudget.maxUnavailable | int | `0` | max number or percentage of pods that can be unavailable |
| vmcluster.vmauth.podDisruptionBudget.minAvailable | int | `0` | min number or percentage of pods that can be unavailable |
| vmcluster.vmauth.podDisruptionBudget.unhealthyPodEvictionPolicy | string | `nil` | Defines criteria when unhealthy pods should be considered for eviction |
| vmcluster.vmauth.podLabels | object | `{}` | VMAuth pod labels |
| vmcluster.vmauth.podSecurityContext | object | `{"enabled":false}` | Pod's security context. Details are [here](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) |
| vmcluster.vmauth.priorityClassName | string | `""` | Name of Priority Class |
| vmcluster.vmauth.probe.liveness | object | `{"failureThreshold":3,"initialDelaySeconds":5,"periodSeconds":15,"tcpSocket":{},"timeoutSeconds":5}` | VMAuth liveness probe |
| vmcluster.vmauth.probe.readiness | object | `{"failureThreshold":10,"httpGet":{},"initialDelaySeconds":5,"periodSeconds":5,"timeoutSeconds":5}` | VMAuth readiness probe |
| vmcluster.vmauth.probe.startup | object | `{}` | VMAuth startup probe |
| vmcluster.vmauth.replicaCount | int | `2` | Count of vmauth pods |
| vmcluster.vmauth.resources | object | `{}` | Resource object |
| vmcluster.vmauth.route.annotations | object | `{}` | HTTPRoute annotations |
| vmcluster.vmauth.route.enabled | bool | `false` | Enable deployment of HTTPRoute for vmauth component |
| vmcluster.vmauth.route.extraLabels | object | `{}` | HTTPRoute extra labels |
| vmcluster.vmauth.route.extraRules | list | `[]` | Extra rules to prepend to route. This is useful when working with annotation based services. |
| vmcluster.vmauth.route.filters | list | `[]` | Filters for a default rule in HTTPRoute |
| vmcluster.vmauth.route.hostnames | list | `[]` | Array of hostnames |
| vmcluster.vmauth.route.matches | list | `[{"path":{"type":"PathPrefix","value":"{{ dig \"extraArgs\" \"http.pathPrefix\" \"/\" .Values.vmauth }}"}}]` | Matches for a default rule in HTTPRoute |
| vmcluster.vmauth.route.parentRefs | list | `[]` | HTTPGateway objects refs |
| vmcluster.vmauth.route.timeouts | object | `{}` | Timeouts for a default rule in HTTPRoute |
| vmcluster.vmauth.runtimeClassName | string | `""` | Name of the [RuntimeClass](https://kubernetes.io/docs/concepts/containers/runtime-class/) used to run the pod, e.g. "gvisor" |
| vmcluster.vmauth.securityContext | object | `{"enabled":false}` | Pod's security context. Details are [here](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) |
| vmcluster.vmauth.service.annotations | object | `{}` | Service annotations |
| vmcluster.vmauth.service.clusterIP | string | `""` | Service ClusterIP |
| vmcluster.vmauth.service.enabled | bool | `true` | Create VMAuth service |
| vmcluster.vmauth.service.externalIPs | list | `[]` | Service External IPs. Details are [here]( https://kubernetes.io/docs/concepts/services-networking/service/#external-ips) |
| vmcluster.vmauth.service.externalTrafficPolicy | string | `""` | Service external traffic policy. Check [here](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip) for details |
| vmcluster.vmauth.service.extraPorts | list | `[]` | Extra service ports |
| vmcluster.vmauth.service.healthCheckNodePort | string | `""` | Health check node port for a service. Check [here](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip) for details |
| vmcluster.vmauth.service.ipFamilies | list | `[]` | List of service IP families. Check [here](https://kubernetes.io/docs/concepts/services-networking/dual-stack/#services) for details. |
| vmcluster.vmauth.service.ipFamilyPolicy | string | `""` | Service IP family policy. Check [here](https://kubernetes.io/docs/concepts/services-networking/dual-stack/#services) for details. |
| vmcluster.vmauth.service.labels | object | `{}` | Service labels |
| vmcluster.vmauth.service.loadBalancerIP | string | `""` | Service load balancer IP |
| vmcluster.vmauth.service.loadBalancerSourceRanges | list | `[]` | Load balancer source range |
| vmcluster.vmauth.service.nodePort | string | `""` | Service node port |
| vmcluster.vmauth.service.servicePort | string | `""` | Service port |
| vmcluster.vmauth.service.trafficDistribution | string | `""` | Traffic Distribution. Check [Traffic distribution](https://kubernetes.io/docs/concepts/services-networking/service/#traffic-distribution) |
| vmcluster.vmauth.service.type | string | `"ClusterIP"` | Service type |
| vmcluster.vmauth.service.udp | bool | `false` | Enable UDP port. used if you have `spec.opentsdbListenAddr` specified Make sure that service is not type `LoadBalancer`, as it requires `MixedProtocolLBService` feature gate. Check [here](https://kubernetes.io/docs/reference/command-line-tools-reference/feature-gates/) |
| vmcluster.vmauth.serviceMonitor.annotations | object | `{}` | Service Monitor annotations |
| vmcluster.vmauth.serviceMonitor.basicAuth | object | `{}` | Basic auth params for Service Monitor |
| vmcluster.vmauth.serviceMonitor.enabled | bool | `false` | Enable deployment of Service Monitor for vmauth component. This is Prometheus operator object |
| vmcluster.vmauth.serviceMonitor.extraLabels | object | `{}` | Service Monitor labels |
| vmcluster.vmauth.serviceMonitor.metricRelabelings | list | `[]` | Service Monitor metricRelabelings |
| vmcluster.vmauth.serviceMonitor.namespace | string | `""` | Target namespace of ServiceMonitor manifest |
| vmcluster.vmauth.serviceMonitor.port | string | `""` | Service Monitor port. Uses primary http item name by default |
| vmcluster.vmauth.serviceMonitor.relabelings | list | `[]` | Service Monitor relabelings |
| vmcluster.vmauth.serviceMonitor.targetPort | string | `""` | Service Monitor target port. Overrides port when set |
| vmcluster.vmauth.strategy | object | `{}` | VMAuth Deployment strategy |
| vmcluster.vmauth.suppressStorageFQDNsRender | bool | `false` | Suppress rendering `--storageNode` FQDNs based on `vmstorage.replicaCount` value. If true suppress rendering `--storageNodes`, they can be re-defined in extraArgs |
| vmcluster.vmauth.tolerations | list | `[]` | Array of tolerations object. Details are [here](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/) |
| vmcluster.vmauth.topologySpreadConstraints | list | `[]` | Pod topologySpreadConstraints |
| vmcluster.vmauth.verticalPodAutoscaler | object | `{"enabled":false}` | Vertical Pod Autoscaler. Requires VPA CRD (`autoscaling.k8s.io/v1`) to be installed in the cluster. Note that VPA should not be used together with HPA on the same resource metrics (CPU/memory). |
| vmcluster.vmauth.verticalPodAutoscaler.enabled | bool | `false` | Use VPA for vmagent |
| vmcluster.vminsert.affinity | object | `{}` | Pod affinity |
| vmcluster.vminsert.annotations | object | `{}` | StatefulSet/Deployment annotations |
| vmcluster.vminsert.command | list | `[]` | Override default container command. Use when the VictoriaMetrics binary is available at a custom path |
| vmcluster.vminsert.containerWorkingDir | string | `""` | Container workdir |
| vmcluster.vminsert.enabled | bool | `true` | Enable deployment of vminsert component. Deployment is used |
| vmcluster.vminsert.env | list | `[]` | Additional environment variables (ex.: secret tokens, flags). Check [here](https://docs.victoriametrics.com/victoriametrics/#environment-variables) for details. |
| vmcluster.vminsert.envFrom | list | `[]` | Specify alternative source for env variables |
| vmcluster.vminsert.excludeStorageIDs | list | `[]` | IDs of vmstorage nodes to exclude from writing |
| vmcluster.vminsert.extraArgs | object | `{"envflag.enable":true,"envflag.prefix":"VM_","loggerFormat":"json"}` | Extra command line arguments for vminsert component |
| vmcluster.vminsert.extraContainers | list | `[]` | Extra containers to run in a pod with vminsert |
| vmcluster.vminsert.extraLabels | object | `{}` | StatefulSet/Deployment additional labels |
| vmcluster.vminsert.extraVolumeMounts | list | `[]` | Extra Volume Mounts for the container |
| vmcluster.vminsert.extraVolumes | list | `[]` | Extra Volumes for the pod |
| vmcluster.vminsert.fullnameOverride | string | `""` | Overrides the full name of vminsert component |
| vmcluster.vminsert.horizontalPodAutoscaler | object | `{"behavior":{},"enabled":false,"maxReplicas":10,"metrics":[],"minReplicas":2}` | Horizontal Pod Autoscaler |
| vmcluster.vminsert.horizontalPodAutoscaler.behavior | object | `{}` | Behavior settings for scaling by the HPA |
| vmcluster.vminsert.horizontalPodAutoscaler.enabled | bool | `false` | Use HPA for vminsert component |
| vmcluster.vminsert.horizontalPodAutoscaler.maxReplicas | int | `10` | Maximum replicas for HPA to use to to scale the vminsert component |
| vmcluster.vminsert.horizontalPodAutoscaler.metrics | list | `[]` | Metric for HPA to use to scale the vminsert component |
| vmcluster.vminsert.horizontalPodAutoscaler.minReplicas | int | `2` | Minimum replicas for HPA to use to scale the vminsert component |
| vmcluster.vminsert.http | list | `[{"mtls":false,"mtlsCAFile":"","name":"http","primary":true,"tls":false,"tlsAutocertCacheDir":"","tlsAutocertEmail":"","tlsAutocertHosts":"","tlsCertFile":"","tlsKeyFile":"","tlsMinVersion":"","value":":8480"}]` | HTTP listen address configuration. See https://docs.victoriametrics.com/helm/victoria-metrics-cluster/#http-listen-address for details. |
| vmcluster.vminsert.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| vmcluster.vminsert.image.registry | string | `""` | Image registry |
| vmcluster.vminsert.image.repository | string | `"victoriametrics/vminsert"` | Image repository |
| vmcluster.vminsert.image.tag | string | `""` | Image tag override Chart.AppVersion |
| vmcluster.vminsert.image.variant | string | `"cluster"` | Variant of the image to use. e.g. cluster, enterprise-cluster |
| vmcluster.vminsert.ingress.annotations | object | `{}` | Ingress annotations |
| vmcluster.vminsert.ingress.enabled | bool | `false` | Enable deployment of ingress for vminsert component |
| vmcluster.vminsert.ingress.extraLabels | object | `{}` | Ingress extra labels |
| vmcluster.vminsert.ingress.hosts | list | `[{"name":"vminsert.local","path":["/insert"],"port":"http"}]` | Array of host objects |
| vmcluster.vminsert.ingress.ingressClassName | string | `""` | Ingress controller class name |
| vmcluster.vminsert.ingress.pathType | string | `"Prefix"` | Ingress path type |
| vmcluster.vminsert.ingress.tls | list | `[]` | Array of TLS objects |
| vmcluster.vminsert.initContainers | list | `[]` | Init containers for vminsert |
| vmcluster.vminsert.lifecycle | object | `{}` | Specify pod lifecycle |
| vmcluster.vminsert.name | string | `""` | Override default `app` label name |
| vmcluster.vminsert.nodeSelector | object | `{}` | Pod's node selector. Details are [here](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector) |
| vmcluster.vminsert.podAnnotations | object | `{}` | Pod's annotations |
| vmcluster.vminsert.podDisruptionBudget | object | `{"enabled":false,"labels":{},"maxUnavailable":0,"minAvailable":0,"unhealthyPodEvictionPolicy":null}` | See `kubectl explain poddisruptionbudget.spec` for more. Details are [here](https://kubernetes.io/docs/tasks/run-application/configure-pdb/) |
| vmcluster.vminsert.podDisruptionBudget.maxUnavailable | int | `0` | max number or percentage of pods that can be unavailable |
| vmcluster.vminsert.podDisruptionBudget.minAvailable | int | `0` | min number or percentage of pods that can be unavailable |
| vmcluster.vminsert.podDisruptionBudget.unhealthyPodEvictionPolicy | string | `nil` | Defines criteria when unhealthy pods should be considered for eviction |
| vmcluster.vminsert.podLabels | object | `{}` | Pod’s additional labels |
| vmcluster.vminsert.podSecurityContext | object | `{"enabled":false}` | Pod's security context. Details are [here](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) |
| vmcluster.vminsert.priorityClassName | string | `""` | Name of Priority Class |
| vmcluster.vminsert.probe | object | `{"liveness":{"failureThreshold":3,"initialDelaySeconds":5,"periodSeconds":15,"tcpSocket":{},"timeoutSeconds":5},"readiness":{"failureThreshold":10,"httpGet":{},"initialDelaySeconds":5,"periodSeconds":5,"timeoutSeconds":5},"startup":{}}` | Readiness & Liveness probes |
| vmcluster.vminsert.probe.liveness | object | `{"failureThreshold":3,"initialDelaySeconds":5,"periodSeconds":15,"tcpSocket":{},"timeoutSeconds":5}` | VMInsert liveness probe |
| vmcluster.vminsert.probe.readiness | object | `{"failureThreshold":10,"httpGet":{},"initialDelaySeconds":5,"periodSeconds":5,"timeoutSeconds":5}` | VMInsert readiness probe |
| vmcluster.vminsert.probe.startup | object | `{}` | VMInsert startup probe |
| vmcluster.vminsert.relabel | object | `{"config":[],"configMap":"","enabled":false}` | Relabel configuration |
| vmcluster.vminsert.relabel.configMap | string | `""` | Use existing configmap if specified otherwise .config values will be used. Relabel config **should** reside under `relabel.yml` key |
| vmcluster.vminsert.replicaCount | int | `2` | Count of vminsert pods |
| vmcluster.vminsert.resources | object | `{}` | Resource object. Details are [here](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/) |
| vmcluster.vminsert.route.annotations | object | `{}` | HTTPRoute annotations |
| vmcluster.vminsert.route.enabled | bool | `false` | Enable deployment of HTTPRoute for insert component |
| vmcluster.vminsert.route.extraLabels | object | `{}` | HTTPRoute extra labels |
| vmcluster.vminsert.route.extraRules | list | `[]` | Extra rules to prepend to route. This is useful when working with annotation based services. |
| vmcluster.vminsert.route.filters | list | `[]` | Filters for a default rule in HTTPRoute |
| vmcluster.vminsert.route.hostnames | list | `[]` | Array of hostnames |
| vmcluster.vminsert.route.matches | list | `[{"path":{"type":"PathPrefix","value":"{{ dig \"extraArgs\" \"http.pathPrefix\" \"/insert\" .Values.vminsert }}"}}]` | Matches for a default rule in HTTPRoute |
| vmcluster.vminsert.route.parentRefs | list | `[]` | HTTPGateway objects refs |
| vmcluster.vminsert.route.timeouts | object | `{}` | Timeouts for a default rule in HTTPRoute |
| vmcluster.vminsert.runtimeClassName | string | `""` | Name of the [RuntimeClass](https://kubernetes.io/docs/concepts/containers/runtime-class/) used to run the pod, e.g. "gvisor" |
| vmcluster.vminsert.securityContext | object | `{"enabled":false}` | Pod's security context. Details are [here](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) |
| vmcluster.vminsert.service.annotations | object | `{}` | Service annotations |
| vmcluster.vminsert.service.clusterIP | string | `""` | Service ClusterIP |
| vmcluster.vminsert.service.enabled | bool | `true` | Create VMInsert service |
| vmcluster.vminsert.service.externalIPs | list | `[]` | Service external IPs. Details are [here]( https://kubernetes.io/docs/concepts/services-networking/service/#external-ips) |
| vmcluster.vminsert.service.externalTrafficPolicy | string | `""` | Service external traffic policy. Check [here](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip) for details |
| vmcluster.vminsert.service.extraPorts | list | `[]` | Extra service ports |
| vmcluster.vminsert.service.healthCheckNodePort | string | `""` | Health check node port for a service. Check [here](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip) for details |
| vmcluster.vminsert.service.ipFamilies | list | `[]` | List of service IP families. Check [here](https://kubernetes.io/docs/concepts/services-networking/dual-stack/#services) for details. |
| vmcluster.vminsert.service.ipFamilyPolicy | string | `""` | Service IP family policy. Check [here](https://kubernetes.io/docs/concepts/services-networking/dual-stack/#services) for details. |
| vmcluster.vminsert.service.labels | object | `{}` | Service labels |
| vmcluster.vminsert.service.loadBalancerIP | string | `""` | Service load balancer IP |
| vmcluster.vminsert.service.loadBalancerSourceRanges | list | `[]` | Load balancer source range |
| vmcluster.vminsert.service.nodePort | string | `""` | Service node port |
| vmcluster.vminsert.service.servicePort | string | `""` | Service port |
| vmcluster.vminsert.service.trafficDistribution | string | `""` | Traffic Distribution. Check [Traffic distribution](https://kubernetes.io/docs/concepts/services-networking/service/#traffic-distribution) |
| vmcluster.vminsert.service.type | string | `"ClusterIP"` | Service type |
| vmcluster.vminsert.service.udp | bool | `false` | Enable UDP port. used if you have `spec.opentsdbListenAddr` specified Make sure that service is not type `LoadBalancer`, as it requires `MixedProtocolLBService` feature gate. Check [here](https://kubernetes.io/docs/reference/command-line-tools-reference/feature-gates/) for details |
| vmcluster.vminsert.serviceMonitor.annotations | object | `{}` | Service Monitor annotations |
| vmcluster.vminsert.serviceMonitor.basicAuth | object | `{}` | Basic auth params for Service Monitor |
| vmcluster.vminsert.serviceMonitor.enabled | bool | `false` | Enable deployment of Service Monitor for vminsert component. This is Prometheus operator object |
| vmcluster.vminsert.serviceMonitor.extraLabels | object | `{}` | Service Monitor labels |
| vmcluster.vminsert.serviceMonitor.metricRelabelings | list | `[]` | Service Monitor metricRelabelings |
| vmcluster.vminsert.serviceMonitor.namespace | string | `""` | Target namespace of ServiceMonitor manifest |
| vmcluster.vminsert.serviceMonitor.port | string | `""` | Service Monitor port. Uses primary http item name by default |
| vmcluster.vminsert.serviceMonitor.relabelings | list | `[]` | Service Monitor relabelings |
| vmcluster.vminsert.serviceMonitor.targetPort | string | `""` | Service Monitor target port. Overrides port when set |
| vmcluster.vminsert.strategy | object | `{}` | VMInsert strategy |
| vmcluster.vminsert.suppressStorageFQDNsRender | bool | `false` | Suppress rendering `--storageNode` FQDNs based on `vmstorage.replicaCount` value. If true suppress rendering `--storageNodes`, they can be re-defined in extraArgs |
| vmcluster.vminsert.terminationGracePeriodSeconds | int | `30` |  |
| vmcluster.vminsert.tolerations | list | `[]` | Array of tolerations object. Details are [here](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/) |
| vmcluster.vminsert.topologySpreadConstraints | list | `[]` | Pod topologySpreadConstraints |
| vmcluster.vminsert.verticalPodAutoscaler | object | `{"enabled":false}` | Vertical Pod Autoscaler. Requires VPA CRD (`autoscaling.k8s.io/v1`) to be installed in the cluster. Note that VPA should not be used together with HPA on the same resource metrics (CPU/memory). |
| vmcluster.vminsert.verticalPodAutoscaler.enabled | bool | `false` | Use VPA for vmagent |
| vmcluster.vmselect.affinity | object | `{}` | Pod affinity |
| vmcluster.vmselect.annotations | object | `{}` | StatefulSet/Deployment annotations |
| vmcluster.vmselect.cacheMountPath | string | `"/cache"` | Cache root folder |
| vmcluster.vmselect.command | list | `[]` | Override default container command. Use when the VictoriaMetrics binary is available at a custom path |
| vmcluster.vmselect.containerWorkingDir | string | `""` | Container workdir |
| vmcluster.vmselect.deployment | object | `{"spec":{"strategy":{}}}` | [K8s Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) specific variables |
| vmcluster.vmselect.deployment.spec.strategy | object | `{}` | VMSelect strategy |
| vmcluster.vmselect.emptyDir | object | `{}` | Empty dir configuration if persistence is disabled |
| vmcluster.vmselect.enabled | bool | `true` | Enable deployment of vmselect component. Can be deployed as Deployment(default) or StatefulSet |
| vmcluster.vmselect.env | list | `[]` | Additional environment variables (ex.: secret tokens, flags). Check [here](https://docs.victoriametrics.com/victoriametrics/#environment-variables) for details. |
| vmcluster.vmselect.envFrom | list | `[]` | Specify alternative source for env variables |
| vmcluster.vmselect.extraArgs | object | `{"envflag.enable":true,"envflag.prefix":"VM_","loggerFormat":"json"}` | Extra command line arguments for vmselect component |
| vmcluster.vmselect.extraContainers | list | `[]` | Extra containers to run in a pod with vmselect |
| vmcluster.vmselect.extraHostPathMounts | list | `[]` | Additional hostPath mounts |
| vmcluster.vmselect.extraLabels | object | `{}` | StatefulSet/Deployment additional labels |
| vmcluster.vmselect.extraVolumeMounts | list | `[]` | Extra Volume Mounts for the container |
| vmcluster.vmselect.extraVolumes | list | `[]` | Extra Volumes for the pod |
| vmcluster.vmselect.fullnameOverride | string | `""` | Overrides the full name of vmselect component |
| vmcluster.vmselect.horizontalPodAutoscaler.behavior | object | `{}` | Behavior settings for scaling by the HPA |
| vmcluster.vmselect.horizontalPodAutoscaler.enabled | bool | `false` | Use HPA for vmselect component |
| vmcluster.vmselect.horizontalPodAutoscaler.maxReplicas | int | `10` | Maximum replicas for HPA to use to to scale the vmselect component |
| vmcluster.vmselect.horizontalPodAutoscaler.metrics | list | `[]` | Metric for HPA to use to scale the vmselect component |
| vmcluster.vmselect.horizontalPodAutoscaler.minReplicas | int | `2` | Minimum replicas for HPA to use to scale the vmselect component |
| vmcluster.vmselect.http | list | `[{"mtls":false,"mtlsCAFile":"","name":"http","primary":true,"tls":false,"tlsAutocertCacheDir":"","tlsAutocertEmail":"","tlsAutocertHosts":"","tlsCertFile":"","tlsKeyFile":"","tlsMinVersion":"","value":":8481"}]` | HTTP listen address configuration. See https://docs.victoriametrics.com/helm/victoria-metrics-cluster/#http-listen-address for details. |
| vmcluster.vmselect.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| vmcluster.vmselect.image.registry | string | `""` | Image registry |
| vmcluster.vmselect.image.repository | string | `"victoriametrics/vmselect"` | Image repository |
| vmcluster.vmselect.image.tag | string | `""` | Image tag override Chart.AppVersion |
| vmcluster.vmselect.image.variant | string | `"cluster"` | Variant of the image to use. e.g. cluster, enterprise-cluster |
| vmcluster.vmselect.ingress.annotations | object | `{}` | Ingress annotations |
| vmcluster.vmselect.ingress.enabled | bool | `false` | Enable deployment of ingress for vmselect component |
| vmcluster.vmselect.ingress.extraLabels | object | `{}` | Ingress extra labels |
| vmcluster.vmselect.ingress.hosts | list | `[{"name":"vmselect.local","path":["/select"],"port":"http"}]` | Array of host objects |
| vmcluster.vmselect.ingress.ingressClassName | string | `""` | Ingress controller class name |
| vmcluster.vmselect.ingress.pathType | string | `"Prefix"` | Ingress path type |
| vmcluster.vmselect.ingress.tls | list | `[]` | Array of TLS objects |
| vmcluster.vmselect.initContainers | list | `[]` | Init containers for vmselect |
| vmcluster.vmselect.lifecycle | object | `{}` | Specify pod lifecycle |
| vmcluster.vmselect.mode | string | `"deployment"` | vmselect mode: deployment, statefulSet |
| vmcluster.vmselect.name | string | `""` | Override default `app` label name |
| vmcluster.vmselect.nodeSelector | object | `{}` | Pod's node selector. Details are [here](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector) |
| vmcluster.vmselect.persistentVolume.accessModes | list | `["ReadWriteOnce"]` | Array of access mode. Must match those of existing PV or dynamic provisioner. Details are [here](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) |
| vmcluster.vmselect.persistentVolume.annotations | object | `{}` | Persistent volume annotations |
| vmcluster.vmselect.persistentVolume.enabled | bool | `false` | Create/use Persistent Volume Claim for vmselect component. Empty dir if false. If true, vmselect will create/use a Persistent Volume Claim |
| vmcluster.vmselect.persistentVolume.existingClaim | string | `""` | Existing Claim name. Requires vmselect.persistentVolume.enabled: true. If defined, PVC must be created manually before volume will be bound |
| vmcluster.vmselect.persistentVolume.extraLabels | object | `{}` | Persistent volume extra labels |
| vmcluster.vmselect.persistentVolume.name | string | `""` | Override Persistent Volume Claim name |
| vmcluster.vmselect.persistentVolume.size | string | `"2Gi"` | Size of the volume. Better to set the same as resource limit memory property |
| vmcluster.vmselect.persistentVolume.subPath | string | `""` | Mount subpath |
| vmcluster.vmselect.persistentVolume.volumeAttributesClassName | string | `nil` | VolumeClassAttribute to user for persistent volume |
| vmcluster.vmselect.podAnnotations | object | `{}` | Pod's annotations |
| vmcluster.vmselect.podDisruptionBudget | object | `{"enabled":false,"labels":{},"maxUnavailable":0,"minAvailable":0,"unhealthyPodEvictionPolicy":null}` | See `kubectl explain poddisruptionbudget.spec` for more. Details are [here](https://kubernetes.io/docs/tasks/run-application/configure-pdb/) |
| vmcluster.vmselect.podDisruptionBudget.enabled | bool | `false` | See `kubectl explain poddisruptionbudget.spec` for more. Details are [here](https://kubernetes.io/docs/tasks/run-application/configure-pdb/) |
| vmcluster.vmselect.podDisruptionBudget.maxUnavailable | int | `0` | max number or percentage of pods that can be unavailable |
| vmcluster.vmselect.podDisruptionBudget.minAvailable | int | `0` | min number or percentage of pods that can be unavailable |
| vmcluster.vmselect.podDisruptionBudget.unhealthyPodEvictionPolicy | string | `nil` | Defines criteria when unhealthy pods should be considered for eviction |
| vmcluster.vmselect.podLabels | object | `{}` | Pod’s additional labels |
| vmcluster.vmselect.podSecurityContext | object | `{"enabled":true}` | Pod's security context. Details are [here](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) |
| vmcluster.vmselect.priorityClassName | string | `""` | Name of Priority Class |
| vmcluster.vmselect.probe | object | `{"liveness":{"failureThreshold":3,"initialDelaySeconds":5,"periodSeconds":15,"tcpSocket":{},"timeoutSeconds":5},"readiness":{"failureThreshold":10,"httpGet":{},"initialDelaySeconds":5,"periodSeconds":5,"timeoutSeconds":5},"startup":{}}` | Readiness & Liveness probes |
| vmcluster.vmselect.probe.liveness | object | `{"failureThreshold":3,"initialDelaySeconds":5,"periodSeconds":15,"tcpSocket":{},"timeoutSeconds":5}` | VMSelect liveness probe |
| vmcluster.vmselect.probe.readiness | object | `{"failureThreshold":10,"httpGet":{},"initialDelaySeconds":5,"periodSeconds":5,"timeoutSeconds":5}` | VMSelect readiness probe |
| vmcluster.vmselect.probe.startup | object | `{}` | VMSelect startup probe |
| vmcluster.vmselect.replicaCount | int | `2` | Count of vmselect pods |
| vmcluster.vmselect.resources | object | `{}` | Resource object. Details are [here](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/) |
| vmcluster.vmselect.route.annotations | object | `{}` | HTTPRoute annotations |
| vmcluster.vmselect.route.enabled | bool | `false` | Enable deployment of HTTPRoute for select component |
| vmcluster.vmselect.route.extraLabels | object | `{}` | HTTPRoute extra labels |
| vmcluster.vmselect.route.extraRules | list | `[]` | Extra rules to prepend to route. This is useful when working with annotation based services. |
| vmcluster.vmselect.route.filters | list | `[]` | Filters for a default rule in HTTPRoute |
| vmcluster.vmselect.route.hostnames | list | `[]` | Array of hostnames |
| vmcluster.vmselect.route.matches | list | `[{"path":{"type":"PathPrefix","value":"{{ dig \"extraArgs\" \"http.pathPrefix\" \"/select\" .Values.vmselect }}"}}]` | Matches for a default rule in HTTPRoute |
| vmcluster.vmselect.route.parentRefs | list | `[]` | HTTPGateway objects refs |
| vmcluster.vmselect.route.timeouts | object | `{}` | Timeouts for a default rule in HTTPRoute |
| vmcluster.vmselect.runtimeClassName | string | `""` | Name of the [RuntimeClass](https://kubernetes.io/docs/concepts/containers/runtime-class/) used to run the pod, e.g. "gvisor" |
| vmcluster.vmselect.securityContext | object | `{"enabled":true}` | Pod's security context. Details are [here](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) |
| vmcluster.vmselect.service.annotations | object | `{}` | Service annotations |
| vmcluster.vmselect.service.clusterIP | string | `""` | Service ClusterIP |
| vmcluster.vmselect.service.enabled | bool | `true` | Create VMSelect service |
| vmcluster.vmselect.service.externalIPs | list | `[]` | Service external IPs. Details are [here](https://kubernetes.io/docs/concepts/services-networking/service/#external-ips) |
| vmcluster.vmselect.service.externalTrafficPolicy | string | `""` | Service external traffic policy. Check [here](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip) for details |
| vmcluster.vmselect.service.extraPorts | list | `[]` | Extra service ports |
| vmcluster.vmselect.service.healthCheckNodePort | string | `""` | Health check node port for a service. Check [here](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip) for details |
| vmcluster.vmselect.service.ipFamilies | list | `[]` | List of service IP families. Check [here](https://kubernetes.io/docs/concepts/services-networking/dual-stack/#services) for details. |
| vmcluster.vmselect.service.ipFamilyPolicy | string | `""` | Service IP family policy. Check [here](https://kubernetes.io/docs/concepts/services-networking/dual-stack/#services) for details. |
| vmcluster.vmselect.service.labels | object | `{}` | Service labels |
| vmcluster.vmselect.service.loadBalancerIP | string | `""` | Service load balancer IP |
| vmcluster.vmselect.service.loadBalancerSourceRanges | list | `[]` | Load balancer source range |
| vmcluster.vmselect.service.nodePort | string | `""` | Service node port |
| vmcluster.vmselect.service.publishNotReadyAddresses | bool | `false` | Publish not-ready addresses. Set this to `true` together with `clusterIP: None` when vmselect is discovered via its headless service (e.g. behind vmauth balancing) before pods pass readiness checks |
| vmcluster.vmselect.service.servicePort | string | `""` | Service port |
| vmcluster.vmselect.service.trafficDistribution | string | `""` | Traffic Distribution. Check [Traffic distribution](https://kubernetes.io/docs/concepts/services-networking/service/#traffic-distribution) |
| vmcluster.vmselect.service.type | string | `"ClusterIP"` | Service type |
| vmcluster.vmselect.serviceMonitor.annotations | object | `{}` | Service Monitor annotations |
| vmcluster.vmselect.serviceMonitor.basicAuth | object | `{}` | Basic auth params for Service Monitor |
| vmcluster.vmselect.serviceMonitor.enabled | bool | `false` | Enable deployment of Service Monitor for vmselect component. This is Prometheus operator object |
| vmcluster.vmselect.serviceMonitor.extraLabels | object | `{}` | Service Monitor labels |
| vmcluster.vmselect.serviceMonitor.metricRelabelings | list | `[]` | Service Monitor metricRelabelings |
| vmcluster.vmselect.serviceMonitor.namespace | string | `""` | Target namespace of ServiceMonitor manifest |
| vmcluster.vmselect.serviceMonitor.port | string | `""` | Service Monitor port. Uses primary http item name by default |
| vmcluster.vmselect.serviceMonitor.relabelings | list | `[]` | Service Monitor relabelings |
| vmcluster.vmselect.serviceMonitor.targetPort | string | `""` | Service Monitor target port. Overrides port when set |
| vmcluster.vmselect.statefulSet | object | `{"spec":{"podManagementPolicy":"OrderedReady"}}` | [K8s StatefulSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/) specific variables |
| vmcluster.vmselect.statefulSet.spec.podManagementPolicy | string | `"OrderedReady"` | Deploy order policy for StatefulSet pods |
| vmcluster.vmselect.suppressStorageFQDNsRender | bool | `false` | Suppress rendering `--storageNode` FQDNs based on `vmstorage.replicaCount` value. If true suppress rendering `--storageNodes`, they can be re-defined in extraArgs |
| vmcluster.vmselect.terminationGracePeriodSeconds | int | `60` | Pod's termination grace period in seconds |
| vmcluster.vmselect.tolerations | list | `[]` | Array of tolerations object. Details are [here](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/) |
| vmcluster.vmselect.topologySpreadConstraints | list | `[]` | Pod topologySpreadConstraints |
| vmcluster.vmselect.verticalPodAutoscaler | object | `{"enabled":false}` | Vertical Pod Autoscaler. Requires VPA CRD (`autoscaling.k8s.io/v1`) to be installed in the cluster. Note that VPA should not be used together with HPA on the same resource metrics (CPU/memory). |
| vmcluster.vmselect.verticalPodAutoscaler.enabled | bool | `false` | Use VPA for vmagent |
| vmcluster.vmstorage.affinity | object | `{}` | Pod affinity |
| vmcluster.vmstorage.annotations | object | `{}` | StatefulSet/Deployment annotations |
| vmcluster.vmstorage.command | list | `[]` | Override default container command. Use when the VictoriaMetrics binary is available at a custom path |
| vmcluster.vmstorage.containerWorkingDir | string | `""` | Container workdir |
| vmcluster.vmstorage.emptyDir | object | `{}` | Empty dir configuration if persistence is disabled |
| vmcluster.vmstorage.enabled | bool | `true` | Enable deployment of vmstorage component. StatefulSet is used |
| vmcluster.vmstorage.env | list | `[]` | Additional environment variables (ex.: secret tokens, flags). Check [here](https://docs.victoriametrics.com/victoriametrics/#environment-variables) for details |
| vmcluster.vmstorage.envFrom | list | `[]` | Specify alternative source for env variables |
| vmcluster.vmstorage.extraArgs | object | `{"envflag.enable":true,"envflag.prefix":"VM_","loggerFormat":"json"}` | Additional vmstorage container arguments. Extra command line arguments for vmstorage component |
| vmcluster.vmstorage.extraContainers | list | `[]` | Extra containers to run in a pod with vmstorage |
| vmcluster.vmstorage.extraHostPathMounts | list | `[]` | Additional hostPath mounts |
| vmcluster.vmstorage.extraLabels | object | `{}` | StatefulSet/Deployment additional labels |
| vmcluster.vmstorage.extraSecretMounts | list | `[]` | Extra secret mounts for vmstorage |
| vmcluster.vmstorage.extraVolumeMounts | list | `[]` | Extra Volume Mounts for the container |
| vmcluster.vmstorage.extraVolumes | list | `[]` | Extra Volumes for the pod |
| vmcluster.vmstorage.fullnameOverride | string | `nil` | Overrides the full name of vmstorage component |
| vmcluster.vmstorage.horizontalPodAutoscaler.behavior | object | `{"scaleDown":{"selectPolicy":"Disabled"}}` | Behavior settings for scaling by the HPA |
| vmcluster.vmstorage.horizontalPodAutoscaler.enabled | bool | `false` | Use HPA for vmstorage component |
| vmcluster.vmstorage.horizontalPodAutoscaler.maxReplicas | int | `10` | Maximum replicas for HPA to use to to scale the vmstorage component |
| vmcluster.vmstorage.horizontalPodAutoscaler.metrics | list | `[]` | Metric for HPA to use to scale the vmstorage component |
| vmcluster.vmstorage.horizontalPodAutoscaler.minReplicas | int | `2` | Minimum replicas for HPA to use to scale the vmstorage component |
| vmcluster.vmstorage.http | list | `[{"mtls":false,"mtlsCAFile":"","name":"http","primary":true,"tls":false,"tlsAutocertCacheDir":"","tlsAutocertEmail":"","tlsAutocertHosts":"","tlsCertFile":"","tlsKeyFile":"","tlsMinVersion":"","value":":8482"}]` | HTTP listen address configuration. See https://docs.victoriametrics.com/helm/victoria-metrics-cluster/#http-listen-address for details. |
| vmcluster.vmstorage.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| vmcluster.vmstorage.image.registry | string | `""` | Image registry |
| vmcluster.vmstorage.image.repository | string | `"victoriametrics/vmstorage"` | Image repository |
| vmcluster.vmstorage.image.tag | string | `""` | Image tag override Chart.AppVersion |
| vmcluster.vmstorage.image.variant | string | `"cluster"` | Variant of the image to use. e.g. cluster, enterprise-cluster |
| vmcluster.vmstorage.initContainers | list | `[]` | Init containers for vmstorage |
| vmcluster.vmstorage.lifecycle | object | `{}` | Specify pod lifecycle |
| vmcluster.vmstorage.minReadySeconds | int | `5` |  |
| vmcluster.vmstorage.name | string | `""` | Override default `app` label name |
| vmcluster.vmstorage.nodeSelector | object | `{}` | Pod's node selector. Details are [here](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector) |
| vmcluster.vmstorage.persistentVolume.accessModes | list | `["ReadWriteOnce"]` | Array of access modes. Must match those of existing PV or dynamic provisioner. Details are [here](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) |
| vmcluster.vmstorage.persistentVolume.annotations | object | `{}` | Persistent volume annotations |
| vmcluster.vmstorage.persistentVolume.enabled | bool | `true` | Create/use Persistent Volume Claim for vmstorage component. Empty dir if false. If true,  vmstorage will create/use a Persistent Volume Claim |
| vmcluster.vmstorage.persistentVolume.existingClaim | string | `""` | Existing Claim name. Requires vmstorage.persistentVolume.enabled: true. If defined, PVC must be created manually before volume will be bound |
| vmcluster.vmstorage.persistentVolume.extraLabels | object | `{}` | Persistent volume extra labels |
| vmcluster.vmstorage.persistentVolume.mountPath | string | `"/storage"` | Data root path. Vmstorage data Persistent Volume mount root path |
| vmcluster.vmstorage.persistentVolume.name | string | `"vmstorage-volume"` | Override Persistent Volume Claim name |
| vmcluster.vmstorage.persistentVolume.size | string | `"8Gi"` | Size of the volume. |
| vmcluster.vmstorage.persistentVolume.storageClassName | string | `""` | Storage class name. Will be empty if not set |
| vmcluster.vmstorage.persistentVolume.subPath | string | `""` | Mount subpath |
| vmcluster.vmstorage.persistentVolume.volumeAttributesClassName | string | `nil` | VolumeClassAttribute to user for persistent volume |
| vmcluster.vmstorage.podAnnotations | object | `{}` | Pod's annotations |
| vmcluster.vmstorage.podDisruptionBudget | object | `{"enabled":false,"labels":{},"maxUnavailable":0,"minAvailable":0,"unhealthyPodEvictionPolicy":null}` | See `kubectl explain poddisruptionbudget.spec` for more. Details are [here](https://kubernetes.io/docs/tasks/run-application/configure-pdb/) |
| vmcluster.vmstorage.podDisruptionBudget.maxUnavailable | int | `0` | max number or percentage of pods that can be unavailable |
| vmcluster.vmstorage.podDisruptionBudget.minAvailable | int | `0` | min number or percentage of pods that can be unavailable |
| vmcluster.vmstorage.podDisruptionBudget.unhealthyPodEvictionPolicy | string | `nil` | Defines criteria when unhealthy pods should be considered for eviction |
| vmcluster.vmstorage.podLabels | object | `{}` | Pod’s additional labels |
| vmcluster.vmstorage.podManagementPolicy | string | `"OrderedReady"` | Deploy order policy for StatefulSet pods |
| vmcluster.vmstorage.podSecurityContext | object | `{"enabled":false}` | Pod's security context. Details are [here](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) |
| vmcluster.vmstorage.priorityClassName | string | `""` | Name of Priority Class |
| vmcluster.vmstorage.probe | object | `{"readiness":{"failureThreshold":10,"httpGet":{},"initialDelaySeconds":5,"periodSeconds":5,"timeoutSeconds":5},"startup":{}}` | Readiness probes |
| vmcluster.vmstorage.probe.readiness | object | `{"failureThreshold":10,"httpGet":{},"initialDelaySeconds":5,"periodSeconds":5,"timeoutSeconds":5}` | VMStorage readiness probe |
| vmcluster.vmstorage.probe.startup | object | `{}` | VMStorage startup probe |
| vmcluster.vmstorage.replicaCount | int | `2` | Count of vmstorage pods |
| vmcluster.vmstorage.resources | object | `{}` | Resource object. Details are [here](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/) |
| vmcluster.vmstorage.retentionPeriod | int | `1` | Data retention period. Possible units character: h(ours), d(ays), w(eeks), y(ears), if no unit character specified - month. The minimum retention period is 24h. See these [docs](https://docs.victoriametrics.com/victoriametrics/single-server-victoriametrics/#retention) |
| vmcluster.vmstorage.runtimeClassName | string | `""` | Name of the [RuntimeClass](https://kubernetes.io/docs/concepts/containers/runtime-class/) used to run the pod, e.g. "gvisor" |
| vmcluster.vmstorage.schedulerName | string | `""` | Use an alternate scheduler, e.g. "stork". Check [here](https://kubernetes.io/docs/tasks/administer-cluster/configure-multiple-schedulers/) for details |
| vmcluster.vmstorage.securityContext | object | `{"enabled":false}` | Pod's security context. Details are [here](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) |
| vmcluster.vmstorage.service.annotations | object | `{}` | Service annotations |
| vmcluster.vmstorage.service.clusterIP | string | `"None"` | Service ClusterIP |
| vmcluster.vmstorage.service.enabled | bool | `true` |  |
| vmcluster.vmstorage.service.externalTrafficPolicy | string | `""` | Service external traffic policy. Check [here](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip) for details |
| vmcluster.vmstorage.service.extraPorts | list | `[]` | Extra service ports |
| vmcluster.vmstorage.service.healthCheckNodePort | string | `""` | Health check node port for a service. Check [here](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip) for details |
| vmcluster.vmstorage.service.ipFamilies | list | `[]` | List of service IP families. Check [here](https://kubernetes.io/docs/concepts/services-networking/dual-stack/#services) for details. |
| vmcluster.vmstorage.service.ipFamilyPolicy | string | `""` | Service IP family policy. Check [here](https://kubernetes.io/docs/concepts/services-networking/dual-stack/#services) for details. |
| vmcluster.vmstorage.service.labels | object | `{}` | Service labels |
| vmcluster.vmstorage.service.nodePort | string | `""` | Service node port |
| vmcluster.vmstorage.service.publishNotReadyAddresses | bool | `true` | Publish not-ready addresses for the headless service, so vminsert/vmselect can discover vmstorage pods via DNS before they pass readiness checks |
| vmcluster.vmstorage.service.servicePort | string | `""` | Service port |
| vmcluster.vmstorage.service.trafficDistribution | string | `""` | Traffic Distribution. Check [Traffic distribution](https://kubernetes.io/docs/concepts/services-networking/service/#traffic-distribution) |
| vmcluster.vmstorage.service.type | string | `"ClusterIP"` | Service type |
| vmcluster.vmstorage.service.vminsertPort | int | `8400` | Port for accepting connections from vminsert |
| vmcluster.vmstorage.service.vmselectPort | int | `8401` | Port for accepting connections from vmselect |
| vmcluster.vmstorage.serviceMonitor.annotations | object | `{}` | Service Monitor annotations |
| vmcluster.vmstorage.serviceMonitor.basicAuth | object | `{}` | Basic auth params for Service Monitor |
| vmcluster.vmstorage.serviceMonitor.enabled | bool | `false` | Enable deployment of Service Monitor for vmstorage component. This is Prometheus operator object |
| vmcluster.vmstorage.serviceMonitor.extraLabels | object | `{}` | Service Monitor labels |
| vmcluster.vmstorage.serviceMonitor.metricRelabelings | list | `[]` | Service Monitor metricRelabelings |
| vmcluster.vmstorage.serviceMonitor.namespace | string | `""` | Target namespace of ServiceMonitor manifest |
| vmcluster.vmstorage.serviceMonitor.port | string | `""` | Service Monitor port. Uses primary http item name by default |
| vmcluster.vmstorage.serviceMonitor.relabelings | list | `[]` | Service Monitor relabelings |
| vmcluster.vmstorage.serviceMonitor.targetPort | string | `""` | Service Monitor target port. Overrides port when set |
| vmcluster.vmstorage.terminationGracePeriodSeconds | int | `60` | Pod's termination grace period in seconds |
| vmcluster.vmstorage.tolerations | list | `[]` | Array of tolerations object. Node tolerations for server scheduling to nodes with taints. Details are [here](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/) |
| vmcluster.vmstorage.topologySpreadConstraints | list | `[]` | Pod topologySpreadConstraints |
| vmcluster.vmstorage.verticalPodAutoscaler | object | `{"enabled":false}` | Vertical Pod Autoscaler. Requires VPA CRD (`autoscaling.k8s.io/v1`) to be installed in the cluster. Note that VPA should not be used together with HPA on the same resource metrics (CPU/memory). |
| vmcluster.vmstorage.verticalPodAutoscaler.enabled | bool | `false` | Use VPA for vmagent |
| vmcluster.vmstorage.vmbackupmanager.destination | string | `""` | Backup destination at S3, GCS or local filesystem. Pod name will be included to path! |
| vmcluster.vmstorage.vmbackupmanager.disableDaily | bool | `false` | Disable daily backups |
| vmcluster.vmstorage.vmbackupmanager.disableHourly | bool | `false` | Disable hourly backups |
| vmcluster.vmstorage.vmbackupmanager.disableMonthly | bool | `false` | Disable monthly backups |
| vmcluster.vmstorage.vmbackupmanager.disableWeekly | bool | `false` | Disable weekly backups |
| vmcluster.vmstorage.vmbackupmanager.enabled | bool | `false` | Enable automatic creation of backup via vmbackupmanager. vmbackupmanager is part of Enterprise packages |
| vmcluster.vmstorage.vmbackupmanager.env | list | `[]` | Additional environment variables (ex.: secret tokens, flags). Check [here](https://docs.victoriametrics.com/victoriametrics/#environment-variables) for details |
| vmcluster.vmstorage.vmbackupmanager.extraArgs | object | `{"envflag.enable":true,"envflag.prefix":"VM_","loggerFormat":"json"}` | Extra command line arguments for container of component |
| vmcluster.vmstorage.vmbackupmanager.extraSecretMounts | list | `[]` | Extra secret mounts for vmbackupmanager |
| vmcluster.vmstorage.vmbackupmanager.extraVolumeMounts | list | `[]` | Extra Volume Mounts for the container |
| vmcluster.vmstorage.vmbackupmanager.image.registry | string | `""` | VMBackupManager image registry |
| vmcluster.vmstorage.vmbackupmanager.image.repository | string | `"victoriametrics/vmbackupmanager"` | VMBackupManager image repository |
| vmcluster.vmstorage.vmbackupmanager.image.tag | string | `""` | VMBackupManager image tag override Chart.AppVersion |
| vmcluster.vmstorage.vmbackupmanager.image.variant | string | `""` | Variant of the image tag to use. e.g. enterprise. |
| vmcluster.vmstorage.vmbackupmanager.probe | object | `{"liveness":{"failureThreshold":10,"initialDelaySeconds":30,"periodSeconds":30,"tcpSocket":{"port":"manager-http"},"timeoutSeconds":5},"readiness":{},"startup":{}}` | Readiness & Liveness probes |
| vmcluster.vmstorage.vmbackupmanager.probe.liveness | object | `{"failureThreshold":10,"initialDelaySeconds":30,"periodSeconds":30,"tcpSocket":{"port":"manager-http"},"timeoutSeconds":5}` | VMBackupManager liveness probe |
| vmcluster.vmstorage.vmbackupmanager.probe.readiness | object | `{}` | VMBackupManager readiness probe |
| vmcluster.vmstorage.vmbackupmanager.probe.startup | object | `{}` | VMBackupManager startup probe |
| vmcluster.vmstorage.vmbackupmanager.resources | object | `{}` | Resource object. Details are [here](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/) |
| vmcluster.vmstorage.vmbackupmanager.restore | object | `{"onStart":{"enabled":false}}` | Allows to enable restore options for pod. Check [here](https://docs.victoriametrics.com/victoriametrics/vmbackupmanager/#restore-commands) for details |
| vmcluster.vmstorage.vmbackupmanager.retention | object | `{"keepLastDaily":2,"keepLastHourly":2,"keepLastMonthly":2,"keepLastWeekly":2}` | Backups' retention settings |
| vmcluster.vmstorage.vmbackupmanager.retention.keepLastDaily | int | `2` | Keep last N daily backups. 0 means delete all existing daily backups. Specify -1 to turn off |
| vmcluster.vmstorage.vmbackupmanager.retention.keepLastHourly | int | `2` | Keep last N hourly backups. 0 means delete all existing hourly backups. Specify -1 to turn off |
| vmcluster.vmstorage.vmbackupmanager.retention.keepLastMonthly | int | `2` | Keep last N monthly backups. 0 means delete all existing monthly backups. Specify -1 to turn off |
| vmcluster.vmstorage.vmbackupmanager.retention.keepLastWeekly | int | `2` | Keep last N weekly backups. 0 means delete all existing weekly backups. Specify -1 to turn off |

## Installing the Chart

### With Helm

To install the chart with the release name `my-release`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/victoria-metrics-cluster
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: victoria-metrics-cluster
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.0"
    chart: victoria-metrics-cluster
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
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/victoria-metrics-cluster --config /charts/charts/victoria-metrics-cluster/ct.yaml
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template victoria-metrics-cluster . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```

