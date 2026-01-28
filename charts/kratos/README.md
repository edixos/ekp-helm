# kratos

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![AppVersion: v25.4.0](https://img.shields.io/badge/AppVersion-v25.4.0-informational?style=flat-square) 





## Prerequisites

- Helm v3
- Config Connector installed (v1.6.0)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://k8s.ory.sh/helm/charts | kratos(kratos) | 0.60.1 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| hamzatalbi | <hamzatalbi831@gmail.com> | <https://github.com/TalbiHamza> |

## Description

A Helm chart for Kubernetes



## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| kratos.autoscaling.behavior | object | `{}` | Set custom behavior https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/#configurable-scaling-behavior |
| kratos.autoscaling.enabled | bool | `false` |  |
| kratos.autoscaling.extraMetrics | list | `[]` | Add extraContainer container resource metrics https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/#container-resource-metrics |
| kratos.autoscaling.maxReplicas | int | `3` |  |
| kratos.autoscaling.minReplicas | int | `1` |  |
| kratos.autoscaling.targetCPU | object | `{}` |  |
| kratos.autoscaling.targetMemory | object | `{}` |  |
| kratos.cleanup | object | `{"batchSize":100,"enabled":false,"keepLast":"6h","sleepTables":"1m0s"}` | SQL cleanup cron job configuration |
| kratos.cleanup.batchSize | int | `100` | Configure how many records are cleaned per run |
| kratos.cleanup.enabled | bool | `false` | Enable cleanup of stale database rows by periodically running the cleanup sql command |
| kratos.cleanup.keepLast | string | `"6h"` | Configure the youngest records to keep |
| kratos.cleanup.sleepTables | string | `"1m0s"` | Configure how long to wait between each table cleanup |
| kratos.configmap.annotations | object | `{}` | If you do want to specify annotations for configmap, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'annotations:'. |
| kratos.configmap.hashSumEnabled | bool | `true` | switch to false to prevent checksum annotations being maintained and propogated to the pods |
| kratos.courier | object | `{"enabled":true}` | Configuration of the courier |
| kratos.cronjob.cleanup.affinity | object | `{}` | Configure node affinity |
| kratos.cronjob.cleanup.annotations | object | `{}` | Set custom cron job level annotations |
| kratos.cronjob.cleanup.automountServiceAccountToken | bool | `true` | Set automounting of the SA token in job's pod |
| kratos.cronjob.cleanup.customArgs | list | `[]` | Configure the arguments of the entrypoint, overriding the default value |
| kratos.cronjob.cleanup.extraContainers | list | `[]` | If you want to add extra sidecar containers. |
| kratos.cronjob.cleanup.extraEnv | list | `[]` | Array of extra envs to be passed to the cronjob. This takes precedence over deployment variables. Kubernetes format is expected. Value is processed with Helm `tpl` - name: FOO   value: BAR |
| kratos.cronjob.cleanup.extraInitContainers | string | `""` | If you want to add extra init containers. |
| kratos.cronjob.cleanup.labels | object | `{}` | Set custom cron job level labels |
| kratos.cronjob.cleanup.nodeSelector | object | `{}` | Configure node labels for pod assignment |
| kratos.cronjob.cleanup.podMetadata | object | `{"annotations":{},"labels":{}}` | Specify pod metadata, this metadata is added directly to the pod, and not higher objects |
| kratos.cronjob.cleanup.podMetadata.annotations | object | `{}` | Extra pod level annotations |
| kratos.cronjob.cleanup.podMetadata.labels | object | `{}` | Extra pod level labels |
| kratos.cronjob.cleanup.resources | object | `{"limits":{},"requests":{}}` | We usually recommend not to specify default resources and to leave this as a conscious choice for the user.  This also increases chances charts run on environments with little  resources, such as Minikube. If you do want to specify resources, uncomment the following  lines, adjust them as necessary, and remove the curly braces after 'resources:'.  limits:    cpu: 100m    memory: 128Mi  requests:    cpu: 100m  memory: 128Mi |
| kratos.cronjob.cleanup.schedule | string | `"0 */1 * * *"` | Configure how often the cron job is ran |
| kratos.cronjob.cleanup.serviceAccount | object | `{"annotations":{"helm.sh/hook":"pre-install, pre-upgrade","helm.sh/hook-delete-policy":"before-hook-creation","helm.sh/hook-weight":"0"},"automountServiceAccountToken":true,"create":true,"name":""}` | Specify the serviceAccountName value. Sometime you need to provide specific permissions for the cleanup cronjob. For example installing Kratos on a cluster with a PosSecurityPolicy and Istio. Uncomment if you need to provide a ServiceAccount for the cleanup cronjob. |
| kratos.cronjob.cleanup.serviceAccount.annotations | object | `{"helm.sh/hook":"pre-install, pre-upgrade","helm.sh/hook-delete-policy":"before-hook-creation","helm.sh/hook-weight":"0"}` | Annotations to add to the service account |
| kratos.cronjob.cleanup.serviceAccount.automountServiceAccountToken | bool | `true` | Set automounting of the SA token |
| kratos.cronjob.cleanup.serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| kratos.cronjob.cleanup.serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| kratos.cronjob.cleanup.shareProcessNamespace | bool | `false` | Set sharing process namespace |
| kratos.cronjob.cleanup.tolerations | list | `[]` | Configure node tolerations |
| kratos.deployment.affinity | object | `{}` | Configure node affinity |
| kratos.deployment.annotations | object | `{}` |  |
| kratos.deployment.automigration | object | `{"extraEnv":[]}` | Parameters for the automigration initContainer |
| kratos.deployment.automigration.extraEnv | list | `[]` | Array of extra envs to be passed to the initContainer. Kubernetes format is expected. Value is processed with Helm `tpl` - name: FOO   value: BAR |
| kratos.deployment.automountServiceAccountToken | bool | `false` |  |
| kratos.deployment.customLivenessProbe | object | `{}` | Configure a custom livenessProbe. This overwrites the default object |
| kratos.deployment.customReadinessProbe | object | `{}` | Configure a custom readinessProbe. This overwrites the default object |
| kratos.deployment.customStartupProbe | object | `{}` | Configure a custom startupProbe. This overwrites the default object |
| kratos.deployment.dnsConfig | object | `{}` | Configure pod dnsConfig. |
| kratos.deployment.extraArgs | list | `[]` | Array of extra arguments to be passed down to the deployment. Kubernetes args format is expected - --foo - --sqa-opt-out |
| kratos.deployment.extraContainers | string | `""` | If you want to add extra sidecar containers. |
| kratos.deployment.extraEnv | list | `[]` | Array of extra envs to be passed to the deployment. Kubernetes format is expected. Value is processed with Helm `tpl` - name: FOO   value: BAR |
| kratos.deployment.extraInitContainers | string | `""` | If you want to add extra init containers. These are processed before the migration init container. |
| kratos.deployment.extraVolumeMounts | list | `[]` |  |
| kratos.deployment.extraVolumes | list | `[]` | If you want to mount external volume For example, mount a secret containing Certificate root CA to verify database TLS connection. |
| kratos.deployment.labels | object | `{}` |  |
| kratos.deployment.lifecycle | object | `{}` |  |
| kratos.deployment.nodeSelector | object | `{}` | Node labels for pod assignment. |
| kratos.deployment.podMetadata | object | `{"annotations":{},"labels":{}}` | Specify pod metadata, this metadata is added directly to the pod, and not higher objects |
| kratos.deployment.podMetadata.annotations | object | `{}` | Extra pod level annotations |
| kratos.deployment.podMetadata.labels | object | `{}` | Extra pod level labels |
| kratos.deployment.podSecurityContext.fsGroup | int | `65534` |  |
| kratos.deployment.podSecurityContext.fsGroupChangePolicy | string | `"OnRootMismatch"` |  |
| kratos.deployment.podSecurityContext.runAsGroup | int | `65534` |  |
| kratos.deployment.podSecurityContext.runAsNonRoot | bool | `true` |  |
| kratos.deployment.podSecurityContext.runAsUser | int | `65534` |  |
| kratos.deployment.podSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| kratos.deployment.priorityClassName | string | `""` | Pod priority https://kubernetes.io/docs/concepts/configuration/pod-priority-preemption/ |
| kratos.deployment.readinessProbe | object | `{"failureThreshold":5,"initialDelaySeconds":5,"periodSeconds":10}` | Configure the readinessProbe parameters |
| kratos.deployment.resources | object | `{}` | Set desired resource parameters  We usually recommend not to specify default resources and to leave this as a conscious  choice for the user. This also increases chances charts run on environments with little  resources, such as Minikube. If you do want to specify resources, uncomment the following  lines, adjust them as necessary, and remove the curly braces after 'resources:'. |
| kratos.deployment.revisionHistoryLimit | int | `5` | Number of revisions kept in history |
| kratos.deployment.serviceAccount | object | `{"annotations":{},"create":true,"name":""}` | Specify the serviceAccountName value. In some situations it is needed to provide specific permissions to Kratos deployments. Like for example installing Kratos on a cluster with a PosSecurityPolicy and Istio. Uncomment if it is needed to provide a ServiceAccount for the Kratos deployment. |
| kratos.deployment.serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| kratos.deployment.serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| kratos.deployment.serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| kratos.deployment.startupProbe | object | `{"failureThreshold":5,"initialDelaySeconds":1,"periodSeconds":1,"successThreshold":1,"timeoutSeconds":2}` | Configure the startupProbe parameters |
| kratos.deployment.terminationGracePeriodSeconds | int | `60` |  |
| kratos.deployment.tolerations | list | `[]` | Configure node tolerations. |
| kratos.deployment.topologySpreadConstraints | list | `[]` | Configure pod topologySpreadConstraints. |
| kratos.fullnameOverride | string | `""` |  |
| kratos.global | object | `{"podMetadata":{"annotations":{},"labels":{}}}` | Global setting, passed down to all pods |
| kratos.global.podMetadata | object | `{"annotations":{},"labels":{}}` | Specify pod metadata, this metadata is added directly to the pod, and not higher objects |
| kratos.global.podMetadata.annotations | object | `{}` | Extra pod level annotations |
| kratos.global.podMetadata.labels | object | `{}` | Extra pod level labels |
| kratos.image.pullPolicy | string | `"IfNotPresent"` |  |
| kratos.image.repository | string | `"oryd/kratos"` | ORY KRATOS image |
| kratos.image.tag | string | `"v25.4.0"` | ORY KRATOS VERSION Alternative format: image: oryd/kratos:v0.6.3-alpha.1 |
| kratos.imagePullSecrets | list | `[]` |  |
| kratos.ingress.admin.annotations | object | `{}` |  |
| kratos.ingress.admin.className | string | `""` |  |
| kratos.ingress.admin.enabled | bool | `false` |  |
| kratos.ingress.admin.hosts[0].host | string | `"kratos.admin.local.com"` |  |
| kratos.ingress.admin.hosts[0].paths[0].path | string | `"/"` |  |
| kratos.ingress.admin.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| kratos.ingress.admin.tls | list | `[]` |  |
| kratos.ingress.public.annotations | object | `{}` |  |
| kratos.ingress.public.className | string | `""` |  |
| kratos.ingress.public.enabled | bool | `false` |  |
| kratos.ingress.public.hosts[0].host | string | `"kratos.public.local.com"` |  |
| kratos.ingress.public.hosts[0].paths[0].path | string | `"/"` |  |
| kratos.ingress.public.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| kratos.ingress.public.tls | list | `[]` |  |
| kratos.job.annotations | object | `{"helm.sh/hook":"pre-install, pre-upgrade","helm.sh/hook-delete-policy":"before-hook-creation,hook-succeeded","helm.sh/hook-weight":"1"}` | If you do want to specify annotations, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'annotations:'. |
| kratos.job.automountServiceAccountToken | bool | `false` | Set automounting of the SA token |
| kratos.job.extraContainers | string | `""` | If you want to add extra sidecar containers. |
| kratos.job.extraEnv | list | `[]` | Array of extra envs to be passed to the job. This takes precedence over deployment variables. Kubernetes format is expected. Value is processed with Helm `tpl` - name: FOO   value: BAR |
| kratos.job.extraInitContainers | string | `""` | If you want to add extra init containers. |
| kratos.job.lifecycle | string | `""` | If you want to add lifecycle hooks. |
| kratos.job.nodeSelector | object | `{}` | Node labels for pod assignment. |
| kratos.job.podMetadata | object | `{"annotations":{},"labels":{}}` | Specify pod metadata, this metadata is added directly to the pod, and not higher objects |
| kratos.job.podMetadata.annotations | object | `{}` | Extra pod level annotations |
| kratos.job.podMetadata.labels | object | `{}` | Extra pod level labels |
| kratos.job.resources | object | `{}` | resource requests and limits for the job |
| kratos.job.serviceAccount | object | `{"annotations":{"helm.sh/hook":"pre-install, pre-upgrade","helm.sh/hook-delete-policy":"before-hook-creation","helm.sh/hook-weight":"0"},"create":true,"name":""}` | Specify the serviceAccountName value. In some situations it is needed to provide specific permissions to Kratos deployments Like for example installing Kratos on a cluster with a PosSecurityPolicy and Istio. Uncomment if it is needed to provide a ServiceAccount for the Kratos deployment. |
| kratos.job.serviceAccount.annotations | object | `{"helm.sh/hook":"pre-install, pre-upgrade","helm.sh/hook-delete-policy":"before-hook-creation","helm.sh/hook-weight":"0"}` | Annotations to add to the service account |
| kratos.job.serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| kratos.job.serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| kratos.job.shareProcessNamespace | bool | `false` | Set sharing process namespace |
| kratos.job.spec.backoffLimit | int | `10` | Set job back off limit |
| kratos.job.tolerations | list | `[]` | Configure node tolerations. |
| kratos.kratos.automigration | object | `{"customArgs":[],"customCommand":[],"enabled":false,"resources":{},"type":"job"}` | Enables database migration |
| kratos.kratos.automigration.customArgs | list | `[]` | Ability to override arguments of the entrypoint. Can be used in-depended of customCommand eg: - sleep 5;   - kratos |
| kratos.kratos.automigration.customCommand | list | `[]` | Ability to override the entrypoint of the automigration container (e.g. to source dynamic secrets or export environment dynamic variables) |
| kratos.kratos.automigration.resources | object | `{}` | resource requests and limits for the automigration initcontainer |
| kratos.kratos.automigration.type | string | `"job"` | Configure the way to execute database migration. Possible values: job, initContainer When set to job, the migration will be executed as a job on release or upgrade. When set to initContainer, the migration will be executed when Kratos pod is created Defaults to job |
| kratos.kratos.config.courier.smtp | object | `{}` |  |
| kratos.kratos.config.secrets | object | `{}` |  |
| kratos.kratos.config.serve.admin.port | int | `4434` |  |
| kratos.kratos.config.serve.public.port | int | `4433` |  |
| kratos.kratos.customMigrations.jobs.example-job.customArgs[0] | string | `"migrate"` |  |
| kratos.kratos.customMigrations.jobs.example-job.customArgs[1] | string | `"sql"` |  |
| kratos.kratos.customMigrations.jobs.example-job.customArgs[2] | string | `"-e"` |  |
| kratos.kratos.customMigrations.jobs.example-job.customArgs[3] | string | `"--yes"` |  |
| kratos.kratos.customMigrations.jobs.example-job.customArgs[4] | string | `"--config"` |  |
| kratos.kratos.customMigrations.jobs.example-job.customArgs[5] | string | `"/etc/config/kratos.yaml"` |  |
| kratos.kratos.customMigrations.jobs.example-job.enabled | bool | `false` |  |
| kratos.kratos.customMigrations.jobs.example-job.extraEnv | list | `[]` |  |
| kratos.kratos.customMigrations.jobs.example-job.nodeSelector | object | `{}` |  |
| kratos.kratos.customMigrations.jobs.example-job.resources | object | `{}` |  |
| kratos.kratos.development | bool | `false` |  |
| kratos.kratos.emailTemplates | object | `{}` | You can customize the emails Kratos is sending (also uncomment config.courier.template_override_path below) |
| kratos.kratos.identitySchemas | object | `{}` | You can add multiple identity schemas here. You can pass JSON schema using `--set-file` Helm CLI argument. |
| kratos.nameOverride | string | `""` |  |
| kratos.pdb.enabled | bool | `false` |  |
| kratos.pdb.spec.maxUnavailable | string | `""` |  |
| kratos.pdb.spec.minAvailable | string | `""` |  |
| kratos.replicaCount | int | `1` | Number of replicas in deployment |
| kratos.secret.enableDefaultAnnotations | bool | `true` | enableDefaultAnnotations set to `true` will add default annotations to the secret. As such the Secret will be managed by helm hooks. |
| kratos.secret.enabled | bool | `true` | switch to false to prevent creating the secret |
| kratos.secret.extraAnnotations | object | `{}` | extraAnnotations to be added to secret. |
| kratos.secret.hashSumEnabled | bool | `true` | switch to false to prevent checksum annotations being maintained and propogated to the pods |
| kratos.secret.nameOverride | string | `""` | Provide custom name of existing secret, or custom name of secret to be created |
| kratos.secret.secretAnnotations | object | `{"helm.sh/hook":"pre-install, pre-upgrade","helm.sh/hook-delete-policy":"before-hook-creation","helm.sh/hook-weight":"0","helm.sh/resource-policy":"keep"}` | Annotations to be added to secret. Annotations are added only when secret is being created. Existing secret will not be modified. |
| kratos.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| kratos.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| kratos.securityContext.privileged | bool | `false` |  |
| kratos.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| kratos.securityContext.runAsGroup | int | `65534` |  |
| kratos.securityContext.runAsNonRoot | bool | `true` |  |
| kratos.securityContext.runAsUser | int | `65534` |  |
| kratos.securityContext.seLinuxOptions.level | string | `"s0:c123,c456"` |  |
| kratos.securityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| kratos.service.admin.annotations | object | `{}` | If you do want to specify annotations, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'annotations:'. |
| kratos.service.admin.enabled | bool | `true` |  |
| kratos.service.admin.externalTrafficPolicy | string | `""` | https://kubernetes.io/docs/reference/networking/virtual-ips/#traffic-policies |
| kratos.service.admin.internalTrafficPolicy | string | `""` | https://kubernetes.io/docs/reference/networking/virtual-ips/#traffic-policies |
| kratos.service.admin.labels | object | `{}` | Provide custom labels. Use the same syntax as for annotations. |
| kratos.service.admin.loadBalancerIP | string | `""` | Load balancer IP |
| kratos.service.admin.metricsPath | string | `"/admin/metrics/prometheus"` | Path to the metrics endpoint |
| kratos.service.admin.name | string | `"http"` | The service port name. Useful to set a custom service port name if it must follow a scheme (e.g. Istio) |
| kratos.service.admin.nodePort | string | `""` |  |
| kratos.service.admin.port | int | `80` |  |
| kratos.service.admin.type | string | `"ClusterIP"` |  |
| kratos.service.courier.annotations | object | `{}` | Provide custom annotations. |
| kratos.service.courier.containerPort | int | `4434` | Container Port |
| kratos.service.courier.enabled | bool | `true` |  |
| kratos.service.courier.labels | object | `{}` | Provide custom labels. Use the same syntax as for annotations. |
| kratos.service.courier.metricsPath | string | `"/metrics/prometheus"` | Path to the metrics endpoint |
| kratos.service.courier.name | string | `"http-metrics"` | The service port name. Useful to set a custom service port name if it must follow a scheme (e.g. Istio) |
| kratos.service.courier.port | int | `80` | Service Port |
| kratos.service.courier.type | string | `"ClusterIP"` |  |
| kratos.service.public.annotations | object | `{}` | If you do want to specify annotations, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'annotations:'. |
| kratos.service.public.enabled | bool | `true` |  |
| kratos.service.public.externalTrafficPolicy | string | `""` | https://kubernetes.io/docs/reference/networking/virtual-ips/#traffic-policies |
| kratos.service.public.internalTrafficPolicy | string | `""` | https://kubernetes.io/docs/reference/networking/virtual-ips/#traffic-policies |
| kratos.service.public.labels | object | `{}` | Provide custom labels. Use the same syntax as for annotations. |
| kratos.service.public.loadBalancerIP | string | `""` | Load balancer IP |
| kratos.service.public.name | string | `"http"` | The service port name. Useful to set a custom service port name if it must follow a scheme (e.g. Istio) |
| kratos.service.public.nodePort | string | `""` |  |
| kratos.service.public.port | int | `80` |  |
| kratos.service.public.type | string | `"ClusterIP"` |  |
| kratos.serviceMonitor.enabled | bool | `false` | switch to true to enable creating the ServiceMonitor |
| kratos.serviceMonitor.labels | object | `{}` | Provide additional labels to the ServiceMonitor ressource metadata |
| kratos.serviceMonitor.metricRelabelings | list | `[]` | Metric relabeling is applied to samples as the last step before ingestion. Reference: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs |
| kratos.serviceMonitor.relabelings | list | `[]` | Relabeling is a powerful tool to dynamically rewrite the label set of a target before it gets scraped. Reference: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config |
| kratos.serviceMonitor.scheme | string | `"http"` | HTTP scheme to use for scraping. |
| kratos.serviceMonitor.scrapeInterval | string | `"60s"` | Interval at which metrics should be scraped |
| kratos.serviceMonitor.scrapeTimeout | string | `"30s"` | Timeout after which the scrape is ended |
| kratos.serviceMonitor.tlsConfig | object | `{}` | TLS configuration to use when scraping the endpoint |
| kratos.statefulSet.affinity | object | `{}` | Configure node affinity |
| kratos.statefulSet.annotations | object | `{}` |  |
| kratos.statefulSet.dnsConfig | object | `{}` | Configure pod dnsConfig. |
| kratos.statefulSet.extraArgs | list | `[]` | Array of extra arguments to be passed down to the StatefulSet. Kubernetes args format is expected |
| kratos.statefulSet.extraContainers | string | `""` | If you want to add extra sidecar containers. |
| kratos.statefulSet.extraEnv | list | `[]` | Array of extra envs to be passed to the StatefulSet. This takes precedence over deployment variables. Kubernetes format is expected. Value is processed with Helm `tpl` - name: FOO   value: BAR |
| kratos.statefulSet.extraInitContainers | string | `""` | If you want to add extra init containers. These are processed before the migration init container. |
| kratos.statefulSet.extraVolumeMounts | list | `[]` |  |
| kratos.statefulSet.extraVolumes | list | `[]` | If you want to mount external volume For example, mount a secret containing Certificate root CA to verify database TLS connection. |
| kratos.statefulSet.labels | object | `{}` | The secret specified here will be used to load environment variables with envFrom. This allows arbitrary environment variables to be provided to the application which is useful for sensitive values which should not be in a configMap. This secret is not created by the helm chart and must already exist in the namespace. https://kubernetes.io/docs/tasks/inject-data-application/distribute-credentials-secure/#configure-all-key-value-pairs-in-a-secret-as-container-environment-variables environmentSecretsName: |
| kratos.statefulSet.log.format | string | `"json"` |  |
| kratos.statefulSet.log.level | string | `"trace"` |  |
| kratos.statefulSet.nodeSelector | object | `{}` | Node labels for pod assignment. |
| kratos.statefulSet.podMetadata.annotations | object | `{}` | Extra pod level annotations |
| kratos.statefulSet.podMetadata.labels | object | `{}` | Extra pod level labels |
| kratos.statefulSet.podSecurityContext.fsGroup | int | `65534` |  |
| kratos.statefulSet.podSecurityContext.fsGroupChangePolicy | string | `"OnRootMismatch"` |  |
| kratos.statefulSet.podSecurityContext.runAsGroup | int | `65534` |  |
| kratos.statefulSet.podSecurityContext.runAsNonRoot | bool | `true` |  |
| kratos.statefulSet.podSecurityContext.runAsUser | int | `65534` |  |
| kratos.statefulSet.podSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| kratos.statefulSet.priorityClassName | string | `""` | Pod priority https://kubernetes.io/docs/concepts/configuration/pod-priority-preemption/ |
| kratos.statefulSet.resources | object | `{}` |  |
| kratos.statefulSet.revisionHistoryLimit | int | `5` | Number of revisions kept in history |
| kratos.statefulSet.terminationGracePeriodSeconds | int | `60` |  |
| kratos.statefulSet.tolerations | list | `[]` | Configure node tolerations. |
| kratos.statefulSet.topologySpreadConstraints | list | `[]` | Configure pod topologySpreadConstraints. |
| kratos.strategy.rollingUpdate.maxSurge | string | `"25%"` |  |
| kratos.strategy.rollingUpdate.maxUnavailable | string | `"25%"` |  |
| kratos.strategy.type | string | `"RollingUpdate"` |  |
| kratos.test.busybox | object | `{"repository":"busybox","tag":1}` | use a busybox image from another repository |
| kratos.watcher.automountServiceAccountToken | bool | `true` |  |
| kratos.watcher.enabled | bool | `false` |  |
| kratos.watcher.image | string | `"oryd/k8s-toolbox:v0.0.7"` |  |
| kratos.watcher.mountFile | string | `""` | Path to mounted file, which wil be monitored for changes. eg: /etc/secrets/my-secret/foo |
| kratos.watcher.podMetadata | object | `{"annotations":{},"labels":{}}` | Specify pod metadata, this metadata is added directly to the pod, and not higher objects |
| kratos.watcher.podMetadata.annotations | object | `{}` | Extra pod level annotations |
| kratos.watcher.podMetadata.labels | object | `{}` | Extra pod level labels |
| kratos.watcher.resources | object | `{}` |  |
| kratos.watcher.revisionHistoryLimit | int | `5` | Number of revisions kept in history |
| kratos.watcher.watchLabelKey | string | `"ory.sh/watcher"` | Label key used for managing applications |
| prometheus.enabled | bool | `false` | Enables Prometheus Operator monitoring |
| prometheus.grafanaDashboard.enabled | bool | `false` | Add grafana dashboard as a configmap |
| prometheus.grafanaDashboard.label | object | `{"grafana_dashboard":"1"}` | label to apply to the config map. Used by Grafana sidecar to automatically install the dashboard |
| prometheus.rules.enabled | bool | `false` | Enables prometheus operator rules |
| prometheus.rules.labels | object | `{"prometheus":"prometheus-operator-prometheus"}` | Labels to affect to the Prometheus Rules |

## Installing the Chart

### With Helm

To install the chart with the release name `my-release`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/kratos
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: kratos
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.0"
    chart: kratos
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
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/kratos --config /charts/charts/kratos/ct.yaml
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template kratos . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```

