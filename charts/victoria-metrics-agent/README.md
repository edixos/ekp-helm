# victoria-metrics-agent

![Version: 0.1.2](https://img.shields.io/badge/Version-0.1.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.150.0](https://img.shields.io/badge/AppVersion-v1.150.0-informational?style=flat-square)

## Prerequisites

- Helm v3
- Config Connector installed (v1.6.0)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://victoriametrics.github.io/helm-charts/ | vmagent(victoria-metrics-agent) | 0.46.0 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| mo-hamedaziz | <aziz@edixos.com> |  |

## Description

vmagent, packaged for the Edixos Kubernetes Platform. Wraps the upstream VictoriaMetrics agent chart — which scrapes targets and forwards samples to one or more remote write endpoints — and adds the platform extensions it does not provide: ExternalSecrets for the credentials vmagent consumes (remote write basic auth or bearer tokens, enterprise license), curated PrometheusRule alerts covering the persistent queue, scraping and remote write, and the official vmagent Grafana dashboard shipped as a sidecar-discoverable ConfigMap. Every extension is optional and driven entirely by values.

## Source Code

* <https://github.com/VictoriaMetrics/helm-charts/tree/master/charts/victoria-metrics-agent>
* <https://docs.victoriametrics.com/helm/victoria-metrics-agent/>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| externalSecrets | list | `[]` | ExternalSecrets rendered for vmagent, e.g. the basic auth or bearer token it presents to a `vmagent.remoteWrite` endpoint, or the enterprise `license.key`. Each entry takes `name`, `namespace`, an optional `syncWave` and the ExternalSecret `spec` verbatim. |
| global.enableArgocdAnnotations | bool | `false` | Annotate the platform extension resources with Argo CD sync options, so Argo CD does not dry-run them against CRDs that are not installed yet |
| prometheus.enabled | bool | `false` | Enables Prometheus Operator monitoring resources |
| prometheus.grafanaDashboard.enabled | bool | `true` | Add grafana dashboard as a configmap |
| prometheus.grafanaDashboard.label | object | `{"grafana_dashboard":"1"}` | Label to apply to the config map. Used by the Grafana sidecar to automatically install the dashboard |
| prometheus.rules.enabled | bool | `true` | Enables prometheus operator rules |
| prometheus.rules.labels | object | `{"prometheus":"prometheus-operator-prometheus"}` | Labels to affect to the Prometheus Rules |
| vmagent.affinity | object | `{}` | Pod affinity |
| vmagent.allowedMetricsEndpoints[0] | string | `"/metrics"` |  |
| vmagent.annotations | object | `{}` | Annotations to be added to the deployment |
| vmagent.command | list | `[]` | Override default container command. Use when the VictoriaMetrics binary is available at a custom path |
| vmagent.config | object | `{"global":{"scrape_interval":"10s"},"scrape_configs":[{"job_name":"vmagent","static_configs":[{"targets":["localhost:8429"]}]},{"bearer_token_file":"/var/run/secrets/kubernetes.io/serviceaccount/token","job_name":"kubernetes-apiservers","kubernetes_sd_configs":[{"role":"endpoints"}],"relabel_configs":[{"action":"keep","regex":"default;kubernetes;https","source_labels":["__meta_kubernetes_namespace","__meta_kubernetes_service_name","__meta_kubernetes_endpoint_port_name"]}],"scheme":"https","tls_config":{"ca_file":"/var/run/secrets/kubernetes.io/serviceaccount/ca.crt","insecure_skip_verify":true}},{"bearer_token_file":"/var/run/secrets/kubernetes.io/serviceaccount/token","job_name":"kubernetes-nodes","kubernetes_sd_configs":[{"role":"node"}],"relabel_configs":[{"action":"labelmap","regex":"__meta_kubernetes_node_label_(.+)"}],"scheme":"https","tls_config":{"ca_file":"/var/run/secrets/kubernetes.io/serviceaccount/ca.crt","insecure_skip_verify":true}},{"bearer_token_file":"/var/run/secrets/kubernetes.io/serviceaccount/token","honor_timestamps":false,"job_name":"kubernetes-nodes-cadvisor","kubernetes_sd_configs":[{"role":"node"}],"metrics_path":"/metrics/cadvisor","relabel_configs":[{"action":"labelmap","regex":"__meta_kubernetes_node_label_(.+)"}],"scheme":"https","tls_config":{"ca_file":"/var/run/secrets/kubernetes.io/serviceaccount/ca.crt","insecure_skip_verify":true}},{"job_name":"kubernetes-service-endpoints","kubernetes_sd_configs":[{"role":"endpointslices"}],"relabel_configs":[{"action":"drop","regex":true,"source_labels":["__meta_kubernetes_pod_container_init"]},{"action":"keep_if_equal","source_labels":["__meta_kubernetes_service_annotation_prometheus_io_port","__meta_kubernetes_pod_container_port_number"]},{"action":"keep","regex":true,"source_labels":["__meta_kubernetes_service_annotation_prometheus_io_scrape"]},{"action":"replace","regex":"(https?)","source_labels":["__meta_kubernetes_service_annotation_prometheus_io_scheme"],"target_label":"__scheme__"},{"action":"replace","regex":"(.+)","source_labels":["__meta_kubernetes_service_annotation_prometheus_io_path"],"target_label":"__metrics_path__"},{"action":"replace","regex":"([^:]+)(?::\\d+)?;(\\d+)","replacement":"$1:$2","source_labels":["__address__","__meta_kubernetes_service_annotation_prometheus_io_port"],"target_label":"__address__"},{"action":"labelmap","regex":"__meta_kubernetes_service_label_(.+)"},{"source_labels":["__meta_kubernetes_pod_name"],"target_label":"pod"},{"source_labels":["__meta_kubernetes_pod_container_name"],"target_label":"container"},{"source_labels":["__meta_kubernetes_namespace"],"target_label":"namespace"},{"source_labels":["__meta_kubernetes_service_name"],"target_label":"service"},{"replacement":"${1}","source_labels":["__meta_kubernetes_service_name"],"target_label":"job"},{"action":"replace","source_labels":["__meta_kubernetes_pod_node_name"],"target_label":"node"}]},{"job_name":"kubernetes-service-endpoints-slow","kubernetes_sd_configs":[{"role":"endpointslices"}],"relabel_configs":[{"action":"drop","regex":true,"source_labels":["__meta_kubernetes_pod_container_init"]},{"action":"keep_if_equal","source_labels":["__meta_kubernetes_service_annotation_prometheus_io_port","__meta_kubernetes_pod_container_port_number"]},{"action":"keep","regex":true,"source_labels":["__meta_kubernetes_service_annotation_prometheus_io_scrape_slow"]},{"action":"replace","regex":"(https?)","source_labels":["__meta_kubernetes_service_annotation_prometheus_io_scheme"],"target_label":"__scheme__"},{"action":"replace","regex":"(.+)","source_labels":["__meta_kubernetes_service_annotation_prometheus_io_path"],"target_label":"__metrics_path__"},{"action":"replace","regex":"([^:]+)(?::\\d+)?;(\\d+)","replacement":"$1:$2","source_labels":["__address__","__meta_kubernetes_service_annotation_prometheus_io_port"],"target_label":"__address__"},{"action":"labelmap","regex":"__meta_kubernetes_service_label_(.+)"},{"source_labels":["__meta_kubernetes_pod_name"],"target_label":"pod"},{"source_labels":["__meta_kubernetes_pod_container_name"],"target_label":"container"},{"source_labels":["__meta_kubernetes_namespace"],"target_label":"namespace"},{"source_labels":["__meta_kubernetes_service_name"],"target_label":"service"},{"replacement":"${1}","source_labels":["__meta_kubernetes_service_name"],"target_label":"job"},{"action":"replace","source_labels":["__meta_kubernetes_pod_node_name"],"target_label":"node"}],"scrape_interval":"5m","scrape_timeout":"30s"},{"job_name":"kubernetes-services","kubernetes_sd_configs":[{"role":"service"}],"metrics_path":"/probe","params":{"module":["http_2xx"]},"relabel_configs":[{"action":"keep","regex":true,"source_labels":["__meta_kubernetes_service_annotation_prometheus_io_probe"]},{"source_labels":["__address__"],"target_label":"__param_target"},{"replacement":"blackbox","target_label":"__address__"},{"source_labels":["__param_target"],"target_label":"instance"},{"action":"labelmap","regex":"__meta_kubernetes_service_label_(.+)"},{"source_labels":["__meta_kubernetes_namespace"],"target_label":"namespace"},{"source_labels":["__meta_kubernetes_service_name"],"target_label":"service"}]},{"job_name":"kubernetes-pods","kubernetes_sd_configs":[{"role":"pod"}],"relabel_configs":[{"action":"drop","regex":true,"source_labels":["__meta_kubernetes_pod_container_init"]},{"action":"keep_if_equal","source_labels":["__meta_kubernetes_pod_annotation_prometheus_io_port","__meta_kubernetes_pod_container_port_number"]},{"action":"keep","regex":true,"source_labels":["__meta_kubernetes_pod_annotation_prometheus_io_scrape"]},{"action":"replace","regex":"(.+)","source_labels":["__meta_kubernetes_pod_annotation_prometheus_io_path"],"target_label":"__metrics_path__"},{"action":"replace","regex":"([^:]+)(?::\\d+)?;(\\d+)","replacement":"$1:$2","source_labels":["__address__","__meta_kubernetes_pod_annotation_prometheus_io_port"],"target_label":"__address__"},{"action":"labelmap","regex":"__meta_kubernetes_pod_label_(.+)"},{"source_labels":["__meta_kubernetes_pod_name"],"target_label":"pod"},{"source_labels":["__meta_kubernetes_pod_container_name"],"target_label":"container"},{"source_labels":["__meta_kubernetes_namespace"],"target_label":"namespace"},{"action":"replace","source_labels":["__meta_kubernetes_pod_node_name"],"target_label":"node"}]}],"useTpl":false}` | VMAgent scrape configuration |
| vmagent.config.useTpl | bool | `false` | Enable config templating |
| vmagent.configMap | string | `""` | VMAgent [scraping configuration](https://docs.victoriametrics.com/victoriametrics/vmagent/#how-to-collect-metrics-in-prometheus-format) use existing configmap if specified otherwise .config values will be used |
| vmagent.containerWorkingDir | string | `"/"` | Container working directory |
| vmagent.daemonSet | object | `{"spec":{}}` | [K8s DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) specific variables |
| vmagent.deployment | object | `{"spec":{"strategy":{}}}` | [K8s Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) specific variables |
| vmagent.deployment.spec.strategy | object | `{}` | Deployment strategy. Check [here](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy) for details |
| vmagent.dnsPolicy | string | "" | DNS policy for pod. If not set and hostNetwork is enabled, defaults to ClusterFirstWithHostNet. |
| vmagent.emptyDir | object | `{}` | Empty dir configuration for a case, when persistence is disabled |
| vmagent.env | list | `[]` | Additional environment variables (ex.: secret tokens, flags). Check [here](https://docs.victoriametrics.com/victoriametrics/#environment-variables) for more details. |
| vmagent.envFrom | list | `[]` | Specify alternative source for env variables |
| vmagent.extraArgs | object | `{"envflag.enable":true,"envflag.prefix":"VM_","loggerFormat":"json"}` | VMAgent extra command line arguments |
| vmagent.extraContainers | list | `[]` | Extra containers to run in a pod with vmagent |
| vmagent.extraHostPathMounts | list | `[]` | Additional hostPath mounts |
| vmagent.extraLabels | object | `{}` | Extra labels for Deployment and Statefulset |
| vmagent.extraObjects | list | `[]` | Add extra specs dynamically to this chart |
| vmagent.extraScrapeConfigs | list | `[]` | Extra scrape configs that will be appended to `config` |
| vmagent.extraVolumeMounts | list | `[]` | Extra Volume Mounts for the container |
| vmagent.extraVolumes | list | `[]` | Extra Volumes for the pod |
| vmagent.fullnameOverride | string | `""` | Override resources fullname |
| vmagent.global.cluster.dnsDomain | string | `"cluster.local."` | K8s cluster domain suffix, uses for building storage pods' FQDN. Details are [here](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/) |
| vmagent.global.compatibility | object | `{"openshift":{"adaptSecurityContext":"auto","automountServiceSigningCA":"auto"}}` | Openshift security context compatibility configuration |
| vmagent.global.compatibility.openshift.automountServiceSigningCA | string | `"auto"` | Automount OpenShift service signing CA into the pod |
| vmagent.global.extraAnnotations | object | `{}` | Annotations added to all resources |
| vmagent.global.extraLabels | object | `{}` | Labels added to all resources |
| vmagent.global.image.registry | string | `""` | Image registry, that can be shared across multiple helm charts |
| vmagent.global.imagePullSecrets | list | `[]` | Image pull secrets, that can be shared across multiple helm charts |
| vmagent.horizontalPodAutoscaler | object | `{"enabled":false,"maxReplicas":10,"metrics":[],"minReplicas":1}` | Horizontal Pod Autoscaler. Note that it is not intended to be used for vmagents which perform scraping. In order to scale scraping vmagents check [here](https://docs.victoriametrics.com/victoriametrics/vmagent/#scraping-big-number-of-targets) |
| vmagent.horizontalPodAutoscaler.enabled | bool | `false` | Use HPA for vmagent |
| vmagent.horizontalPodAutoscaler.maxReplicas | int | `10` | Maximum replicas for HPA to use to to scale vmagent |
| vmagent.horizontalPodAutoscaler.metrics | list | `[]` | Metric for HPA to use to scale vmagent |
| vmagent.horizontalPodAutoscaler.minReplicas | int | `1` | Minimum replicas for HPA to use to scale vmagent |
| vmagent.hostAliases | list | `[]` | Add additional DNS entries to pods hosts file. Check [official documentation](https://kubernetes.io/docs/tasks/network/customize-hosts-file-for-pods/) |
| vmagent.hostNetwork | bool | `false` | Enable the host network |
| vmagent.http | list | `[{"name":"http","primary":true,"value":":8429"}]` | HTTP listen address configuration. See https://docs.victoriametrics.com/helm/victoria-metrics-agent/#http-listen-address for details. |
| vmagent.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| vmagent.image.registry | string | `""` | Image registry |
| vmagent.image.repository | string | `"victoriametrics/vmagent"` | Image repository |
| vmagent.image.tag | string | `""` | Image tag, set to `Chart.AppVersion` by default |
| vmagent.image.variant | string | `""` | Variant of the image to use. e.g. enterprise, scratch |
| vmagent.imagePullSecrets | list | `[]` | Image pull secrets |
| vmagent.ingress.annotations | object | `{}` | Ingress annotations |
| vmagent.ingress.enabled | bool | `false` | Enable deployment of ingress for agent |
| vmagent.ingress.extraLabels | object | `{}` | Ingress extra labels |
| vmagent.ingress.hosts | list | `[{"name":"vmagent.local","path":["/"],"port":"http"}]` | Array of host objects |
| vmagent.ingress.ingressClassName | string | `""` | Ingress controller class name |
| vmagent.ingress.pathType | string | `"Prefix"` | Ingress path type |
| vmagent.ingress.tls | list | `[]` | Array of TLS objects |
| vmagent.initContainers | list | `[]` | Init containers for vmagent |
| vmagent.license | object | `{"key":"","secret":{"key":"","name":""}}` | Enterprise license key configuration for VictoriaMetrics enterprise. Required only for VictoriaMetrics enterprise. Check docs [here](https://docs.victoriametrics.com/victoriametrics/enterprise/), for more information, visit [site](https://victoriametrics.com/products/enterprise/). Request a trial license [here](https://victoriametrics.com/products/enterprise/trial/) Supported starting from VictoriaMetrics v1.94.0 |
| vmagent.license.key | string | `""` | License key |
| vmagent.license.secret | object | `{"key":"","name":""}` | Use existing secret with license key |
| vmagent.license.secret.key | string | `""` | Key in secret with license key |
| vmagent.license.secret.name | string | `""` | Existing secret name |
| vmagent.lifecycle | object | `{}` | Specify pod lifecycle |
| vmagent.mode | string | `"deployment"` | VMAgent mode: daemonSet, deployment, statefulSet |
| vmagent.nameOverride | string | `""` | Override chart name |
| vmagent.networkPolicy | object | `{"annotations":{},"egress":[],"enabled":false,"ingress":[],"labels":{}}` | See `kubectl explain networkpolicy.spec` for more. Details are [here](https://kubernetes.io/docs/concepts/services-networking/network-policies/) |
| vmagent.networkPolicy.annotations | object | `{}` | Extra annotations for NetworkPolicy |
| vmagent.networkPolicy.egress | list | `[]` | Egress rules |
| vmagent.networkPolicy.ingress | list | `[]` | Ingress rules |
| vmagent.networkPolicy.labels | object | `{}` | Extra labels for NetworkPolicy |
| vmagent.nodeSelector | object | `{}` | Pod's node selector. Details are [here](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector) |
| vmagent.persistentVolume.accessModes | list | `["ReadWriteOnce"]` | Array of access modes. Must match those of existing PV or dynamic provisioner. Details are [here](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) |
| vmagent.persistentVolume.annotations | object | `{}` | Persistent volume annotations |
| vmagent.persistentVolume.enabled | bool | `false` | Create/use Persistent Volume Claim for server component. Empty dir if false |
| vmagent.persistentVolume.existingClaim | string | `""` | Existing Claim name. If defined, PVC must be created manually before volume will be bound |
| vmagent.persistentVolume.extraLabels | object | `{}` | Persistent volume additional labels |
| vmagent.persistentVolume.matchLabels | object | `{}` | Bind Persistent Volume by labels. Must match all labels of targeted PV. |
| vmagent.persistentVolume.name | string | `""` | Override Persistent Volume Claim name |
| vmagent.persistentVolume.size | string | `"10Gi"` | Size of the volume. Should be calculated based on the logs you send and retention policy you set. |
| vmagent.persistentVolume.storageClassName | string | `""` | StorageClass to use for persistent volume. Requires server.persistentVolume.enabled: true. If defined, PVC created automatically |
| vmagent.persistentVolume.volumeAttributesClassName | string | `nil` | VolumeClassAttribute to user for persistent volume |
| vmagent.podAnnotations | object | `{}` | Annotations to be added to pod |
| vmagent.podDisruptionBudget | object | `{"enabled":false,"labels":{},"maxUnavailable":0,"minAvailable":0,"unhealthyPodEvictionPolicy":null}` | See `kubectl explain poddisruptionbudget.spec` for more or check [official documentation](https://kubernetes.io/docs/tasks/run-application/configure-pdb/) |
| vmagent.podDisruptionBudget.maxUnavailable | int | `0` | max number or percentage of pods that can be unavailable |
| vmagent.podDisruptionBudget.minAvailable | int | `0` | min number or percentage of pods that can be unavailable |
| vmagent.podDisruptionBudget.unhealthyPodEvictionPolicy | string | `nil` | Defines criteria when unhealthy pods should be considered for eviction |
| vmagent.podLabels | object | `{}` | Extra labels for Pods only |
| vmagent.podSecurityContext | object | `{"enabled":true}` | Security context to be added to pod |
| vmagent.priorityClassName | string | `""` | Priority class to be assigned to the pod(s) |
| vmagent.probe.liveness | object | `{"initialDelaySeconds":5,"periodSeconds":15,"tcpSocket":{},"timeoutSeconds":5}` | Liveness probe |
| vmagent.probe.readiness | object | `{"httpGet":{},"initialDelaySeconds":5,"periodSeconds":15}` | Readiness probe |
| vmagent.probe.startup | object | `{}` | Startup probe |
| vmagent.rbac.annotations | object | `{}` | Role/RoleBinding annotations |
| vmagent.rbac.create | bool | `true` | Enables Role/RoleBinding creation |
| vmagent.rbac.extraLabels | object | `{}` | Role/RoleBinding labels |
| vmagent.rbac.extraRules | list | `[]` | additional rules for a role |
| vmagent.rbac.namespaced | bool | `false` | If true and `rbac.enabled`, will deploy a Role/RoleBinding instead of a ClusterRole/ClusterRoleBinding |
| vmagent.remoteWrite | list | `[]` | Generates `remoteWrite.*` flags and config maps with value content for values, that are of type list of map. Each item should contain `url` param to pass validation. |
| vmagent.replicaCount | int | `1` | Replica count |
| vmagent.resources | object | `{}` | Resource object. Details are [here](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/) |
| vmagent.route.annotations | object | `{}` | HTTPRoute annotations |
| vmagent.route.enabled | bool | `false` | Enable deployment of HTTPRoute for VMAgent |
| vmagent.route.extraLabels | object | `{}` | HTTPRoute extra labels |
| vmagent.route.extraRules | list | `[]` | Extra rules to prepend to route. This is useful when working with annotation based services. |
| vmagent.route.filters | list | `[]` | Filters for a default rule in HTTPRoute |
| vmagent.route.hostnames | list | `[]` | Array of hostnames |
| vmagent.route.matches | list | `[{"path":{"type":"PathPrefix","value":"/"}}]` | Matches for a default rule in HTTPRoute |
| vmagent.route.parentRefs | list | `[]` | HTTPGateway objects refs |
| vmagent.runtimeClassName | string | `""` | Name of the [RuntimeClass](https://kubernetes.io/docs/concepts/containers/runtime-class/) used to run the pod, e.g. "gvisor" |
| vmagent.schedulerName | string | `""` | Use an alternate scheduler, e.g. "stork". Check details [here](https://kubernetes.io/docs/tasks/administer-cluster/configure-multiple-schedulers/) |
| vmagent.securityContext | object | `{"enabled":true}` | Security context to be added to pod's containers |
| vmagent.selectorLabels | object | `{}` | Extra selector labels common for pod and service |
| vmagent.service.annotations | object | `{}` | Service annotations |
| vmagent.service.clusterIP | string | `""` | Service ClusterIP |
| vmagent.service.enabled | bool | `false` | Enable agent service |
| vmagent.service.externalIPs | list | `[]` | Service external IPs. Check [here](https://kubernetes.io/docs/concepts/services-networking/service/#external-ips) for details |
| vmagent.service.externalTrafficPolicy | string | `""` | Service external traffic policy. Check [here](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip) for details |
| vmagent.service.extraLabels | object | `{}` | Service labels |
| vmagent.service.healthCheckNodePort | string | `""` | Health check node port for a service. Check [here](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip) for details |
| vmagent.service.internalTrafficPolicy | string | `""` | Service internal traffic policy. Check [here](https://kubernetes.io/docs/concepts/services-networking/service/#traffic-policies) for details |
| vmagent.service.ipFamilies | list | `[]` | List of service IP families. Check [here](https://kubernetes.io/docs/concepts/services-networking/dual-stack/#services) for details. |
| vmagent.service.ipFamilyPolicy | string | `""` | Service IP family policy. Check [here](https://kubernetes.io/docs/concepts/services-networking/dual-stack/#services) for details. |
| vmagent.service.loadBalancerIP | string | `""` | Service load balancer IP |
| vmagent.service.loadBalancerSourceRanges | list | `[]` | Load balancer source range |
| vmagent.service.selectorLabels | object | `{}` | Extra selector labels common for service only |
| vmagent.service.servicePort | string | `""` | Service port |
| vmagent.service.trafficDistribution | string | `""` | Traffic Distribution. Check [Traffic distribution](https://kubernetes.io/docs/concepts/services-networking/service/#traffic-distribution) |
| vmagent.service.type | string | `"ClusterIP"` | Service type |
| vmagent.serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| vmagent.serviceAccount.automountToken | bool | `true` | mount API token to pod directly |
| vmagent.serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| vmagent.serviceAccount.name | string | `nil` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| vmagent.serviceMonitor.annotations | object | `{}` | Service Monitor annotations |
| vmagent.serviceMonitor.basicAuth | object | `{}` | Basic auth params for Service Monitor |
| vmagent.serviceMonitor.enabled | bool | `false` | Enable deployment of Service Monitor for server component. This is Prometheus operator object |
| vmagent.serviceMonitor.extraLabels | object | `{}` | Service Monitor labels |
| vmagent.serviceMonitor.metricRelabelings | list | `[]` | Service Monitor metricRelabelings |
| vmagent.serviceMonitor.port | string | `""` | Service Monitor port. Uses primary http item name by default |
| vmagent.serviceMonitor.relabelings | list | `[]` | Service Monitor relabelings |
| vmagent.serviceMonitor.targetPort | string | `""` | Service Monitor target port. Overrides port when set |
| vmagent.statefulSet | object | `{"clusterMode":false,"replicationFactor":1,"spec":{"updateStrategy":{}}}` | [K8s StatefulSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/) specific variables |
| vmagent.statefulSet.clusterMode | bool | `false` | create cluster of vmagents. Check [here](https://docs.victoriametrics.com/victoriametrics/vmagent/#scraping-big-number-of-targets) available since [v1.77.2](https://github.com/VictoriaMetrics/VictoriaMetrics/releases/tag/v1.77.2) |
| vmagent.statefulSet.replicationFactor | int | `1` | replication factor for vmagent in cluster mode |
| vmagent.statefulSet.spec.updateStrategy | object | `{}` | StatefulSet update strategy. Check [here](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#update-strategies) for details. |
| vmagent.tolerations | list | `[]` | Node tolerations for server scheduling to nodes with taints. Details are [here](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/) |
| vmagent.topologySpreadConstraints | list | `[]` | Pod topologySpreadConstraints |
| vmagent.verticalPodAutoscaler | object | `{"enabled":false}` | Vertical Pod Autoscaler. Requires VPA CRD (`autoscaling.k8s.io/v1`) to be installed in the cluster. Note that VPA should not be used together with HPA on the same resource metrics (CPU/memory). |
| vmagent.verticalPodAutoscaler.enabled | bool | `false` | Use VPA for vmagent |

## Installing the Chart

### With Helm

To install the chart with the release name `my-release`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/victoria-metrics-agent
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: victoria-metrics-agent
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.2"
    chart: victoria-metrics-agent
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
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/victoria-metrics-agent --config /charts/charts/victoria-metrics-agent/ct.yaml
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template victoria-metrics-agent . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```

