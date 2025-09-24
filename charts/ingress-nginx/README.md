# ingress-nginx

![Version: 0.1.4](https://img.shields.io/badge/Version-0.1.4-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.12.1](https://img.shields.io/badge/AppVersion-1.12.1-informational?style=flat-square)

## Prerequisites

- Helm v3
- Config Connector installed (v1.6.0)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://kubernetes.github.io/ingress-nginx | ingressNginx(ingress-nginx) | 4.13.2 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| ilyasabdellaoui | <ilyas.abdellaoui21@gmail.com> | <https://github.com/ilyasabdellaoui> |

## Description

A Helm chart for Kubernetes

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| ingressNginx.commonLabels | object | `{}` |  |
| ingressNginx.controller.addHeaders | object | `{}` | Will add custom headers before sending response traffic to the client according to: https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/configmap/#add-headers |
| ingressNginx.controller.admissionWebhooks.annotations | object | `{}` |  |
| ingressNginx.controller.admissionWebhooks.certManager.admissionCert.duration | string | `""` |  |
| ingressNginx.controller.admissionWebhooks.certManager.admissionCert.revisionHistoryLimit | int | `0` | Revision history limit of the webhook certificate. Ref.: https://cert-manager.io/docs/reference/api-docs/#cert-manager.io/v1.CertificateSpec |
| ingressNginx.controller.admissionWebhooks.certManager.enabled | bool | `false` |  |
| ingressNginx.controller.admissionWebhooks.certManager.rootCert.duration | string | `""` |  |
| ingressNginx.controller.admissionWebhooks.certManager.rootCert.revisionHistoryLimit | int | `0` | Revision history limit of the root certificate. Ref.: https://cert-manager.io/docs/reference/api-docs/#cert-manager.io/v1.CertificateSpec |
| ingressNginx.controller.admissionWebhooks.certificate | string | `"/usr/local/certificates/cert"` |  |
| ingressNginx.controller.admissionWebhooks.createSecretJob.activeDeadlineSeconds | int | `0` | Deadline in seconds for the job to complete. Must be greater than 0 to enforce. If unset or 0, no deadline is enforced. |
| ingressNginx.controller.admissionWebhooks.createSecretJob.name | string | `"create"` |  |
| ingressNginx.controller.admissionWebhooks.createSecretJob.resources | object | `{}` |  |
| ingressNginx.controller.admissionWebhooks.createSecretJob.securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"readOnlyRootFilesystem":true,"runAsGroup":65532,"runAsNonRoot":true,"runAsUser":65532,"seccompProfile":{"type":"RuntimeDefault"}}` | Security context for secret creation containers |
| ingressNginx.controller.admissionWebhooks.enabled | bool | `true` |  |
| ingressNginx.controller.admissionWebhooks.extraEnvs | list | `[]` | Additional environment variables to set |
| ingressNginx.controller.admissionWebhooks.failurePolicy | string | `"Fail"` | Admission Webhook failure policy to use |
| ingressNginx.controller.admissionWebhooks.key | string | `"/usr/local/certificates/key"` |  |
| ingressNginx.controller.admissionWebhooks.labels | object | `{}` | Labels to be added to admission webhooks |
| ingressNginx.controller.admissionWebhooks.name | string | `"admission"` |  |
| ingressNginx.controller.admissionWebhooks.namespaceSelector | object | `{}` |  |
| ingressNginx.controller.admissionWebhooks.objectSelector | object | `{}` |  |
| ingressNginx.controller.admissionWebhooks.patch.enabled | bool | `true` |  |
| ingressNginx.controller.admissionWebhooks.patch.image.digest | string | `"sha256:050a34002d5bb4966849c880c56c91f5320372564245733b33d4b3461b4dbd24"` |  |
| ingressNginx.controller.admissionWebhooks.patch.image.image | string | `"ingress-nginx/kube-webhook-certgen"` |  |
| ingressNginx.controller.admissionWebhooks.patch.image.pullPolicy | string | `"IfNotPresent"` |  |
| ingressNginx.controller.admissionWebhooks.patch.image.tag | string | `"v1.6.2"` |  |
| ingressNginx.controller.admissionWebhooks.patch.labels | object | `{}` | Labels to be added to patch job resources |
| ingressNginx.controller.admissionWebhooks.patch.networkPolicy.enabled | bool | `false` | Enable 'networkPolicy' or not |
| ingressNginx.controller.admissionWebhooks.patch.nodeSelector."kubernetes.io/os" | string | `"linux"` |  |
| ingressNginx.controller.admissionWebhooks.patch.podAnnotations | object | `{}` |  |
| ingressNginx.controller.admissionWebhooks.patch.priorityClassName | string | `""` | Provide a priority class name to the webhook patching job # |
| ingressNginx.controller.admissionWebhooks.patch.rbac | object | `{"create":true}` | Admission webhook patch job RBAC |
| ingressNginx.controller.admissionWebhooks.patch.rbac.create | bool | `true` | Create RBAC or not |
| ingressNginx.controller.admissionWebhooks.patch.runtimeClassName | string | `""` | Instruct the kubelet to use the named RuntimeClass to run the pod |
| ingressNginx.controller.admissionWebhooks.patch.securityContext | object | `{}` | Security context for secret creation & webhook patch pods |
| ingressNginx.controller.admissionWebhooks.patch.serviceAccount | object | `{"automountServiceAccountToken":true,"create":true,"name":""}` | Admission webhook patch job service account |
| ingressNginx.controller.admissionWebhooks.patch.serviceAccount.automountServiceAccountToken | bool | `true` | Auto-mount service account token or not |
| ingressNginx.controller.admissionWebhooks.patch.serviceAccount.create | bool | `true` | Create a service account or not |
| ingressNginx.controller.admissionWebhooks.patch.serviceAccount.name | string | `""` | Custom service account name |
| ingressNginx.controller.admissionWebhooks.patch.tolerations | list | `[]` |  |
| ingressNginx.controller.admissionWebhooks.patchWebhookJob.activeDeadlineSeconds | int | `0` | Deadline in seconds for the job to complete. Must be greater than 0 to enforce. If unset or 0, no deadline is enforced. |
| ingressNginx.controller.admissionWebhooks.patchWebhookJob.name | string | `"patch"` |  |
| ingressNginx.controller.admissionWebhooks.patchWebhookJob.resources | object | `{}` |  |
| ingressNginx.controller.admissionWebhooks.patchWebhookJob.securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"readOnlyRootFilesystem":true,"runAsGroup":65532,"runAsNonRoot":true,"runAsUser":65532,"seccompProfile":{"type":"RuntimeDefault"}}` | Security context for webhook patch containers |
| ingressNginx.controller.admissionWebhooks.port | int | `8443` |  |
| ingressNginx.controller.admissionWebhooks.service.annotations | object | `{}` |  |
| ingressNginx.controller.admissionWebhooks.service.externalIPs | list | `[]` |  |
| ingressNginx.controller.admissionWebhooks.service.loadBalancerSourceRanges | list | `[]` |  |
| ingressNginx.controller.admissionWebhooks.service.servicePort | int | `443` |  |
| ingressNginx.controller.admissionWebhooks.service.type | string | `"ClusterIP"` |  |
| ingressNginx.controller.affinity | object | `{}` | Affinity and anti-affinity rules for server scheduling to nodes # Ref: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity # |
| ingressNginx.controller.allowSnippetAnnotations | bool | `false` | This configuration defines if Ingress Controller should allow users to set their own *-snippet annotations, otherwise this is forbidden / dropped when users add those annotations. Global snippets in ConfigMap are still respected |
| ingressNginx.controller.annotations | object | `{}` | Annotations to be added to the controller Deployment or DaemonSet # |
| ingressNginx.controller.autoscaling.annotations | object | `{}` |  |
| ingressNginx.controller.autoscaling.behavior | object | `{}` |  |
| ingressNginx.controller.autoscaling.enabled | bool | `false` |  |
| ingressNginx.controller.autoscaling.maxReplicas | int | `11` |  |
| ingressNginx.controller.autoscaling.minReplicas | int | `1` |  |
| ingressNginx.controller.autoscaling.targetCPUUtilizationPercentage | int | `50` |  |
| ingressNginx.controller.autoscaling.targetMemoryUtilizationPercentage | int | `50` |  |
| ingressNginx.controller.autoscalingTemplate | list | `[]` |  |
| ingressNginx.controller.config | object | `{}` | Global configuration passed to the ConfigMap consumed by the controller. Values may contain Helm templates. Ref.: https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/configmap/ |
| ingressNginx.controller.configAnnotations | object | `{}` | Annotations to be added to the controller config configuration configmap. |
| ingressNginx.controller.configMapNamespace | string | `""` | Allows customization of the configmap / nginx-configmap namespace; defaults to $(POD_NAMESPACE) |
| ingressNginx.controller.containerName | string | `"controller"` | Configures the controller container name |
| ingressNginx.controller.containerPort | object | `{"http":80,"https":443}` | Configures the ports that the nginx-controller listens on |
| ingressNginx.controller.containerSecurityContext | object | `{}` | Security context for controller containers |
| ingressNginx.controller.customTemplate.configMapKey | string | `""` |  |
| ingressNginx.controller.customTemplate.configMapName | string | `""` |  |
| ingressNginx.controller.disableLeaderElection | bool | `false` | This configuration disable Nginx Controller Leader Election |
| ingressNginx.controller.dnsConfig | object | `{}` | Optionally customize the pod dnsConfig. |
| ingressNginx.controller.dnsPolicy | string | `"ClusterFirst"` | Optionally change this to ClusterFirstWithHostNet in case you have 'hostNetwork: true'. By default, while using host network, name resolution uses the host's DNS. If you wish nginx-controller to keep resolving names inside the k8s network, use ClusterFirstWithHostNet. |
| ingressNginx.controller.electionID | string | `""` | Election ID to use for status update, by default it uses the controller name combined with a suffix of 'leader' |
| ingressNginx.controller.electionTTL | string | `""` | Duration a leader election is valid before it's getting re-elected, e.g. `15s`, `10m` or `1h`. (Default: 30s) |
| ingressNginx.controller.enableAnnotationValidations | bool | `true` |  |
| ingressNginx.controller.enableMimalloc | bool | `true` | Enable mimalloc as a drop-in replacement for malloc. # ref: https://github.com/microsoft/mimalloc # |
| ingressNginx.controller.enableTopologyAwareRouting | bool | `false` | This configuration enables Topology Aware Routing feature, used together with service annotation service.kubernetes.io/topology-mode="auto" Defaults to false |
| ingressNginx.controller.extraArgs | object | `{}` | Additional command line arguments to pass to Ingress-Nginx Controller E.g. to specify the default SSL certificate you can use |
| ingressNginx.controller.extraContainers | list | `[]` | Additional containers to be added to the controller pod. See https://github.com/lemonldap-ng-controller/lemonldap-ng-controller as example. |
| ingressNginx.controller.extraEnvs | list | `[]` | Additional environment variables to set |
| ingressNginx.controller.extraInitContainers | list | `[]` | Containers, which are run before the app containers are started. |
| ingressNginx.controller.extraModules | list | `[]` | Modules, which are mounted into the core nginx image. |
| ingressNginx.controller.extraVolumeMounts | list | `[]` | Additional volumeMounts to the controller main container. |
| ingressNginx.controller.extraVolumes | list | `[]` | Additional volumes to the controller pod. |
| ingressNginx.controller.healthCheckHost | string | `""` | Address to bind the health check endpoint. It is better to set this option to the internal node address if the Ingress-Nginx Controller is running in the `hostNetwork: true` mode. |
| ingressNginx.controller.healthCheckPath | string | `"/healthz"` | Path of the health check endpoint. All requests received on the port defined by the healthz-port parameter are forwarded internally to this path. |
| ingressNginx.controller.hostAliases | list | `[]` | Optionally customize the pod hostAliases. |
| ingressNginx.controller.hostNetwork | bool | `false` | Required for use with CNI based kubernetes installations (such as ones set up by kubeadm), since CNI and hostport don't mix yet. Can be deprecated once https://github.com/kubernetes/kubernetes/issues/23920 is merged |
| ingressNginx.controller.hostPort.enabled | bool | `false` | Enable 'hostPort' or not |
| ingressNginx.controller.hostPort.ports.http | int | `80` | 'hostPort' http port |
| ingressNginx.controller.hostPort.ports.https | int | `443` | 'hostPort' https port |
| ingressNginx.controller.hostname | object | `{}` | Optionally customize the pod hostname. |
| ingressNginx.controller.image.allowPrivilegeEscalation | bool | `false` |  |
| ingressNginx.controller.image.chroot | bool | `false` |  |
| ingressNginx.controller.image.digest | string | `"sha256:1f7eaeb01933e719c8a9f4acd8181e555e582330c7d50f24484fb64d2ba9b2ef"` |  |
| ingressNginx.controller.image.digestChroot | string | `"sha256:2beb2139c53d6bcb9c8b11d68b412a6a1aa1de3a7e6040695848b0ce997b2be8"` |  |
| ingressNginx.controller.image.image | string | `"ingress-nginx/controller"` |  |
| ingressNginx.controller.image.pullPolicy | string | `"IfNotPresent"` |  |
| ingressNginx.controller.image.readOnlyRootFilesystem | bool | `false` |  |
| ingressNginx.controller.image.runAsGroup | int | `82` | This value must not be changed using the official image. uid=101(www-data) gid=82(www-data) groups=82(www-data) |
| ingressNginx.controller.image.runAsNonRoot | bool | `true` |  |
| ingressNginx.controller.image.runAsUser | int | `101` | This value must not be changed using the official image. uid=101(www-data) gid=82(www-data) groups=82(www-data) |
| ingressNginx.controller.image.seccompProfile.type | string | `"RuntimeDefault"` |  |
| ingressNginx.controller.image.tag | string | `"v1.13.2"` |  |
| ingressNginx.controller.ingressClass | string | `"nginx"` | For backwards compatibility with ingress.class annotation, use ingressClass. Algorithm is as follows, first ingressClassName is considered, if not present, controller looks for ingress.class annotation |
| ingressNginx.controller.ingressClassByName | bool | `false` | Process IngressClass per name (additionally as per spec.controller). |
| ingressNginx.controller.ingressClassResource | object | `{"aliases":[],"annotations":{},"controllerValue":"k8s.io/ingress-nginx","default":false,"enabled":true,"name":"nginx","parameters":{}}` | This section refers to the creation of the IngressClass resource. IngressClasses are immutable and cannot be changed after creation. We do not support namespaced IngressClasses, yet, so a ClusterRole and a ClusterRoleBinding is required. |
| ingressNginx.controller.ingressClassResource.aliases | list | `[]` | Aliases of this IngressClass. Creates copies with identical settings but the respective alias as name. Useful for development environments with only one Ingress Controller but production-like Ingress resources. `default` gets enabled on the original IngressClass only. |
| ingressNginx.controller.ingressClassResource.annotations | object | `{}` | Annotations to be added to the IngressClass resource. |
| ingressNginx.controller.ingressClassResource.controllerValue | string | `"k8s.io/ingress-nginx"` | Controller of the IngressClass. An Ingress Controller looks for IngressClasses it should reconcile by this value. This value is also being set as the `--controller-class` argument of this Ingress Controller. Ref: https://kubernetes.io/docs/concepts/services-networking/ingress/#ingress-class |
| ingressNginx.controller.ingressClassResource.default | bool | `false` | If true, Ingresses without `ingressClassName` get assigned to this IngressClass on creation. Ingress creation gets rejected if there are multiple default IngressClasses. Ref: https://kubernetes.io/docs/concepts/services-networking/ingress/#default-ingress-class |
| ingressNginx.controller.ingressClassResource.enabled | bool | `true` | Create the IngressClass or not |
| ingressNginx.controller.ingressClassResource.name | string | `"nginx"` | Name of the IngressClass |
| ingressNginx.controller.ingressClassResource.parameters | object | `{}` | A link to a custom resource containing additional configuration for the controller. This is optional if the controller consuming this IngressClass does not require additional parameters. Ref: https://kubernetes.io/docs/concepts/services-networking/ingress/#ingress-class |
| ingressNginx.controller.keda.apiVersion | string | `"keda.sh/v1alpha1"` |  |
| ingressNginx.controller.keda.behavior | object | `{}` |  |
| ingressNginx.controller.keda.cooldownPeriod | int | `300` |  |
| ingressNginx.controller.keda.enabled | bool | `false` |  |
| ingressNginx.controller.keda.maxReplicas | int | `11` |  |
| ingressNginx.controller.keda.minReplicas | int | `1` |  |
| ingressNginx.controller.keda.pollingInterval | int | `30` |  |
| ingressNginx.controller.keda.restoreToOriginalReplicaCount | bool | `false` |  |
| ingressNginx.controller.keda.scaledObject.annotations | object | `{}` |  |
| ingressNginx.controller.keda.triggers | list | `[]` |  |
| ingressNginx.controller.kind | string | `"Deployment"` | Use a `DaemonSet` or `Deployment` |
| ingressNginx.controller.labels | object | `{}` | Labels to be added to the controller Deployment or DaemonSet and other resources that do not have option to specify labels # |
| ingressNginx.controller.lifecycle | object | `{"preStop":{"exec":{"command":["/wait-shutdown"]}}}` | Improve connection draining when ingress controller pod is deleted using a lifecycle hook: With this new hook, we increased the default terminationGracePeriodSeconds from 30 seconds to 300, allowing the draining of connections up to five minutes. If the active connections end before that, the pod will terminate gracefully at that time. To effectively take advantage of this feature, the Configmap feature worker-shutdown-timeout new value is 240s instead of 10s. # |
| ingressNginx.controller.livenessProbe.failureThreshold | int | `5` |  |
| ingressNginx.controller.livenessProbe.httpGet.path | string | `"/healthz"` |  |
| ingressNginx.controller.livenessProbe.httpGet.port | int | `10254` |  |
| ingressNginx.controller.livenessProbe.httpGet.scheme | string | `"HTTP"` |  |
| ingressNginx.controller.livenessProbe.initialDelaySeconds | int | `10` |  |
| ingressNginx.controller.livenessProbe.periodSeconds | int | `10` |  |
| ingressNginx.controller.livenessProbe.successThreshold | int | `1` |  |
| ingressNginx.controller.livenessProbe.timeoutSeconds | int | `1` |  |
| ingressNginx.controller.maxmindLicenseKey | string | `""` | Maxmind license key to download GeoLite2 Databases. # https://blog.maxmind.com/2019/12/significant-changes-to-accessing-and-using-geolite2-databases/ |
| ingressNginx.controller.metrics.enabled | bool | `false` |  |
| ingressNginx.controller.metrics.port | int | `10254` |  |
| ingressNginx.controller.metrics.portName | string | `"metrics"` |  |
| ingressNginx.controller.metrics.prometheusRule.additionalLabels | object | `{}` |  |
| ingressNginx.controller.metrics.prometheusRule.annotations | object | `{}` | Annotations to be added to the PrometheusRule. |
| ingressNginx.controller.metrics.prometheusRule.enabled | bool | `false` |  |
| ingressNginx.controller.metrics.prometheusRule.rules | list | `[]` |  |
| ingressNginx.controller.metrics.service.annotations | object | `{}` |  |
| ingressNginx.controller.metrics.service.enabled | bool | `true` | Enable the metrics service or not. |
| ingressNginx.controller.metrics.service.externalIPs | list | `[]` | List of IP addresses at which the stats-exporter service is available # Ref: https://kubernetes.io/docs/concepts/services-networking/service/#external-ips # |
| ingressNginx.controller.metrics.service.labels | object | `{}` | Labels to be added to the metrics service resource |
| ingressNginx.controller.metrics.service.loadBalancerSourceRanges | list | `[]` |  |
| ingressNginx.controller.metrics.service.servicePort | int | `10254` |  |
| ingressNginx.controller.metrics.service.type | string | `"ClusterIP"` |  |
| ingressNginx.controller.metrics.serviceMonitor.additionalLabels | object | `{}` |  |
| ingressNginx.controller.metrics.serviceMonitor.annotations | object | `{}` | Annotations to be added to the ServiceMonitor. |
| ingressNginx.controller.metrics.serviceMonitor.enabled | bool | `false` |  |
| ingressNginx.controller.metrics.serviceMonitor.labelLimit | int | `0` | Per-scrape limit on number of labels that will be accepted for a sample. |
| ingressNginx.controller.metrics.serviceMonitor.labelNameLengthLimit | int | `0` | Per-scrape limit on length of labels name that will be accepted for a sample. |
| ingressNginx.controller.metrics.serviceMonitor.labelValueLengthLimit | int | `0` | Per-scrape limit on length of labels value that will be accepted for a sample. |
| ingressNginx.controller.metrics.serviceMonitor.metricRelabelings | list | `[]` |  |
| ingressNginx.controller.metrics.serviceMonitor.namespace | string | `""` |  |
| ingressNginx.controller.metrics.serviceMonitor.namespaceSelector | object | `{}` |  |
| ingressNginx.controller.metrics.serviceMonitor.relabelings | list | `[]` |  |
| ingressNginx.controller.metrics.serviceMonitor.sampleLimit | int | `0` | Defines a per-scrape limit on the number of scraped samples that will be accepted. |
| ingressNginx.controller.metrics.serviceMonitor.scrapeInterval | string | `"30s"` |  |
| ingressNginx.controller.metrics.serviceMonitor.targetLabels | list | `[]` |  |
| ingressNginx.controller.metrics.serviceMonitor.targetLimit | int | `0` | Defines a limit on the number of scraped targets that will be accepted. |
| ingressNginx.controller.minAvailable | int | `1` | Minimum available pods set in PodDisruptionBudget. Define either 'minAvailable' or 'maxUnavailable', never both. |
| ingressNginx.controller.minReadySeconds | int | `0` | `minReadySeconds` to avoid killing pods before we are ready # |
| ingressNginx.controller.name | string | `"controller"` |  |
| ingressNginx.controller.networkPolicy.enabled | bool | `false` | Enable 'networkPolicy' or not |
| ingressNginx.controller.nodeSelector | object | `{"kubernetes.io/os":"linux"}` | Node labels for controller pod assignment # Ref: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/ # |
| ingressNginx.controller.podAnnotations | object | `{}` | Annotations to be added to controller pods # |
| ingressNginx.controller.podLabels | object | `{}` | Labels to add to the pod container metadata |
| ingressNginx.controller.podSecurityContext | object | `{}` | Security context for controller pods |
| ingressNginx.controller.priorityClassName | string | `""` |  |
| ingressNginx.controller.progressDeadlineSeconds | int | `0` | Specifies the number of seconds you want to wait for the controller deployment to progress before the system reports back that it has failed. Ref.: https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#progress-deadline-seconds |
| ingressNginx.controller.proxySetHeaders | object | `{}` | Will add custom headers before sending traffic to backends according to https://github.com/kubernetes/ingress-nginx/tree/main/docs/examples/customization/custom-headers |
| ingressNginx.controller.publishService | object | `{"enabled":true,"pathOverride":""}` | Allows customization of the source of the IP address or FQDN to report in the ingress status field. By default, it reads the information provided by the service. If disable, the status field reports the IP address of the node or nodes where an ingress controller pod is running. |
| ingressNginx.controller.publishService.enabled | bool | `true` | Enable 'publishService' or not |
| ingressNginx.controller.publishService.pathOverride | string | `""` | Allows overriding of the publish service to bind to Must be <namespace>/<service_name> |
| ingressNginx.controller.readinessProbe.failureThreshold | int | `3` |  |
| ingressNginx.controller.readinessProbe.httpGet.path | string | `"/healthz"` |  |
| ingressNginx.controller.readinessProbe.httpGet.port | int | `10254` |  |
| ingressNginx.controller.readinessProbe.httpGet.scheme | string | `"HTTP"` |  |
| ingressNginx.controller.readinessProbe.initialDelaySeconds | int | `10` |  |
| ingressNginx.controller.readinessProbe.periodSeconds | int | `10` |  |
| ingressNginx.controller.readinessProbe.successThreshold | int | `1` |  |
| ingressNginx.controller.readinessProbe.timeoutSeconds | int | `1` |  |
| ingressNginx.controller.replicaCount | int | `1` |  |
| ingressNginx.controller.reportNodeInternalIp | bool | `false` | Bare-metal considerations via the host network https://kubernetes.github.io/ingress-nginx/deploy/baremetal/#via-the-host-network Ingress status was blank because there is no Service exposing the Ingress-Nginx Controller in a configuration using the host network, the default --publish-service flag used in standard cloud setups does not apply |
| ingressNginx.controller.resources.requests.cpu | string | `"100m"` |  |
| ingressNginx.controller.resources.requests.memory | string | `"90Mi"` |  |
| ingressNginx.controller.runtimeClassName | string | `""` | Instruct the kubelet to use the named RuntimeClass to run the pod |
| ingressNginx.controller.scope.enabled | bool | `false` | Enable 'scope' or not |
| ingressNginx.controller.scope.namespace | string | `""` | Namespace to limit the controller to; defaults to $(POD_NAMESPACE) |
| ingressNginx.controller.scope.namespaceSelector | string | `""` | When scope.enabled == false, instead of watching all namespaces, we watching namespaces whose labels only match with namespaceSelector. Format like foo=bar. Defaults to empty, means watching all namespaces. |
| ingressNginx.controller.service.annotations | object | `{}` | Annotations to be added to the external controller service. See `controller.service.internal.annotations` for annotations to be added to the internal controller service. |
| ingressNginx.controller.service.appProtocol | bool | `true` | Declare the app protocol of the external HTTP and HTTPS listeners or not. Supersedes provider-specific annotations for declaring the backend protocol. Ref: https://kubernetes.io/docs/concepts/services-networking/service/#application-protocol |
| ingressNginx.controller.service.clusterIP | string | `""` | Pre-defined cluster internal IP address of the external controller service. Take care of collisions with existing services. This value is immutable. Set once, it can not be changed without deleting and re-creating the service. Ref: https://kubernetes.io/docs/concepts/services-networking/service/#choosing-your-own-ip-address |
| ingressNginx.controller.service.clusterIPs | list | `[]` | Pre-defined cluster internal IP addresses of the external controller service. Take care of collisions with existing services. This value is immutable. Set once, it can not be changed without deleting and re-creating the service. Ref: https://kubernetes.io/docs/concepts/services-networking/service/#choosing-your-own-ip-address |
| ingressNginx.controller.service.enableHttp | bool | `true` | Enable the HTTP listener on both controller services or not. |
| ingressNginx.controller.service.enableHttps | bool | `true` | Enable the HTTPS listener on both controller services or not. |
| ingressNginx.controller.service.enabled | bool | `true` | Enable controller services or not. This does not influence the creation of either the admission webhook or the metrics service. |
| ingressNginx.controller.service.external.enabled | bool | `true` | Enable the external controller service or not. Useful for internal-only deployments. |
| ingressNginx.controller.service.external.labels | object | `{}` | Labels to be added to the external controller service. |
| ingressNginx.controller.service.externalIPs | list | `[]` | List of node IP addresses at which the external controller service is available. Ref: https://kubernetes.io/docs/concepts/services-networking/service/#external-ips |
| ingressNginx.controller.service.externalTrafficPolicy | string | `""` | External traffic policy of the external controller service. Set to "Local" to preserve source IP on providers supporting it. Ref: https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip |
| ingressNginx.controller.service.internal.annotations | object | `{}` | Annotations to be added to the internal controller service. Mandatory for the internal controller service to be created. Varies with the cloud service. Ref: https://kubernetes.io/docs/concepts/services-networking/service/#internal-load-balancer |
| ingressNginx.controller.service.internal.appProtocol | bool | `true` | Declare the app protocol of the internal HTTP and HTTPS listeners or not. Supersedes provider-specific annotations for declaring the backend protocol. Ref: https://kubernetes.io/docs/concepts/services-networking/service/#application-protocol |
| ingressNginx.controller.service.internal.clusterIP | string | `""` | Pre-defined cluster internal IP address of the internal controller service. Take care of collisions with existing services. This value is immutable. Set once, it can not be changed without deleting and re-creating the service. Ref: https://kubernetes.io/docs/concepts/services-networking/service/#choosing-your-own-ip-address |
| ingressNginx.controller.service.internal.clusterIPs | list | `[]` | Pre-defined cluster internal IP addresses of the internal controller service. Take care of collisions with existing services. This value is immutable. Set once, it can not be changed without deleting and re-creating the service. Ref: https://kubernetes.io/docs/concepts/services-networking/service/#choosing-your-own-ip-address |
| ingressNginx.controller.service.internal.enabled | bool | `false` | Enable the internal controller service or not. Remember to configure `controller.service.internal.annotations` when enabling this. |
| ingressNginx.controller.service.internal.externalIPs | list | `[]` | List of node IP addresses at which the internal controller service is available. Ref: https://kubernetes.io/docs/concepts/services-networking/service/#external-ips |
| ingressNginx.controller.service.internal.externalTrafficPolicy | string | `""` | External traffic policy of the internal controller service. Set to "Local" to preserve source IP on providers supporting it. Ref: https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip |
| ingressNginx.controller.service.internal.ipFamilies | list | `["IPv4"]` | List of IP families (e.g. IPv4, IPv6) assigned to the internal controller service. This field is usually assigned automatically based on cluster configuration and the `ipFamilyPolicy` field. Ref: https://kubernetes.io/docs/concepts/services-networking/dual-stack/#services |
| ingressNginx.controller.service.internal.ipFamilyPolicy | string | `"SingleStack"` | Represents the dual-stack capabilities of the internal controller service. Possible values are SingleStack, PreferDualStack or RequireDualStack. Fields `ipFamilies` and `clusterIP` depend on the value of this field. Ref: https://kubernetes.io/docs/concepts/services-networking/dual-stack/#services |
| ingressNginx.controller.service.internal.labels | object | `{}` | Labels to be added to the internal controller service. |
| ingressNginx.controller.service.internal.loadBalancerClass | string | `""` | Load balancer class of the internal controller service. Used by cloud providers to select a load balancer implementation other than the cloud provider default. Ref: https://kubernetes.io/docs/concepts/services-networking/service/#load-balancer-class |
| ingressNginx.controller.service.internal.loadBalancerIP | string | `""` | Deprecated: Pre-defined IP address of the internal controller service. Used by cloud providers to connect the resulting load balancer service to a pre-existing static IP. Ref: https://kubernetes.io/docs/concepts/services-networking/service/#loadbalancer |
| ingressNginx.controller.service.internal.loadBalancerSourceRanges | list | `[]` | Restrict access to the internal controller service. Values must be CIDRs. Allows any source address by default. |
| ingressNginx.controller.service.internal.nodePorts.http | string | `""` | Node port allocated for the internal HTTP listener. If left empty, the service controller allocates one from the configured node port range. |
| ingressNginx.controller.service.internal.nodePorts.https | string | `""` | Node port allocated for the internal HTTPS listener. If left empty, the service controller allocates one from the configured node port range. |
| ingressNginx.controller.service.internal.nodePorts.tcp | object | `{}` | Node port mapping for internal TCP listeners. If left empty, the service controller allocates them from the configured node port range. Example: tcp:   8080: 30080 |
| ingressNginx.controller.service.internal.nodePorts.udp | object | `{}` | Node port mapping for internal UDP listeners. If left empty, the service controller allocates them from the configured node port range. Example: udp:   53: 30053 |
| ingressNginx.controller.service.internal.ports | object | `{}` |  |
| ingressNginx.controller.service.internal.sessionAffinity | string | `""` | Session affinity of the internal controller service. Must be either "None" or "ClientIP" if set. Defaults to "None". Ref: https://kubernetes.io/docs/reference/networking/virtual-ips/#session-affinity |
| ingressNginx.controller.service.internal.targetPorts | object | `{}` |  |
| ingressNginx.controller.service.internal.trafficDistribution | string | `""` | Traffic distribution policy of the internal controller service. Set to "PreferClose" to route traffic to endpoints that are topologically closer to the client. Ref: https://kubernetes.io/docs/concepts/services-networking/service/#traffic-distribution |
| ingressNginx.controller.service.internal.type | string | `""` | Type of the internal controller service. Defaults to the value of `controller.service.type`. Ref: https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types |
| ingressNginx.controller.service.ipFamilies | list | `["IPv4"]` | List of IP families (e.g. IPv4, IPv6) assigned to the external controller service. This field is usually assigned automatically based on cluster configuration and the `ipFamilyPolicy` field. Ref: https://kubernetes.io/docs/concepts/services-networking/dual-stack/#services |
| ingressNginx.controller.service.ipFamilyPolicy | string | `"SingleStack"` | Represents the dual-stack capabilities of the external controller service. Possible values are SingleStack, PreferDualStack or RequireDualStack. Fields `ipFamilies` and `clusterIP` depend on the value of this field. Ref: https://kubernetes.io/docs/concepts/services-networking/dual-stack/#services |
| ingressNginx.controller.service.labels | object | `{}` | Labels to be added to both controller services. |
| ingressNginx.controller.service.loadBalancerClass | string | `""` | Load balancer class of the external controller service. Used by cloud providers to select a load balancer implementation other than the cloud provider default. Ref: https://kubernetes.io/docs/concepts/services-networking/service/#load-balancer-class |
| ingressNginx.controller.service.loadBalancerIP | string | `""` | Deprecated: Pre-defined IP address of the external controller service. Used by cloud providers to connect the resulting load balancer service to a pre-existing static IP. Ref: https://kubernetes.io/docs/concepts/services-networking/service/#loadbalancer |
| ingressNginx.controller.service.loadBalancerSourceRanges | list | `[]` | Restrict access to the external controller service. Values must be CIDRs. Allows any source address by default. |
| ingressNginx.controller.service.nodePorts.http | string | `""` | Node port allocated for the external HTTP listener. If left empty, the service controller allocates one from the configured node port range. |
| ingressNginx.controller.service.nodePorts.https | string | `""` | Node port allocated for the external HTTPS listener. If left empty, the service controller allocates one from the configured node port range. |
| ingressNginx.controller.service.nodePorts.tcp | object | `{}` | Node port mapping for external TCP listeners. If left empty, the service controller allocates them from the configured node port range. Example: tcp:   8080: 30080 |
| ingressNginx.controller.service.nodePorts.udp | object | `{}` | Node port mapping for external UDP listeners. If left empty, the service controller allocates them from the configured node port range. Example: udp:   53: 30053 |
| ingressNginx.controller.service.ports.http | int | `80` | Port the external HTTP listener is published with. |
| ingressNginx.controller.service.ports.https | int | `443` | Port the external HTTPS listener is published with. |
| ingressNginx.controller.service.sessionAffinity | string | `""` | Session affinity of the external controller service. Must be either "None" or "ClientIP" if set. Defaults to "None". Ref: https://kubernetes.io/docs/reference/networking/virtual-ips/#session-affinity |
| ingressNginx.controller.service.targetPorts.http | string | `"http"` | Port of the ingress controller the external HTTP listener is mapped to. |
| ingressNginx.controller.service.targetPorts.https | string | `"https"` | Port of the ingress controller the external HTTPS listener is mapped to. |
| ingressNginx.controller.service.trafficDistribution | string | `""` | Traffic distribution policy of the external controller service. Set to "PreferClose" to route traffic to endpoints that are topologically closer to the client. Ref: https://kubernetes.io/docs/concepts/services-networking/service/#traffic-distribution |
| ingressNginx.controller.service.type | string | `"LoadBalancer"` | Type of the external controller service. Ref: https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types |
| ingressNginx.controller.shareProcessNamespace | bool | `false` |  |
| ingressNginx.controller.sysctls | object | `{}` | sysctls for controller pods # Ref: https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/ |
| ingressNginx.controller.tcp.annotations | object | `{}` | Annotations to be added to the tcp config configmap |
| ingressNginx.controller.tcp.configMapNamespace | string | `""` | Allows customization of the tcp-services-configmap; defaults to $(POD_NAMESPACE) |
| ingressNginx.controller.terminationGracePeriodSeconds | int | `300` | `terminationGracePeriodSeconds` to avoid killing pods before we are ready # wait up to five minutes for the drain of connections # |
| ingressNginx.controller.tolerations | list | `[]` | Node tolerations for server scheduling to nodes with taints # Ref: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/ # |
| ingressNginx.controller.topologySpreadConstraints | list | `[]` | Topology spread constraints rely on node labels to identify the topology domain(s) that each Node is in. # Ref: https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/ # |
| ingressNginx.controller.udp.annotations | object | `{}` | Annotations to be added to the udp config configmap |
| ingressNginx.controller.udp.configMapNamespace | string | `""` | Allows customization of the udp-services-configmap; defaults to $(POD_NAMESPACE) |
| ingressNginx.controller.unhealthyPodEvictionPolicy | string | `""` | Eviction policy for unhealthy pods guarded by PodDisruptionBudget. Ref: https://kubernetes.io/blog/2023/01/06/unhealthy-pod-eviction-policy-for-pdbs/ |
| ingressNginx.controller.updateStrategy | object | `{}` | The update strategy to apply to the Deployment or DaemonSet # |
| ingressNginx.controller.watchIngressWithoutClass | bool | `false` | Process Ingress objects without ingressClass annotation/ingressClassName field Overrides value for --watch-ingress-without-class flag of the controller binary Defaults to false |
| ingressNginx.defaultBackend.affinity | object | `{}` | Affinity and anti-affinity rules for server scheduling to nodes # Ref: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity |
| ingressNginx.defaultBackend.autoscaling.annotations | object | `{}` |  |
| ingressNginx.defaultBackend.autoscaling.enabled | bool | `false` |  |
| ingressNginx.defaultBackend.autoscaling.maxReplicas | int | `2` |  |
| ingressNginx.defaultBackend.autoscaling.minReplicas | int | `1` |  |
| ingressNginx.defaultBackend.autoscaling.targetCPUUtilizationPercentage | int | `50` |  |
| ingressNginx.defaultBackend.autoscaling.targetMemoryUtilizationPercentage | int | `50` |  |
| ingressNginx.defaultBackend.containerSecurityContext | object | `{}` | Security context for default backend containers |
| ingressNginx.defaultBackend.enabled | bool | `false` |  |
| ingressNginx.defaultBackend.extraArgs | object | `{}` |  |
| ingressNginx.defaultBackend.extraConfigMaps | list | `[]` |  |
| ingressNginx.defaultBackend.extraEnvs | list | `[]` | Additional environment variables to set for defaultBackend pods |
| ingressNginx.defaultBackend.extraVolumeMounts | list | `[]` |  |
| ingressNginx.defaultBackend.extraVolumes | list | `[]` |  |
| ingressNginx.defaultBackend.image.allowPrivilegeEscalation | bool | `false` |  |
| ingressNginx.defaultBackend.image.image | string | `"defaultbackend-amd64"` |  |
| ingressNginx.defaultBackend.image.pullPolicy | string | `"IfNotPresent"` |  |
| ingressNginx.defaultBackend.image.readOnlyRootFilesystem | bool | `true` |  |
| ingressNginx.defaultBackend.image.runAsGroup | int | `65534` |  |
| ingressNginx.defaultBackend.image.runAsNonRoot | bool | `true` |  |
| ingressNginx.defaultBackend.image.runAsUser | int | `65534` |  |
| ingressNginx.defaultBackend.image.seccompProfile.type | string | `"RuntimeDefault"` |  |
| ingressNginx.defaultBackend.image.tag | string | `"1.5"` |  |
| ingressNginx.defaultBackend.labels | object | `{}` | Labels to be added to the default backend resources |
| ingressNginx.defaultBackend.livenessProbe.failureThreshold | int | `3` |  |
| ingressNginx.defaultBackend.livenessProbe.initialDelaySeconds | int | `30` |  |
| ingressNginx.defaultBackend.livenessProbe.periodSeconds | int | `10` |  |
| ingressNginx.defaultBackend.livenessProbe.successThreshold | int | `1` |  |
| ingressNginx.defaultBackend.livenessProbe.timeoutSeconds | int | `5` |  |
| ingressNginx.defaultBackend.minAvailable | int | `1` | Minimum available pods set in PodDisruptionBudget. Define either 'minAvailable' or 'maxUnavailable', never both. |
| ingressNginx.defaultBackend.minReadySeconds | int | `0` | `minReadySeconds` to avoid killing pods before we are ready # |
| ingressNginx.defaultBackend.name | string | `"defaultbackend"` |  |
| ingressNginx.defaultBackend.networkPolicy.enabled | bool | `false` | Enable 'networkPolicy' or not |
| ingressNginx.defaultBackend.nodeSelector | object | `{"kubernetes.io/os":"linux"}` | Node labels for default backend pod assignment # Ref: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/ # |
| ingressNginx.defaultBackend.podAnnotations | object | `{}` | Annotations to be added to default backend pods # |
| ingressNginx.defaultBackend.podLabels | object | `{}` | Labels to add to the pod container metadata |
| ingressNginx.defaultBackend.podSecurityContext | object | `{}` | Security context for default backend pods |
| ingressNginx.defaultBackend.port | int | `8080` |  |
| ingressNginx.defaultBackend.priorityClassName | string | `""` |  |
| ingressNginx.defaultBackend.readinessProbe.failureThreshold | int | `6` |  |
| ingressNginx.defaultBackend.readinessProbe.initialDelaySeconds | int | `0` |  |
| ingressNginx.defaultBackend.readinessProbe.periodSeconds | int | `5` |  |
| ingressNginx.defaultBackend.readinessProbe.successThreshold | int | `1` |  |
| ingressNginx.defaultBackend.readinessProbe.timeoutSeconds | int | `5` |  |
| ingressNginx.defaultBackend.replicaCount | int | `1` |  |
| ingressNginx.defaultBackend.resources | object | `{}` |  |
| ingressNginx.defaultBackend.runtimeClassName | string | `""` | Instruct the kubelet to use the named RuntimeClass to run the pod |
| ingressNginx.defaultBackend.service.annotations | object | `{}` |  |
| ingressNginx.defaultBackend.service.clusterIPs | list | `[]` | Pre-defined cluster internal IP addresses of the default backend service. Take care of collisions with existing services. This value is immutable. Set once, it can not be changed without deleting and re-creating the service. Ref: https://kubernetes.io/docs/concepts/services-networking/service/#choosing-your-own-ip-address |
| ingressNginx.defaultBackend.service.externalIPs | list | `[]` | List of IP addresses at which the default backend service is available # Ref: https://kubernetes.io/docs/concepts/services-networking/service/#external-ips # |
| ingressNginx.defaultBackend.service.loadBalancerSourceRanges | list | `[]` |  |
| ingressNginx.defaultBackend.service.servicePort | int | `80` |  |
| ingressNginx.defaultBackend.service.type | string | `"ClusterIP"` |  |
| ingressNginx.defaultBackend.serviceAccount.automountServiceAccountToken | bool | `true` |  |
| ingressNginx.defaultBackend.serviceAccount.create | bool | `true` |  |
| ingressNginx.defaultBackend.serviceAccount.name | string | `""` |  |
| ingressNginx.defaultBackend.tolerations | list | `[]` | Node tolerations for server scheduling to nodes with taints # Ref: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/ # |
| ingressNginx.defaultBackend.topologySpreadConstraints | list | `[]` | Topology spread constraints rely on node labels to identify the topology domain(s) that each Node is in. Ref.: https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/ |
| ingressNginx.defaultBackend.unhealthyPodEvictionPolicy | string | `""` | Eviction policy for unhealthy pods guarded by PodDisruptionBudget. Ref: https://kubernetes.io/blog/2023/01/06/unhealthy-pod-eviction-policy-for-pdbs/ |
| ingressNginx.defaultBackend.updateStrategy | object | `{}` | The update strategy to apply to the Deployment or DaemonSet # |
| ingressNginx.dhParam | string | `""` | A base64-encoded Diffie-Hellman parameter. This can be generated with: `openssl dhparam 4096 2> /dev/null | base64` # Ref: https://github.com/kubernetes/ingress-nginx/tree/main/docs/examples/customization/ssl-dh-param |
| ingressNginx.global.image.registry | string | `"registry.k8s.io"` | Registry host to pull images from. |
| ingressNginx.imagePullSecrets | list | `[]` | Optional array of imagePullSecrets containing private registry credentials # Ref: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/ |
| ingressNginx.namespaceOverride | string | `""` | Override the deployment namespace; defaults to .Release.Namespace |
| ingressNginx.portNamePrefix | string | `""` | Prefix for TCP and UDP ports names in ingress controller service # Some cloud providers, like Yandex Cloud may have a requirements for a port name regex to support cloud load balancer integration |
| ingressNginx.rbac.create | bool | `true` |  |
| ingressNginx.rbac.scope | bool | `false` |  |
| ingressNginx.revisionHistoryLimit | int | `10` | Rollback limit # |
| ingressNginx.serviceAccount.annotations | object | `{}` | Annotations for the controller service account |
| ingressNginx.serviceAccount.automountServiceAccountToken | bool | `true` |  |
| ingressNginx.serviceAccount.create | bool | `true` |  |
| ingressNginx.serviceAccount.name | string | `""` |  |
| ingressNginx.tcp | object | `{}` | TCP service key-value pairs # Ref: https://github.com/kubernetes/ingress-nginx/blob/main/docs/user-guide/exposing-tcp-udp-services.md # |
| ingressNginx.udp | object | `{}` | UDP service key-value pairs # Ref: https://github.com/kubernetes/ingress-nginx/blob/main/docs/user-guide/exposing-tcp-udp-services.md # |
| prometheus.enabled | bool | `false` | Enables Prometheus Operator monitoring |
| prometheus.grafanaDashboard.enabled | bool | `false` | Enables Grafana dashboard config map |
| prometheus.grafanaDashboard.label | object | `{"grafana_dashboard":"1"}` | Label to apply to grafana dashboard config map. |
| prometheus.rules.labels | object | `{"prometheus":"ekp-operator-prometheus"}` | Labels to affect to the Prometheus Rules |

## Installing the Chart

### With Helm

To install the chart with the release name `my-release`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/ingress-nginx
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: ingress-nginx
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.4"
    chart: ingress-nginx
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
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/ingress-nginx --config /charts/charts/ingress-nginx/ct.yaml
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template ingress-nginx . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```

