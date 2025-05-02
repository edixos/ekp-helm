# argocd

![Version: 0.1.1](https://img.shields.io/badge/Version-0.1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.14.4](https://img.shields.io/badge/AppVersion-2.14.4-informational?style=flat-square)

## Prerequisites

- Helm v3
- Config Connector installed (v1.6.0)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://argoproj.github.io/argo-helm | argocd(argo-cd) | 7.8.8 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| ilyasabdellaoui | <ilyas.abdellaoui21@gmail.com> | <https://github.com/ilyasabdellaoui> |

## Description

A Helm chart for Kubernetes

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| prometheus.enabled | bool | `false` | Enables Prometheus Operator monitoring |
| prometheus.rules.enabled | bool | `true` | Enables prometheus operator rules |
| prometheus.rules.labels | object | `{"prometheus":"prometheus-operator-prometheus"}` | Labels to affect to the Prometheus Rules |
| prometheus.grafanaDashboard.enabled | bool | `true` | Add grafana dashboard as a configmap |
| prometheus.grafanaDashboard.label | object | `{"grafana_dashboard":"1"}` | label to apply to the config map. Used by Grafana sidecar to automatically install the dashboard |
| argocd.nameOverride | string | `"argocd"` | Provide a name in place of `argocd` |
| argocd.fullnameOverride | string | `""` | String to fully override `"argo-cd.fullname"` |
| argocd.namespaceOverride | string | `.Release.Namespace` | Override the namespace |
| argocd.kubeVersionOverride | string | `""` | Override the Kubernetes version, which is used to evaluate certain manifests |
| argocd.apiVersionOverrides | object | `{}` |  |
| argocd.createAggregateRoles | bool | `false` | Create aggregated roles that extend existing cluster roles to interact with argo-cd resources # Ref: https://kubernetes.io/docs/reference/access-authn-authz/rbac/#aggregated-clusterroles |
| argocd.createClusterRoles | bool | `true` | Create cluster roles for cluster-wide installation. # Used when you manage applications in the same cluster where Argo CD runs |
| argocd.openshift.enabled | bool | `false` | enables using arbitrary uid for argo repo server |
| argocd.crds.install | bool | `true` | Install and upgrade CRDs |
| argocd.crds.keep | bool | `true` | Keep CRDs on chart uninstall |
| argocd.crds.annotations | object | `{}` | Annotations to be added to all CRDs |
| argocd.crds.additionalLabels | object | `{}` | Addtional labels to be added to all CRDs |
| argocd.global.domain | string | `"argocd.example.com"` | Default domain used by all components # Used for ingresses, certificates, SSO, notifications, etc. |
| argocd.global.runtimeClassName | string | `""` | Runtime class name for all components |
| argocd.global.additionalLabels | object | `{}` | Common labels for the all resources |
| argocd.global.revisionHistoryLimit | int | `3` | Number of old deployment ReplicaSets to retain. The rest will be garbage collected. |
| argocd.global.image.repository | string | `"quay.io/argoproj/argocd"` | If defined, a repository applied to all Argo CD deployments |
| argocd.global.image.tag | string | `""` | Overrides the global Argo CD image tag whose default is the chart appVersion |
| argocd.global.image.imagePullPolicy | string | `"IfNotPresent"` | If defined, a imagePullPolicy applied to all Argo CD deployments |
| argocd.global.imagePullSecrets | list | `[]` | Secrets with credentials to pull images from a private registry |
| argocd.global.logging.format | string | `"text"` | Set the global logging format. Either: `text` or `json` |
| argocd.global.logging.level | string | `"info"` | Set the global logging level. One of: `debug`, `info`, `warn` or `error` |
| argocd.global.statefulsetAnnotations | object | `{}` | Annotations for the all deployed Statefulsets |
| argocd.global.deploymentAnnotations | object | `{}` | Annotations for the all deployed Deployments |
| argocd.global.podAnnotations | object | `{}` | Annotations for the all deployed pods |
| argocd.global.podLabels | object | `{}` | Labels for the all deployed pods |
| argocd.global.addPrometheusAnnotations | bool | `false` | Add Prometheus scrape annotations to all metrics services. This can be used as an alternative to the ServiceMonitors. |
| argocd.global.securityContext | object | `{}` (See [values.yaml]) | Toggle and define pod-level security context. |
| argocd.global.hostAliases | list | `[]` | Mapping between IP and hostnames that will be injected as entries in the pod's hosts files |
| argocd.global.dualStack.ipFamilyPolicy | string | `""` | IP family policy to configure dual-stack see [Configure dual-stack](https://kubernetes.io/docs/concepts/services-networking/dual-stack/#services) |
| argocd.global.dualStack.ipFamilies | list | `[]` | IP families that should be supported and the order in which they should be applied to ClusterIP as well. Can be IPv4 and/or IPv6. |
| argocd.global.networkPolicy.create | bool | `false` | Create NetworkPolicy objects for all components |
| argocd.global.networkPolicy.defaultDenyIngress | bool | `false` | Default deny all ingress traffic |
| argocd.global.priorityClassName | string | `""` | Default priority class for all components |
| argocd.global.nodeSelector | object | `{"kubernetes.io/os":"linux"}` | Default node selector for all components |
| argocd.global.tolerations | list | `[]` | Default tolerations for all components |
| argocd.global.affinity.podAntiAffinity | string | `"soft"` | Default pod anti-affinity rules. Either: `none`, `soft` or `hard` |
| argocd.global.affinity.nodeAffinity.type | string | `"hard"` | Default node affinity rules. Either: `none`, `soft` or `hard` |
| argocd.global.affinity.nodeAffinity.matchExpressions | list | `[]` | Default match expressions for node affinity |
| argocd.global.topologySpreadConstraints | list | `[]` | Default [TopologySpreadConstraints] rules for all components # Ref: https://kubernetes.io/docs/concepts/scheduling-eviction/topology-spread-constraints/ # If labelSelector is left out, it will default to the labelSelector of the component |
| argocd.global.deploymentStrategy | object | `{}` | Deployment strategy for the all deployed Deployments |
| argocd.global.env | list | `[]` | Environment variables to pass to all deployed Deployments |
| argocd.global.certificateAnnotations | object | `{}` | Annotations for the all deployed Certificates |
| argocd.configs.cm.create | bool | `true` | Create the argocd-cm configmap for [declarative setup] |
| argocd.configs.cm.annotations | object | `{}` | Annotations to be added to argocd-cm configmap |
| argocd.configs.cm."application.instanceLabelKey" | string | `"argocd.argoproj.io/instance"` | The name of tracking label used by Argo CD for resource pruning |
| argocd.configs.cm."application.sync.impersonation.enabled" | bool | `false` | Enable control of the service account used for the sync operation (alpha) # Ref: https://argo-cd.readthedocs.io/en/stable/operator-manual/app-sync-using-impersonation/ |
| argocd.configs.cm."server.rbac.log.enforce.enable" | bool | `false` | Enable logs RBAC enforcement # Ref: https://argo-cd.readthedocs.io/en/latest/operator-manual/upgrading/2.3-2.4/#enable-logs-rbac-enforcement |
| argocd.configs.cm."exec.enabled" | bool | `false` | Enable exec feature in Argo UI # Ref: https://argo-cd.readthedocs.io/en/latest/operator-manual/rbac/#exec-resource |
| argocd.configs.cm."admin.enabled" | bool | `true` | Enable local admin user # Ref: https://argo-cd.readthedocs.io/en/latest/faq/#how-to-disable-admin-user |
| argocd.configs.cm."timeout.reconciliation" | string | `"180s"` | Timeout to discover if a new manifests version got published to the repository |
| argocd.configs.cm."timeout.hard.reconciliation" | string | `"0s"` | Timeout to refresh application data as well as target manifests cache |
| argocd.configs.cm."statusbadge.enabled" | bool | `false` | Enable Status Badge # Ref: https://argo-cd.readthedocs.io/en/stable/user-guide/status-badge/ |
| argocd.configs.params.create | bool | `true` | Create the argocd-cmd-params-cm configmap If false, it is expected the configmap will be created by something else. |
| argocd.configs.params.annotations | object | `{}` | Annotations to be added to the argocd-cmd-params-cm ConfigMap |
| argocd.configs.params."otlp.address" | string | `""` | Open-Telemetry collector address: (e.g. "otel-collector:4317") |
| argocd.configs.params."controller.status.processors" | int | `20` | Number of application status processors |
| argocd.configs.params."controller.operation.processors" | int | `10` | Number of application operation processors |
| argocd.configs.params."controller.self.heal.timeout.seconds" | int | `5` | Specifies timeout between application self heal attempts |
| argocd.configs.params."controller.repo.server.timeout.seconds" | int | `60` | Repo server RPC call timeout seconds. |
| argocd.configs.params."controller.sync.timeout.seconds" | int | `0` | Specifies the timeout after which a sync would be terminated. 0 means no timeout |
| argocd.configs.params."server.insecure" | bool | `false` | Run server without TLS # NOTE: This value should be set when you generate params by other means as it changes ports used by ingress template. |
| argocd.configs.params."server.basehref" | string | `"/"` | Value for base href in index.html. Used if Argo CD is running behind reverse proxy under subpath different from / |
| argocd.configs.params."server.rootpath" | string | `""` | Used if Argo CD is running behind reverse proxy under subpath different from / |
| argocd.configs.params."server.staticassets" | string | `"/shared/app"` | Directory path that contains additional static assets |
| argocd.configs.params."server.disable.auth" | bool | `false` | Disable Argo CD RBAC for user authentication |
| argocd.configs.params."server.enable.gzip" | bool | `true` | Enable GZIP compression |
| argocd.configs.params."server.enable.proxy.extension" | bool | `false` | Enable proxy extension feature. (proxy extension is in Alpha phase) |
| argocd.configs.params."server.x.frame.options" | string | `"sameorigin"` | Set X-Frame-Options header in HTTP responses to value. To disable, set to "". |
| argocd.configs.params."reposerver.parallelism.limit" | int | `0` | Limit on number of concurrent manifests generate requests. Any value less the 1 means no limit. |
| argocd.configs.params."applicationsetcontroller.policy" | string | `"sync"` | Modify how application is synced between the generator and the cluster. One of: `sync`, `create-only`, `create-update`, `create-delete` |
| argocd.configs.params."applicationsetcontroller.enable.progressive.syncs" | bool | `false` | Enables use of the Progressive Syncs capability |
| argocd.configs.params."applicationsetcontroller.namespaces" | string | `""` (default is only the ns where the controller is installed) | A list of glob patterns specifying where to look for ApplicationSet resources. (e.g. `"argocd,argocd-appsets-*"`) # For more information: https://argo-cd.readthedocs.io/en/stable/operator-manual/applicationset/Appset-Any-Namespace/ |
| argocd.configs.params."application.namespaces" | string | `""` | Enables [Applications in any namespace] # List of additional namespaces where applications may be created in and reconciled from. # The namespace where Argo CD is installed to will always be allowed. # Set comma-separated list. (e.g. app-team-one, app-team-two) |
| argocd.configs.params."controller.ignore.normalizer.jq.timeout" | string | `"1s"` | JQ Path expression timeout # By default, the evaluation of a JQPathExpression is limited to one second. # If you encounter a "JQ patch execution timed out" error message due to a complex JQPathExpression # that requires more time to evaluate, you can extend the timeout period. |
| argocd.configs.rbac.create | bool | `true` | Create the argocd-rbac-cm configmap with ([Argo CD RBAC policy]) definitions. If false, it is expected the configmap will be created by something else. Argo CD will not work if there is no configmap created with the name above. |
| argocd.configs.rbac.annotations | object | `{}` | Annotations to be added to argocd-rbac-cm configmap |
| argocd.configs.rbac."policy.default" | string | `""` | The name of the default role which Argo CD will falls back to, when authorizing API requests (optional). If omitted or empty, users may be still be able to login, but will see no apps, projects, etc... |
| argocd.configs.rbac."policy.csv" | string | `''` (See [values.yaml]) | File containing user-defined policies and role definitions. |
| argocd.configs.rbac.scopes | string | `"[groups]"` | OIDC scopes to examine during rbac enforcement (in addition to `sub` scope). The scope value can be a string, or a list of strings. |
| argocd.configs.rbac."policy.matchMode" | string | `"glob"` | Matcher function for Casbin, `glob` for glob matcher and `regex` for regex matcher. |
| argocd.configs.gpg.annotations | object | `{}` | Annotations to be added to argocd-gpg-keys-cm configmap |
| argocd.configs.gpg.keys | object | `{}` (See [values.yaml]) | [GnuPG] public keys to add to the keyring # Note: Public keys should be exported with `gpg --export --armor <KEY>` |
| argocd.configs.ssh.create | bool | `true` | Specifies if the argocd-ssh-known-hosts-cm configmap should be created by Helm. |
| argocd.configs.ssh.annotations | object | `{}` | Annotations to be added to argocd-ssh-known-hosts-cm configmap |
| argocd.configs.ssh.knownHosts | string | See [values.yaml] | Known hosts to be added to the known host list by default. |
| argocd.configs.ssh.extraHosts | string | `""` | Additional known hosts for private repositories |
| argocd.configs.tls.annotations | object | `{}` | Annotations to be added to argocd-tls-certs-cm configmap |
| argocd.configs.tls.certificates | object | `{}` (See [values.yaml]) | TLS certificates for Git repositories |
| argocd.configs.tls.create | bool | `true` | Specifies if the argocd-tls-certs-cm configmap should be created by Helm. |
| argocd.configs.cmp.create | bool | `false` | Create the argocd-cmp-cm configmap |
| argocd.configs.cmp.annotations | object | `{}` | Annotations to be added to argocd-cmp-cm configmap |
| argocd.configs.cmp.plugins | object | `{}` | Plugin yaml files to be added to argocd-cmp-cm |
| argocd.configs.clusterCredentials | object | `{}` (See [values.yaml]) | Provide one or multiple [external cluster credentials] # Ref: # - https://argo-cd.readthedocs.io/en/stable/operator-manual/declarative-setup/#clusters # - https://argo-cd.readthedocs.io/en/stable/operator-manual/security/#external-cluster-credentials # - https://argo-cd.readthedocs.io/en/stable/user-guide/projects/#project-scoped-repositories-and-clusters |
| argocd.configs.credentialTemplates | object | `{}` | Repository credentials to be used as Templates for other repos # Creates a secret for each key/value specified below to create repository credentials |
| argocd.configs.credentialTemplatesAnnotations | object | `{}` | Annotations to be added to `configs.credentialTemplates` Secret |
| argocd.configs.repositories | object | `{}` | Repositories list to be used by applications # Creates a secret for each key/value specified below to create repositories # Note: the last example in the list would use a repository credential template, configured under "configs.credentialTemplates". |
| argocd.configs.repositoriesAnnotations | object | `{}` | Annotations to be added to `configs.repositories` Secret |
| argocd.configs.secret.createSecret | bool | `true` | Create the argocd-secret |
| argocd.configs.secret.labels | object | `{}` | Labels to be added to argocd-secret |
| argocd.configs.secret.annotations | object | `{}` | Annotations to be added to argocd-secret |
| argocd.configs.secret.githubSecret | string | `""` | Shared secret for authenticating GitHub webhook events |
| argocd.configs.secret.gitlabSecret | string | `""` | Shared secret for authenticating GitLab webhook events |
| argocd.configs.secret.bitbucketServerSecret | string | `""` | Shared secret for authenticating BitbucketServer webhook events |
| argocd.configs.secret.bitbucketUUID | string | `""` | UUID for authenticating Bitbucket webhook events |
| argocd.configs.secret.gogsSecret | string | `""` | Shared secret for authenticating Gogs webhook events |
| argocd.configs.secret.azureDevops.username | string | `""` | Shared secret username for authenticating Azure DevOps webhook events |
| argocd.configs.secret.azureDevops.password | string | `""` | Shared secret password for authenticating Azure DevOps webhook events |
| argocd.configs.secret.extra | object | `{}` | add additional secrets to be added to argocd-secret # Custom secrets. Useful for injecting SSO secrets into environment variables. # Ref: https://argo-cd.readthedocs.io/en/stable/operator-manual/user-management/#sensitive-data-and-sso-client-secrets # Note that all values must be non-empty. |
| argocd.configs.secret.argocdServerAdminPassword | string | `""` | Bcrypt hashed admin password # Argo expects the password in the secret to be bcrypt hashed. You can create this hash with # `htpasswd -nbBC 10 "" $ARGO_PWD | tr -d ':\n' | sed 's/$2y/$2a/'` |
| argocd.configs.secret.argocdServerAdminPasswordMtime | string | `""` (defaults to current time) | Admin password modification time. Eg. `"2006-01-02T15:04:05Z"` |
| argocd.configs.styles | string | `""` (See [values.yaml]) | Define custom [CSS styles] for your argo instance. This setting will automatically mount the provided CSS and reference it in the argo configuration. # Ref: https://argo-cd.readthedocs.io/en/stable/operator-manual/custom-styles/ |
| argocd.extraObjects | list | `[]` | Array of extra K8s manifests to deploy # Note: Supports use of custom Helm templates |
| argocd.controller.name | string | `"application-controller"` | Application controller name string |
| argocd.controller.replicas | int | `1` | The number of application controller pods to run. Additional replicas will cause sharding of managed clusters across number of replicas. # With dynamic cluster distribution turned on, sharding of the clusters will gracefully # rebalance if the number of replica's changes or one becomes unhealthy. (alpha) |
| argocd.controller.dynamicClusterDistribution | bool | `false` | Enable dynamic cluster distribution (alpha) Ref: https://argo-cd.readthedocs.io/en/stable/operator-manual/dynamic-cluster-distribution # This is done using a deployment instead of a statefulSet # When replicas are added or removed, the sharding algorithm is re-run to ensure that the # clusters are distributed according to the algorithm. If the algorithm is well-balanced, # like round-robin, then the shards will be well-balanced. |
| argocd.controller.runtimeClassName | string | `""` (defaults to global.runtimeClassName) | Runtime class name for the application controller |
| argocd.controller.heartbeatTime | int | `10` | Application controller heartbeat time Ref: https://argo-cd.readthedocs.io/en/stable/operator-manual/dynamic-cluster-distribution/#working-of-dynamic-distribution |
| argocd.controller.revisionHistoryLimit | int | `5` | Maximum number of controller revisions that will be maintained in StatefulSet history |
| argocd.controller.pdb.enabled | bool | `false` | Deploy a [PodDisruptionBudget] for the application controller |
| argocd.controller.pdb.labels | object | `{}` | Labels to be added to application controller pdb |
| argocd.controller.pdb.annotations | object | `{}` | Annotations to be added to application controller pdb |
| argocd.controller.pdb.minAvailable | string | `""` (defaults to 0 if not specified) | Number of pods that are available after eviction as number or percentage (eg.: 50%) |
| argocd.controller.pdb.maxUnavailable | string | `""` | Number of pods that are unavailable after eviction as number or percentage (eg.: 50%). # Has higher precedence over `controller.pdb.minAvailable` |
| argocd.controller.image.repository | string | `""` (defaults to global.image.repository) | Repository to use for the application controller |
| argocd.controller.image.tag | string | `""` (defaults to global.image.tag) | Tag to use for the application controller |
| argocd.controller.image.imagePullPolicy | string | `""` (defaults to global.image.imagePullPolicy) | Image pull policy for the application controller |
| argocd.controller.imagePullSecrets | list | `[]` (defaults to global.imagePullSecrets) | Secrets with credentials to pull images from a private registry |
| argocd.controller.extraArgs | list | `[]` | Additional command line arguments to pass to application controller |
| argocd.controller.env | list | `[]` | Environment variables to pass to application controller |
| argocd.controller.envFrom | list | `[]` (See [values.yaml]) | envFrom to pass to application controller |
| argocd.controller.extraContainers | list | `[]` | Additional containers to be added to the application controller pod # Note: Supports use of custom Helm templates |
| argocd.controller.initContainers | list | `[]` | Init containers to add to the application controller pod # If your target Kubernetes cluster(s) require a custom credential (exec) plugin # you could use this (and the same in the server pod) to provide such executable # Ref: https://kubernetes.io/docs/reference/access-authn-authz/authentication/#client-go-credential-plugins # Note: Supports use of custom Helm templates |
| argocd.controller.volumeMounts | list | `[]` | Additional volumeMounts to the application controller main container |
| argocd.controller.volumes | list | `[]` | Additional volumes to the application controller pod |
| argocd.controller.emptyDir.sizeLimit | string | `""` (defaults not set if not specified i.e. no size limit) | EmptyDir size limit for application controller |
| argocd.controller.statefulsetAnnotations | object | `{}` | Annotations for the application controller StatefulSet |
| argocd.controller.deploymentAnnotations | object | `{}` | Annotations for the application controller Deployment |
| argocd.controller.podAnnotations | object | `{}` | Annotations to be added to application controller pods |
| argocd.controller.podLabels | object | `{}` | Labels to be added to application controller pods |
| argocd.controller.resources | object | `{}` | Resource limits and requests for the application controller pods |
| argocd.controller.containerPorts.metrics | int | `8082` | Metrics container port |
| argocd.controller.hostNetwork | bool | `false` | Host Network for application controller pods |
| argocd.controller.dnsConfig | object | `{}` | [DNS configuration] |
| argocd.controller.dnsPolicy | string | `"ClusterFirst"` | Alternative DNS policy for application controller pods |
| argocd.controller.containerSecurityContext | object | See [values.yaml] | Application controller container-level security context |
| argocd.controller.readinessProbe.failureThreshold | int | `3` | Minimum consecutive failures for the [probe] to be considered failed after having succeeded |
| argocd.controller.readinessProbe.initialDelaySeconds | int | `10` | Number of seconds after the container has started before [probe] is initiated |
| argocd.controller.readinessProbe.periodSeconds | int | `10` | How often (in seconds) to perform the [probe] |
| argocd.controller.readinessProbe.successThreshold | int | `1` | Minimum consecutive successes for the [probe] to be considered successful after having failed |
| argocd.controller.readinessProbe.timeoutSeconds | int | `1` | Number of seconds after which the [probe] times out |
| argocd.controller.terminationGracePeriodSeconds | int | `30` | terminationGracePeriodSeconds for container lifecycle hook |
| argocd.controller.priorityClassName | string | `""` (defaults to global.priorityClassName) | Priority class for the application controller pods |
| argocd.controller.nodeSelector | object | `{}` (defaults to global.nodeSelector) | [Node selector] |
| argocd.controller.tolerations | list | `[]` (defaults to global.tolerations) | [Tolerations] for use with node taints |
| argocd.controller.affinity | object | `{}` (defaults to global.affinity preset) | Assign custom [affinity] rules to the deployment |
| argocd.controller.topologySpreadConstraints | list | `[]` (defaults to global.topologySpreadConstraints) | Assign custom [TopologySpreadConstraints] rules to the application controller # Ref: https://kubernetes.io/docs/concepts/scheduling-eviction/topology-spread-constraints/ # If labelSelector is left out, it will default to the labelSelector configuration of the deployment |
| argocd.controller.automountServiceAccountToken | bool | `true` | Automount API credentials for the Service Account into the pod. |
| argocd.controller.serviceAccount.create | bool | `true` | Create a service account for the application controller |
| argocd.controller.serviceAccount.name | string | `"argocd-application-controller"` | Service account name |
| argocd.controller.serviceAccount.annotations | object | `{}` | Annotations applied to created service account |
| argocd.controller.serviceAccount.labels | object | `{}` | Labels applied to created service account |
| argocd.controller.serviceAccount.automountServiceAccountToken | bool | `true` | Automount API credentials for the Service Account |
| argocd.controller.metrics.enabled | bool | `false` | Deploy metrics service |
| argocd.controller.metrics.scrapeTimeout | string | `""` | Prometheus ServiceMonitor scrapeTimeout. If empty, Prometheus uses the global scrape timeout unless it is less than the target's scrape interval value in which the latter is used. |
| argocd.controller.metrics.applicationLabels.enabled | bool | `false` | Enables additional labels in argocd_app_labels metric |
| argocd.controller.metrics.applicationLabels.labels | list | `[]` | Additional labels |
| argocd.controller.metrics.service.type | string | `"ClusterIP"` | Metrics service type |
| argocd.controller.metrics.service.clusterIP | string | `""` | Metrics service clusterIP. `None` makes a "headless service" (no virtual IP) |
| argocd.controller.metrics.service.annotations | object | `{}` | Metrics service annotations |
| argocd.controller.metrics.service.labels | object | `{}` | Metrics service labels |
| argocd.controller.metrics.service.servicePort | int | `8082` | Metrics service port |
| argocd.controller.metrics.service.portName | string | `"http-metrics"` | Metrics service port name |
| argocd.controller.metrics.serviceMonitor.enabled | bool | `false` | Enable a prometheus ServiceMonitor |
| argocd.controller.metrics.serviceMonitor.interval | string | `"30s"` | Prometheus ServiceMonitor interval |
| argocd.controller.metrics.serviceMonitor.honorLabels | bool | `false` | When true, honorLabels preserves the metric’s labels when they collide with the target’s labels. |
| argocd.controller.metrics.serviceMonitor.relabelings | list | `[]` | Prometheus [RelabelConfigs] to apply to samples before scraping |
| argocd.controller.metrics.serviceMonitor.metricRelabelings | list | `[]` | Prometheus [MetricRelabelConfigs] to apply to samples before ingestion |
| argocd.controller.metrics.serviceMonitor.selector | object | `{}` | Prometheus ServiceMonitor selector |
| argocd.controller.metrics.serviceMonitor.scheme | string | `""` | Prometheus ServiceMonitor scheme |
| argocd.controller.metrics.serviceMonitor.tlsConfig | object | `{}` | Prometheus ServiceMonitor tlsConfig |
| argocd.controller.metrics.serviceMonitor.namespace | string | `""` | Prometheus ServiceMonitor namespace |
| argocd.controller.metrics.serviceMonitor.additionalLabels | object | `{}` | Prometheus ServiceMonitor labels |
| argocd.controller.metrics.serviceMonitor.annotations | object | `{}` | Prometheus ServiceMonitor annotations |
| argocd.controller.metrics.rules.enabled | bool | `false` | Deploy a PrometheusRule for the application controller |
| argocd.controller.metrics.rules.namespace | string | `""` | PrometheusRule namespace |
| argocd.controller.metrics.rules.selector | object | `{}` | PrometheusRule selector |
| argocd.controller.metrics.rules.additionalLabels | object | `{}` | PrometheusRule labels |
| argocd.controller.metrics.rules.annotations | object | `{}` | PrometheusRule annotations |
| argocd.controller.metrics.rules.spec | list | `[]` | PrometheusRule.Spec for the application controller |
| argocd.controller.clusterRoleRules.enabled | bool | `false` | Enable custom rules for the application controller's ClusterRole resource |
| argocd.controller.clusterRoleRules.rules | list | `[]` | List of custom rules for the application controller's ClusterRole resource |
| argocd.dex.enabled | bool | `true` | Enable dex |
| argocd.dex.name | string | `"dex-server"` | Dex name |
| argocd.dex.extraArgs | list | `[]` | Additional command line arguments to pass to the Dex server |
| argocd.dex.runtimeClassName | string | `""` (defaults to global.runtimeClassName) | Runtime class name for Dex |
| argocd.dex.metrics.enabled | bool | `false` | Deploy metrics service |
| argocd.dex.metrics.service.annotations | object | `{}` | Metrics service annotations |
| argocd.dex.metrics.service.labels | object | `{}` | Metrics service labels |
| argocd.dex.metrics.service.portName | string | `"http-metrics"` | Metrics service port name |
| argocd.dex.metrics.serviceMonitor.enabled | bool | `false` | Enable a prometheus ServiceMonitor |
| argocd.dex.metrics.serviceMonitor.interval | string | `"30s"` | Prometheus ServiceMonitor interval |
| argocd.dex.metrics.serviceMonitor.honorLabels | bool | `false` | When true, honorLabels preserves the metric’s labels when they collide with the target’s labels. |
| argocd.dex.metrics.serviceMonitor.relabelings | list | `[]` | Prometheus [RelabelConfigs] to apply to samples before scraping |
| argocd.dex.metrics.serviceMonitor.metricRelabelings | list | `[]` | Prometheus [MetricRelabelConfigs] to apply to samples before ingestion |
| argocd.dex.metrics.serviceMonitor.selector | object | `{}` | Prometheus ServiceMonitor selector |
| argocd.dex.metrics.serviceMonitor.scheme | string | `""` | Prometheus ServiceMonitor scheme |
| argocd.dex.metrics.serviceMonitor.tlsConfig | object | `{}` | Prometheus ServiceMonitor tlsConfig |
| argocd.dex.metrics.serviceMonitor.namespace | string | `""` | Prometheus ServiceMonitor namespace |
| argocd.dex.metrics.serviceMonitor.additionalLabels | object | `{}` | Prometheus ServiceMonitor labels |
| argocd.dex.metrics.serviceMonitor.annotations | object | `{}` | Prometheus ServiceMonitor annotations |
| argocd.dex.pdb.enabled | bool | `false` | Deploy a [PodDisruptionBudget] for the Dex server |
| argocd.dex.pdb.labels | object | `{}` | Labels to be added to Dex server pdb |
| argocd.dex.pdb.annotations | object | `{}` | Annotations to be added to Dex server pdb |
| argocd.dex.pdb.minAvailable | string | `""` (defaults to 0 if not specified) | Number of pods that are available after eviction as number or percentage (eg.: 50%) |
| argocd.dex.pdb.maxUnavailable | string | `""` | Number of pods that are unavailble after eviction as number or percentage (eg.: 50%). # Has higher precedence over `dex.pdb.minAvailable` |
| argocd.dex.image.repository | string | `"ghcr.io/dexidp/dex"` | Dex image repository |
| argocd.dex.image.tag | string | `"v2.42.0"` | Dex image tag |
| argocd.dex.image.imagePullPolicy | string | `""` (defaults to global.image.imagePullPolicy) | Dex imagePullPolicy |
| argocd.dex.imagePullSecrets | list | `[]` (defaults to global.imagePullSecrets) | Secrets with credentials to pull images from a private registry |
| argocd.dex.initImage.repository | string | `""` (defaults to global.image.repository) | Argo CD init image repository |
| argocd.dex.initImage.tag | string | `""` (defaults to global.image.tag) | Argo CD init image tag |
| argocd.dex.initImage.imagePullPolicy | string | `""` (defaults to global.image.imagePullPolicy) | Argo CD init image imagePullPolicy |
| argocd.dex.initImage.resources | object | `{}` (defaults to dex.resources) | Argo CD init image resources |
| argocd.dex.env | list | `[]` | Environment variables to pass to the Dex server |
| argocd.dex.envFrom | list | `[]` (See [values.yaml]) | envFrom to pass to the Dex server |
| argocd.dex.extraContainers | list | `[]` | Additional containers to be added to the dex pod # Note: Supports use of custom Helm templates |
| argocd.dex.initContainers | list | `[]` | Init containers to add to the dex pod # Note: Supports use of custom Helm templates |
| argocd.dex.volumeMounts | list | `[]` | Additional volumeMounts to the dex main container |
| argocd.dex.volumes | list | `[]` | Additional volumes to the dex pod |
| argocd.dex.emptyDir.sizeLimit | string | `""` (defaults not set if not specified i.e. no size limit) | EmptyDir size limit for Dex server |
| argocd.dex.certificateSecret.enabled | bool | `false` | Create argocd-dex-server-tls secret |
| argocd.dex.certificateSecret.labels | object | `{}` | Labels to be added to argocd-dex-server-tls secret |
| argocd.dex.certificateSecret.annotations | object | `{}` | Annotations to be added to argocd-dex-server-tls secret |
| argocd.dex.certificateSecret.ca | string | `""` | Certificate authority. Required for self-signed certificates. |
| argocd.dex.certificateSecret.key | string | `""` | Certificate private key |
| argocd.dex.certificateSecret.crt | string | `""` | Certificate data. Must contain SANs of Dex service (ie: argocd-dex-server, argocd-dex-server.argo-cd.svc) |
| argocd.dex.deploymentAnnotations | object | `{}` | Annotations to be added to the Dex server Deployment |
| argocd.dex.podAnnotations | object | `{}` | Annotations to be added to the Dex server pods |
| argocd.dex.podLabels | object | `{}` | Labels to be added to the Dex server pods |
| argocd.dex.resources | object | `{}` | Resource limits and requests for dex |
| argocd.dex.containerPorts.http | int | `5556` | HTTP container port |
| argocd.dex.containerPorts.grpc | int | `5557` | gRPC container port |
| argocd.dex.containerPorts.metrics | int | `5558` | Metrics container port |
| argocd.dex.dnsConfig | object | `{}` | [DNS configuration] |
| argocd.dex.dnsPolicy | string | `"ClusterFirst"` | Alternative DNS policy for Dex server pods |
| argocd.dex.containerSecurityContext | object | See [values.yaml] | Dex container-level security context |
| argocd.dex.livenessProbe.enabled | bool | `false` | Enable Kubernetes liveness probe for Dex >= 2.28.0 |
| argocd.dex.livenessProbe.httpPath | string | `"/healthz/live"` | Http path to use for the liveness probe |
| argocd.dex.livenessProbe.httpPort | string | `"metrics"` | Http port to use for the liveness probe |
| argocd.dex.livenessProbe.httpScheme | string | `"HTTP"` | Scheme to use for for the liveness probe (can be HTTP or HTTPS) |
| argocd.dex.livenessProbe.failureThreshold | int | `3` | Minimum consecutive failures for the [probe] to be considered failed after having succeeded |
| argocd.dex.livenessProbe.initialDelaySeconds | int | `10` | Number of seconds after the container has started before [probe] is initiated |
| argocd.dex.livenessProbe.periodSeconds | int | `10` | How often (in seconds) to perform the [probe] |
| argocd.dex.livenessProbe.successThreshold | int | `1` | Minimum consecutive successes for the [probe] to be considered successful after having failed |
| argocd.dex.livenessProbe.timeoutSeconds | int | `1` | Number of seconds after which the [probe] times out |
| argocd.dex.readinessProbe.enabled | bool | `false` | Enable Kubernetes readiness probe for Dex >= 2.28.0 |
| argocd.dex.readinessProbe.httpPath | string | `"/healthz/ready"` | Http path to use for the readiness probe |
| argocd.dex.readinessProbe.httpPort | string | `"metrics"` | Http port to use for the readiness probe |
| argocd.dex.readinessProbe.httpScheme | string | `"HTTP"` | Scheme to use for for the liveness probe (can be HTTP or HTTPS) |
| argocd.dex.readinessProbe.failureThreshold | int | `3` | Minimum consecutive failures for the [probe] to be considered failed after having succeeded |
| argocd.dex.readinessProbe.initialDelaySeconds | int | `10` | Number of seconds after the container has started before [probe] is initiated |
| argocd.dex.readinessProbe.periodSeconds | int | `10` | How often (in seconds) to perform the [probe] |
| argocd.dex.readinessProbe.successThreshold | int | `1` | Minimum consecutive successes for the [probe] to be considered successful after having failed |
| argocd.dex.readinessProbe.timeoutSeconds | int | `1` | Number of seconds after which the [probe] times out |
| argocd.dex.terminationGracePeriodSeconds | int | `30` | terminationGracePeriodSeconds for container lifecycle hook |
| argocd.dex.automountServiceAccountToken | bool | `true` | Automount API credentials for the Service Account into the pod. |
| argocd.dex.serviceAccount.create | bool | `true` | Create dex service account |
| argocd.dex.serviceAccount.name | string | `"argocd-dex-server"` | Dex service account name |
| argocd.dex.serviceAccount.annotations | object | `{}` | Annotations applied to created service account |
| argocd.dex.serviceAccount.automountServiceAccountToken | bool | `true` | Automount API credentials for the Service Account |
| argocd.dex.servicePortHttp | int | `5556` | Service port for HTTP access |
| argocd.dex.servicePortHttpName | string | `"http"` | Service port name for HTTP access |
| argocd.dex.servicePortGrpc | int | `5557` | Service port for gRPC access |
| argocd.dex.servicePortGrpcName | string | `"grpc"` | Service port name for gRPC access |
| argocd.dex.servicePortMetrics | int | `5558` | Service port for metrics access |
| argocd.dex.priorityClassName | string | `""` (defaults to global.priorityClassName) | Priority class for the dex pods |
| argocd.dex.nodeSelector | object | `{}` (defaults to global.nodeSelector) | [Node selector] |
| argocd.dex.tolerations | list | `[]` (defaults to global.tolerations) | [Tolerations] for use with node taints |
| argocd.dex.affinity | object | `{}` (defaults to global.affinity preset) | Assign custom [affinity] rules to the deployment |
| argocd.dex.topologySpreadConstraints | list | `[]` (defaults to global.topologySpreadConstraints) | Assign custom [TopologySpreadConstraints] rules to dex # Ref: https://kubernetes.io/docs/concepts/scheduling-eviction/topology-spread-constraints/ # If labelSelector is left out, it will default to the labelSelector configuration of the deployment |
| argocd.dex.deploymentStrategy | object | `{}` | Deployment strategy to be added to the Dex server Deployment |
| argocd.dex.logFormat | string | `""` (defaults to global.logging.format) | Dex log format. Either `text` or `json` |
| argocd.dex.logLevel | string | `""` (defaults to global.logging.level) | Dex log level. One of: `debug`, `info`, `warn`, `error` |
| argocd.redis.enabled | bool | `true` | Enable redis |
| argocd.redis.name | string | `"redis"` | Redis name |
| argocd.redis.runtimeClassName | string | `""` (defaults to global.runtimeClassName) | Runtime class name for redis |
| argocd.redis.pdb.enabled | bool | `false` | Deploy a [PodDisruptionBudget] for the Redis |
| argocd.redis.pdb.labels | object | `{}` | Labels to be added to Redis pdb |
| argocd.redis.pdb.annotations | object | `{}` | Annotations to be added to Redis pdb |
| argocd.redis.pdb.minAvailable | string | `""` (defaults to 0 if not specified) | Number of pods that are available after eviction as number or percentage (eg.: 50%) |
| argocd.redis.pdb.maxUnavailable | string | `""` | Number of pods that are unavailble after eviction as number or percentage (eg.: 50%). # Has higher precedence over `redis.pdb.minAvailable` |
| argocd.redis.image.repository | string | `"public.ecr.aws/docker/library/redis"` | Redis repository |
| argocd.redis.image.tag | string | `"7.4.2-alpine"` | Redis tag |
| argocd.redis.image.imagePullPolicy | string | `""` (defaults to global.image.imagePullPolicy) | Redis image pull policy |
| argocd.redis.exporter.enabled | bool | `false` | Enable Prometheus redis-exporter sidecar |
| argocd.redis.exporter.env | list | `[]` | Environment variables to pass to the Redis exporter |
| argocd.redis.exporter.image.repository | string | `"public.ecr.aws/bitnami/redis-exporter"` | Repository to use for the redis-exporter |
| argocd.redis.exporter.image.tag | string | `"1.67.0"` | Tag to use for the redis-exporter |
| argocd.redis.exporter.image.imagePullPolicy | string | `""` (defaults to global.image.imagePullPolicy) | Image pull policy for the redis-exporter |
| argocd.redis.exporter.containerSecurityContext | object | See [values.yaml] | Redis exporter security context |
| argocd.redis.exporter.readinessProbe.enabled | bool | `false` | Enable Kubernetes liveness probe for Redis exporter (optional) |
| argocd.redis.exporter.readinessProbe.initialDelaySeconds | int | `30` | Number of seconds after the container has started before [probe] is initiated |
| argocd.redis.exporter.readinessProbe.periodSeconds | int | `15` | How often (in seconds) to perform the [probe] |
| argocd.redis.exporter.readinessProbe.timeoutSeconds | int | `15` | Number of seconds after which the [probe] times out |
| argocd.redis.exporter.readinessProbe.successThreshold | int | `1` | Minimum consecutive successes for the [probe] to be considered successful after having failed |
| argocd.redis.exporter.readinessProbe.failureThreshold | int | `5` | Minimum consecutive failures for the [probe] to be considered failed after having succeeded |
| argocd.redis.exporter.livenessProbe.enabled | bool | `false` | Enable Kubernetes liveness probe for Redis exporter |
| argocd.redis.exporter.livenessProbe.initialDelaySeconds | int | `30` | Number of seconds after the container has started before [probe] is initiated |
| argocd.redis.exporter.livenessProbe.periodSeconds | int | `15` | How often (in seconds) to perform the [probe] |
| argocd.redis.exporter.livenessProbe.timeoutSeconds | int | `15` | Number of seconds after which the [probe] times out |
| argocd.redis.exporter.livenessProbe.successThreshold | int | `1` | Minimum consecutive successes for the [probe] to be considered successful after having failed |
| argocd.redis.exporter.livenessProbe.failureThreshold | int | `5` | Minimum consecutive failures for the [probe] to be considered failed after having succeeded |
| argocd.redis.exporter.resources | object | `{}` | Resource limits and requests for redis-exporter sidecar |
| argocd.redis.imagePullSecrets | list | `[]` (defaults to global.imagePullSecrets) | Secrets with credentials to pull images from a private registry |
| argocd.redis.extraArgs | list | `[]` | Additional command line arguments to pass to redis-server |
| argocd.redis.env | list | `[]` | Environment variables to pass to the Redis server |
| argocd.redis.envFrom | list | `[]` (See [values.yaml]) | envFrom to pass to the Redis server |
| argocd.redis.readinessProbe.enabled | bool | `false` | Enable Kubernetes liveness probe for Redis server |
| argocd.redis.readinessProbe.initialDelaySeconds | int | `30` | Number of seconds after the container has started before [probe] is initiated |
| argocd.redis.readinessProbe.periodSeconds | int | `15` | How often (in seconds) to perform the [probe] |
| argocd.redis.readinessProbe.timeoutSeconds | int | `15` | Number of seconds after which the [probe] times out |
| argocd.redis.readinessProbe.successThreshold | int | `1` | Minimum consecutive successes for the [probe] to be considered successful after having failed |
| argocd.redis.readinessProbe.failureThreshold | int | `5` | Minimum consecutive failures for the [probe] to be considered failed after having succeeded |
| argocd.redis.livenessProbe.enabled | bool | `false` | Enable Kubernetes liveness probe for Redis server |
| argocd.redis.livenessProbe.initialDelaySeconds | int | `30` | Number of seconds after the container has started before [probe] is initiated |
| argocd.redis.livenessProbe.periodSeconds | int | `15` | How often (in seconds) to perform the [probe] |
| argocd.redis.livenessProbe.timeoutSeconds | int | `15` | Number of seconds after which the [probe] times out |
| argocd.redis.livenessProbe.successThreshold | int | `1` | Minimum consecutive successes for the [probe] to be considered successful after having failed |
| argocd.redis.livenessProbe.failureThreshold | int | `5` | Minimum consecutive failures for the [probe] to be considered failed after having succeeded |
| argocd.redis.extraContainers | list | `[]` | Additional containers to be added to the redis pod # Note: Supports use of custom Helm templates |
| argocd.redis.initContainers | list | `[]` | Init containers to add to the redis pod # Note: Supports use of custom Helm templates |
| argocd.redis.volumeMounts | list | `[]` | Additional volumeMounts to the redis container |
| argocd.redis.volumes | list | `[]` | Additional volumes to the redis pod |
| argocd.redis.deploymentAnnotations | object | `{}` | Annotations to be added to the Redis server Deployment |
| argocd.redis.podAnnotations | object | `{}` | Annotations to be added to the Redis server pods |
| argocd.redis.podLabels | object | `{}` | Labels to be added to the Redis server pods |
| argocd.redis.resources | object | `{}` | Resource limits and requests for redis |
| argocd.redis.securityContext | object | See [values.yaml] | Redis pod-level security context |
| argocd.redis.containerPorts.redis | int | `6379` | Redis container port |
| argocd.redis.containerPorts.metrics | int | `9121` | Metrics container port |
| argocd.redis.dnsConfig | object | `{}` | [DNS configuration] |
| argocd.redis.dnsPolicy | string | `"ClusterFirst"` | Alternative DNS policy for Redis server pods |
| argocd.redis.containerSecurityContext | object | See [values.yaml] | Redis container-level security context |
| argocd.redis.servicePort | int | `6379` | Redis service port |
| argocd.redis.priorityClassName | string | `""` (defaults to global.priorityClassName) | Priority class for redis pods |
| argocd.redis.nodeSelector | object | `{}` (defaults to global.nodeSelector) | [Node selector] |
| argocd.redis.tolerations | list | `[]` (defaults to global.tolerations) | [Tolerations] for use with node taints |
| argocd.redis.affinity | object | `{}` (defaults to global.affinity preset) | Assign custom [affinity] rules to the deployment |
| argocd.redis.topologySpreadConstraints | list | `[]` (defaults to global.topologySpreadConstraints) | Assign custom [TopologySpreadConstraints] rules to redis # Ref: https://kubernetes.io/docs/concepts/scheduling-eviction/topology-spread-constraints/ # If labelSelector is left out, it will default to the labelSelector configuration of the deployment |
| argocd.redis.terminationGracePeriodSeconds | int | `30` | terminationGracePeriodSeconds for container lifecycle hook |
| argocd.redis.automountServiceAccountToken | bool | `true` | Automount API credentials for the Service Account into the pod. |
| argocd.redis.serviceAccount.create | bool | `false` | Create a service account for the redis pod |
| argocd.redis.serviceAccount.name | string | `""` | Service account name for redis pod |
| argocd.redis.serviceAccount.annotations | object | `{}` | Annotations applied to created service account |
| argocd.redis.serviceAccount.automountServiceAccountToken | bool | `false` | Automount API credentials for the Service Account |
| argocd.redis.service.annotations | object | `{}` | Redis service annotations |
| argocd.redis.service.labels | object | `{}` | Additional redis service labels |
| argocd.redis.metrics.enabled | bool | `false` | Deploy metrics service |
| argocd.redis.metrics.service.type | string | `"ClusterIP"` | Metrics service type |
| argocd.redis.metrics.service.clusterIP | string | `"None"` | Metrics service clusterIP. `None` makes a "headless service" (no virtual IP) |
| argocd.redis.metrics.service.annotations | object | `{}` | Metrics service annotations |
| argocd.redis.metrics.service.labels | object | `{}` | Metrics service labels |
| argocd.redis.metrics.service.servicePort | int | `9121` | Metrics service port |
| argocd.redis.metrics.service.portName | string | `"http-metrics"` | Metrics service port name |
| argocd.redis.metrics.serviceMonitor.enabled | bool | `false` | Enable a prometheus ServiceMonitor |
| argocd.redis.metrics.serviceMonitor.interval | string | `"30s"` | Interval at which metrics should be scraped |
| argocd.redis.metrics.serviceMonitor.honorLabels | bool | `false` | When true, honorLabels preserves the metric’s labels when they collide with the target’s labels. |
| argocd.redis.metrics.serviceMonitor.relabelings | list | `[]` | Prometheus [RelabelConfigs] to apply to samples before scraping |
| argocd.redis.metrics.serviceMonitor.metricRelabelings | list | `[]` | Prometheus [MetricRelabelConfigs] to apply to samples before ingestion |
| argocd.redis.metrics.serviceMonitor.selector | object | `{}` | Prometheus ServiceMonitor selector |
| argocd.redis.metrics.serviceMonitor.scheme | string | `""` | Prometheus ServiceMonitor scheme |
| argocd.redis.metrics.serviceMonitor.tlsConfig | object | `{}` | Prometheus ServiceMonitor tlsConfig |
| argocd.redis.metrics.serviceMonitor.namespace | string | `""` | Prometheus ServiceMonitor namespace |
| argocd.redis.metrics.serviceMonitor.additionalLabels | object | `{}` | Prometheus ServiceMonitor labels |
| argocd.redis.metrics.serviceMonitor.annotations | object | `{}` | Prometheus ServiceMonitor annotations |
| argocd.redis-ha.enabled | bool | `false` | Enables the Redis HA subchart and disables the custom Redis single node deployment |
| argocd.redis-ha.image.repository | string | `"public.ecr.aws/docker/library/redis"` | Redis repository |
| argocd.redis-ha.image.tag | string | `"7.4.2-alpine"` | Redis tag |
| argocd.redis-ha.exporter.enabled | bool | `false` | Enable Prometheus redis-exporter sidecar |
| argocd.redis-ha.exporter.image | string | `"public.ecr.aws/bitnami/redis-exporter"` | Repository to use for the redis-exporter |
| argocd.redis-ha.exporter.tag | string | `"1.58.0"` | Tag to use for the redis-exporter |
| argocd.redis-ha.persistentVolume.enabled | bool | `false` | Configures persistence on Redis nodes |
| argocd.redis-ha.redis.masterGroupName | string | `"argocd"` | Redis convention for naming the cluster group: must match `^[\\w-\\.]+$` and can be templated |
| argocd.redis-ha.redis.config | object | See [values.yaml] | Any valid redis config options in this section will be applied to each server (see `redis-ha` chart) |
| argocd.redis-ha.redis.config.save | string | `'""'` | Will save the DB if both the given number of seconds and the given number of write operations against the DB occurred. `""`  is disabled |
| argocd.redis-ha.haproxy.enabled | bool | `true` | Enabled HAProxy LoadBalancing/Proxy |
| argocd.redis-ha.haproxy.labels | object | `{"app.kubernetes.io/name":"argocd-redis-ha-haproxy"}` | Custom labels for the haproxy pod. This is relevant for Argo CD CLI. |
| argocd.redis-ha.haproxy.metrics.enabled | bool | `true` | HAProxy enable prometheus metric scraping |
| argocd.redis-ha.haproxy.hardAntiAffinity | bool | `true` | Whether the haproxy pods should be forced to run on separate nodes. |
| argocd.redis-ha.haproxy.additionalAffinities | object | `{}` | Additional affinities to add to the haproxy pods. |
| argocd.redis-ha.haproxy.affinity | string | `""` | Assign custom [affinity] rules to the haproxy pods. |
| argocd.redis-ha.haproxy.tolerations | list | `[]` | [Tolerations] for use with node taints for haproxy pods. |
| argocd.redis-ha.haproxy.containerSecurityContext | object | See [values.yaml] | HAProxy container-level security context |
| argocd.redis-ha.auth | bool | `true` | Configures redis-ha with AUTH |
| argocd.redis-ha.existingSecret | string | `"argocd-redis"` | Existing Secret to use for redis-ha authentication. By default the redis-secret-init Job is generating this Secret. |
| argocd.redis-ha.hardAntiAffinity | bool | `true` | Whether the Redis server pods should be forced to run on separate nodes. |
| argocd.redis-ha.additionalAffinities | object | `{}` | Additional affinities to add to the Redis server pods. |
| argocd.redis-ha.affinity | string | `""` | Assign custom [affinity] rules to the Redis pods. |
| argocd.redis-ha.tolerations | list | `[]` | [Tolerations] for use with node taints for Redis pods. |
| argocd.redis-ha.topologySpreadConstraints | object | `{"enabled":false,"maxSkew":"","topologyKey":"","whenUnsatisfiable":""}` | Assign custom [TopologySpreadConstraints] rules to the Redis pods. # https://kubernetes.io/docs/concepts/scheduling-eviction/topology-spread-constraints/ |
| argocd.redis-ha.topologySpreadConstraints.enabled | bool | `false` | Enable Redis HA topology spread constraints |
| argocd.redis-ha.topologySpreadConstraints.maxSkew | string | `""` (defaults to `1`) | Max skew of pods tolerated |
| argocd.redis-ha.topologySpreadConstraints.topologyKey | string | `""` (defaults to `topology.kubernetes.io/zone`) | Topology key for spread |
| argocd.redis-ha.topologySpreadConstraints.whenUnsatisfiable | string | `""` (defaults to `ScheduleAnyway`) | Enforcement policy, hard or soft |
| argocd.redis-ha.containerSecurityContext | object | See [values.yaml] | Redis HA statefulset container-level security context |
| argocd.externalRedis.host | string | `""` | External Redis server host |
| argocd.externalRedis.username | string | `""` | External Redis username |
| argocd.externalRedis.password | string | `""` | External Redis password |
| argocd.externalRedis.port | int | `6379` | External Redis server port |
| argocd.externalRedis.existingSecret | string | `""` | The name of an existing secret with Redis (must contain key `redis-password`) and Sentinel credentials. When it's set, the `externalRedis.password` parameter is ignored |
| argocd.externalRedis.secretAnnotations | object | `{}` | External Redis Secret annotations |
| argocd.redisSecretInit.enabled | bool | `true` | Enable Redis secret initialization. If disabled, secret must be provisioned by alternative methods |
| argocd.redisSecretInit.name | string | `"redis-secret-init"` | Redis secret-init name |
| argocd.redisSecretInit.image.repository | string | `""` (defaults to global.image.repository) | Repository to use for the Redis secret-init Job |
| argocd.redisSecretInit.image.tag | string | `""` (defaults to global.image.tag) | Tag to use for the Redis secret-init Job |
| argocd.redisSecretInit.image.imagePullPolicy | string | `""` (defaults to global.image.imagePullPolicy) | Image pull policy for the Redis secret-init Job |
| argocd.redisSecretInit.imagePullSecrets | list | `[]` (defaults to global.imagePullSecrets) | Secrets with credentials to pull images from a private registry |
| argocd.redisSecretInit.jobAnnotations | object | `{}` | Annotations to be added to the Redis secret-init Job |
| argocd.redisSecretInit.podAnnotations | object | `{}` | Annotations to be added to the Redis secret-init Job |
| argocd.redisSecretInit.podLabels | object | `{}` | Labels to be added to the Redis secret-init Job |
| argocd.redisSecretInit.resources | object | `{}` | Resource limits and requests for Redis secret-init Job |
| argocd.redisSecretInit.containerSecurityContext | object | See [values.yaml] | Application controller container-level security context |
| argocd.redisSecretInit.securityContext | object | `{}` | Redis secret-init Job pod-level security context |
| argocd.redisSecretInit.serviceAccount.create | bool | `true` | Create a service account for the redis pod |
| argocd.redisSecretInit.serviceAccount.name | string | `""` | Service account name for redis pod |
| argocd.redisSecretInit.serviceAccount.annotations | object | `{}` | Annotations applied to created service account |
| argocd.redisSecretInit.serviceAccount.automountServiceAccountToken | bool | `true` | Automount API credentials for the Service Account |
| argocd.redisSecretInit.priorityClassName | string | `""` (defaults to global.priorityClassName) | Priority class for Redis secret-init Job |
| argocd.redisSecretInit.affinity | object | `{}` | Assign custom [affinity] rules to the Redis secret-init Job |
| argocd.redisSecretInit.nodeSelector | object | `{}` (defaults to global.nodeSelector) | Node selector to be added to the Redis secret-init Job |
| argocd.redisSecretInit.tolerations | list | `[]` (defaults to global.tolerations) | Tolerations to be added to the Redis secret-init Job |
| argocd.server.name | string | `"server"` | Argo CD server name |
| argocd.server.replicas | int | `1` | The number of server pods to run |
| argocd.server.runtimeClassName | string | `""` (defaults to global.runtimeClassName) | Runtime class name for the Argo CD server |
| argocd.server.autoscaling.enabled | bool | `false` | Enable Horizontal Pod Autoscaler ([HPA]) for the Argo CD server |
| argocd.server.autoscaling.minReplicas | int | `1` | Minimum number of replicas for the Argo CD server [HPA] |
| argocd.server.autoscaling.maxReplicas | int | `5` | Maximum number of replicas for the Argo CD server [HPA] |
| argocd.server.autoscaling.targetCPUUtilizationPercentage | int | `50` | Average CPU utilization percentage for the Argo CD server [HPA] |
| argocd.server.autoscaling.targetMemoryUtilizationPercentage | int | `50` | Average memory utilization percentage for the Argo CD server [HPA] |
| argocd.server.autoscaling.behavior | object | `{}` | Configures the scaling behavior of the target in both Up and Down directions. |
| argocd.server.autoscaling.metrics | list | `[]` | Configures custom HPA metrics for the Argo CD server Ref: https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/ |
| argocd.server.pdb.enabled | bool | `false` | Deploy a [PodDisruptionBudget] for the Argo CD server |
| argocd.server.pdb.labels | object | `{}` | Labels to be added to Argo CD server pdb |
| argocd.server.pdb.annotations | object | `{}` | Annotations to be added to Argo CD server pdb |
| argocd.server.pdb.minAvailable | string | `""` (defaults to 0 if not specified) | Number of pods that are available after eviction as number or percentage (eg.: 50%) |
| argocd.server.pdb.maxUnavailable | string | `""` | Number of pods that are unavailable after eviction as number or percentage (eg.: 50%). # Has higher precedence over `server.pdb.minAvailable` |
| argocd.server.image.repository | string | `""` (defaults to global.image.repository) | Repository to use for the Argo CD server |
| argocd.server.image.tag | string | `""` (defaults to global.image.tag) | Tag to use for the Argo CD server |
| argocd.server.image.imagePullPolicy | string | `""` (defaults to global.image.imagePullPolicy) | Image pull policy for the Argo CD server |
| argocd.server.imagePullSecrets | list | `[]` (defaults to global.imagePullSecrets) | Secrets with credentials to pull images from a private registry |
| argocd.server.extraArgs | list | `[]` | Additional command line arguments to pass to Argo CD server |
| argocd.server.env | list | `[]` | Environment variables to pass to Argo CD server |
| argocd.server.envFrom | list | `[]` (See [values.yaml]) | envFrom to pass to Argo CD server |
| argocd.server.lifecycle | object | `{}` | Specify postStart and preStop lifecycle hooks for your argo-cd-server container |
| argocd.server.extensions.enabled | bool | `false` | Enable support for Argo CD extensions |
| argocd.server.extensions.image.repository | string | `"quay.io/argoprojlabs/argocd-extension-installer"` | Repository to use for extension installer image |
| argocd.server.extensions.image.tag | string | `"v0.0.8"` | Tag to use for extension installer image |
| argocd.server.extensions.image.imagePullPolicy | string | `""` (defaults to global.image.imagePullPolicy) | Image pull policy for extensions |
| argocd.server.extensions.extensionList | list | `[]` (See [values.yaml]) | Extensions for Argo CD # Ref: https://github.com/argoproj-labs/argocd-extension-metrics#install-ui-extension |
| argocd.server.extensions.containerSecurityContext | object | See [values.yaml] | Server UI extensions container-level security context |
| argocd.server.extensions.resources | object | `{}` | Resource limits and requests for the argocd-extensions container |
| argocd.server.extraContainers | list | `[]` | Additional containers to be added to the server pod # Note: Supports use of custom Helm templates |
| argocd.server.initContainers | list | `[]` | Init containers to add to the server pod # If your target Kubernetes cluster(s) require a custom credential (exec) plugin # you could use this (and the same in the application controller pod) to provide such executable # Ref: https://kubernetes.io/docs/reference/access-authn-authz/authentication/#client-go-credential-plugins |
| argocd.server.volumeMounts | list | `[]` | Additional volumeMounts to the server main container |
| argocd.server.volumes | list | `[]` | Additional volumes to the server pod |
| argocd.server.emptyDir.sizeLimit | string | `""` (defaults not set if not specified i.e. no size limit) | EmptyDir size limit for the Argo CD server |
| argocd.server.deploymentAnnotations | object | `{}` | Annotations to be added to server Deployment |
| argocd.server.podAnnotations | object | `{}` | Annotations to be added to server pods |
| argocd.server.podLabels | object | `{}` | Labels to be added to server pods |
| argocd.server.resources | object | `{}` | Resource limits and requests for the Argo CD server |
| argocd.server.containerPorts.server | int | `8080` | Server container port |
| argocd.server.containerPorts.metrics | int | `8083` | Metrics container port |
| argocd.server.hostNetwork | bool | `false` | Host Network for Server pods |
| argocd.server.dnsConfig | object | `{}` | [DNS configuration] |
| argocd.server.dnsPolicy | string | `"ClusterFirst"` | Alternative DNS policy for Server pods |
| argocd.server.containerSecurityContext | object | See [values.yaml] | Server container-level security context |
| argocd.server.readinessProbe.failureThreshold | int | `3` | Minimum consecutive failures for the [probe] to be considered failed after having succeeded |
| argocd.server.readinessProbe.initialDelaySeconds | int | `10` | Number of seconds after the container has started before [probe] is initiated |
| argocd.server.readinessProbe.periodSeconds | int | `10` | How often (in seconds) to perform the [probe] |
| argocd.server.readinessProbe.successThreshold | int | `1` | Minimum consecutive successes for the [probe] to be considered successful after having failed |
| argocd.server.readinessProbe.timeoutSeconds | int | `1` | Number of seconds after which the [probe] times out |
| argocd.server.livenessProbe.failureThreshold | int | `3` | Minimum consecutive failures for the [probe] to be considered failed after having succeeded |
| argocd.server.livenessProbe.initialDelaySeconds | int | `10` | Number of seconds after the container has started before [probe] is initiated |
| argocd.server.livenessProbe.periodSeconds | int | `10` | How often (in seconds) to perform the [probe] |
| argocd.server.livenessProbe.successThreshold | int | `1` | Minimum consecutive successes for the [probe] to be considered successful after having failed |
| argocd.server.livenessProbe.timeoutSeconds | int | `1` | Number of seconds after which the [probe] times out |
| argocd.server.terminationGracePeriodSeconds | int | `30` | terminationGracePeriodSeconds for container lifecycle hook |
| argocd.server.priorityClassName | string | `""` (defaults to global.priorityClassName) | Priority class for the Argo CD server pods |
| argocd.server.nodeSelector | object | `{}` (defaults to global.nodeSelector) | [Node selector] |
| argocd.server.tolerations | list | `[]` (defaults to global.tolerations) | [Tolerations] for use with node taints |
| argocd.server.affinity | object | `{}` (defaults to global.affinity preset) | Assign custom [affinity] rules to the deployment |
| argocd.server.topologySpreadConstraints | list | `[]` (defaults to global.topologySpreadConstraints) | Assign custom [TopologySpreadConstraints] rules to the Argo CD server # Ref: https://kubernetes.io/docs/concepts/scheduling-eviction/topology-spread-constraints/ # If labelSelector is left out, it will default to the labelSelector configuration of the deployment |
| argocd.server.deploymentStrategy | object | `{}` | Deployment strategy to be added to the server Deployment |
| argocd.server.certificate.enabled | bool | `false` | Deploy a Certificate resource (requires cert-manager) |
| argocd.server.certificate.domain | string | `""` (defaults to global.domain) | Certificate primary domain (commonName) |
| argocd.server.certificate.additionalHosts | list | `[]` | Certificate Subject Alternate Names (SANs) |
| argocd.server.certificate.duration | string | `""` (defaults to 2160h = 90d if not specified) | The requested 'duration' (i.e. lifetime) of the certificate. # Ref: https://cert-manager.io/docs/usage/certificate/#renewal |
| argocd.server.certificate.renewBefore | string | `""` (defaults to 360h = 15d if not specified) | How long before the expiry a certificate should be renewed. # Ref: https://cert-manager.io/docs/usage/certificate/#renewal |
| argocd.server.certificate.issuer.group | string | `""` | Certificate issuer group. Set if using an external issuer. Eg. `cert-manager.io` |
| argocd.server.certificate.issuer.kind | string | `""` | Certificate issuer kind. Either `Issuer` or `ClusterIssuer` |
| argocd.server.certificate.issuer.name | string | `""` | Certificate issuer name. Eg. `letsencrypt` |
| argocd.server.certificate.privateKey.rotationPolicy | string | `"Never"` | Rotation policy of private key when certificate is re-issued. Either: `Never` or `Always` |
| argocd.server.certificate.privateKey.encoding | string | `"PKCS1"` | The private key cryptography standards (PKCS) encoding for private key. Either: `PCKS1` or `PKCS8` |
| argocd.server.certificate.privateKey.algorithm | string | `"RSA"` | Algorithm used to generate certificate private key. One of: `RSA`, `Ed25519` or `ECDSA` |
| argocd.server.certificate.privateKey.size | int | `2048` | Key bit size of the private key. If algorithm is set to `Ed25519`, size is ignored. |
| argocd.server.certificate.annotations | object | `{}` | Annotations to be applied to the Server Certificate |
| argocd.server.certificate.usages | list | `[]` | Usages for the certificate ## Ref: https://cert-manager.io/docs/reference/api-docs/#cert-manager.io/v1.KeyUsage |
| argocd.server.certificate.secretTemplateAnnotations | object | `{}` | Annotations that allow the certificate to be composed from data residing in existing Kubernetes Resources |
| argocd.server.certificateSecret.enabled | bool | `false` | Create argocd-server-tls secret |
| argocd.server.certificateSecret.annotations | object | `{}` | Annotations to be added to argocd-server-tls secret |
| argocd.server.certificateSecret.labels | object | `{}` | Labels to be added to argocd-server-tls secret |
| argocd.server.certificateSecret.key | string | `""` | Private Key of the certificate |
| argocd.server.certificateSecret.crt | string | `""` | Certificate data |
| argocd.server.service.annotations | object | `{}` | Server service annotations |
| argocd.server.service.labels | object | `{}` | Server service labels |
| argocd.server.service.type | string | `"ClusterIP"` | Server service type |
| argocd.server.service.nodePortHttp | int | `30080` | Server service http port for NodePort service type (only if `server.service.type` is set to "NodePort") |
| argocd.server.service.nodePortHttps | int | `30443` | Server service https port for NodePort service type (only if `server.service.type` is set to "NodePort") |
| argocd.server.service.servicePortHttp | int | `80` | Server service http port |
| argocd.server.service.servicePortHttps | int | `443` | Server service https port |
| argocd.server.service.servicePortHttpName | string | `"http"` | Server service http port name, can be used to route traffic via istio |
| argocd.server.service.servicePortHttpsName | string | `"https"` | Server service https port name, can be used to route traffic via istio |
| argocd.server.service.servicePortHttpsAppProtocol | string | `""` | Server service https port appProtocol # Ref: https://kubernetes.io/docs/concepts/services-networking/service/#application-protocol |
| argocd.server.service.loadBalancerClass | string | `""` | The class of the load balancer implementation |
| argocd.server.service.loadBalancerIP | string | `""` | LoadBalancer will get created with the IP specified in this field |
| argocd.server.service.loadBalancerSourceRanges | list | `[]` | Source IP ranges to allow access to service from # EKS Ref: https://repost.aws/knowledge-center/eks-cidr-ip-address-loadbalancer # GKE Ref: https://cloud.google.com/kubernetes-engine/docs/concepts/network-overview#limit-connectivity-ext-lb |
| argocd.server.service.externalIPs | list | `[]` | Server service external IPs |
| argocd.server.service.externalTrafficPolicy | string | `"Cluster"` | Denotes if this Service desires to route external traffic to node-local or cluster-wide endpoints # Ref: https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip |
| argocd.server.service.sessionAffinity | string | `"None"` | Used to maintain session affinity. Supports `ClientIP` and `None` # Ref: https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies |
| argocd.server.metrics.enabled | bool | `false` | Deploy metrics service |
| argocd.server.metrics.service.type | string | `"ClusterIP"` | Metrics service type |
| argocd.server.metrics.service.clusterIP | string | `""` | Metrics service clusterIP. `None` makes a "headless service" (no virtual IP) |
| argocd.server.metrics.service.annotations | object | `{}` | Metrics service annotations |
| argocd.server.metrics.service.labels | object | `{}` | Metrics service labels |
| argocd.server.metrics.service.servicePort | int | `8083` | Metrics service port |
| argocd.server.metrics.service.portName | string | `"http-metrics"` | Metrics service port name |
| argocd.server.metrics.serviceMonitor.enabled | bool | `false` | Enable a prometheus ServiceMonitor |
| argocd.server.metrics.serviceMonitor.interval | string | `"30s"` | Prometheus ServiceMonitor interval |
| argocd.server.metrics.serviceMonitor.scrapeTimeout | string | `""` | Prometheus ServiceMonitor scrapeTimeout. If empty, Prometheus uses the global scrape timeout unless it is less than the target's scrape interval value in which the latter is used. |
| argocd.server.metrics.serviceMonitor.honorLabels | bool | `false` | When true, honorLabels preserves the metric’s labels when they collide with the target’s labels. |
| argocd.server.metrics.serviceMonitor.relabelings | list | `[]` | Prometheus [RelabelConfigs] to apply to samples before scraping |
| argocd.server.metrics.serviceMonitor.metricRelabelings | list | `[]` | Prometheus [MetricRelabelConfigs] to apply to samples before ingestion |
| argocd.server.metrics.serviceMonitor.selector | object | `{}` | Prometheus ServiceMonitor selector |
| argocd.server.metrics.serviceMonitor.scheme | string | `""` | Prometheus ServiceMonitor scheme |
| argocd.server.metrics.serviceMonitor.tlsConfig | object | `{}` | Prometheus ServiceMonitor tlsConfig |
| argocd.server.metrics.serviceMonitor.namespace | string | `""` | Prometheus ServiceMonitor namespace |
| argocd.server.metrics.serviceMonitor.additionalLabels | object | `{}` | Prometheus ServiceMonitor labels |
| argocd.server.metrics.serviceMonitor.annotations | object | `{}` | Prometheus ServiceMonitor annotations |
| argocd.server.automountServiceAccountToken | bool | `true` | Automount API credentials for the Service Account into the pod. |
| argocd.server.serviceAccount.create | bool | `true` | Create server service account |
| argocd.server.serviceAccount.name | string | `"argocd-server"` | Server service account name |
| argocd.server.serviceAccount.annotations | object | `{}` | Annotations applied to created service account |
| argocd.server.serviceAccount.labels | object | `{}` | Labels applied to created service account |
| argocd.server.serviceAccount.automountServiceAccountToken | bool | `true` | Automount API credentials for the Service Account |
| argocd.server.ingress.enabled | bool | `false` | Enable an ingress resource for the Argo CD server |
| argocd.server.ingress.controller | string | `"generic"` | Specific implementation for ingress controller. One of `generic`, `aws` or `gke` # Additional configuration might be required in related configuration sections |
| argocd.server.ingress.labels | object | `{}` | Additional ingress labels |
| argocd.server.ingress.annotations | object | `{}` | Additional ingress annotations # Ref: https://argo-cd.readthedocs.io/en/stable/operator-manual/ingress/#option-1-ssl-passthrough |
| argocd.server.ingress.ingressClassName | string | `""` | Defines which ingress controller will implement the resource |
| argocd.server.ingress.hostname | string | `""` (defaults to global.domain) | Argo CD server hostname |
| argocd.server.ingress.path | string | `"/"` | The path to Argo CD server |
| argocd.server.ingress.pathType | string | `"Prefix"` | Ingress path type. One of `Exact`, `Prefix` or `ImplementationSpecific` |
| argocd.server.ingress.tls | bool | `false` | Enable TLS configuration for the hostname defined at `server.ingress.hostname` # TLS certificate will be retrieved from a TLS secret `argocd-server-tls` # You can create this secret via `certificate` or `certificateSecret` option |
| argocd.server.ingress.extraHosts | list | `[]` (See [values.yaml]) | The list of additional hostnames to be covered by ingress record |
| argocd.server.ingress.extraPaths | list | `[]` (See [values.yaml]) | Additional ingress paths # Note: Supports use of custom Helm templates |
| argocd.server.ingress.extraRules | list | `[]` (See [values.yaml]) | Additional ingress rules # Note: Supports use of custom Helm templates |
| argocd.server.ingress.extraTls | list | `[]` (See [values.yaml]) | Additional TLS configuration |
| argocd.server.ingress.aws.backendProtocolVersion | string | `"GRPC"` | Backend protocol version for the AWS ALB gRPC service # This tells AWS to send traffic from the ALB using gRPC. # For more information: https://docs.aws.amazon.com/elasticloadbalancing/latest/application/target-group-health-checks.html#health-check-settings |
| argocd.server.ingress.aws.serviceType | string | `"NodePort"` | Service type for the AWS ALB gRPC service # Can be of type NodePort or ClusterIP depending on which mode you are running. # Instance mode needs type NodePort, IP mode needs type ClusterIP # Ref: https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.2/how-it-works/#ingress-traffic |
| argocd.server.ingress.gke.backendConfig | object | `{}` (See [values.yaml]) | Google [BackendConfig] resource, for use with the GKE Ingress Controller # Ref: https://cloud.google.com/kubernetes-engine/docs/how-to/ingress-features#configuring_ingress_features_through_frontendconfig_parameters |
| argocd.server.ingress.gke.frontendConfig | object | `{}` (See [values.yaml]) | Google [FrontendConfig] resource, for use with the GKE Ingress Controller # Ref: https://cloud.google.com/kubernetes-engine/docs/how-to/ingress-features#configuring_ingress_features_through_frontendconfig_parameters |
| argocd.server.ingress.gke.managedCertificate.create | bool | `true` | Create ManagedCertificate resource and annotations for Google Load balancer # Ref: https://cloud.google.com/kubernetes-engine/docs/how-to/managed-certs |
| argocd.server.ingress.gke.managedCertificate.extraDomains | list | `[]` | Additional domains for ManagedCertificate resource |
| argocd.server.ingressGrpc.enabled | bool | `false` | Enable an ingress resource for the Argo CD server for dedicated [gRPC-ingress] |
| argocd.server.ingressGrpc.annotations | object | `{}` | Additional ingress annotations for dedicated [gRPC-ingress] |
| argocd.server.ingressGrpc.labels | object | `{}` | Additional ingress labels for dedicated [gRPC-ingress] |
| argocd.server.ingressGrpc.ingressClassName | string | `""` | Defines which ingress controller will implement the resource [gRPC-ingress] |
| argocd.server.ingressGrpc.hostname | string | `""` (defaults to grpc.`server.ingress.hostname`) | Argo CD server hostname for dedicated [gRPC-ingress] |
| argocd.server.ingressGrpc.path | string | `"/"` | Argo CD server ingress path for dedicated [gRPC-ingress] |
| argocd.server.ingressGrpc.pathType | string | `"Prefix"` | Ingress path type for dedicated [gRPC-ingress]. One of `Exact`, `Prefix` or `ImplementationSpecific` |
| argocd.server.ingressGrpc.tls | bool | `false` | Enable TLS configuration for the hostname defined at `server.ingressGrpc.hostname` # TLS certificate will be retrieved from a TLS secret with name: `argocd-server-grpc-tls` |
| argocd.server.ingressGrpc.extraHosts | list | `[]` (See [values.yaml]) | The list of additional hostnames to be covered by ingress record |
| argocd.server.ingressGrpc.extraPaths | list | `[]` (See [values.yaml]) | Additional ingress paths for dedicated [gRPC-ingress] # Note: Supports use of custom Helm templates |
| argocd.server.ingressGrpc.extraRules | list | `[]` (See [values.yaml]) | Additional ingress rules # Note: Supports use of custom Helm templates |
| argocd.server.ingressGrpc.extraTls | list | `[]` (See [values.yaml]) | Additional TLS configuration for dedicated [gRPC-ingress] |
| argocd.server.route.enabled | bool | `false` | Enable an OpenShift Route for the Argo CD server |
| argocd.server.route.annotations | object | `{}` | Openshift Route annotations |
| argocd.server.route.hostname | string | `""` | Hostname of OpenShift Route |
| argocd.server.route.termination_type | string | `"passthrough"` | Termination type of Openshift Route |
| argocd.server.route.termination_policy | string | `"None"` | Termination policy of Openshift Route |
| argocd.server.clusterRoleRules.enabled | bool | `false` | Enable custom rules for the server's ClusterRole resource |
| argocd.server.clusterRoleRules.rules | list | `[]` | List of custom rules for the server's ClusterRole resource |
| argocd.repoServer.name | string | `"repo-server"` | Repo server name |
| argocd.repoServer.replicas | int | `1` | The number of repo server pods to run |
| argocd.repoServer.runtimeClassName | string | `""` (defaults to global.runtimeClassName) | Runtime class name for the repo server |
| argocd.repoServer.autoscaling.enabled | bool | `false` | Enable Horizontal Pod Autoscaler ([HPA]) for the repo server |
| argocd.repoServer.autoscaling.minReplicas | int | `1` | Minimum number of replicas for the repo server [HPA] |
| argocd.repoServer.autoscaling.maxReplicas | int | `5` | Maximum number of replicas for the repo server [HPA] |
| argocd.repoServer.autoscaling.targetCPUUtilizationPercentage | int | `50` | Average CPU utilization percentage for the repo server [HPA] |
| argocd.repoServer.autoscaling.targetMemoryUtilizationPercentage | int | `50` | Average memory utilization percentage for the repo server [HPA] |
| argocd.repoServer.autoscaling.behavior | object | `{}` | Configures the scaling behavior of the target in both Up and Down directions. |
| argocd.repoServer.autoscaling.metrics | list | `[]` | Configures custom HPA metrics for the Argo CD repo server Ref: https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/ |
| argocd.repoServer.pdb.enabled | bool | `false` | Deploy a [PodDisruptionBudget] for the repo server |
| argocd.repoServer.pdb.labels | object | `{}` | Labels to be added to repo server pdb |
| argocd.repoServer.pdb.annotations | object | `{}` | Annotations to be added to repo server pdb |
| argocd.repoServer.pdb.minAvailable | string | `""` (defaults to 0 if not specified) | Number of pods that are available after eviction as number or percentage (eg.: 50%) |
| argocd.repoServer.pdb.maxUnavailable | string | `""` | Number of pods that are unavailable after eviction as number or percentage (eg.: 50%). # Has higher precedence over `repoServer.pdb.minAvailable` |
| argocd.repoServer.image.repository | string | `""` (defaults to global.image.repository) | Repository to use for the repo server |
| argocd.repoServer.image.tag | string | `""` (defaults to global.image.tag) | Tag to use for the repo server |
| argocd.repoServer.image.imagePullPolicy | string | `""` (defaults to global.image.imagePullPolicy) | Image pull policy for the repo server |
| argocd.repoServer.imagePullSecrets | list | `[]` (defaults to global.imagePullSecrets) | Secrets with credentials to pull images from a private registry |
| argocd.repoServer.extraArgs | list | `[]` | Additional command line arguments to pass to repo server |
| argocd.repoServer.env | list | `[]` | Environment variables to pass to repo server |
| argocd.repoServer.envFrom | list | `[]` (See [values.yaml]) | envFrom to pass to repo server |
| argocd.repoServer.lifecycle | object | `{}` | Specify postStart and preStop lifecycle hooks for your argo-repo-server container |
| argocd.repoServer.extraContainers | list | `[]` | Additional containers to be added to the repo server pod # Ref: https://argo-cd.readthedocs.io/en/stable/user-guide/config-management-plugins/ # Note: Supports use of custom Helm templates |
| argocd.repoServer.initContainers | list | `[]` | Init containers to add to the repo server pods |
| argocd.repoServer.volumeMounts | list | `[]` | Additional volumeMounts to the repo server main container |
| argocd.repoServer.volumes | list | `[]` | Additional volumes to the repo server pod |
| argocd.repoServer.existingVolumes | object | `{}` | Volumes to be used in replacement of emptydir on default volumes |
| argocd.repoServer.emptyDir.sizeLimit | string | `""` (defaults not set if not specified i.e. no size limit) | EmptyDir size limit for repo server |
| argocd.repoServer.useEphemeralHelmWorkingDir | bool | `true` | Toggle the usage of a ephemeral Helm working directory |
| argocd.repoServer.deploymentAnnotations | object | `{}` | Annotations to be added to repo server Deployment |
| argocd.repoServer.podAnnotations | object | `{}` | Annotations to be added to repo server pods |
| argocd.repoServer.podLabels | object | `{}` | Labels to be added to repo server pods |
| argocd.repoServer.resources | object | `{}` | Resource limits and requests for the repo server pods |
| argocd.repoServer.containerPorts.server | int | `8081` | Repo server container port |
| argocd.repoServer.containerPorts.metrics | int | `8084` | Metrics container port |
| argocd.repoServer.hostNetwork | bool | `false` | Host Network for Repo server pods |
| argocd.repoServer.dnsConfig | object | `{}` | [DNS configuration] |
| argocd.repoServer.dnsPolicy | string | `"ClusterFirst"` | Alternative DNS policy for Repo server pods |
| argocd.repoServer.containerSecurityContext | object | See [values.yaml] | Repo server container-level security context |
| argocd.repoServer.readinessProbe.failureThreshold | int | `3` | Minimum consecutive failures for the [probe] to be considered failed after having succeeded |
| argocd.repoServer.readinessProbe.initialDelaySeconds | int | `10` | Number of seconds after the container has started before [probe] is initiated |
| argocd.repoServer.readinessProbe.periodSeconds | int | `10` | How often (in seconds) to perform the [probe] |
| argocd.repoServer.readinessProbe.successThreshold | int | `1` | Minimum consecutive successes for the [probe] to be considered successful after having failed |
| argocd.repoServer.readinessProbe.timeoutSeconds | int | `1` | Number of seconds after which the [probe] times out |
| argocd.repoServer.livenessProbe.failureThreshold | int | `3` | Minimum consecutive failures for the [probe] to be considered failed after having succeeded |
| argocd.repoServer.livenessProbe.initialDelaySeconds | int | `10` | Number of seconds after the container has started before [probe] is initiated |
| argocd.repoServer.livenessProbe.periodSeconds | int | `10` | How often (in seconds) to perform the [probe] |
| argocd.repoServer.livenessProbe.successThreshold | int | `1` | Minimum consecutive successes for the [probe] to be considered successful after having failed |
| argocd.repoServer.livenessProbe.timeoutSeconds | int | `1` | Number of seconds after which the [probe] times out |
| argocd.repoServer.terminationGracePeriodSeconds | int | `30` | terminationGracePeriodSeconds for container lifecycle hook |
| argocd.repoServer.nodeSelector | object | `{}` (defaults to global.nodeSelector) | [Node selector] |
| argocd.repoServer.tolerations | list | `[]` (defaults to global.tolerations) | [Tolerations] for use with node taints |
| argocd.repoServer.affinity | object | `{}` (defaults to global.affinity preset) | Assign custom [affinity] rules to the deployment |
| argocd.repoServer.topologySpreadConstraints | list | `[]` (defaults to global.topologySpreadConstraints) | Assign custom [TopologySpreadConstraints] rules to the repo server # Ref: https://kubernetes.io/docs/concepts/scheduling-eviction/topology-spread-constraints/ # If labelSelector is left out, it will default to the labelSelector configuration of the deployment |
| argocd.repoServer.deploymentStrategy | object | `{}` | Deployment strategy to be added to the repo server Deployment |
| argocd.repoServer.priorityClassName | string | `""` (defaults to global.priorityClassName) | Priority class for the repo server pods |
| argocd.repoServer.certificateSecret.enabled | bool | `false` | Create argocd-repo-server-tls secret |
| argocd.repoServer.certificateSecret.annotations | object | `{}` | Annotations to be added to argocd-repo-server-tls secret |
| argocd.repoServer.certificateSecret.labels | object | `{}` | Labels to be added to argocd-repo-server-tls secret |
| argocd.repoServer.certificateSecret.ca | string | `""` | Certificate authority. Required for self-signed certificates. |
| argocd.repoServer.certificateSecret.key | string | `""` | Certificate private key |
| argocd.repoServer.certificateSecret.crt | string | `""` | Certificate data. Must contain SANs of Repo service (ie: argocd-repo-server, argocd-repo-server.argo-cd.svc) |
| argocd.repoServer.service.annotations | object | `{}` | Repo server service annotations |
| argocd.repoServer.service.labels | object | `{}` | Repo server service labels |
| argocd.repoServer.service.port | int | `8081` | Repo server service port |
| argocd.repoServer.service.portName | string | `"tcp-repo-server"` | Repo server service port name |
| argocd.repoServer.metrics.enabled | bool | `false` | Deploy metrics service |
| argocd.repoServer.metrics.service.type | string | `"ClusterIP"` | Metrics service type |
| argocd.repoServer.metrics.service.clusterIP | string | `""` | Metrics service clusterIP. `None` makes a "headless service" (no virtual IP) |
| argocd.repoServer.metrics.service.annotations | object | `{}` | Metrics service annotations |
| argocd.repoServer.metrics.service.labels | object | `{}` | Metrics service labels |
| argocd.repoServer.metrics.service.servicePort | int | `8084` | Metrics service port |
| argocd.repoServer.metrics.service.portName | string | `"http-metrics"` | Metrics service port name |
| argocd.repoServer.metrics.serviceMonitor.enabled | bool | `false` | Enable a prometheus ServiceMonitor |
| argocd.repoServer.metrics.serviceMonitor.interval | string | `"30s"` | Prometheus ServiceMonitor interval |
| argocd.repoServer.metrics.serviceMonitor.scrapeTimeout | string | `""` | Prometheus ServiceMonitor scrapeTimeout. If empty, Prometheus uses the global scrape timeout unless it is less than the target's scrape interval value in which the latter is used. |
| argocd.repoServer.metrics.serviceMonitor.honorLabels | bool | `false` | When true, honorLabels preserves the metric’s labels when they collide with the target’s labels. |
| argocd.repoServer.metrics.serviceMonitor.relabelings | list | `[]` | Prometheus [RelabelConfigs] to apply to samples before scraping |
| argocd.repoServer.metrics.serviceMonitor.metricRelabelings | list | `[]` | Prometheus [MetricRelabelConfigs] to apply to samples before ingestion |
| argocd.repoServer.metrics.serviceMonitor.selector | object | `{}` | Prometheus ServiceMonitor selector |
| argocd.repoServer.metrics.serviceMonitor.scheme | string | `""` | Prometheus ServiceMonitor scheme |
| argocd.repoServer.metrics.serviceMonitor.tlsConfig | object | `{}` | Prometheus ServiceMonitor tlsConfig |
| argocd.repoServer.metrics.serviceMonitor.namespace | string | `""` | Prometheus ServiceMonitor namespace |
| argocd.repoServer.metrics.serviceMonitor.additionalLabels | object | `{}` | Prometheus ServiceMonitor labels |
| argocd.repoServer.metrics.serviceMonitor.annotations | object | `{}` | Prometheus ServiceMonitor annotations |
| argocd.repoServer.clusterRoleRules.enabled | bool | `false` | Enable custom rules for the Repo server's Cluster Role resource |
| argocd.repoServer.clusterRoleRules.rules | list | `[]` | List of custom rules for the Repo server's Cluster Role resource |
| argocd.repoServer.automountServiceAccountToken | bool | `true` | Automount API credentials for the Service Account into the pod. |
| argocd.repoServer.serviceAccount.create | bool | `true` | Create repo server service account |
| argocd.repoServer.serviceAccount.name | string | `""` | Repo server service account name |
| argocd.repoServer.serviceAccount.annotations | object | `{}` | Annotations applied to created service account |
| argocd.repoServer.serviceAccount.labels | object | `{}` | Labels applied to created service account |
| argocd.repoServer.serviceAccount.automountServiceAccountToken | bool | `true` | Automount API credentials for the Service Account |
| argocd.repoServer.rbac | list | `[]` | Repo server rbac rules |
| argocd.applicationSet.name | string | `"applicationset-controller"` | ApplicationSet controller name string |
| argocd.applicationSet.replicas | int | `1` | The number of ApplicationSet controller pods to run |
| argocd.applicationSet.runtimeClassName | string | `""` (defaults to global.runtimeClassName) | Runtime class name for the ApplicationSet controller |
| argocd.applicationSet.pdb.enabled | bool | `false` | Deploy a [PodDisruptionBudget] for the ApplicationSet controller |
| argocd.applicationSet.pdb.labels | object | `{}` | Labels to be added to ApplicationSet controller pdb |
| argocd.applicationSet.pdb.annotations | object | `{}` | Annotations to be added to ApplicationSet controller pdb |
| argocd.applicationSet.pdb.minAvailable | string | `""` (defaults to 0 if not specified) | Number of pods that are available after eviction as number or percentage (eg.: 50%) |
| argocd.applicationSet.pdb.maxUnavailable | string | `""` | Number of pods that are unavailable after eviction as number or percentage (eg.: 50%). # Has higher precedence over `applicationSet.pdb.minAvailable` |
| argocd.applicationSet.image.repository | string | `""` (defaults to global.image.repository) | Repository to use for the ApplicationSet controller |
| argocd.applicationSet.image.tag | string | `""` (defaults to global.image.tag) | Tag to use for the ApplicationSet controller |
| argocd.applicationSet.image.imagePullPolicy | string | `""` (defaults to global.image.imagePullPolicy) | Image pull policy for the ApplicationSet controller |
| argocd.applicationSet.imagePullSecrets | list | `[]` (defaults to global.imagePullSecrets) | If defined, uses a Secret to pull an image from a private Docker registry or repository. |
| argocd.applicationSet.extraArgs | list | `[]` | ApplicationSet controller command line flags |
| argocd.applicationSet.extraEnv | list | `[]` | Environment variables to pass to the ApplicationSet controller |
| argocd.applicationSet.extraEnvFrom | list | `[]` (See [values.yaml]) | envFrom to pass to the ApplicationSet controller |
| argocd.applicationSet.extraContainers | list | `[]` | Additional containers to be added to the ApplicationSet controller pod # Note: Supports use of custom Helm templates |
| argocd.applicationSet.initContainers | list | `[]` | Init containers to add to the ApplicationSet controller pod # Note: Supports use of custom Helm templates |
| argocd.applicationSet.extraVolumeMounts | list | `[]` | List of extra mounts to add (normally used with extraVolumes) |
| argocd.applicationSet.extraVolumes | list | `[]` | List of extra volumes to add |
| argocd.applicationSet.emptyDir.sizeLimit | string | `""` (defaults not set if not specified i.e. no size limit) | EmptyDir size limit for applicationSet controller |
| argocd.applicationSet.metrics.enabled | bool | `false` | Deploy metrics service |
| argocd.applicationSet.metrics.service.type | string | `"ClusterIP"` | Metrics service type |
| argocd.applicationSet.metrics.service.clusterIP | string | `""` | Metrics service clusterIP. `None` makes a "headless service" (no virtual IP) |
| argocd.applicationSet.metrics.service.annotations | object | `{}` | Metrics service annotations |
| argocd.applicationSet.metrics.service.labels | object | `{}` | Metrics service labels |
| argocd.applicationSet.metrics.service.servicePort | int | `8080` | Metrics service port |
| argocd.applicationSet.metrics.service.portName | string | `"http-metrics"` | Metrics service port name |
| argocd.applicationSet.metrics.serviceMonitor.enabled | bool | `false` | Enable a prometheus ServiceMonitor |
| argocd.applicationSet.metrics.serviceMonitor.interval | string | `"30s"` | Prometheus ServiceMonitor interval |
| argocd.applicationSet.metrics.serviceMonitor.scrapeTimeout | string | `""` | Prometheus ServiceMonitor scrapeTimeout. If empty, Prometheus uses the global scrape timeout unless it is less than the target's scrape interval value in which the latter is used. |
| argocd.applicationSet.metrics.serviceMonitor.honorLabels | bool | `false` | When true, honorLabels preserves the metric’s labels when they collide with the target’s labels. |
| argocd.applicationSet.metrics.serviceMonitor.relabelings | list | `[]` | Prometheus [RelabelConfigs] to apply to samples before scraping |
| argocd.applicationSet.metrics.serviceMonitor.metricRelabelings | list | `[]` | Prometheus [MetricRelabelConfigs] to apply to samples before ingestion |
| argocd.applicationSet.metrics.serviceMonitor.selector | object | `{}` | Prometheus ServiceMonitor selector |
| argocd.applicationSet.metrics.serviceMonitor.scheme | string | `""` | Prometheus ServiceMonitor scheme |
| argocd.applicationSet.metrics.serviceMonitor.tlsConfig | object | `{}` | Prometheus ServiceMonitor tlsConfig |
| argocd.applicationSet.metrics.serviceMonitor.namespace | string | `""` | Prometheus ServiceMonitor namespace |
| argocd.applicationSet.metrics.serviceMonitor.additionalLabels | object | `{}` | Prometheus ServiceMonitor labels |
| argocd.applicationSet.metrics.serviceMonitor.annotations | object | `{}` | Prometheus ServiceMonitor annotations |
| argocd.applicationSet.service.annotations | object | `{}` | ApplicationSet service annotations |
| argocd.applicationSet.service.labels | object | `{}` | ApplicationSet service labels |
| argocd.applicationSet.service.type | string | `"ClusterIP"` | ApplicationSet service type |
| argocd.applicationSet.service.port | int | `7000` | ApplicationSet service port |
| argocd.applicationSet.service.portName | string | `"http-webhook"` | ApplicationSet service port name |
| argocd.applicationSet.automountServiceAccountToken | bool | `true` | Automount API credentials for the Service Account into the pod. |
| argocd.applicationSet.serviceAccount.create | bool | `true` | Create ApplicationSet controller service account |
| argocd.applicationSet.serviceAccount.name | string | `"argocd-applicationset-controller"` | ApplicationSet controller service account name |
| argocd.applicationSet.serviceAccount.annotations | object | `{}` | Annotations applied to created service account |
| argocd.applicationSet.serviceAccount.labels | object | `{}` | Labels applied to created service account |
| argocd.applicationSet.serviceAccount.automountServiceAccountToken | bool | `true` | Automount API credentials for the Service Account |
| argocd.applicationSet.deploymentAnnotations | object | `{}` | Annotations to be added to ApplicationSet controller Deployment |
| argocd.applicationSet.podAnnotations | object | `{}` | Annotations for the ApplicationSet controller pods |
| argocd.applicationSet.podLabels | object | `{}` | Labels for the ApplicationSet controller pods |
| argocd.applicationSet.resources | object | `{}` | Resource limits and requests for the ApplicationSet controller pods. |
| argocd.applicationSet.containerPorts.metrics | int | `8080` | Metrics container port |
| argocd.applicationSet.containerPorts.probe | int | `8081` | Probe container port |
| argocd.applicationSet.containerPorts.webhook | int | `7000` | Webhook container port |
| argocd.applicationSet.dnsConfig | object | `{}` | [DNS configuration] |
| argocd.applicationSet.dnsPolicy | string | `"ClusterFirst"` | Alternative DNS policy for ApplicationSet controller pods |
| argocd.applicationSet.containerSecurityContext | object | See [values.yaml] | ApplicationSet controller container-level security context |
| argocd.applicationSet.readinessProbe.enabled | bool | `false` | Enable Kubernetes liveness probe for ApplicationSet controller |
| argocd.applicationSet.readinessProbe.initialDelaySeconds | int | `10` | Number of seconds after the container has started before [probe] is initiated |
| argocd.applicationSet.readinessProbe.periodSeconds | int | `10` | How often (in seconds) to perform the [probe] |
| argocd.applicationSet.readinessProbe.timeoutSeconds | int | `1` | Number of seconds after which the [probe] times out |
| argocd.applicationSet.readinessProbe.successThreshold | int | `1` | Minimum consecutive successes for the [probe] to be considered successful after having failed |
| argocd.applicationSet.readinessProbe.failureThreshold | int | `3` | Minimum consecutive failures for the [probe] to be considered failed after having succeeded |
| argocd.applicationSet.livenessProbe.enabled | bool | `false` | Enable Kubernetes liveness probe for ApplicationSet controller |
| argocd.applicationSet.livenessProbe.initialDelaySeconds | int | `10` | Number of seconds after the container has started before [probe] is initiated |
| argocd.applicationSet.livenessProbe.periodSeconds | int | `10` | How often (in seconds) to perform the [probe] |
| argocd.applicationSet.livenessProbe.timeoutSeconds | int | `1` | Number of seconds after which the [probe] times out |
| argocd.applicationSet.livenessProbe.successThreshold | int | `1` | Minimum consecutive successes for the [probe] to be considered successful after having failed |
| argocd.applicationSet.livenessProbe.failureThreshold | int | `3` | Minimum consecutive failures for the [probe] to be considered failed after having succeeded |
| argocd.applicationSet.terminationGracePeriodSeconds | int | `30` | terminationGracePeriodSeconds for container lifecycle hook |
| argocd.applicationSet.nodeSelector | object | `{}` (defaults to global.nodeSelector) | [Node selector] |
| argocd.applicationSet.tolerations | list | `[]` (defaults to global.tolerations) | [Tolerations] for use with node taints |
| argocd.applicationSet.affinity | object | `{}` (defaults to global.affinity preset) | Assign custom [affinity] rules |
| argocd.applicationSet.topologySpreadConstraints | list | `[]` (defaults to global.topologySpreadConstraints) | Assign custom [TopologySpreadConstraints] rules to the ApplicationSet controller # Ref: https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/ # If labelSelector is left out, it will default to the labelSelector configuration of the deployment |
| argocd.applicationSet.deploymentStrategy | object | `{}` | Deployment strategy to be added to the ApplicationSet controller Deployment |
| argocd.applicationSet.priorityClassName | string | `""` (defaults to global.priorityClassName) | Priority class for the ApplicationSet controller pods |
| argocd.applicationSet.certificate.enabled | bool | `false` | Deploy a Certificate resource (requires cert-manager) |
| argocd.applicationSet.certificate.domain | string | `""` (defaults to global.domain) | Certificate primary domain (commonName) |
| argocd.applicationSet.certificate.additionalHosts | list | `[]` | Certificate Subject Alternate Names (SANs) |
| argocd.applicationSet.certificate.duration | string | `""` (defaults to 2160h = 90d if not specified) | The requested 'duration' (i.e. lifetime) of the certificate. # Ref: https://cert-manager.io/docs/usage/certificate/#renewal |
| argocd.applicationSet.certificate.renewBefore | string | `""` (defaults to 360h = 15d if not specified) | How long before the expiry a certificate should be renewed. # Ref: https://cert-manager.io/docs/usage/certificate/#renewal |
| argocd.applicationSet.certificate.issuer.group | string | `""` | Certificate issuer group. Set if using an external issuer. Eg. `cert-manager.io` |
| argocd.applicationSet.certificate.issuer.kind | string | `""` | Certificate issuer kind. Either `Issuer` or `ClusterIssuer` |
| argocd.applicationSet.certificate.issuer.name | string | `""` | Certificate issuer name. Eg. `letsencrypt` |
| argocd.applicationSet.certificate.privateKey.rotationPolicy | string | `"Never"` | Rotation policy of private key when certificate is re-issued. Either: `Never` or `Always` |
| argocd.applicationSet.certificate.privateKey.encoding | string | `"PKCS1"` | The private key cryptography standards (PKCS) encoding for private key. Either: `PCKS1` or `PKCS8` |
| argocd.applicationSet.certificate.privateKey.algorithm | string | `"RSA"` | Algorithm used to generate certificate private key. One of: `RSA`, `Ed25519` or `ECDSA` |
| argocd.applicationSet.certificate.privateKey.size | int | `2048` | Key bit size of the private key. If algorithm is set to `Ed25519`, size is ignored. |
| argocd.applicationSet.certificate.annotations | object | `{}` | Annotations to be applied to the ApplicationSet Certificate |
| argocd.applicationSet.ingress.enabled | bool | `false` | Enable an ingress resource for ApplicationSet webhook |
| argocd.applicationSet.ingress.labels | object | `{}` | Additional ingress labels |
| argocd.applicationSet.ingress.annotations | object | `{}` | Additional ingress annotations |
| argocd.applicationSet.ingress.ingressClassName | string | `""` | Defines which ingress ApplicationSet controller will implement the resource |
| argocd.applicationSet.ingress.hostname | string | `""` (defaults to global.domain) | Argo CD ApplicationSet hostname |
| argocd.applicationSet.ingress.path | string | `"/api/webhook"` | List of ingress paths |
| argocd.applicationSet.ingress.pathType | string | `"Prefix"` | Ingress path type. One of `Exact`, `Prefix` or `ImplementationSpecific` |
| argocd.applicationSet.ingress.tls | bool | `false` | Enable TLS configuration for the hostname defined at `applicationSet.webhook.ingress.hostname` # TLS certificate will be retrieved from a TLS secret with name:`argocd-applicationset-controller-tls` |
| argocd.applicationSet.ingress.extraHosts | list | `[]` (See [values.yaml]) | The list of additional hostnames to be covered by ingress record |
| argocd.applicationSet.ingress.extraPaths | list | `[]` (See [values.yaml]) | Additional ingress paths |
| argocd.applicationSet.ingress.extraRules | list | `[]` (See [values.yaml]) | Additional ingress rules # Note: Supports use of custom Helm templates |
| argocd.applicationSet.ingress.extraTls | list | `[]` (See [values.yaml]) | Additional ingress TLS configuration |
| argocd.applicationSet.allowAnyNamespace | bool | `false` | Enable ApplicationSet in any namespace feature |
| argocd.notifications.enabled | bool | `true` | Enable notifications controller |
| argocd.notifications.name | string | `"notifications-controller"` | Notifications controller name string |
| argocd.notifications.argocdUrl | string | `""` (defaults to https://`global.domain`) | Argo CD dashboard url; used in place of {{.context.argocdUrl}} in templates |
| argocd.notifications.runtimeClassName | string | `""` (defaults to global.runtimeClassName) | Runtime class name for the notifications controller |
| argocd.notifications.pdb.enabled | bool | `false` | Deploy a [PodDisruptionBudget] for the notifications controller |
| argocd.notifications.pdb.labels | object | `{}` | Labels to be added to notifications controller pdb |
| argocd.notifications.pdb.annotations | object | `{}` | Annotations to be added to notifications controller pdb |
| argocd.notifications.pdb.minAvailable | string | `""` (defaults to 0 if not specified) | Number of pods that are available after eviction as number or percentage (eg.: 50%) |
| argocd.notifications.pdb.maxUnavailable | string | `""` | Number of pods that are unavailable after eviction as number or percentage (eg.: 50%). # Has higher precedence over `notifications.pdb.minAvailable` |
| argocd.notifications.image.repository | string | `""` (defaults to global.image.repository) | Repository to use for the notifications controller |
| argocd.notifications.image.tag | string | `""` (defaults to global.image.tag) | Tag to use for the notifications controller |
| argocd.notifications.image.imagePullPolicy | string | `""` (defaults to global.image.imagePullPolicy) | Image pull policy for the notifications controller |
| argocd.notifications.imagePullSecrets | list | `[]` (defaults to global.imagePullSecrets) | Secrets with credentials to pull images from a private registry |
| argocd.notifications.logFormat | string | `""` (defaults to global.logging.format) | Notifications controller log format. Either `text` or `json` |
| argocd.notifications.logLevel | string | `""` (defaults to global.logging.level) | Notifications controller log level. One of: `debug`, `info`, `warn`, `error` |
| argocd.notifications.extraArgs | list | `[]` | Extra arguments to provide to the notifications controller |
| argocd.notifications.extraEnv | list | `[]` | Additional container environment variables |
| argocd.notifications.extraEnvFrom | list | `[]` (See [values.yaml]) | envFrom to pass to the notifications controller |
| argocd.notifications.extraContainers | list | `[]` | Additional containers to be added to the notifications controller pod # Note: Supports use of custom Helm templates |
| argocd.notifications.initContainers | list | `[]` | Init containers to add to the notifications controller pod # Note: Supports use of custom Helm templates |
| argocd.notifications.extraVolumeMounts | list | `[]` | List of extra mounts to add (normally used with extraVolumes) |
| argocd.notifications.extraVolumes | list | `[]` | List of extra volumes to add |
| argocd.notifications.context | object | `{}` | Define user-defined context # For more information: https://argo-cd.readthedocs.io/en/stable/operator-manual/notifications/templates/#defining-user-defined-context |
| argocd.notifications.secret.create | bool | `true` | Whether helm chart creates notifications controller secret # If true, will create a secret with the name below. Otherwise, will assume existence of a secret with that name. |
| argocd.notifications.secret.name | string | `"argocd-notifications-secret"` | notifications controller Secret name |
| argocd.notifications.secret.annotations | object | `{}` | key:value pairs of annotations to be added to the secret |
| argocd.notifications.secret.labels | object | `{}` | key:value pairs of labels to be added to the secret |
| argocd.notifications.secret.items | object | `{}` | Generic key:value pairs to be inserted into the secret # Can be used for templates, notification services etc. Some examples given below. # For more information: https://argo-cd.readthedocs.io/en/stable/operator-manual/notifications/services/overview/ |
| argocd.notifications.metrics.enabled | bool | `false` | Enables prometheus metrics server |
| argocd.notifications.metrics.port | int | `9001` | Metrics port |
| argocd.notifications.metrics.service.type | string | `"ClusterIP"` | Metrics service type |
| argocd.notifications.metrics.service.clusterIP | string | `""` | Metrics service clusterIP. `None` makes a "headless service" (no virtual IP) |
| argocd.notifications.metrics.service.annotations | object | `{}` | Metrics service annotations |
| argocd.notifications.metrics.service.labels | object | `{}` | Metrics service labels |
| argocd.notifications.metrics.service.portName | string | `"http-metrics"` | Metrics service port name |
| argocd.notifications.metrics.serviceMonitor.enabled | bool | `false` | Enable a prometheus ServiceMonitor |
| argocd.notifications.metrics.serviceMonitor.selector | object | `{}` | Prometheus ServiceMonitor selector |
| argocd.notifications.metrics.serviceMonitor.additionalLabels | object | `{}` | Prometheus ServiceMonitor labels |
| argocd.notifications.metrics.serviceMonitor.annotations | object | `{}` | Prometheus ServiceMonitor annotations |
| argocd.notifications.metrics.serviceMonitor.scheme | string | `""` | Prometheus ServiceMonitor scheme |
| argocd.notifications.metrics.serviceMonitor.tlsConfig | object | `{}` | Prometheus ServiceMonitor tlsConfig |
| argocd.notifications.metrics.serviceMonitor.honorLabels | bool | `false` | When true, honorLabels preserves the metric’s labels when they collide with the target’s labels. |
| argocd.notifications.metrics.serviceMonitor.relabelings | list | `[]` | Prometheus [RelabelConfigs] to apply to samples before scraping |
| argocd.notifications.metrics.serviceMonitor.metricRelabelings | list | `[]` | Prometheus [MetricRelabelConfigs] to apply to samples before ingestion |
| argocd.notifications.notifiers | object | See [values.yaml] | Configures notification services such as slack, email or custom webhook # For more information: https://argo-cd.readthedocs.io/en/stable/operator-manual/notifications/services/overview/ |
| argocd.notifications.deploymentAnnotations | object | `{}` | Annotations to be applied to the notifications controller Deployment |
| argocd.notifications.podAnnotations | object | `{}` | Annotations to be applied to the notifications controller Pods |
| argocd.notifications.podLabels | object | `{}` | Labels to be applied to the notifications controller Pods |
| argocd.notifications.resources | object | `{}` | Resource limits and requests for the notifications controller |
| argocd.notifications.containerPorts.metrics | int | `9001` | Metrics container port |
| argocd.notifications.dnsConfig | object | `{}` | [DNS configuration] |
| argocd.notifications.dnsPolicy | string | `"ClusterFirst"` | Alternative DNS policy for notifications controller Pods |
| argocd.notifications.containerSecurityContext | object | See [values.yaml] | Notification controller container-level security Context |
| argocd.notifications.readinessProbe.enabled | bool | `false` | Enable Kubernetes liveness probe for notifications controller Pods |
| argocd.notifications.readinessProbe.initialDelaySeconds | int | `10` | Number of seconds after the container has started before [probe] is initiated |
| argocd.notifications.readinessProbe.periodSeconds | int | `10` | How often (in seconds) to perform the [probe] |
| argocd.notifications.readinessProbe.timeoutSeconds | int | `1` | Number of seconds after which the [probe] times out |
| argocd.notifications.readinessProbe.successThreshold | int | `1` | Minimum consecutive successes for the [probe] to be considered successful after having failed |
| argocd.notifications.readinessProbe.failureThreshold | int | `3` | Minimum consecutive failures for the [probe] to be considered failed after having succeeded |
| argocd.notifications.livenessProbe.enabled | bool | `false` | Enable Kubernetes liveness probe for notifications controller Pods |
| argocd.notifications.livenessProbe.initialDelaySeconds | int | `10` | Number of seconds after the container has started before [probe] is initiated |
| argocd.notifications.livenessProbe.periodSeconds | int | `10` | How often (in seconds) to perform the [probe] |
| argocd.notifications.livenessProbe.timeoutSeconds | int | `1` | Number of seconds after which the [probe] times out |
| argocd.notifications.livenessProbe.successThreshold | int | `1` | Minimum consecutive successes for the [probe] to be considered successful after having failed |
| argocd.notifications.livenessProbe.failureThreshold | int | `3` | Minimum consecutive failures for the [probe] to be considered failed after having succeeded |
| argocd.notifications.terminationGracePeriodSeconds | int | `30` | terminationGracePeriodSeconds for container lifecycle hook |
| argocd.notifications.nodeSelector | object | `{}` (defaults to global.nodeSelector) | [Node selector] |
| argocd.notifications.tolerations | list | `[]` (defaults to global.tolerations) | [Tolerations] for use with node taints |
| argocd.notifications.affinity | object | `{}` (defaults to global.affinity preset) | Assign custom [affinity] rules |
| argocd.notifications.topologySpreadConstraints | list | `[]` (defaults to global.topologySpreadConstraints) | Assign custom [TopologySpreadConstraints] rules to the application controller # Ref: https://kubernetes.io/docs/concepts/scheduling-eviction/topology-spread-constraints/ # If labelSelector is left out, it will default to the labelSelector configuration of the deployment |
| argocd.notifications.deploymentStrategy | object | `{"type":"Recreate"}` | Deployment strategy to be added to the notifications controller Deployment |
| argocd.notifications.priorityClassName | string | `""` (defaults to global.priorityClassName) | Priority class for the notifications controller pods |
| argocd.notifications.automountServiceAccountToken | bool | `true` | Automount API credentials for the Service Account into the pod. |
| argocd.notifications.serviceAccount.create | bool | `true` | Create notifications controller service account |
| argocd.notifications.serviceAccount.name | string | `"argocd-notifications-controller"` | Notification controller service account name |
| argocd.notifications.serviceAccount.annotations | object | `{}` | Annotations applied to created service account |
| argocd.notifications.serviceAccount.labels | object | `{}` | Labels applied to created service account |
| argocd.notifications.serviceAccount.automountServiceAccountToken | bool | `true` | Automount API credentials for the Service Account |
| argocd.notifications.cm.create | bool | `true` | Whether helm chart creates notifications controller config map |
| argocd.notifications.clusterRoleRules.rules | list | `[]` | List of custom rules for the notifications controller's ClusterRole resource |
| argocd.notifications.subscriptions | list | `[]` | Contains centrally managed global application subscriptions # For more information: https://argo-cd.readthedocs.io/en/stable/operator-manual/notifications/subscriptions/ |
| argocd.notifications.templates | object | `{}` | The notification template is used to generate the notification content # For more information: https://argo-cd.readthedocs.io/en/stable/operator-manual/notifications/templates/ |
| argocd.notifications.triggers | object | `{}` | The trigger defines the condition when the notification should be sent # For more information: https://argo-cd.readthedocs.io/en/stable/operator-manual/notifications/triggers/ |
| argocd.commitServer.enabled | bool | `false` | Enable commit server |
| argocd.commitServer.name | string | `"commit-server"` | Commit server name |
| argocd.commitServer.runtimeClassName | string | `""` (defaults to global.runtimeClassName) | Runtime class name for the commit server |
| argocd.commitServer.image.repository | string | `""` (defaults to global.image.repository) | Repository to use for the commit server |
| argocd.commitServer.image.tag | string | `""` (defaults to global.image.tag) | Tag to use for the commit server |
| argocd.commitServer.image.imagePullPolicy | string | `""` (defaults to global.image.imagePullPolicy) | Image pull policy for the commit server |
| argocd.commitServer.extraArgs | list | `[]` | commit server command line flags |
| argocd.commitServer.extraEnv | list | `[]` | Environment variables to pass to the commit server |
| argocd.commitServer.extraEnvFrom | list | `[]` (See [values.yaml]) | envFrom to pass to the commit server |
| argocd.commitServer.extraVolumeMounts | list | `[]` | List of extra mounts to add (normally used with extraVolumes) |
| argocd.commitServer.extraVolumes | list | `[]` | List of extra volumes to add |
| argocd.commitServer.metrics.enabled | bool | `false` | Enables prometheus metrics server |
| argocd.commitServer.metrics.service.type | string | `"ClusterIP"` | Metrics service type |
| argocd.commitServer.metrics.service.clusterIP | string | `""` | Metrics service clusterIP. `None` makes a "headless service" (no virtual IP) |
| argocd.commitServer.metrics.service.annotations | object | `{}` | Metrics service annotations |
| argocd.commitServer.metrics.service.labels | object | `{}` | Metrics service labels |
| argocd.commitServer.metrics.service.servicePort | int | `8087` | Metrics service port |
| argocd.commitServer.metrics.service.portName | string | `"metrics"` | Metrics service port name |
| argocd.commitServer.service.annotations | object | `{}` | commit server service annotations |
| argocd.commitServer.service.labels | object | `{}` | commit server service labels |
| argocd.commitServer.automountServiceAccountToken | bool | `false` | Automount API credentials for the Service Account into the pod. |
| argocd.commitServer.serviceAccount.create | bool | `true` | Create commit server service account |
| argocd.commitServer.serviceAccount.name | string | `"argocd-commit-server"` | commit server service account name |
| argocd.commitServer.serviceAccount.annotations | object | `{}` | Annotations applied to created service account |
| argocd.commitServer.serviceAccount.labels | object | `{}` | Labels applied to created service account |
| argocd.commitServer.serviceAccount.automountServiceAccountToken | bool | `true` | Automount API credentials for the Service Account |
| argocd.commitServer.deploymentAnnotations | object | `{}` | Annotations to be added to commit server Deployment |
| argocd.commitServer.podAnnotations | object | `{}` | Annotations for the commit server pods |
| argocd.commitServer.podLabels | object | `{}` | Labels for the commit server pods |
| argocd.commitServer.resources | object | `{}` | Resource limits and requests for the commit server pods. |
| argocd.commitServer.dnsConfig | object | `{}` | [DNS configuration] |
| argocd.commitServer.dnsPolicy | string | `"ClusterFirst"` | Alternative DNS policy for commit server pods |
| argocd.commitServer.containerSecurityContext | object | See [values.yaml] | commit server container-level security context |
| argocd.commitServer.readinessProbe.enabled | bool | `true` | Enable Kubernetes liveness probe for commit server |
| argocd.commitServer.readinessProbe.initialDelaySeconds | int | `5` | Number of seconds after the container has started before [probe] is initiated |
| argocd.commitServer.readinessProbe.periodSeconds | int | `10` | How often (in seconds) to perform the [probe] |
| argocd.commitServer.readinessProbe.timeoutSeconds | int | `1` | Number of seconds after which the [probe] times out |
| argocd.commitServer.readinessProbe.failureThreshold | int | `3` | Minimum consecutive failures for the [probe] to be considered failed after having succeeded |
| argocd.commitServer.livenessProbe.enabled | bool | `true` | Enable Kubernetes liveness probe for commit server |
| argocd.commitServer.livenessProbe.initialDelaySeconds | int | `30` | Number of seconds after the container has started before [probe] is initiated |
| argocd.commitServer.livenessProbe.periodSeconds | int | `30` | How often (in seconds) to perform the [probe] |
| argocd.commitServer.livenessProbe.timeoutSeconds | int | `5` | Number of seconds after which the [probe] times out |
| argocd.commitServer.livenessProbe.failureThreshold | int | `3` | Minimum consecutive failures for the [probe] to be considered failed after having succeeded |
| argocd.commitServer.terminationGracePeriodSeconds | int | `30` | terminationGracePeriodSeconds for container lifecycle hook |
| argocd.commitServer.nodeSelector | object | `{}` (defaults to global.nodeSelector) | [Node selector] |
| argocd.commitServer.tolerations | list | `[]` (defaults to global.tolerations) | [Tolerations] for use with node taints |
| argocd.commitServer.affinity | object | `{}` (defaults to global.affinity preset) | Assign custom [affinity] rules |
| argocd.commitServer.topologySpreadConstraints | list | `[]` (defaults to global.topologySpreadConstraints) | Assign custom [TopologySpreadConstraints] rules to the commit server # Ref: https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/ # If labelSelector is left out, it will default to the labelSelector configuration of the deployment |
| argocd.commitServer.deploymentStrategy | object | `{}` | Deployment strategy to be added to the commit server Deployment |
| argocd.commitServer.priorityClassName | string | `""` (defaults to global.priorityClassName) | Priority class for the commit server pods |

## Installing the Chart

### With Helm

To install the chart with the release name `my-release`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/argocd
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: argocd
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.1"
    chart: argocd
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
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/argocd --config /charts/charts/argocd/ct.yaml
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template argocd . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```

