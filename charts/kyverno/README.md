# kyverno

![Version: 0.1.1](https://img.shields.io/badge/Version-0.1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.13.4](https://img.shields.io/badge/AppVersion-1.13.4-informational?style=flat-square)

## Prerequisites

- Helm v3
- Config Connector installed (v1.6.0)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://kyverno.github.io/kyverno/ | kyverno | 0.1.1 |

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
| prometheus.enabled | bool | `false` | Enables Prometheus Operator monitoring |
| prometheus.rules.enabled | bool | `true` | Enables prometheus operator rules |
| prometheus.rules.labels | object | `{"prometheus":"prometheus-operator-prometheus"}` | Labels to affect to the Prometheus Rules |
| prometheus.grafanaDashboard.enabled | bool | `true` | Add grafana dashboard as a configmap |
| prometheus.grafanaDashboard.label | object | `{"grafana_dashboard":"1"}` | label to apply to the config map. Used by Grafana sidecar to automatically install the dashboard |
| kyverno.global.image.registry | string | `nil` | Global value that allows to set a single image registry across all deployments. When set, it will override any values set under `.image.registry` across the chart. |
| kyverno.global.imagePullSecrets | list | `[]` | Global list of Image pull secrets When set, it will override any values set under `imagePullSecrets` under different components across the chart. |
| kyverno.global.resyncPeriod | string | `"15m"` | Resync period for informers |
| kyverno.global.caCertificates.data | string | `nil` | Global CA certificates to use with Kyverno deployments This value is expected to be one large string of CA certificates Individual controller values will override this global value |
| kyverno.global.caCertificates.volume | object | `{}` | Global value to set single volume to be mounted for CA certificates for all deployments. Not used when `.Values.global.caCertificates.data` is defined Individual  controller values will override this global value |
| kyverno.global.extraEnvVars | list | `[]` | Additional container environment variables to apply to all containers and init containers |
| kyverno.global.nodeSelector | object | `{}` | Global node labels for pod assignment. Non-global values will override the global value. |
| kyverno.global.tolerations | list | `[]` | Global List of node taints to tolerate. Non-global values will override the global value. |
| kyverno.nameOverride | string | `nil` | Override the name of the chart |
| kyverno.fullnameOverride | string | `nil` | Override the expanded name of the chart |
| kyverno.namespaceOverride | string | `nil` | Override the namespace the chart deploys to |
| kyverno.upgrade.fromV2 | bool | `false` | Upgrading from v2 to v3 is not allowed by default, set this to true once changes have been reviewed. |
| kyverno.apiVersionOverride.podDisruptionBudget | string | `nil` | Override api version used to create `PodDisruptionBudget`` resources. When not specified the chart will check if `policy/v1/PodDisruptionBudget` is available to determine the api version automatically. |
| kyverno.crds.install | bool | `true` | Whether to have Helm install the Kyverno CRDs, if the CRDs are not installed by Helm, they must be added before policies can be created |
| kyverno.crds.groups.kyverno | object | `{"cleanuppolicies":true,"clustercleanuppolicies":true,"clusterpolicies":true,"globalcontextentries":true,"policies":true,"policyexceptions":true,"updaterequests":true}` | Install CRDs in group `kyverno.io` |
| kyverno.crds.groups.reports | object | `{"clusterephemeralreports":true,"ephemeralreports":true}` | Install CRDs in group `reports.kyverno.io` |
| kyverno.crds.groups.wgpolicyk8s | object | `{"clusterpolicyreports":true,"policyreports":true}` | Install CRDs in group `wgpolicyk8s.io` |
| kyverno.crds.annotations | object | `{}` | Additional CRDs annotations |
| kyverno.crds.customLabels | object | `{}` | Additional CRDs labels |
| kyverno.crds.migration.enabled | bool | `true` | Enable CRDs migration using helm post upgrade hook |
| kyverno.crds.migration.resources | list | `["cleanuppolicies.kyverno.io","clustercleanuppolicies.kyverno.io","clusterpolicies.kyverno.io","globalcontextentries.kyverno.io","policies.kyverno.io","policyexceptions.kyverno.io","updaterequests.kyverno.io"]` | Resources to migrate |
| kyverno.crds.migration.image.registry | string | `nil` | Image registry |
| kyverno.crds.migration.image.defaultRegistry | string | `"ghcr.io"` |  |
| kyverno.crds.migration.image.repository | string | `"kyverno/kyverno-cli"` | Image repository |
| kyverno.crds.migration.image.tag | string | `nil` | Image tag Defaults to appVersion in Chart.yaml if omitted |
| kyverno.crds.migration.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| kyverno.crds.migration.imagePullSecrets | list | `[]` | Image pull secrets |
| kyverno.crds.migration.podSecurityContext | object | `{}` | Security context for the pod |
| kyverno.crds.migration.nodeSelector | object | `{}` | Node labels for pod assignment |
| kyverno.crds.migration.tolerations | list | `[]` | List of node taints to tolerate |
| kyverno.crds.migration.podAntiAffinity | object | `{}` | Pod anti affinity constraints. |
| kyverno.crds.migration.podAffinity | object | `{}` | Pod affinity constraints. |
| kyverno.crds.migration.podLabels | object | `{}` | Pod labels. |
| kyverno.crds.migration.podAnnotations | object | `{}` | Pod annotations. |
| kyverno.crds.migration.nodeAffinity | object | `{}` | Node affinity constraints. |
| kyverno.crds.migration.securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"privileged":false,"readOnlyRootFilesystem":true,"runAsGroup":65534,"runAsNonRoot":true,"runAsUser":65534,"seccompProfile":{"type":"RuntimeDefault"}}` | Security context for the hook containers |
| kyverno.config.create | bool | `true` | Create the configmap. |
| kyverno.config.preserve | bool | `true` | Preserve the configmap settings during upgrade. |
| kyverno.config.name | string | `nil` | The configmap name (required if `create` is `false`). |
| kyverno.config.annotations | object | `{}` | Additional annotations to add to the configmap. |
| kyverno.config.enableDefaultRegistryMutation | bool | `true` | Enable registry mutation for container images. Enabled by default. |
| kyverno.config.defaultRegistry | string | `"docker.io"` | The registry hostname used for the image mutation. |
| kyverno.config.excludeGroups | list | `["system:nodes"]` | Exclude groups |
| kyverno.config.excludeUsernames | list | `[]` | Exclude usernames |
| kyverno.config.excludeRoles | list | `[]` | Exclude roles |
| kyverno.config.excludeClusterRoles | list | `[]` | Exclude roles |
| kyverno.config.generateSuccessEvents | bool | `false` | Generate success events. |
| kyverno.config.resourceFilters | list | See [values.yaml](values.yaml) | Resource types to be skipped by the Kyverno policy engine. Make sure to surround each entry in quotes so that it doesn't get parsed as a nested YAML list. These are joined together without spaces, run through `tpl`, and the result is set in the config map. |
| kyverno.config.updateRequestThreshold | int | `1000` | Sets the threshold for the total number of UpdateRequests generated for mutateExisitng and generate policies. |
| kyverno.config.webhooks | object | `{"namespaceSelector":{"matchExpressions":[{"key":"kubernetes.io/metadata.name","operator":"NotIn","values":["kube-system"]}]}}` | Defines the `namespaceSelector`/`objectSelector` in the webhook configurations. The Kyverno namespace is excluded if `excludeKyvernoNamespace` is `true` (default) |
| kyverno.config.webhookAnnotations | object | `{"admissions.enforcer/disabled":"true"}` | Defines annotations to set on webhook configurations. |
| kyverno.config.webhookLabels | object | `{}` | Defines labels to set on webhook configurations. |
| kyverno.config.matchConditions | list | `[]` | Defines match conditions to set on webhook configurations (requires Kubernetes 1.27+). |
| kyverno.config.excludeKyvernoNamespace | bool | `true` | Exclude Kyverno namespace Determines if default Kyverno namespace exclusion is enabled for webhooks and resourceFilters |
| kyverno.config.resourceFiltersExcludeNamespaces | list | `[]` | resourceFilter namespace exclude Namespaces to exclude from the default resourceFilters |
| kyverno.config.resourceFiltersExclude | list | `[]` | resourceFilters exclude list Items to exclude from config.resourceFilters |
| kyverno.config.resourceFiltersIncludeNamespaces | list | `[]` | resourceFilter namespace include Namespaces to include to the default resourceFilters |
| kyverno.config.resourceFiltersInclude | list | `[]` | resourceFilters include list Items to include to config.resourceFilters |
| kyverno.metricsConfig.create | bool | `true` | Create the configmap. |
| kyverno.metricsConfig.name | string | `nil` | The configmap name (required if `create` is `false`). |
| kyverno.metricsConfig.annotations | object | `{}` | Additional annotations to add to the configmap. |
| kyverno.metricsConfig.namespaces.include | list | `[]` | List of namespaces to capture metrics for. |
| kyverno.metricsConfig.namespaces.exclude | list | `[]` | list of namespaces to NOT capture metrics for. |
| kyverno.metricsConfig.metricsRefreshInterval | string | `nil` | Rate at which metrics should reset so as to clean up the memory footprint of kyverno metrics, if you might be expecting high memory footprint of Kyverno's metrics. Default: 0, no refresh of metrics. WARNING: This flag is not working since Kyverno 1.8.0 |
| kyverno.metricsConfig.bucketBoundaries | list | `[0.005,0.01,0.025,0.05,0.1,0.25,0.5,1,2.5,5,10,15,20,25,30]` | Configures the bucket boundaries for all Histogram metrics, changing this configuration requires restart of the kyverno admission controller |
| kyverno.metricsConfig.metricsExposure | map | `{"kyverno_admission_requests_total":{"disabledLabelDimensions":["resource_namespace"]},"kyverno_admission_review_duration_seconds":{"disabledLabelDimensions":["resource_namespace"]},"kyverno_cleanup_controller_deletedobjects_total":{"disabledLabelDimensions":["resource_namespace","policy_namespace"]},"kyverno_policy_execution_duration_seconds":{"disabledLabelDimensions":["resource_namespace","resource_request_operation"]},"kyverno_policy_results_total":{"disabledLabelDimensions":["resource_namespace","policy_namespace"]},"kyverno_policy_rule_info_total":{"disabledLabelDimensions":["resource_namespace","policy_namespace"]}}` | Configures the exposure of individual metrics, by default all metrics and all labels are exported, changing this configuration requires restart of the kyverno admission controller |
| kyverno.imagePullSecrets | object | `{}` | Image pull secrets for image verification policies, this will define the `--imagePullSecrets` argument |
| kyverno.existingImagePullSecrets | list | `[]` | Existing Image pull secrets for image verification policies, this will define the `--imagePullSecrets` argument |
| kyverno.test.sleep | int | `20` | Sleep time before running test |
| kyverno.test.image.registry | string | `nil` | Image registry |
| kyverno.test.image.repository | string | `"busybox"` | Image repository |
| kyverno.test.image.tag | string | `"1.35"` | Image tag Defaults to `latest` if omitted |
| kyverno.test.image.pullPolicy | string | `nil` | Image pull policy Defaults to image.pullPolicy if omitted |
| kyverno.test.imagePullSecrets | list | `[]` | Image pull secrets |
| kyverno.test.resources.limits | object | `{"cpu":"100m","memory":"256Mi"}` | Pod resource limits |
| kyverno.test.resources.requests | object | `{"cpu":"10m","memory":"64Mi"}` | Pod resource requests |
| kyverno.test.securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"privileged":false,"readOnlyRootFilesystem":true,"runAsGroup":65534,"runAsNonRoot":true,"runAsUser":65534,"seccompProfile":{"type":"RuntimeDefault"}}` | Security context for the test containers |
| kyverno.customLabels | object | `{}` | Additional labels |
| kyverno.webhooksCleanup.enabled | bool | `true` | Create a helm pre-delete hook to cleanup webhooks. |
| kyverno.webhooksCleanup.autoDeleteWebhooks.enabled | bool | `false` | Allow webhooks controller to delete webhooks using finalizers |
| kyverno.webhooksCleanup.image.registry | string | `nil` | Image registry |
| kyverno.webhooksCleanup.image.repository | string | `"bitnami/kubectl"` | Image repository |
| kyverno.webhooksCleanup.image.tag | string | `"1.30.2"` | Image tag Defaults to `latest` if omitted |
| kyverno.webhooksCleanup.image.pullPolicy | string | `nil` | Image pull policy Defaults to image.pullPolicy if omitted |
| kyverno.webhooksCleanup.imagePullSecrets | list | `[]` | Image pull secrets |
| kyverno.webhooksCleanup.podSecurityContext | object | `{}` | Security context for the pod |
| kyverno.webhooksCleanup.nodeSelector | object | `{}` | Node labels for pod assignment |
| kyverno.webhooksCleanup.tolerations | list | `[]` | List of node taints to tolerate |
| kyverno.webhooksCleanup.podAntiAffinity | object | `{}` | Pod anti affinity constraints. |
| kyverno.webhooksCleanup.podAffinity | object | `{}` | Pod affinity constraints. |
| kyverno.webhooksCleanup.podLabels | object | `{}` | Pod labels. |
| kyverno.webhooksCleanup.podAnnotations | object | `{}` | Pod annotations. |
| kyverno.webhooksCleanup.nodeAffinity | object | `{}` | Node affinity constraints. |
| kyverno.webhooksCleanup.securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"privileged":false,"readOnlyRootFilesystem":true,"runAsGroup":65534,"runAsNonRoot":true,"runAsUser":65534,"seccompProfile":{"type":"RuntimeDefault"}}` | Security context for the hook containers |
| kyverno.policyReportsCleanup.enabled | bool | `true` | Create a helm post-upgrade hook to cleanup the old policy reports. |
| kyverno.policyReportsCleanup.image.registry | string | `nil` | Image registry |
| kyverno.policyReportsCleanup.image.repository | string | `"bitnami/kubectl"` | Image repository |
| kyverno.policyReportsCleanup.image.tag | string | `"1.30.2"` | Image tag Defaults to `latest` if omitted |
| kyverno.policyReportsCleanup.image.pullPolicy | string | `nil` | Image pull policy Defaults to image.pullPolicy if omitted |
| kyverno.policyReportsCleanup.imagePullSecrets | list | `[]` | Image pull secrets |
| kyverno.policyReportsCleanup.podSecurityContext | object | `{}` | Security context for the pod |
| kyverno.policyReportsCleanup.nodeSelector | object | `{}` | Node labels for pod assignment |
| kyverno.policyReportsCleanup.tolerations | list | `[]` | List of node taints to tolerate |
| kyverno.policyReportsCleanup.podAntiAffinity | object | `{}` | Pod anti affinity constraints. |
| kyverno.policyReportsCleanup.podAffinity | object | `{}` | Pod affinity constraints. |
| kyverno.policyReportsCleanup.podLabels | object | `{}` | Pod labels. |
| kyverno.policyReportsCleanup.podAnnotations | object | `{}` | Pod annotations. |
| kyverno.policyReportsCleanup.nodeAffinity | object | `{}` | Node affinity constraints. |
| kyverno.policyReportsCleanup.securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"privileged":false,"readOnlyRootFilesystem":true,"runAsGroup":65534,"runAsNonRoot":true,"runAsUser":65534,"seccompProfile":{"type":"RuntimeDefault"}}` | Security context for the hook containers |
| kyverno.grafana.enabled | bool | `false` | Enable grafana dashboard creation. |
| kyverno.grafana.configMapName | string | `"{{ include \"kyverno.fullname\" . }}-grafana"` | Configmap name template. |
| kyverno.grafana.namespace | string | `nil` | Namespace to create the grafana dashboard configmap. If not set, it will be created in the same namespace where the chart is deployed. |
| kyverno.grafana.annotations | object | `{}` | Grafana dashboard configmap annotations. |
| kyverno.grafana.labels | object | `{"grafana_dashboard":"1"}` | Grafana dashboard configmap labels |
| kyverno.grafana.grafanaDashboard | object | `{"allowCrossNamespaceImport":true,"create":false,"folder":"kyverno","matchLabels":{"dashboards":"grafana"}}` | create GrafanaDashboard custom resource referencing to the configMap. according to https://grafana-operator.github.io/grafana-operator/docs/examples/dashboard_from_configmap/readme/ |
| kyverno.features.admissionReports.enabled | bool | `true` | Enables the feature |
| kyverno.features.aggregateReports.enabled | bool | `true` | Enables the feature |
| kyverno.features.policyReports.enabled | bool | `true` | Enables the feature |
| kyverno.features.validatingAdmissionPolicyReports.enabled | bool | `false` | Enables the feature |
| kyverno.features.reporting.validate | bool | `true` | Enables the feature |
| kyverno.features.reporting.mutate | bool | `true` | Enables the feature |
| kyverno.features.reporting.mutateExisting | bool | `true` | Enables the feature |
| kyverno.features.reporting.imageVerify | bool | `true` | Enables the feature |
| kyverno.features.reporting.generate | bool | `true` | Enables the feature |
| kyverno.features.autoUpdateWebhooks.enabled | bool | `true` | Enables the feature |
| kyverno.features.backgroundScan.enabled | bool | `true` | Enables the feature |
| kyverno.features.backgroundScan.backgroundScanWorkers | int | `2` | Number of background scan workers |
| kyverno.features.backgroundScan.backgroundScanInterval | string | `"1h"` | Background scan interval |
| kyverno.features.backgroundScan.skipResourceFilters | bool | `true` | Skips resource filters in background scan |
| kyverno.features.configMapCaching.enabled | bool | `true` | Enables the feature |
| kyverno.features.deferredLoading.enabled | bool | `true` | Enables the feature |
| kyverno.features.dumpPayload.enabled | bool | `false` | Enables the feature |
| kyverno.features.forceFailurePolicyIgnore.enabled | bool | `false` | Enables the feature |
| kyverno.features.generateValidatingAdmissionPolicy.enabled | bool | `false` | Enables the feature |
| kyverno.features.dumpPatches.enabled | bool | `false` | Enables the feature |
| kyverno.features.globalContext.maxApiCallResponseLength | int | `2000000` | Maximum allowed response size from API Calls. A value of 0 bypasses checks (not recommended) |
| kyverno.features.logging.format | string | `"text"` | Logging format |
| kyverno.features.logging.verbosity | int | `2` | Logging verbosity |
| kyverno.features.omitEvents.eventTypes | list | `["PolicyApplied","PolicySkipped"]` | Events which should not be emitted (possible values `PolicyViolation`, `PolicyApplied`, `PolicyError`, and `PolicySkipped`) |
| kyverno.features.policyExceptions.enabled | bool | `false` | Enables the feature |
| kyverno.features.policyExceptions.namespace | string | `""` | Restrict policy exceptions to a single namespace Set to "*" to allow exceptions in all namespaces |
| kyverno.features.protectManagedResources.enabled | bool | `false` | Enables the feature |
| kyverno.features.registryClient.allowInsecure | bool | `false` | Allow insecure registry |
| kyverno.features.registryClient.credentialHelpers | list | `["default","google","amazon","azure","github"]` | Enable registry client helpers |
| kyverno.features.ttlController.reconciliationInterval | string | `"1m"` | Reconciliation interval for the label based cleanup manager |
| kyverno.features.tuf.enabled | bool | `false` | Enables the feature |
| kyverno.features.tuf.root | string | `nil` | Path to Tuf root |
| kyverno.features.tuf.rootRaw | string | `nil` | Raw Tuf root |
| kyverno.features.tuf.mirror | string | `nil` | Tuf mirror |
| kyverno.admissionController.featuresOverride | object | `{"admissionReports":{"backPressureThreshold":1000}}` | Overrides features defined at the root level |
| kyverno.admissionController.featuresOverride.admissionReports.backPressureThreshold | int | `1000` | Max number of admission reports allowed in flight until the admission controller stops creating new ones |
| kyverno.admissionController.rbac.create | bool | `true` | Create RBAC resources |
| kyverno.admissionController.rbac.createViewRoleBinding | bool | `true` | Create rolebinding to view role |
| kyverno.admissionController.rbac.viewRoleName | string | `"view"` | The view role to use in the rolebinding |
| kyverno.admissionController.rbac.serviceAccount.name | string | `nil` | The ServiceAccount name |
| kyverno.admissionController.rbac.serviceAccount.annotations | object | `{}` | Annotations for the ServiceAccount |
| kyverno.admissionController.rbac.coreClusterRole.extraResources | list | See [values.yaml](values.yaml) | Extra resource permissions to add in the core cluster role. This was introduced to avoid breaking change in the chart but should ideally be moved in `clusterRole.extraResources`. |
| kyverno.admissionController.rbac.clusterRole.extraResources | list | `[]` | Extra resource permissions to add in the cluster role |
| kyverno.admissionController.createSelfSignedCert | bool | `false` | Create self-signed certificates at deployment time. The certificates won't be automatically renewed if this is set to `true`. |
| kyverno.admissionController.replicas | int | `nil` | Desired number of pods |
| kyverno.admissionController.revisionHistoryLimit | int | `10` | The number of revisions to keep |
| kyverno.admissionController.resyncPeriod | string | `"15m"` | Resync period for informers |
| kyverno.admissionController.podLabels | object | `{}` | Additional labels to add to each pod |
| kyverno.admissionController.podAnnotations | object | `{}` | Additional annotations to add to each pod |
| kyverno.admissionController.annotations | object | `{}` | Deployment annotations. |
| kyverno.admissionController.updateStrategy | object | See [values.yaml](values.yaml) | Deployment update strategy. Ref: https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy |
| kyverno.admissionController.priorityClassName | string | `""` | Optional priority class |
| kyverno.admissionController.apiPriorityAndFairness | bool | `false` | Change `apiPriorityAndFairness` to `true` if you want to insulate the API calls made by Kyverno admission controller activities. This will help ensure Kyverno stability in busy clusters. Ref: https://kubernetes.io/docs/concepts/cluster-administration/flow-control/ |
| kyverno.admissionController.priorityLevelConfigurationSpec | object | See [values.yaml](values.yaml) | Priority level configuration. The block is directly forwarded into the priorityLevelConfiguration, so you can use whatever specification you want. ref: https://kubernetes.io/docs/concepts/cluster-administration/flow-control/#prioritylevelconfiguration |
| kyverno.admissionController.hostNetwork | bool | `false` | Change `hostNetwork` to `true` when you want the pod to share its host's network namespace. Useful for situations like when you end up dealing with a custom CNI over Amazon EKS. Update the `dnsPolicy` accordingly as well to suit the host network mode. |
| kyverno.admissionController.webhookServer | object | `{"port":9443}` | admissionController webhook server port in case you are using hostNetwork: true, you might want to change the port the webhookServer is listening to |
| kyverno.admissionController.dnsPolicy | string | `"ClusterFirst"` | `dnsPolicy` determines the manner in which DNS resolution happens in the cluster. In case of `hostNetwork: true`, usually, the `dnsPolicy` is suitable to be `ClusterFirstWithHostNet`. For further reference: https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#pod-s-dns-policy. |
| kyverno.admissionController.startupProbe | object | See [values.yaml](values.yaml) | Startup probe. The block is directly forwarded into the deployment, so you can use whatever startupProbes configuration you want. ref: https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/ |
| kyverno.admissionController.livenessProbe | object | See [values.yaml](values.yaml) | Liveness probe. The block is directly forwarded into the deployment, so you can use whatever livenessProbe configuration you want. ref: https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/ |
| kyverno.admissionController.readinessProbe | object | See [values.yaml](values.yaml) | Readiness Probe. The block is directly forwarded into the deployment, so you can use whatever readinessProbe configuration you want. ref: https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/ |
| kyverno.admissionController.nodeSelector | object | `{}` | Node labels for pod assignment |
| kyverno.admissionController.tolerations | list | `[]` | List of node taints to tolerate |
| kyverno.admissionController.antiAffinity.enabled | bool | `true` | Pod antiAffinities toggle. Enabled by default but can be disabled if you want to schedule pods to the same node. |
| kyverno.admissionController.podAntiAffinity | object | See [values.yaml](values.yaml) | Pod anti affinity constraints. |
| kyverno.admissionController.podAffinity | object | `{}` | Pod affinity constraints. |
| kyverno.admissionController.nodeAffinity | object | `{}` | Node affinity constraints. |
| kyverno.admissionController.topologySpreadConstraints | list | `[]` | Topology spread constraints. |
| kyverno.admissionController.podSecurityContext | object | `{}` | Security context for the pod |
| kyverno.admissionController.podDisruptionBudget.enabled | bool | `false` | Enable PodDisruptionBudget. Will always be enabled if replicas > 1. This non-declarative behavior should ideally be avoided, but changing it now would be breaking. |
| kyverno.admissionController.podDisruptionBudget.minAvailable | int | `1` | Configures the minimum available pods for disruptions. Cannot be used if `maxUnavailable` is set. |
| kyverno.admissionController.podDisruptionBudget.maxUnavailable | string | `nil` | Configures the maximum unavailable pods for disruptions. Cannot be used if `minAvailable` is set. |
| kyverno.admissionController.tufRootMountPath | string | `"/.sigstore"` | A writable volume to use for the TUF root initialization. |
| kyverno.admissionController.sigstoreVolume | object | `{"emptyDir":{}}` | Volume to be mounted in pods for TUF/cosign work. |
| kyverno.admissionController.caCertificates.data | string | `nil` | CA certificates to use with Kyverno deployments This value is expected to be one large string of CA certificates |
| kyverno.admissionController.caCertificates.volume | object | `{}` | Volume to be mounted for CA certificates Not used when `.Values.admissionController.caCertificates.data` is defined |
| kyverno.admissionController.imagePullSecrets | list | `[]` | Image pull secrets |
| kyverno.admissionController.initContainer.image.registry | string | `nil` | Image registry |
| kyverno.admissionController.initContainer.image.defaultRegistry | string | `"ghcr.io"` |  |
| kyverno.admissionController.initContainer.image.repository | string | `"kyverno/kyvernopre"` | Image repository |
| kyverno.admissionController.initContainer.image.tag | string | `nil` | Image tag If missing, defaults to image.tag |
| kyverno.admissionController.initContainer.image.pullPolicy | string | `nil` | Image pull policy If missing, defaults to image.pullPolicy |
| kyverno.admissionController.initContainer.resources.limits | object | `{"cpu":"100m","memory":"256Mi"}` | Pod resource limits |
| kyverno.admissionController.initContainer.resources.requests | object | `{"cpu":"10m","memory":"64Mi"}` | Pod resource requests |
| kyverno.admissionController.initContainer.securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"privileged":false,"readOnlyRootFilesystem":true,"runAsNonRoot":true,"seccompProfile":{"type":"RuntimeDefault"}}` | Container security context |
| kyverno.admissionController.initContainer.extraArgs | object | `{}` | Additional container args. |
| kyverno.admissionController.initContainer.extraEnvVars | list | `[]` | Additional container environment variables. |
| kyverno.admissionController.container.image.registry | string | `nil` | Image registry |
| kyverno.admissionController.container.image.defaultRegistry | string | `"ghcr.io"` |  |
| kyverno.admissionController.container.image.repository | string | `"kyverno/kyverno"` | Image repository |
| kyverno.admissionController.container.image.tag | string | `nil` | Image tag Defaults to appVersion in Chart.yaml if omitted |
| kyverno.admissionController.container.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| kyverno.admissionController.container.resources.limits | object | `{"memory":"384Mi"}` | Pod resource limits |
| kyverno.admissionController.container.resources.requests | object | `{"cpu":"100m","memory":"128Mi"}` | Pod resource requests |
| kyverno.admissionController.container.securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"privileged":false,"readOnlyRootFilesystem":true,"runAsNonRoot":true,"seccompProfile":{"type":"RuntimeDefault"}}` | Container security context |
| kyverno.admissionController.container.extraArgs | object | `{}` | Additional container args. |
| kyverno.admissionController.container.extraEnvVars | list | `[]` | Additional container environment variables. |
| kyverno.admissionController.extraInitContainers | list | `[]` | Array of extra init containers |
| kyverno.admissionController.extraContainers | list | `[]` | Array of extra containers to run alongside kyverno |
| kyverno.admissionController.service.port | int | `443` | Service port. |
| kyverno.admissionController.service.type | string | `"ClusterIP"` | Service type. |
| kyverno.admissionController.service.nodePort | string | `nil` | Service node port. Only used if `type` is `NodePort`. |
| kyverno.admissionController.service.annotations | object | `{}` | Service annotations. |
| kyverno.admissionController.metricsService.create | bool | `true` | Create service. |
| kyverno.admissionController.metricsService.port | int | `8000` | Service port. Kyverno's metrics server will be exposed at this port. |
| kyverno.admissionController.metricsService.type | string | `"ClusterIP"` | Service type. |
| kyverno.admissionController.metricsService.nodePort | string | `nil` | Service node port. Only used if `type` is `NodePort`. |
| kyverno.admissionController.metricsService.annotations | object | `{}` | Service annotations. |
| kyverno.admissionController.networkPolicy.enabled | bool | `false` | When true, use a NetworkPolicy to allow ingress to the webhook This is useful on clusters using Calico and/or native k8s network policies in a default-deny setup. |
| kyverno.admissionController.networkPolicy.ingressFrom | list | `[]` | A list of valid from selectors according to https://kubernetes.io/docs/concepts/services-networking/network-policies. |
| kyverno.admissionController.serviceMonitor.enabled | bool | `false` | Create a `ServiceMonitor` to collect Prometheus metrics. |
| kyverno.admissionController.serviceMonitor.additionalLabels | object | `{}` | Additional labels |
| kyverno.admissionController.serviceMonitor.namespace | string | `nil` | Override namespace |
| kyverno.admissionController.serviceMonitor.interval | string | `"30s"` | Interval to scrape metrics |
| kyverno.admissionController.serviceMonitor.scrapeTimeout | string | `"25s"` | Timeout if metrics can't be retrieved in given time interval |
| kyverno.admissionController.serviceMonitor.secure | bool | `false` | Is TLS required for endpoint |
| kyverno.admissionController.serviceMonitor.tlsConfig | object | `{}` | TLS Configuration for endpoint |
| kyverno.admissionController.serviceMonitor.relabelings | list | `[]` | RelabelConfigs to apply to samples before scraping |
| kyverno.admissionController.serviceMonitor.metricRelabelings | list | `[]` | MetricRelabelConfigs to apply to samples before ingestion. |
| kyverno.admissionController.tracing.enabled | bool | `false` | Enable tracing |
| kyverno.admissionController.tracing.address | string | `nil` | Traces receiver address |
| kyverno.admissionController.tracing.port | string | `nil` | Traces receiver port |
| kyverno.admissionController.tracing.creds | string | `""` | Traces receiver credentials |
| kyverno.admissionController.metering.disabled | bool | `false` | Disable metrics export |
| kyverno.admissionController.metering.config | string | `"prometheus"` | Otel configuration, can be `prometheus` or `grpc` |
| kyverno.admissionController.metering.port | int | `8000` | Prometheus endpoint port |
| kyverno.admissionController.metering.collector | string | `""` | Otel collector endpoint |
| kyverno.admissionController.metering.creds | string | `""` | Otel collector credentials |
| kyverno.admissionController.profiling.enabled | bool | `false` | Enable profiling |
| kyverno.admissionController.profiling.port | int | `6060` | Profiling endpoint port |
| kyverno.admissionController.profiling.serviceType | string | `"ClusterIP"` | Service type. |
| kyverno.admissionController.profiling.nodePort | string | `nil` | Service node port. Only used if `type` is `NodePort`. |
| kyverno.backgroundController.featuresOverride | object | `{}` | Overrides features defined at the root level |
| kyverno.backgroundController.enabled | bool | `true` | Enable background controller. |
| kyverno.backgroundController.rbac.create | bool | `true` | Create RBAC resources |
| kyverno.backgroundController.rbac.createViewRoleBinding | bool | `true` | Create rolebinding to view role |
| kyverno.backgroundController.rbac.viewRoleName | string | `"view"` | The view role to use in the rolebinding |
| kyverno.backgroundController.rbac.serviceAccount.name | string | `nil` | Service account name |
| kyverno.backgroundController.rbac.serviceAccount.annotations | object | `{}` | Annotations for the ServiceAccount |
| kyverno.backgroundController.rbac.coreClusterRole.extraResources | list | See [values.yaml](values.yaml) | Extra resource permissions to add in the core cluster role. This was introduced to avoid breaking change in the chart but should ideally be moved in `clusterRole.extraResources`. |
| kyverno.backgroundController.rbac.clusterRole.extraResources | list | `[]` | Extra resource permissions to add in the cluster role |
| kyverno.backgroundController.image.registry | string | `nil` | Image registry |
| kyverno.backgroundController.image.defaultRegistry | string | `"ghcr.io"` |  |
| kyverno.backgroundController.image.repository | string | `"kyverno/background-controller"` | Image repository |
| kyverno.backgroundController.image.tag | string | `nil` | Image tag Defaults to appVersion in Chart.yaml if omitted |
| kyverno.backgroundController.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| kyverno.backgroundController.imagePullSecrets | list | `[]` | Image pull secrets |
| kyverno.backgroundController.replicas | int | `nil` | Desired number of pods |
| kyverno.backgroundController.revisionHistoryLimit | int | `10` | The number of revisions to keep |
| kyverno.backgroundController.resyncPeriod | string | `"15m"` | Resync period for informers |
| kyverno.backgroundController.podLabels | object | `{}` | Additional labels to add to each pod |
| kyverno.backgroundController.podAnnotations | object | `{}` | Additional annotations to add to each pod |
| kyverno.backgroundController.annotations | object | `{}` | Deployment annotations. |
| kyverno.backgroundController.updateStrategy | object | See [values.yaml](values.yaml) | Deployment update strategy. Ref: https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy |
| kyverno.backgroundController.priorityClassName | string | `""` | Optional priority class |
| kyverno.backgroundController.hostNetwork | bool | `false` | Change `hostNetwork` to `true` when you want the pod to share its host's network namespace. Useful for situations like when you end up dealing with a custom CNI over Amazon EKS. Update the `dnsPolicy` accordingly as well to suit the host network mode. |
| kyverno.backgroundController.dnsPolicy | string | `"ClusterFirst"` | `dnsPolicy` determines the manner in which DNS resolution happens in the cluster. In case of `hostNetwork: true`, usually, the `dnsPolicy` is suitable to be `ClusterFirstWithHostNet`. For further reference: https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#pod-s-dns-policy. |
| kyverno.backgroundController.extraArgs | object | `{}` | Extra arguments passed to the container on the command line |
| kyverno.backgroundController.extraEnvVars | list | `[]` | Additional container environment variables. |
| kyverno.backgroundController.resources.limits | object | `{"memory":"128Mi"}` | Pod resource limits |
| kyverno.backgroundController.resources.requests | object | `{"cpu":"100m","memory":"64Mi"}` | Pod resource requests |
| kyverno.backgroundController.nodeSelector | object | `{}` | Node labels for pod assignment |
| kyverno.backgroundController.tolerations | list | `[]` | List of node taints to tolerate |
| kyverno.backgroundController.antiAffinity.enabled | bool | `true` | Pod antiAffinities toggle. Enabled by default but can be disabled if you want to schedule pods to the same node. |
| kyverno.backgroundController.podAntiAffinity | object | See [values.yaml](values.yaml) | Pod anti affinity constraints. |
| kyverno.backgroundController.podAffinity | object | `{}` | Pod affinity constraints. |
| kyverno.backgroundController.nodeAffinity | object | `{}` | Node affinity constraints. |
| kyverno.backgroundController.topologySpreadConstraints | list | `[]` | Topology spread constraints. |
| kyverno.backgroundController.podSecurityContext | object | `{}` | Security context for the pod |
| kyverno.backgroundController.securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"privileged":false,"readOnlyRootFilesystem":true,"runAsNonRoot":true,"seccompProfile":{"type":"RuntimeDefault"}}` | Security context for the containers |
| kyverno.backgroundController.podDisruptionBudget.enabled | bool | `false` | Enable PodDisruptionBudget. Will always be enabled if replicas > 1. This non-declarative behavior should ideally be avoided, but changing it now would be breaking. |
| kyverno.backgroundController.podDisruptionBudget.minAvailable | int | `1` | Configures the minimum available pods for disruptions. Cannot be used if `maxUnavailable` is set. |
| kyverno.backgroundController.podDisruptionBudget.maxUnavailable | string | `nil` | Configures the maximum unavailable pods for disruptions. Cannot be used if `minAvailable` is set. |
| kyverno.backgroundController.caCertificates.data | string | `nil` | CA certificates to use with Kyverno deployments This value is expected to be one large string of CA certificates |
| kyverno.backgroundController.caCertificates.volume | object | `{}` | Volume to be mounted for CA certificates Not used when `.Values.backgroundController.caCertificates.data` is defined |
| kyverno.backgroundController.metricsService.create | bool | `true` | Create service. |
| kyverno.backgroundController.metricsService.port | int | `8000` | Service port. Metrics server will be exposed at this port. |
| kyverno.backgroundController.metricsService.type | string | `"ClusterIP"` | Service type. |
| kyverno.backgroundController.metricsService.nodePort | string | `nil` | Service node port. Only used if `metricsService.type` is `NodePort`. |
| kyverno.backgroundController.metricsService.annotations | object | `{}` | Service annotations. |
| kyverno.backgroundController.networkPolicy.enabled | bool | `false` | When true, use a NetworkPolicy to allow ingress to the webhook This is useful on clusters using Calico and/or native k8s network policies in a default-deny setup. |
| kyverno.backgroundController.networkPolicy.ingressFrom | list | `[]` | A list of valid from selectors according to https://kubernetes.io/docs/concepts/services-networking/network-policies. |
| kyverno.backgroundController.serviceMonitor.enabled | bool | `false` | Create a `ServiceMonitor` to collect Prometheus metrics. |
| kyverno.backgroundController.serviceMonitor.additionalLabels | object | `{}` | Additional labels |
| kyverno.backgroundController.serviceMonitor.namespace | string | `nil` | Override namespace |
| kyverno.backgroundController.serviceMonitor.interval | string | `"30s"` | Interval to scrape metrics |
| kyverno.backgroundController.serviceMonitor.scrapeTimeout | string | `"25s"` | Timeout if metrics can't be retrieved in given time interval |
| kyverno.backgroundController.serviceMonitor.secure | bool | `false` | Is TLS required for endpoint |
| kyverno.backgroundController.serviceMonitor.tlsConfig | object | `{}` | TLS Configuration for endpoint |
| kyverno.backgroundController.serviceMonitor.relabelings | list | `[]` | RelabelConfigs to apply to samples before scraping |
| kyverno.backgroundController.serviceMonitor.metricRelabelings | list | `[]` | MetricRelabelConfigs to apply to samples before ingestion. |
| kyverno.backgroundController.tracing.enabled | bool | `false` | Enable tracing |
| kyverno.backgroundController.tracing.address | string | `nil` | Traces receiver address |
| kyverno.backgroundController.tracing.port | string | `nil` | Traces receiver port |
| kyverno.backgroundController.tracing.creds | string | `""` | Traces receiver credentials |
| kyverno.backgroundController.metering.disabled | bool | `false` | Disable metrics export |
| kyverno.backgroundController.metering.config | string | `"prometheus"` | Otel configuration, can be `prometheus` or `grpc` |
| kyverno.backgroundController.metering.port | int | `8000` | Prometheus endpoint port |
| kyverno.backgroundController.metering.collector | string | `""` | Otel collector endpoint |
| kyverno.backgroundController.metering.creds | string | `""` | Otel collector credentials |
| kyverno.backgroundController.server | object | `{"port":9443}` | backgroundController server port in case you are using hostNetwork: true, you might want to change the port the backgroundController is listening to |
| kyverno.backgroundController.profiling.enabled | bool | `false` | Enable profiling |
| kyverno.backgroundController.profiling.port | int | `6060` | Profiling endpoint port |
| kyverno.backgroundController.profiling.serviceType | string | `"ClusterIP"` | Service type. |
| kyverno.backgroundController.profiling.nodePort | string | `nil` | Service node port. Only used if `type` is `NodePort`. |
| kyverno.cleanupController.featuresOverride | object | `{}` | Overrides features defined at the root level |
| kyverno.cleanupController.enabled | bool | `true` | Enable cleanup controller. |
| kyverno.cleanupController.rbac.create | bool | `true` | Create RBAC resources |
| kyverno.cleanupController.rbac.serviceAccount.name | string | `nil` | Service account name |
| kyverno.cleanupController.rbac.serviceAccount.annotations | object | `{}` | Annotations for the ServiceAccount |
| kyverno.cleanupController.rbac.clusterRole.extraResources | list | `[]` | Extra resource permissions to add in the cluster role |
| kyverno.cleanupController.createSelfSignedCert | bool | `false` | Create self-signed certificates at deployment time. The certificates won't be automatically renewed if this is set to `true`. |
| kyverno.cleanupController.image.registry | string | `nil` | Image registry |
| kyverno.cleanupController.image.defaultRegistry | string | `"ghcr.io"` |  |
| kyverno.cleanupController.image.repository | string | `"kyverno/cleanup-controller"` | Image repository |
| kyverno.cleanupController.image.tag | string | `nil` | Image tag Defaults to appVersion in Chart.yaml if omitted |
| kyverno.cleanupController.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| kyverno.cleanupController.imagePullSecrets | list | `[]` | Image pull secrets |
| kyverno.cleanupController.replicas | int | `nil` | Desired number of pods |
| kyverno.cleanupController.revisionHistoryLimit | int | `10` | The number of revisions to keep |
| kyverno.cleanupController.resyncPeriod | string | `"15m"` | Resync period for informers |
| kyverno.cleanupController.podLabels | object | `{}` | Additional labels to add to each pod |
| kyverno.cleanupController.podAnnotations | object | `{}` | Additional annotations to add to each pod |
| kyverno.cleanupController.annotations | object | `{}` | Deployment annotations. |
| kyverno.cleanupController.updateStrategy | object | See [values.yaml](values.yaml) | Deployment update strategy. Ref: https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy |
| kyverno.cleanupController.priorityClassName | string | `""` | Optional priority class |
| kyverno.cleanupController.hostNetwork | bool | `false` | Change `hostNetwork` to `true` when you want the pod to share its host's network namespace. Useful for situations like when you end up dealing with a custom CNI over Amazon EKS. Update the `dnsPolicy` accordingly as well to suit the host network mode. |
| kyverno.cleanupController.server | object | `{"port":9443}` | cleanupController server port in case you are using hostNetwork: true, you might want to change the port the cleanupController is listening to |
| kyverno.cleanupController.webhookServer | object | `{"port":9443}` | cleanupController webhook server port in case you are using hostNetwork: true, you might want to change the port the webhookServer is listening to |
| kyverno.cleanupController.dnsPolicy | string | `"ClusterFirst"` | `dnsPolicy` determines the manner in which DNS resolution happens in the cluster. In case of `hostNetwork: true`, usually, the `dnsPolicy` is suitable to be `ClusterFirstWithHostNet`. For further reference: https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#pod-s-dns-policy. |
| kyverno.cleanupController.extraArgs | object | `{}` | Extra arguments passed to the container on the command line |
| kyverno.cleanupController.extraEnvVars | list | `[]` | Additional container environment variables. |
| kyverno.cleanupController.resources.limits | object | `{"memory":"128Mi"}` | Pod resource limits |
| kyverno.cleanupController.resources.requests | object | `{"cpu":"100m","memory":"64Mi"}` | Pod resource requests |
| kyverno.cleanupController.startupProbe | object | See [values.yaml](values.yaml) | Startup probe. The block is directly forwarded into the deployment, so you can use whatever startupProbes configuration you want. ref: https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/ |
| kyverno.cleanupController.livenessProbe | object | See [values.yaml](values.yaml) | Liveness probe. The block is directly forwarded into the deployment, so you can use whatever livenessProbe configuration you want. ref: https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/ |
| kyverno.cleanupController.readinessProbe | object | See [values.yaml](values.yaml) | Readiness Probe. The block is directly forwarded into the deployment, so you can use whatever readinessProbe configuration you want. ref: https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/ |
| kyverno.cleanupController.nodeSelector | object | `{}` | Node labels for pod assignment |
| kyverno.cleanupController.tolerations | list | `[]` | List of node taints to tolerate |
| kyverno.cleanupController.antiAffinity.enabled | bool | `true` | Pod antiAffinities toggle. Enabled by default but can be disabled if you want to schedule pods to the same node. |
| kyverno.cleanupController.podAntiAffinity | object | See [values.yaml](values.yaml) | Pod anti affinity constraints. |
| kyverno.cleanupController.podAffinity | object | `{}` | Pod affinity constraints. |
| kyverno.cleanupController.nodeAffinity | object | `{}` | Node affinity constraints. |
| kyverno.cleanupController.topologySpreadConstraints | list | `[]` | Topology spread constraints. |
| kyverno.cleanupController.podSecurityContext | object | `{}` | Security context for the pod |
| kyverno.cleanupController.securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"privileged":false,"readOnlyRootFilesystem":true,"runAsNonRoot":true,"seccompProfile":{"type":"RuntimeDefault"}}` | Security context for the containers |
| kyverno.cleanupController.podDisruptionBudget.enabled | bool | `false` | Enable PodDisruptionBudget. Will always be enabled if replicas > 1. This non-declarative behavior should ideally be avoided, but changing it now would be breaking. |
| kyverno.cleanupController.podDisruptionBudget.minAvailable | int | `1` | Configures the minimum available pods for disruptions. Cannot be used if `maxUnavailable` is set. |
| kyverno.cleanupController.podDisruptionBudget.maxUnavailable | string | `nil` | Configures the maximum unavailable pods for disruptions. Cannot be used if `minAvailable` is set. |
| kyverno.cleanupController.service.port | int | `443` | Service port. |
| kyverno.cleanupController.service.type | string | `"ClusterIP"` | Service type. |
| kyverno.cleanupController.service.nodePort | string | `nil` | Service node port. Only used if `service.type` is `NodePort`. |
| kyverno.cleanupController.service.annotations | object | `{}` | Service annotations. |
| kyverno.cleanupController.metricsService.create | bool | `true` | Create service. |
| kyverno.cleanupController.metricsService.port | int | `8000` | Service port. Metrics server will be exposed at this port. |
| kyverno.cleanupController.metricsService.type | string | `"ClusterIP"` | Service type. |
| kyverno.cleanupController.metricsService.nodePort | string | `nil` | Service node port. Only used if `metricsService.type` is `NodePort`. |
| kyverno.cleanupController.metricsService.annotations | object | `{}` | Service annotations. |
| kyverno.cleanupController.networkPolicy.enabled | bool | `false` | When true, use a NetworkPolicy to allow ingress to the webhook This is useful on clusters using Calico and/or native k8s network policies in a default-deny setup. |
| kyverno.cleanupController.networkPolicy.ingressFrom | list | `[]` | A list of valid from selectors according to https://kubernetes.io/docs/concepts/services-networking/network-policies. |
| kyverno.cleanupController.serviceMonitor.enabled | bool | `false` | Create a `ServiceMonitor` to collect Prometheus metrics. |
| kyverno.cleanupController.serviceMonitor.additionalLabels | object | `{}` | Additional labels |
| kyverno.cleanupController.serviceMonitor.namespace | string | `nil` | Override namespace |
| kyverno.cleanupController.serviceMonitor.interval | string | `"30s"` | Interval to scrape metrics |
| kyverno.cleanupController.serviceMonitor.scrapeTimeout | string | `"25s"` | Timeout if metrics can't be retrieved in given time interval |
| kyverno.cleanupController.serviceMonitor.secure | bool | `false` | Is TLS required for endpoint |
| kyverno.cleanupController.serviceMonitor.tlsConfig | object | `{}` | TLS Configuration for endpoint |
| kyverno.cleanupController.serviceMonitor.relabelings | list | `[]` | RelabelConfigs to apply to samples before scraping |
| kyverno.cleanupController.serviceMonitor.metricRelabelings | list | `[]` | MetricRelabelConfigs to apply to samples before ingestion. |
| kyverno.cleanupController.tracing.enabled | bool | `false` | Enable tracing |
| kyverno.cleanupController.tracing.address | string | `nil` | Traces receiver address |
| kyverno.cleanupController.tracing.port | string | `nil` | Traces receiver port |
| kyverno.cleanupController.tracing.creds | string | `""` | Traces receiver credentials |
| kyverno.cleanupController.metering.disabled | bool | `false` | Disable metrics export |
| kyverno.cleanupController.metering.config | string | `"prometheus"` | Otel configuration, can be `prometheus` or `grpc` |
| kyverno.cleanupController.metering.port | int | `8000` | Prometheus endpoint port |
| kyverno.cleanupController.metering.collector | string | `""` | Otel collector endpoint |
| kyverno.cleanupController.metering.creds | string | `""` | Otel collector credentials |
| kyverno.cleanupController.profiling.enabled | bool | `false` | Enable profiling |
| kyverno.cleanupController.profiling.port | int | `6060` | Profiling endpoint port |
| kyverno.cleanupController.profiling.serviceType | string | `"ClusterIP"` | Service type. |
| kyverno.cleanupController.profiling.nodePort | string | `nil` | Service node port. Only used if `type` is `NodePort`. |
| kyverno.reportsController.featuresOverride | object | `{}` | Overrides features defined at the root level |
| kyverno.reportsController.enabled | bool | `true` | Enable reports controller. |
| kyverno.reportsController.rbac.create | bool | `true` | Create RBAC resources |
| kyverno.reportsController.rbac.createViewRoleBinding | bool | `true` | Create rolebinding to view role |
| kyverno.reportsController.rbac.viewRoleName | string | `"view"` | The view role to use in the rolebinding |
| kyverno.reportsController.rbac.serviceAccount.name | string | `nil` | Service account name |
| kyverno.reportsController.rbac.serviceAccount.annotations | object | `{}` | Annotations for the ServiceAccount |
| kyverno.reportsController.rbac.coreClusterRole.extraResources | list | See [values.yaml](values.yaml) | Extra resource permissions to add in the core cluster role. This was introduced to avoid breaking change in the chart but should ideally be moved in `clusterRole.extraResources`. |
| kyverno.reportsController.rbac.clusterRole.extraResources | list | `[]` | Extra resource permissions to add in the cluster role |
| kyverno.reportsController.image.registry | string | `nil` | Image registry |
| kyverno.reportsController.image.defaultRegistry | string | `"ghcr.io"` |  |
| kyverno.reportsController.image.repository | string | `"kyverno/reports-controller"` | Image repository |
| kyverno.reportsController.image.tag | string | `nil` | Image tag Defaults to appVersion in Chart.yaml if omitted |
| kyverno.reportsController.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| kyverno.reportsController.imagePullSecrets | list | `[]` | Image pull secrets |
| kyverno.reportsController.replicas | int | `nil` | Desired number of pods |
| kyverno.reportsController.revisionHistoryLimit | int | `10` | The number of revisions to keep |
| kyverno.reportsController.resyncPeriod | string | `"15m"` | Resync period for informers |
| kyverno.reportsController.podLabels | object | `{}` | Additional labels to add to each pod |
| kyverno.reportsController.podAnnotations | object | `{}` | Additional annotations to add to each pod |
| kyverno.reportsController.annotations | object | `{}` | Deployment annotations. |
| kyverno.reportsController.updateStrategy | object | See [values.yaml](values.yaml) | Deployment update strategy. Ref: https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy |
| kyverno.reportsController.priorityClassName | string | `""` | Optional priority class |
| kyverno.reportsController.apiPriorityAndFairness | bool | `false` | Change `apiPriorityAndFairness` to `true` if you want to insulate the API calls made by Kyverno reports controller activities. This will help ensure Kyverno reports stability in busy clusters. Ref: https://kubernetes.io/docs/concepts/cluster-administration/flow-control/ |
| kyverno.reportsController.priorityLevelConfigurationSpec | object | See [values.yaml](values.yaml) | Priority level configuration. The block is directly forwarded into the priorityLevelConfiguration, so you can use whatever specification you want. ref: https://kubernetes.io/docs/concepts/cluster-administration/flow-control/#prioritylevelconfiguration |
| kyverno.reportsController.hostNetwork | bool | `false` | Change `hostNetwork` to `true` when you want the pod to share its host's network namespace. Useful for situations like when you end up dealing with a custom CNI over Amazon EKS. Update the `dnsPolicy` accordingly as well to suit the host network mode. |
| kyverno.reportsController.dnsPolicy | string | `"ClusterFirst"` | `dnsPolicy` determines the manner in which DNS resolution happens in the cluster. In case of `hostNetwork: true`, usually, the `dnsPolicy` is suitable to be `ClusterFirstWithHostNet`. For further reference: https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#pod-s-dns-policy. |
| kyverno.reportsController.extraArgs | object | `{}` | Extra arguments passed to the container on the command line |
| kyverno.reportsController.extraEnvVars | list | `[]` | Additional container environment variables. |
| kyverno.reportsController.resources.limits | object | `{"memory":"128Mi"}` | Pod resource limits |
| kyverno.reportsController.resources.requests | object | `{"cpu":"100m","memory":"64Mi"}` | Pod resource requests |
| kyverno.reportsController.nodeSelector | object | `{}` | Node labels for pod assignment |
| kyverno.reportsController.tolerations | list | `[]` | List of node taints to tolerate |
| kyverno.reportsController.antiAffinity.enabled | bool | `true` | Pod antiAffinities toggle. Enabled by default but can be disabled if you want to schedule pods to the same node. |
| kyverno.reportsController.podAntiAffinity | object | See [values.yaml](values.yaml) | Pod anti affinity constraints. |
| kyverno.reportsController.podAffinity | object | `{}` | Pod affinity constraints. |
| kyverno.reportsController.nodeAffinity | object | `{}` | Node affinity constraints. |
| kyverno.reportsController.topologySpreadConstraints | list | `[]` | Topology spread constraints. |
| kyverno.reportsController.podSecurityContext | object | `{}` | Security context for the pod |
| kyverno.reportsController.securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"privileged":false,"readOnlyRootFilesystem":true,"runAsNonRoot":true,"seccompProfile":{"type":"RuntimeDefault"}}` | Security context for the containers |
| kyverno.reportsController.podDisruptionBudget.enabled | bool | `false` | Enable PodDisruptionBudget. Will always be enabled if replicas > 1. This non-declarative behavior should ideally be avoided, but changing it now would be breaking. |
| kyverno.reportsController.podDisruptionBudget.minAvailable | int | `1` | Configures the minimum available pods for disruptions. Cannot be used if `maxUnavailable` is set. |
| kyverno.reportsController.podDisruptionBudget.maxUnavailable | string | `nil` | Configures the maximum unavailable pods for disruptions. Cannot be used if `minAvailable` is set. |
| kyverno.reportsController.tufRootMountPath | string | `"/.sigstore"` | A writable volume to use for the TUF root initialization. |
| kyverno.reportsController.sigstoreVolume | object | `{"emptyDir":{}}` | Volume to be mounted in pods for TUF/cosign work. |
| kyverno.reportsController.caCertificates.data | string | `nil` | CA certificates to use with Kyverno deployments This value is expected to be one large string of CA certificates |
| kyverno.reportsController.caCertificates.volume | object | `{}` | Volume to be mounted for CA certificates Not used when `.Values.reportsController.caCertificates.data` is defined |
| kyverno.reportsController.metricsService.create | bool | `true` | Create service. |
| kyverno.reportsController.metricsService.port | int | `8000` | Service port. Metrics server will be exposed at this port. |
| kyverno.reportsController.metricsService.type | string | `"ClusterIP"` | Service type. |
| kyverno.reportsController.metricsService.nodePort | string | `nil` | Service node port. Only used if `type` is `NodePort`. |
| kyverno.reportsController.metricsService.annotations | object | `{}` | Service annotations. |
| kyverno.reportsController.networkPolicy.enabled | bool | `false` | When true, use a NetworkPolicy to allow ingress to the webhook This is useful on clusters using Calico and/or native k8s network policies in a default-deny setup. |
| kyverno.reportsController.networkPolicy.ingressFrom | list | `[]` | A list of valid from selectors according to https://kubernetes.io/docs/concepts/services-networking/network-policies. |
| kyverno.reportsController.serviceMonitor.enabled | bool | `false` | Create a `ServiceMonitor` to collect Prometheus metrics. |
| kyverno.reportsController.serviceMonitor.additionalLabels | object | `{}` | Additional labels |
| kyverno.reportsController.serviceMonitor.namespace | string | `nil` | Override namespace |
| kyverno.reportsController.serviceMonitor.interval | string | `"30s"` | Interval to scrape metrics |
| kyverno.reportsController.serviceMonitor.scrapeTimeout | string | `"25s"` | Timeout if metrics can't be retrieved in given time interval |
| kyverno.reportsController.serviceMonitor.secure | bool | `false` | Is TLS required for endpoint |
| kyverno.reportsController.serviceMonitor.tlsConfig | object | `{}` | TLS Configuration for endpoint |
| kyverno.reportsController.serviceMonitor.relabelings | list | `[]` | RelabelConfigs to apply to samples before scraping |
| kyverno.reportsController.serviceMonitor.metricRelabelings | list | `[]` | MetricRelabelConfigs to apply to samples before ingestion. |
| kyverno.reportsController.tracing.enabled | bool | `false` | Enable tracing |
| kyverno.reportsController.tracing.address | string | `nil` | Traces receiver address |
| kyverno.reportsController.tracing.port | string | `nil` | Traces receiver port |
| kyverno.reportsController.tracing.creds | string | `nil` | Traces receiver credentials |
| kyverno.reportsController.metering.disabled | bool | `false` | Disable metrics export |
| kyverno.reportsController.metering.config | string | `"prometheus"` | Otel configuration, can be `prometheus` or `grpc` |
| kyverno.reportsController.metering.port | int | `8000` | Prometheus endpoint port |
| kyverno.reportsController.metering.collector | string | `nil` | Otel collector endpoint |
| kyverno.reportsController.metering.creds | string | `nil` | Otel collector credentials |
| kyverno.reportsController.server | object | `{"port":9443}` | reportsController server port in case you are using hostNetwork: true, you might want to change the port the reportsController is listening to |
| kyverno.reportsController.profiling.enabled | bool | `false` | Enable profiling |
| kyverno.reportsController.profiling.port | int | `6060` | Profiling endpoint port |
| kyverno.reportsController.profiling.serviceType | string | `"ClusterIP"` | Service type. |
| kyverno.reportsController.profiling.nodePort | string | `nil` | Service node port. Only used if `type` is `NodePort`. |
| kyverno.reportsController.sanityChecks | bool | `true` | Enable sanity check for reports CRDs |

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
    targetRevision: "0.1.1"
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

