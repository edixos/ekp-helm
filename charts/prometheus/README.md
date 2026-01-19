# prometheus

![Version: 0.1.1](https://img.shields.io/badge/Version-0.1.1-informational?style=flat-square) ![AppVersion: v3.0.1](https://img.shields.io/badge/AppVersion-v3.0.1-informational?style=flat-square)

----

[[_TOC_]]

----

## Prerequisites

- Helm v3
- [Prometheus-operator](https://github.com/edixos/ekp-helm/tree/main/charts/kube-prometheus-stack) deployed on the K8S Cluster

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://oauth2-proxy.github.io/manifests | oidc(oauth2-proxy) | 10.1.0 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| ilyasabdellaoui | <ilyas.abdellaoui21@gmail.com> | <https://github.com/ilyasabdellaoui> |

## Description

Deploys Prometheus through prometheus operator

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| alerting.endpoints | list | `[]` | AlertmanagerEndpoints Prometheus should fire alerts against |
| commonLabels | object | `{}` | Labels to apply to all resources |
| fullnameOverride | string | `""` | Provide a name to substitute for the full names of resources |
| imagePullSecrets | list | `[]` | Reference to one or more secrets to be used when pulling images ref: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/ |
| ingress.acme.annotations | list | `["kubernetes.io/tls-acme: \"true\""]` | Annotations to add when `ingress.acme.enabled` is true |
| ingress.acme.enabled | bool | `true` | Manage certificates with ACME protocol |
| ingress.annotations."kubernetes.io/ingress.allow-http" | string | `"false"` |  |
| ingress.enabled | bool | `false` | Enables ingress for prometheus |
| ingress.extraAnnotations | object | `{}` | Map of annotations to add  to th ingress |
| ingress.host | string | `""` | FQDN of the prometheus |
| ingress.labels | object | `{}` | Map of labels to apply to the ingress |
| ingress.path | string | `"/*"` |  |
| ingress.tls.secretName | string | Generated name based on chart release full name | Name of the secret containing the certificates |
| istio.podAnnotations | object | `{"proxy.istio.io/config":"proxyMetadata:\n  OUTPUT_CERTS: /etc/istio-certs/\n","sidecar.istio.io/userVolume":"[{\"name\": \"istio-certs\", \"emptyDir\": {\"medium\": \"Memory\"}}]","sidecar.istio.io/userVolumeMount":"[{\"name\": \"istio-certs\", \"mountPath\": \"/etc/istio-certs/\"}]","traffic.sidecar.istio.io/includeInboundPorts":"","traffic.sidecar.istio.io/includeOutboundIPRanges":""}` | Annotate prometheus pod to allow to inject side car |
| istio.useCertificates | bool | `false` | Allow to scrap metrics using istio certificates |
| istio.volumeMount | list | `[{"mountPath":"/etc/istio-certs/","name":"istio-certs","readOnly":true}]` | volumeMount used to expose istio certificates |
| nameOverride | string | `""` | Provide a name in place of prometheus for `app:` labels |
| oidc.alphaConfig.annotations | object | `{}` |  |
| oidc.alphaConfig.configData | object | `{}` |  |
| oidc.alphaConfig.configFile | string | `""` |  |
| oidc.alphaConfig.enabled | bool | `false` |  |
| oidc.alphaConfig.existingConfig | string | `nil` |  |
| oidc.alphaConfig.existingSecret | string | `nil` |  |
| oidc.alphaConfig.metricsConfigData | object | `{}` |  |
| oidc.alphaConfig.serverConfigData | object | `{}` |  |
| oidc.authenticatedEmailsFile.annotations | object | `{}` |  |
| oidc.authenticatedEmailsFile.enabled | bool | `false` |  |
| oidc.authenticatedEmailsFile.persistence | string | `"configmap"` |  |
| oidc.authenticatedEmailsFile.restrictedUserAccessKey | string | `""` |  |
| oidc.authenticatedEmailsFile.restricted_access | string | `""` |  |
| oidc.authenticatedEmailsFile.template | string | `""` |  |
| oidc.autoscaling.annotations | object | `{}` |  |
| oidc.autoscaling.behavior | object | `{}` |  |
| oidc.autoscaling.enabled | bool | `false` |  |
| oidc.autoscaling.maxReplicas | int | `10` |  |
| oidc.autoscaling.minReplicas | int | `1` |  |
| oidc.autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| oidc.checkDeprecation | bool | `true` |  |
| oidc.config.annotations | object | `{}` |  |
| oidc.config.clientID | string | `"XXXXXXX"` |  |
| oidc.config.clientSecret | string | `"XXXXXXXX"` |  |
| oidc.config.configFile | string | `"email_domains = [ \"*\" ]\nupstreams = [ \"file:///dev/null\" ]"` |  |
| oidc.config.cookieName | string | `""` |  |
| oidc.config.cookieSecret | string | `"XXXXXXXXXXXXXXXX"` |  |
| oidc.config.google | object | `{}` |  |
| oidc.config.requiredSecretKeys[0] | string | `"client-id"` |  |
| oidc.config.requiredSecretKeys[1] | string | `"client-secret"` |  |
| oidc.config.requiredSecretKeys[2] | string | `"cookie-secret"` |  |
| oidc.customLabels | object | `{}` | Custom labels to add into metadata |
| oidc.deploymentAnnotations | object | `{}` |  |
| oidc.enableServiceLinks | bool | `true` |  |
| oidc.envFrom | list | `[]` |  |
| oidc.extraArgs | object | `{}` |  |
| oidc.extraContainers | list | `[]` |  |
| oidc.extraEnv | list | `[]` |  |
| oidc.extraInitContainers | list | `[]` |  |
| oidc.extraObjects | list | `[]` |  |
| oidc.extraVolumeMounts | list | `[]` |  |
| oidc.extraVolumes | list | `[]` |  |
| oidc.gatewayApi.annotations | object | `{}` |  |
| oidc.gatewayApi.enabled | bool | `false` |  |
| oidc.gatewayApi.gatewayRef.name | string | `""` |  |
| oidc.gatewayApi.gatewayRef.namespace | string | `""` |  |
| oidc.gatewayApi.hostnames | list | `[]` |  |
| oidc.gatewayApi.labels | object | `{}` |  |
| oidc.gatewayApi.rules | list | `[]` |  |
| oidc.global.imagePullSecrets | list | `[]` |  |
| oidc.global.imageRegistry | string | `""` |  |
| oidc.hostAliases | list | `[]` |  |
| oidc.htpasswdFile.enabled | bool | `false` |  |
| oidc.htpasswdFile.entries | list | `[]` |  |
| oidc.htpasswdFile.existingSecret | string | `""` |  |
| oidc.httpScheme | string | `"http"` |  |
| oidc.image.command | list | `[]` |  |
| oidc.image.pullPolicy | string | `"IfNotPresent"` |  |
| oidc.image.registry | string | `""` |  |
| oidc.image.repository | string | `"oauth2-proxy/oauth2-proxy"` |  |
| oidc.image.tag | string | `""` |  |
| oidc.imagePullSecrets | list | `[]` |  |
| oidc.ingress.enabled | bool | `false` |  |
| oidc.ingress.labels | object | `{}` |  |
| oidc.ingress.path | string | `"/"` |  |
| oidc.ingress.pathType | string | `"ImplementationSpecific"` |  |
| oidc.initContainers.waitForRedis.enabled | bool | `true` |  |
| oidc.initContainers.waitForRedis.image.pullPolicy | string | `"IfNotPresent"` |  |
| oidc.initContainers.waitForRedis.image.repository | string | `"alpine"` |  |
| oidc.initContainers.waitForRedis.image.tag | string | `"latest"` |  |
| oidc.initContainers.waitForRedis.kubectlVersion | string | `""` |  |
| oidc.initContainers.waitForRedis.resources | object | `{}` |  |
| oidc.initContainers.waitForRedis.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| oidc.initContainers.waitForRedis.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| oidc.initContainers.waitForRedis.securityContext.enabled | bool | `true` |  |
| oidc.initContainers.waitForRedis.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| oidc.initContainers.waitForRedis.securityContext.runAsGroup | int | `65534` |  |
| oidc.initContainers.waitForRedis.securityContext.runAsNonRoot | bool | `true` |  |
| oidc.initContainers.waitForRedis.securityContext.runAsUser | int | `65534` |  |
| oidc.initContainers.waitForRedis.securityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| oidc.initContainers.waitForRedis.timeout | int | `180` |  |
| oidc.kubeVersion | string | `nil` |  |
| oidc.livenessProbe.enabled | bool | `true` |  |
| oidc.livenessProbe.initialDelaySeconds | int | `0` |  |
| oidc.livenessProbe.timeoutSeconds | int | `1` |  |
| oidc.metrics.enabled | bool | `true` |  |
| oidc.metrics.port | int | `44180` |  |
| oidc.metrics.service.appProtocol | string | `"http"` |  |
| oidc.metrics.serviceMonitor.annotations | object | `{}` |  |
| oidc.metrics.serviceMonitor.bearerTokenFile | string | `""` |  |
| oidc.metrics.serviceMonitor.enabled | bool | `false` |  |
| oidc.metrics.serviceMonitor.interval | string | `"60s"` |  |
| oidc.metrics.serviceMonitor.labels | object | `{}` |  |
| oidc.metrics.serviceMonitor.metricRelabelings | list | `[]` |  |
| oidc.metrics.serviceMonitor.namespace | string | `""` |  |
| oidc.metrics.serviceMonitor.prometheusInstance | string | `"default"` |  |
| oidc.metrics.serviceMonitor.relabelings | list | `[]` |  |
| oidc.metrics.serviceMonitor.scheme | string | `""` |  |
| oidc.metrics.serviceMonitor.scrapeTimeout | string | `"30s"` |  |
| oidc.metrics.serviceMonitor.tlsConfig | object | `{}` |  |
| oidc.namespaceOverride | string | `""` |  |
| oidc.networkPolicy.create | bool | `false` |  |
| oidc.networkPolicy.egress | list | `[]` |  |
| oidc.networkPolicy.ingress | list | `[]` |  |
| oidc.nodeSelector | object | `{}` |  |
| oidc.podAnnotations | object | `{}` |  |
| oidc.podDisruptionBudget.enabled | bool | `true` |  |
| oidc.podDisruptionBudget.maxUnavailable | string | `nil` |  |
| oidc.podDisruptionBudget.minAvailable | int | `1` |  |
| oidc.podDisruptionBudget.unhealthyPodEvictionPolicy | string | `""` |  |
| oidc.podLabels | object | `{}` |  |
| oidc.podSecurityContext | object | `{}` |  |
| oidc.priorityClassName | string | `""` |  |
| oidc.proxyVarsAsSecrets | bool | `true` |  |
| oidc.readinessProbe.enabled | bool | `true` |  |
| oidc.readinessProbe.initialDelaySeconds | int | `0` |  |
| oidc.readinessProbe.periodSeconds | int | `10` |  |
| oidc.readinessProbe.successThreshold | int | `1` |  |
| oidc.readinessProbe.timeoutSeconds | int | `5` |  |
| oidc.redis-ha.enabled | bool | `false` |  |
| oidc.replicaCount | int | `1` |  |
| oidc.resizePolicy | list | `[]` |  |
| oidc.resources | object | `{}` |  |
| oidc.revisionHistoryLimit | int | `10` |  |
| oidc.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| oidc.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| oidc.securityContext.enabled | bool | `true` |  |
| oidc.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| oidc.securityContext.runAsGroup | int | `2000` |  |
| oidc.securityContext.runAsNonRoot | bool | `true` |  |
| oidc.securityContext.runAsUser | int | `2000` |  |
| oidc.securityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| oidc.service.annotations | object | `{}` |  |
| oidc.service.appProtocol | string | `"http"` |  |
| oidc.service.externalTrafficPolicy | string | `""` |  |
| oidc.service.internalTrafficPolicy | string | `""` |  |
| oidc.service.ipDualStack.enabled | bool | `false` |  |
| oidc.service.ipDualStack.ipFamilies[0] | string | `"IPv6"` |  |
| oidc.service.ipDualStack.ipFamilies[1] | string | `"IPv4"` |  |
| oidc.service.ipDualStack.ipFamilyPolicy | string | `"PreferDualStack"` |  |
| oidc.service.portNumber | int | `80` |  |
| oidc.service.targetPort | string | `""` |  |
| oidc.service.trafficDistribution | string | `""` |  |
| oidc.service.type | string | `"ClusterIP"` |  |
| oidc.serviceAccount.annotations | object | `{}` |  |
| oidc.serviceAccount.automountServiceAccountToken | bool | `true` |  |
| oidc.serviceAccount.enabled | bool | `true` |  |
| oidc.serviceAccount.imagePullSecrets | list | `[]` |  |
| oidc.serviceAccount.name | string | `nil` |  |
| oidc.sessionStorage.redis.clientType | string | `"standalone"` |  |
| oidc.sessionStorage.redis.cluster.connectionUrls | list | `[]` |  |
| oidc.sessionStorage.redis.existingSecret | string | `""` |  |
| oidc.sessionStorage.redis.password | string | `""` |  |
| oidc.sessionStorage.redis.passwordKey | string | `"redis-password"` |  |
| oidc.sessionStorage.redis.sentinel.connectionUrls | list | `[]` |  |
| oidc.sessionStorage.redis.sentinel.existingSecret | string | `""` |  |
| oidc.sessionStorage.redis.sentinel.masterName | string | `""` |  |
| oidc.sessionStorage.redis.sentinel.password | string | `""` |  |
| oidc.sessionStorage.redis.sentinel.passwordKey | string | `"redis-sentinel-password"` |  |
| oidc.sessionStorage.redis.standalone.connectionUrl | string | `""` |  |
| oidc.sessionStorage.type | string | `"cookie"` |  |
| oidc.strategy | object | `{}` |  |
| oidc.tolerations | list | `[]` |  |
| prometheus.additionalAlertManagerConfigs | list | `[]` | AdditionalAlertManagerConfigs allows for manual configuration of alertmanager jobs in the form as specified in the official Prometheus documentation https://prometheus.io/docs/prometheus/latest/configuration/configuration/#<alertmanager_config>. AlertManager configurations specified are appended to the configurations generated by the Prometheus Operator. As AlertManager configs are appended, the user is responsible to make sure it is valid. Note that using this feature may expose the possibility to break upgrades of Prometheus. It is advised to review Prometheus release notes to ensure that no incompatible AlertManager configs are going to break Prometheus after the upgrade. |
| prometheus.additionalAlertRelabelConfigs | list | `[]` | AdditionalAlertRelabelConfigs allows specifying Prometheus alert relabel configurations. Alert relabel configurations specified are appended to the configurations generated by the Prometheus Operator. Alert relabel configurations specified must have the form as specified in the official Prometheus documentation: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#alert_relabel_configs. As alert relabel configs are appended, the user is responsible to make sure it is valid. Note that using this feature may expose the possibility to break upgrades of Prometheus. It is advised to review Prometheus release notes to ensure that no incompatible alert relabel configs are going to break Prometheus after the upgrade. |
| prometheus.additionalScrapeConfigs | list | `[]` | AdditionalScrapeConfigs allows specifying additional Prometheus scrape configurations. Scrape configurations are appended to the configurations generated by the Prometheus Operator. Job configurations must have the form as specified in the official Prometheus documentation: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#scrape_config. As scrape configs are appended, the user is responsible to make sure it is valid. Note that using this feature may expose the possibility to break upgrades of Prometheus. It is advised to review Prometheus release notes to ensure that no incompatible scrape configs are going to break Prometheus after the upgrade.  The scrape configuraiton example below will find master nodes, provided they have the name .*mst.*, relabel the port to 2379 and allow etcd scraping provided it is running on all Kubernetes master nodes |
| prometheus.additionalScrapeConfigsSecret | object | `{}` | If additional scrape configurations are already deployed in a single secret file you can use this section. Expected values are the secret name and key Cannot be used with additionalScrapeConfigs |
| prometheus.affinity | object | `{}` | Assign custom affinity rules to the prometheus instance ref: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/ |
| prometheus.annotations | object | `{}` | Annotations for Prometheus |
| prometheus.apiserverConfig | object | `{}` | APIServerConfig ref: https://github.com/prometheus-operator/prometheus-operator/blob/master/Documentation/api.md#apiserverconfig |
| prometheus.configMaps | list | `[]` | ConfigMaps is a list of ConfigMaps in the same namespace as the Prometheus object, which shall be mounted into the Prometheus Pods. The ConfigMaps are mounted into /etc/prometheus/configmaps/. |
| prometheus.containers | list | `[]` | Containers allows injecting additional containers. This is meant to allow adding an authentication proxy to a Prometheus pod. if using proxy extraContainer, update targetPort with proxy container port |
| prometheus.disableCompaction | bool | `false` |  |
| prometheus.enableAdminAPI | bool | `false` | EnableAdminAPI enables Prometheus the administrative HTTP API which includes functionality such as deleting time series. This is disabled by default. ref: https://prometheus.io/docs/prometheus/latest/querying/api/#tsdb-admin-apis |
| prometheus.enforcedNamespaceLabel | string | `""` | EnforcedNamespaceLabel enforces adding a namespace label of origin for each alert and metric that is user created. The label value will always be the namespace of the object that is being created. |
| prometheus.evaluationInterval | string | `""` | Interval between consecutive evaluations. |
| prometheus.externalLabels | object | `{}` | External labels to add to any time series or alerts when communicating with external systems |
| prometheus.externalUrl | string | `""` | External URL at which Prometheus will be reachable. |
| prometheus.image.repository | string | `"quay.io/prometheus/prometheus"` | Image of Prometheus to deploy. |
| prometheus.initContainers | list | `[]` | InitContainers allows injecting additional initContainers. This is meant to allow doing some changes (permissions, dir tree) on mounted volumes before starting prometheus |
| prometheus.logFormat | string | `"logfmt"` | Log format for Prometheus be configured in |
| prometheus.logLevel | string | `"info"` | Log level for Prometheus be configured in |
| prometheus.nodeSelector | object | `{}` | Define which Nodes the Pods are scheduled on. ref: https://kubernetes.io/docs/user-guide/node-selection/ |
| prometheus.paused | bool | `false` | If true, the Operator won't process any Prometheus configuration changes |
| prometheus.podAntiAffinity | string | `""` | Pod anti-affinity can prevent the scheduler from placing Prometheus replicas on the same node. The default value "soft" means that the scheduler should *prefer* to not schedule two replica pods onto the same node but no guarantee is provided. The value "hard" means that the scheduler is *required* to not schedule two replica pods onto the same node. The value "" will disable pod anti-affinity so that no anti-affinity rules will be configured. |
| prometheus.podAntiAffinityTopologyKey | string | `"kubernetes.io/hostname"` | If anti-affinity is enabled sets the topologyKey to use for anti-affinity. This can be changed to, for example, failure-domain.beta.kubernetes.io/zone |
| prometheus.podDisruptionBudget | object | `{"enabled":false,"maxUnavailable":"","minAvailable":1}` | Configure pod disruption budgets for Prometheus ref: https://kubernetes.io/docs/tasks/run-application/configure-pdb/#specifying-a-poddisruptionbudget This configuration is immutable once created and will require the PDB to be deleted to be changed https://github.com/kubernetes/kubernetes/issues/45398  |
| prometheus.podMetadata | object | `{"annotations":{},"labels":{}}` | Standard object’s metadata. More info: https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#metadata Metadata Labels and Annotations gets propagated to the prometheus pods. |
| prometheus.podMetadata.annotations | object | `{}` | Annotations to add add on prometheus pod |
| prometheus.podMetadata.labels | object | `{}` | Labels to add add on prometheus pod |
| prometheus.podMonitorNamespaceSelector | object | `{}` | Namespaces to be selected for PodMonitor discovery. See https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.17/#labelselector-v1-meta for usage |
| prometheus.podMonitorSelector | object | `{}` | PodMonitors to be selected for target discovery. If {}, select all PodMonitors See [values.yaml](./values.yaml) for example. |
| prometheus.portName | string | `"http-web"` | PortName to use for Prometheus. |
| prometheus.priorityClassName | string | `""` | Priority class assigned to the Pods |
| prometheus.prometheusExternalLabelName | string | `""` | Name of the external label used to denote Prometheus instance name |
| prometheus.prometheusExternalLabelNameClear | bool | `false` | If true, the Operator won't add the external label used to denote Prometheus instance name |
| prometheus.query | object | `{}` | QuerySpec defines the query command line flags when starting Prometheus. ref: https://github.com/prometheus-operator/prometheus-operator/blob/master/Documentation/api.md#queryspec |
| prometheus.remoteRead | list | `[]` | The remote_read spec configuration for Prometheus. ref: https://github.com/prometheus-operator/prometheus-operator/blob/master/Documentation/api.md#remotereadspec |
| prometheus.remoteWrite | list | `[]` | The remote_write spec configuration for Prometheus. ref: https://github.com/prometheus-operator/prometheus-operator/blob/master/Documentation/api.md#remotewritespec |
| prometheus.replicaExternalLabelName | string | `""` | Name of the external label used to denote replica name |
| prometheus.replicaExternalLabelNameClear | bool | `false` | If true, the Operator won't add the external label used to denote replica name |
| prometheus.replicas | int | `1` | Number of Prometheus replicas desired |
| prometheus.resources | object | `{"limits":{"cpu":"1000m","memory":"1000Mi"},"requests":{"cpu":"500m","memory":"700Mi"}}` | Add resources limits and request to prometheus container. |
| prometheus.retention | string | `"10d"` | How long to retain metrics |
| prometheus.retentionSize | string | `""` | Maximum size of metrics |
| prometheus.routePrefix | string | `"/"` | Prefix used to register routes, overriding externalUrl route. Useful for proxies that rewrite URLs. |
| prometheus.ruleNamespaceSelector | object | `{}` | Namespaces to be selected for PrometheusRules discovery. If nil, select own namespace. Namespaces to be selected for PrometheusRules discovery. See https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.17/#labelselector-v1-meta for usage |
| prometheus.ruleSelector | object | `{}` | PrometheusRules to be selected for target discovery. If {}, select all PrometheusRules. See [values.yaml](./values.yaml) for example. |
| prometheus.scrapeInterval | string | `""` | Interval between consecutive scrapes. |
| prometheus.secrets | list | `[]` | Secrets is a list of Secrets in the same namespace as the Prometheus object, which shall be mounted into the Prometheus Pods. The Secrets are mounted into /etc/prometheus/secrets/. Secrets changes after initial creation of a Prometheus object are not reflected in the running Pods. To change the secrets mounted into the Prometheus Pods, the object must be deleted and recreated with the new list of secrets. |
| prometheus.securityContext.fsGroup | int | `1000` |  |
| prometheus.securityContext.runAsGroup | int | `1000` | The GID to run the entrypoint of the container process |
| prometheus.securityContext.runAsNonRoot | bool | `true` | Indicates that the container must run as a non-root user |
| prometheus.securityContext.runAsUser | int | `1000` | The UID to run the entrypoint of the container process |
| prometheus.serviceAccount.annotations | object | `{}` | Annotations for Prometheus |
| prometheus.serviceAccount.create | bool | `true` | When `true`, create prometheus serviceAccount with `prometheus.serviceAccount.name`. If `prometheus.serviceAccount.name` is empty, use `.Chart.fullname` value. |
| prometheus.serviceAccount.name | string | `""` | Name of the ServiceAccount to use to run the Prometheus Pods. If `prometheus.serviceAccount.create` is `false` and no name is defined, use `default`. |
| prometheus.serviceMonitorNamespaceSelector | object | `{}` | Namespaces to be selected for ServiceMonitor discovery. See https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.17/#labelselector-v1-meta for usage |
| prometheus.serviceMonitorSelector | object | `{}` | ServiceMonitors to be selected for target discovery. If {}, select all ServiceMonitors See [values.yaml](./values.yaml) for example. |
| prometheus.storageSpec | object | `{}` | Prometheus StorageSpec for persistent data ref: https://github.com/prometheus-operator/prometheus-operator/blob/master/Documentation/user-guides/storage.md |
| prometheus.tolerations | list | `[]` | Tolerations for use with node taints ref: https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/ |
| prometheus.volumeMounts | list | `[]` | Additional VolumeMounts on the output StatefulSet definition. |
| prometheus.volumes | list | `[]` | Additional volumes on the output StatefulSet definition. |
| prometheus.walCompression | bool | `false` | Enable compression of the write-ahead log using Snappy. |
| rbac.create | bool | `true` | Create rbac resources when set to `true` |
| rbac.scopeNamespaced | bool | `true` | Use `Role` and `RoleBinding` resources when set to true, else `ClusterRole` and `ClusterRoleBinding`  |
| rules.annotations | object | `{}` | Map of annotations to apply to the prometheus rules created |
| rules.enabled | bool | `true` | If `true`, create prometheus rules to monitor prometheus instance when ServiceMonitor is enabled |
| rules.labels | object | `{prometheus: "release chart fullname"}` | Map of labels to apply to the prometheus rules. This labels are used to define `prometheus.ruleSelector` |
| service.annotations | object | `{}` | Map of annotations to apply to the service |
| service.clusterIP | string | `""` | Cluster IP Only use if service.type is "ClusterIP" |
| service.externalIPs | list | `[]` | List of IP addresses at which the Prometheus server service is available Ref: https://kubernetes.io/docs/user-guide/services/#external-ips |
| service.labels | object | `{}` | Map of labels to apply to the service |
| service.loadBalancerIP | string | `""` | Loadbalancer IP Only use if service.type is "loadbalancer" |
| service.loadBalancerSourceRanges | list | `[]` |  |
| service.nodePort | int | `30090` | Port to expose on each node Only used if service.type is 'NodePort' |
| service.port | int | `9090` | Port for Prometheus Service to listen on |
| service.sessionAffinity | string | `""` |  |
| service.targetPort | int | `9090` | To be used with a proxy extraContainer port |
| service.type | string | `"ClusterIP"` | Service type |
| serviceMonitor.annotations | object | `{}` | Map of annotations to apply to the ServiceMonitor |
| serviceMonitor.bearerTokenFile | string | `nil` |  |
| serviceMonitor.enabled | bool | `false` | If `true` Self monitor prometheus with ServiceMonitor |
| serviceMonitor.interval | string | `""` | Scrape interval. If not set, the Prometheus default scrape interval is used. dd |
| serviceMonitor.metricRelabelings | list | `[]` | metric relabel configs to apply to samples before ingestion. |
| serviceMonitor.relabelings | list | `[]` | Relabel configs to apply to samples before ingestion. |
| serviceMonitor.scheme | string | `""` | HTTP scheme to use for scraping. Can be used with `tlsConfig` for example if using istio mTLS. |
| serviceMonitor.tlsConfig | object | `{}` | TLS configuration to use when scraping the endpoint. For example if using istio mTLS. Of type: https://github.com/prometheus-operator/prometheus-operator/blob/master/Documentation/api.md#tlsconfig |

## Installing the Chart

### With Helm

To install the chart with the release name `my-release`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/prometheus
```

### With ArgoCD

#### Cluster k8s with access to public registry

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: prometheus
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.1"
    chart: prometheus
    path: ''

    helm:

      values: |
        ingress:
          # Configure ingress
          enabled: true
          host: "prom.example.com"
          # Use nginx ingress controller
          extraAnnotations:
            kubernetes.io/ingress.class: nginx
          path: "/"

        prometheus:
          # Provision 10Gi to store data using default storageClassName
          storageSpec:
            volumeClaimTemplate:
              spec:
                accessModes:
                - ReadWriteOnce
                resources:
                  requests:
                    storage: "10Gi"
                volumeMode: Filesystem

        # Self monitor prometheus instance
        serviceMonitor:
          enabled: true

  destination:
    server: https://kubernetes.default.svc
    namespace: "infra-monitoring"

  ignoreDifferences:
  - group: ""
    kind: Secret
    name: prometheus-gatekeeper
    jsonPointers:
    - /data/secretId
    - /data/encyptionKey
```

#### Istio integration

To allow prometheus to scrap application metrics when istio mtls is enable, inject istio sidecar that will obtain certificate at init.
See [istio documentation](https://istio.io/latest/docs/ops/integrations/prometheus/?_ga=2.130085258.425225454.1609851114-318080454.1558103507#tls-settings)
for details.

If prometheus is deployed with prometheus-operator and prometheus helm chart

    1. enable istio-injection on prometheus namespace

    2. enable helm flags

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: prometheus
spec:
  ...
  source:
    helm:
      values: |
        ...
        istio:
            useCertificates: true
        ...

  destination:
    ...
```

    3. Configure ServiceMonitor resources to use istio certificate

```yaml
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: my-service
spec:
  endpoints:
  - path: /metrics
    port: http-metrics
    scheme: https
    tlsConfig:
      caFile: /etc/istio-certs/root-cert.pem
      certFile: /etc/istio-certs/cert-chain.pem
      keyFile: /etc/istio-certs/key.pem
      insecureSkipVerify: true
    ...
  ...
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
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/prometheus --config /charts/charts/prometheus/ct.yaml
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
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template prometheus . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```
