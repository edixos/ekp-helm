# tetragon

![Version: 0.1.1](https://img.shields.io/badge/Version-0.1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.7.1](https://img.shields.io/badge/AppVersion-1.7.1-informational?style=flat-square)

## Prerequisites

- Helm v3
- A cluster with eBPF support for the Tetragon agent

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://helm.cilium.io/ | tetragon | 1.7.1 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| hamzatalbi | <hamzatalbi831@gmail.com> | <https://github.com/TalbiHamza> |

## Description

Tetragon runtime security packaged for the Edixos Kubernetes Platform. Wraps the upstream Cilium Tetragon chart, which deploys the eBPF agent DaemonSet and the operator that owns the TracingPolicy CRDs, and adds the EKP extensions: file-backed TracingPolicy bundles split into observation and enforcement, Prometheus or VictoriaMetrics alerting rules and a Grafana dashboard. The baseline is observation-only; enforcement is opt-in per policy and per namespace. All upstream settings are available under the tetragon values key.

## Source Code

* <https://github.com/cilium/tetragon>
* <https://github.com/cilium/tetragon/tree/main/install/kubernetes/tetragon>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.argocdSyncWave | string | `"1"` | Argo CD sync wave placed on the TracingPolicy resources. The Tetragon operator creates the CRDs those resources need, so they must be applied after the operator Deployment of the same release is healthy |
| global.enableArgocdAnnotations | bool | `false` | Annotate the platform extension resources with Argo CD sync options, so Argo CD does not dry-run the TracingPolicy resources against CRDs that the Tetragon operator has not created yet |
| prometheus.enabled | bool | `false` | Enables Prometheus Operator monitoring resources |
| prometheus.grafanaDashboard.enabled | bool | `true` | Add grafana dashboard as a configmap |
| prometheus.grafanaDashboard.label | object | `{"grafana_dashboard":"1"}` | Label to apply to the config map. Used by the Grafana sidecar to automatically install the dashboard |
| prometheus.rules.enabled | bool | `true` | Enables prometheus operator rules |
| prometheus.rules.labels | object | `{"prometheus":"prometheus-operator-prometheus"}` | Labels to affect to the Prometheus Rules |
| tetragon.affinity | object | `{}` |  |
| tetragon.crds.installMethod | string | `"operator"` | Method for installing CRDs. Supported values are: "operator", "helm" and "none". The "operator" method allows for fine-grained control over which CRDs are installed and by default doesn't perform CRD downgrades. These can be configured in tetragonOperator section. The "helm" method always installs all CRDs for the chart version. |
| tetragon.daemonSetAnnotations | object | `{}` |  |
| tetragon.daemonSetLabelsOverride | object | `{}` |  |
| tetragon.dnsPolicy | string | `"Default"` | DNS policy for Tetragon pods.  https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#pod-s-dns-policy |
| tetragon.enabled | bool | `true` |  |
| tetragon.export | object | `{"filenames":["tetragon.log"],"mode":"stdout","resources":{"limits":{"memory":"128Mi"},"requests":{"cpu":"25m","memory":"64Mi"}},"securityContext":{},"stdout":{"argsOverride":[],"commandOverride":[],"enabledArgs":true,"enabledCommand":true,"envFromSecrets":[],"extraEnv":[],"extraEnvFrom":[],"extraVolumeMounts":[],"image":{"override":null,"repository":"quay.io/cilium/hubble-export-stdout","tag":"v1.1.1"}}}` | Tetragon events export settings |
| tetragon.export.resources | object | `{"limits":{"memory":"128Mi"},"requests":{"cpu":"25m","memory":"64Mi"}}` | Resources of the export-stdout sidecar. It only tails the JSON export file and writes it to stdout, where the cluster log collector picks it up. |
| tetragon.export.stdout.envFromSecrets | list | `[]` | A simplified way to add secret references to envFrom. Can be specified either as a string (just the secret name) or as an object with additional parameters. Example: envFromSecrets:   - my-simple-secret   - name: my-optional-secret     optional: true |
| tetragon.export.stdout.extraEnv | list | `[]` | Extra environment variables to add to the export-stdout container. Example: extraEnv:   - name: FOO     value: bar   - name: SECRET_KEY     valueFrom:       secretKeyRef:         name: my-secret         key: secret-key |
| tetragon.export.stdout.extraEnvFrom | list | `[]` | Extra envFrom sources to add to the export-stdout container. This allows adding any type of envFrom source (configMapRef, secretRef, etc.). Example: extraEnvFrom:   - configMapRef:       name: my-config-map   - secretRef:       name: my-secret       optional: true |
| tetragon.exportDirectory | string | `"/var/run/cilium/tetragon"` | Directory to put Tetragon JSON export files. |
| tetragon.extraConfigmapMounts | list | `[]` |  |
| tetragon.extraHostPathMounts | list | `[]` |  |
| tetragon.extraVolumes | list | `[]` |  |
| tetragon.hostNetwork | bool | `true` | Configures whether Tetragon pods run on the host network.  IMPORTANT: Tetragon must be on the host network for the process visibility to function properly. |
| tetragon.imagePullPolicy | string | `"IfNotPresent"` |  |
| tetragon.imagePullSecrets | list | `[]` |  |
| tetragon.nodeSelector | object | `{}` |  |
| tetragon.podAnnotations | object | `{}` |  |
| tetragon.podLabels | object | `{}` |  |
| tetragon.podLabelsOverride | object | `{}` |  |
| tetragon.podSecurityContext | object | `{}` |  |
| tetragon.priorityClassName | string | `"system-node-critical"` | Priority class of the Tetragon agent DaemonSet. The agent is a node local security sensor: while it is not running the node reports nothing, so it is scheduled in the same tier as the CNI. |
| tetragon.rthooks | object | `{"annotations":{},"enabled":false,"extraHookArgs":{},"extraLabels":{},"extraVolumeMounts":[],"failAllowNamespaces":"","image":{"override":null,"repository":"quay.io/cilium/tetragon-rthooks","tag":"v0.8"},"installDir":"/opt/tetragon","interface":"","nameOverride":"","nriHook":{"nriSocket":"/var/run/nri/nri.sock"},"ociHooks":{"hooksPath":"/usr/share/containers/oci/hooks.d"},"podAnnotations":{},"podSecurityContext":{},"priorityClassName":"","resources":{},"serviceAccount":{"name":""}}` | Method for installing Tetagon rthooks (tetragon-rthooks) daemonset The tetragon-rthooks daemonset is responsible for installing run-time hooks on the host. See: https://tetragon.io/docs/concepts/runtime-hooks |
| tetragon.rthooks.annotations | object | `{}` | Annotations for the Tetragon rthooks daemonset |
| tetragon.rthooks.enabled | bool | `false` | Enable the Tetragon rthooks daemonset |
| tetragon.rthooks.extraHookArgs | object | `{}` | extra args to pass to tetragon-oci-hook |
| tetragon.rthooks.extraLabels | object | `{}` | Extra labels for the Tetrargon rthooks daemonset |
| tetragon.rthooks.extraVolumeMounts | list | `[]` | Extra volume mounts to add to the oci-hook-setup init container |
| tetragon.rthooks.failAllowNamespaces | string | `""` | Comma-separated list of namespaces to allow Pod creation for, in case tetragon-oci-hook fails to reach Tetragon agent. The namespace Tetragon is deployed in is always added as an exception and must not be added again. |
| tetragon.rthooks.image | object | `{"override":null,"repository":"quay.io/cilium/tetragon-rthooks","tag":"v0.8"}` | image for the Tetragon rthooks pod |
| tetragon.rthooks.installDir | string | `"/opt/tetragon"` | installDir is the host location where the tetragon-oci-hook binary will be installed |
| tetragon.rthooks.interface | string | `""` | Method to use for installing  rthooks. Values:     "oci-hooks":       Add an apppriate file to "/usr/share/containers/oci/hooks.d". Use this with CRI-O.       See https://github.com/containers/common/blob/main/pkg/hooks/docs/oci-hooks.5.md       for more details.       Specific configuration for this interface can be found under "ociHooks".     "nri-hook":      Install the hook via NRI. Use this with containerd. Requires NRI being enabled.      see: https://github.com/containerd/containerd/blob/main/docs/NRI.md.      Specific configuration for this interface can be found under "nriHook".  |
| tetragon.rthooks.nameOverride | string | `""` | tetragon-rthooks name override |
| tetragon.rthooks.nriHook | object | `{"nriSocket":"/var/run/nri/nri.sock"}` | configuration for the "nri-hook" interface |
| tetragon.rthooks.nriHook.nriSocket | string | `"/var/run/nri/nri.sock"` | path to NRI socket |
| tetragon.rthooks.ociHooks | object | `{"hooksPath":"/usr/share/containers/oci/hooks.d"}` | configuration for "oci-hooks" interface |
| tetragon.rthooks.ociHooks.hooksPath | string | `"/usr/share/containers/oci/hooks.d"` | directory to install .json file for running the hook |
| tetragon.rthooks.podAnnotations | object | `{}` | Pod annotations for the Tetrargon rthooks pod |
| tetragon.rthooks.podSecurityContext | object | `{}` | security context for the Tetrargon rthooks pod |
| tetragon.rthooks.priorityClassName | string | `""` | priorityClassName for the Tetrargon rthooks pod |
| tetragon.rthooks.resources | object | `{}` | resources for the the oci-hook-setup init container |
| tetragon.rthooks.serviceAccount | object | `{"name":""}` | rthooks service account. |
| tetragon.selectorLabelsOverride | object | `{}` |  |
| tetragon.serviceAccount.annotations | object | `{}` |  |
| tetragon.serviceAccount.create | bool | `true` |  |
| tetragon.serviceAccount.name | string | `""` |  |
| tetragon.serviceLabelsOverride | object | `{}` |  |
| tetragon.tetragon.argsOverride | list | `[]` | Override the arguments. For advanced users only. |
| tetragon.tetragon.btf | string | `""` |  |
| tetragon.tetragon.cgidmap | object | `{"enabled":false}` | Enabling cgidmap instructs the Tetragon agent to use cgroup ids (instead of cgroup names) for pod association. This feature depends on cri being enabled. |
| tetragon.tetragon.clusterName | string | `""` | Name of the cluster where Tetragon is installed. Tetragon uses this value to set the cluster_name field in GetEventsResponse messages. |
| tetragon.tetragon.commandOverride | list | `[]` | Override the command. For advanced users only. |
| tetragon.tetragon.cri | object | `{"enabled":false,"socketHostPath":""}` | Configure tetragon pod so that it can contact the CRI running on the host |
| tetragon.tetragon.cri.socketHostPath | string | `""` | path of the CRI socket on the host. This will typically be "/run/containerd/containerd.sock" for containerd or "/var/run/crio/crio.sock"  for crio. |
| tetragon.tetragon.debug | bool | `false` | If you want to run Tetragon in debug mode change this value to true |
| tetragon.tetragon.enableK8sAPI | bool | `true` | Access Kubernetes API to associate Tetragon events with Kubernetes pods. |
| tetragon.tetragon.enableKeepSensorsOnExit | bool | `false` | Persistent enforcement to allow the enforcement policy to continue running even when its Tetragon process is gone. |
| tetragon.tetragon.enableMsgHandlingLatency | bool | `false` | Enable latency monitoring in message handling |
| tetragon.tetragon.enablePolicyFilter | bool | `true` | Enable policy filter. This is required for K8s namespace and pod-label filtering. |
| tetragon.tetragon.enablePolicyFilterCgroupMap | bool | `false` | Enable policy filter cgroup map. |
| tetragon.tetragon.enablePolicyFilterDebug | bool | `false` | Enable policy filter debug messages. |
| tetragon.tetragon.enableProcessCred | bool | `true` | Enable Capabilities visibility in exec and kprobe events. Enabled by default here: without it an exec event does not say whether the process holds CAP_SYS_ADMIN, which is most of what makes the event useful for runtime security. |
| tetragon.tetragon.enableProcessNs | bool | `true` | Enable Namespaces visibility in exec and kprobe events. Enabled by default here so events carry the namespaces of the process, which is how a container escape becomes visible. |
| tetragon.tetragon.enabled | bool | `true` |  |
| tetragon.tetragon.eventCacheRetries | int | `15` | Configure the number of retries in tetragon's event cache. |
| tetragon.tetragon.eventCacheRetryDelay | int | `2` | Configure the delay (in seconds) between retires in tetragon's event cache. |
| tetragon.tetragon.exportAllowList | string | `"{\"event_set\":[\"PROCESS_EXEC\", \"PROCESS_EXIT\", \"PROCESS_KPROBE\", \"PROCESS_UPROBE\", \"PROCESS_TRACEPOINT\", \"PROCESS_LSM\"]}"` | Allowlist for JSON export. For example, to export only process_connect events from the default namespace:  exportAllowList: |   {"namespace":["default"],"event_set":["PROCESS_EXEC"]} |
| tetragon.tetragon.exportDenyList | string | `"{\"health_check\":true}\n{\"namespace\":[\"\", \"cilium\", \"kube-system\"]}"` | Denylist for JSON export **(for file sinks only; does not filter gRPC output)**. For example, to exclude exec events that look similar to Kubernetes health checks and all the events from kube-system namespace and the host:  exportDenyList: |   {"health_check":true}   {"namespace":["kube-system",""]}  |
| tetragon.tetragon.exportFileCompress | bool | `false` | Compress rotated JSON export files. |
| tetragon.tetragon.exportFileMaxBackups | int | `5` | Number of rotated files to retain. |
| tetragon.tetragon.exportFileMaxSizeMB | int | `10` | Size in megabytes at which to rotate JSON export files. |
| tetragon.tetragon.exportFilePerm | string | `"600"` | JSON export file permissions as a string. Typically it's either "600" (to restrict access to owner) or "640"/"644" (to allow read access by logs collector or another agent). |
| tetragon.tetragon.exportFilename | string | `"tetragon.log"` | JSON export filename. Set it to an empty string to disable JSON export altogether. |
| tetragon.tetragon.exportRateLimit | int | `-1` | Rate-limit event export (events per minute), Set to -1 to export all events. |
| tetragon.tetragon.extraArgs | object | `{}` |  |
| tetragon.tetragon.extraEnv | list | `[]` |  |
| tetragon.tetragon.extraVolumeMounts | list | `[]` |  |
| tetragon.tetragon.fieldFilters | string | `""` | Filters to include or exclude fields from Tetragon events. Without any filters, all fields are included by default. The presence of at least one inclusion filter implies default-exclude (i.e. any fields that don't match an inclusion filter will be excluded). Field paths are expressed using dot notation like "a.b.c" and multiple field paths can be separated by commas like "a.b.c,d,e.f". An optional "event_set" may be specified to apply the field filter to a specific set of events.  For example, to exclude the "parent" field from all events and include the "process" field in PROCESS_KPROBE events while excluding all others:  fieldFilters: |   {"fields": "parent", "action": "EXCLUDE"}   {"event_set": ["PROCESS_KPROBE"], "fields": "process", "action": "INCLUDE"}  |
| tetragon.tetragon.gops.address | string | `"localhost"` | The address at which to expose gops. |
| tetragon.tetragon.gops.enabled | bool | `true` | Whether to enable exposing gops server. |
| tetragon.tetragon.gops.port | int | `8118` | The port at which to expose gops. |
| tetragon.tetragon.grpc.address | string | `"unix:///var/run/tetragon/tetragon.sock"` | The address at which to expose gRPC. Examples: localhost:54321, unix:///var/run/tetragon/tetragon.sock |
| tetragon.tetragon.grpc.enabled | bool | `true` | Whether to enable exposing Tetragon gRPC. |
| tetragon.tetragon.healthGrpc.enabled | bool | `true` | Whether to enable health gRPC server. |
| tetragon.tetragon.healthGrpc.interval | int | `10` | The interval at which to check the health of the agent. |
| tetragon.tetragon.healthGrpc.port | int | `6789` | The port at which to expose health gRPC. |
| tetragon.tetragon.hostProcPath | string | `"/proc"` | Location of the host proc filesystem in the runtime environment. If the runtime runs in the host, the path is /proc. Exceptions to this are environments like kind, where the runtime itself does not run on the host. |
| tetragon.tetragon.image.override | string | `nil` |  |
| tetragon.tetragon.image.repository | string | `"quay.io/cilium/tetragon"` |  |
| tetragon.tetragon.image.tag | string | `"v1.7.1"` |  |
| tetragon.tetragon.livenessProbe | object | `{}` | Overrides the default livenessProbe for the tetragon container. |
| tetragon.tetragon.nameOverride | string | `""` |  |
| tetragon.tetragon.podAnnotations.enabled | bool | `false` |  |
| tetragon.tetragon.pprof.address | string | `"localhost"` | The address at which to expose pprof. |
| tetragon.tetragon.pprof.enabled | bool | `false` | Whether to enable exposing pprof server. |
| tetragon.tetragon.pprof.port | int | `6060` | The port at which to expose pprof. |
| tetragon.tetragon.processAncestors.enabled | string | `""` | Comma-separated list of process event types to enable ancestors for. Supported event types are: base, kprobe, tracepoint, loader, uprobe, lsm, usdt. Unknown event types will be ignored. Type "base" is required by all other supported event types for correct reference counting. Set it to "" to disable ancestors completely. |
| tetragon.tetragon.processCacheGCInterval | string | `"30s"` | Configure the interval (suffixed with s for seconds, m for minutes, etc) for the process cache garbage collector. |
| tetragon.tetragon.processCacheSize | int | `65536` | Tetragon puts processes in an LRU cache. The cache is used to find ancestors for subsequently exec'ed processes. |
| tetragon.tetragon.prometheus.address | string | `""` | The address at which to expose metrics. Set it to "" to expose on all available interfaces. |
| tetragon.tetragon.prometheus.enabled | bool | `true` | Whether to enable exposing Tetragon metrics. |
| tetragon.tetragon.prometheus.metricsLabelFilter | string | `"namespace,workload,pod,binary"` | Comma-separated list of enabled metrics labels. The configurable labels are: namespace, workload, pod, binary. Unknown labels will be ignored. Removing some labels from the list might help reduce the metrics cardinality if needed. |
| tetragon.tetragon.prometheus.port | int | `2112` | The port at which to expose metrics. |
| tetragon.tetragon.prometheus.serviceMonitor.enabled | bool | `false` | Whether to create a 'ServiceMonitor' resource targeting the tetragon pods. |
| tetragon.tetragon.prometheus.serviceMonitor.extraLabels | object | `{}` | Extra labels to be added on the Tetragon ServiceMonitor. |
| tetragon.tetragon.prometheus.serviceMonitor.labelsOverride | object | `{}` | The set of labels to place on the 'ServiceMonitor' resource. |
| tetragon.tetragon.prometheus.serviceMonitor.scrapeInterval | string | `"60s"` | Interval at which metrics should be scraped. If not specified, Prometheus' global scrape interval is used. |
| tetragon.tetragon.redactionFilters | string | `""` | Filters to redact secrets from the args fields in Tetragon events. To perform redactions, redaction filters define RE2 regular expressions in the `redact` field. Any capture groups in these RE2 regular expressions are redacted and replaced with "*****".  For more control, you can select which binary or binaries should have their arguments redacted with the `binary_regex` field.  NOTE: This feature uses RE2 as its regular expression library. Make sure that you follow RE2 regular expression guidelines as you may observe unexpected results otherwise. More information on RE2 syntax can be found [here](https://github.com/google/re2/wiki/Syntax).  NOTE: When writing regular expressions in JSON, it is important to escape backslash characters. For instance `\Wpasswd\W?` would be written as `{"redact": "\\Wpasswd\\W?"}`.  As a concrete example, the following will redact all passwords passed to processes with the "--password" argument:    {"redact": ["--password(?:\\s+|=)(\\S*)"]}  Now, an event which contains the string "--password=foo" would have that string replaced with "--password=*****".  Suppose we also see some passwords passed via the -p shorthand for a specific binary, foo. We can also redact these as follows:    {"binary_regex": ["(?:^|/)foo$"], "redact": ["-p(?:\\s+|=)(\\S*)"]}  With both of the above redaction filters in place, we are now redacting all password arguments. |
| tetragon.tetragon.resources | object | `{"limits":{"memory":"1Gi"},"requests":{"cpu":"100m","memory":"256Mi"}}` | Resources of the Tetragon agent container. The agent keeps its process cache (`processCacheSize`) and its BPF maps in memory, so memory scales with the number of processes on the node rather than with the request rate. Only memory is capped: a CPU limit would throttle the ring buffer reader and lose events. |
| tetragon.tetragon.securityContext.privileged | bool | `true` |  |
| tetragon.tetragon.usePerfRingBuffer | bool | `false` |  |
| tetragon.tetragonOperator.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.labelSelector.matchLabels."app.kubernetes.io/name" | string | `"tetragon-operator"` |  |
| tetragon.tetragonOperator.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.topologyKey | string | `"kubernetes.io/hostname"` |  |
| tetragon.tetragonOperator.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].weight | int | `100` |  |
| tetragon.tetragonOperator.annotations | object | `{}` | Annotations for the Tetragon Operator Deployment. |
| tetragon.tetragonOperator.containerSecurityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"runAsGroup":65532,"runAsNonRoot":true,"runAsUser":65532}` | securityContext for the Tetragon Operator Deployment Pod container. |
| tetragon.tetragonOperator.enabled | bool | `true` | Enables the Tetragon Operator. |
| tetragon.tetragonOperator.extraLabels | object | `{}` | Extra labels to be added on the Tetragon Operator Deployment. |
| tetragon.tetragonOperator.extraPodLabels | object | `{}` | Extra labels to be added on the Tetragon Operator Deployment Pods. |
| tetragon.tetragonOperator.extraVolumeMounts | list | `[]` |  |
| tetragon.tetragonOperator.extraVolumes | list | `[]` | Extra volumes for the Tetragon Operator Deployment. |
| tetragon.tetragonOperator.failoverLease | object | `{"enabled":false,"leaseDuration":"15s","leaseRenewDeadline":"5s","leaseRetryPeriod":"2s","namespace":""}` | Lease handling for an automated failover when running multiple replicas |
| tetragon.tetragonOperator.failoverLease.enabled | bool | `false` | Enable lease failover functionality |
| tetragon.tetragonOperator.failoverLease.leaseDuration | string | `"15s"` | If a lease is not renewed for X duration, the current leader is considered dead, a new leader is picked |
| tetragon.tetragonOperator.failoverLease.leaseRenewDeadline | string | `"5s"` | The interval at which the leader will renew the lease |
| tetragon.tetragonOperator.failoverLease.leaseRetryPeriod | string | `"2s"` | The timeout between retries if renewal fails |
| tetragon.tetragonOperator.failoverLease.namespace | string | `""` | Kubernetes Namespace in which the Lease resource is created. Defaults to the namespace where Tetragon is deployed in, if it's empty. |
| tetragon.tetragonOperator.forceUpdateCRDs | bool | `false` |  |
| tetragon.tetragonOperator.image | object | `{"override":null,"pullPolicy":"IfNotPresent","repository":"quay.io/cilium/tetragon-operator","tag":"v1.7.1"}` | tetragon-operator image. |
| tetragon.tetragonOperator.nameOverride | string | `""` | The name of the Tetragon Operator deployment. |
| tetragon.tetragonOperator.nodeSelector | object | `{}` | Steer the Tetragon Operator Deployment Pod placement via nodeSelector, tolerations and affinity rules. |
| tetragon.tetragonOperator.podAnnotations | object | `{}` | Annotations for the Tetragon Operator Deployment Pods. |
| tetragon.tetragonOperator.podInfo.enabled | bool | `false` | Enables the PodInfo CRD and the controller that reconciles PodInfo custom resources. |
| tetragon.tetragonOperator.podSecurityContext | object | `{}` | securityContext for the Tetragon Operator Deployment Pods. |
| tetragon.tetragonOperator.priorityClassName | string | `""` | priorityClassName for the Tetragon Operator Deployment Pods. |
| tetragon.tetragonOperator.prometheus.address | string | `""` | The address at which to expose Tetragon Operator metrics. Set it to "" to expose on all available interfaces. |
| tetragon.tetragonOperator.prometheus.enabled | bool | `true` | Enables the Tetragon Operator metrics. |
| tetragon.tetragonOperator.prometheus.port | int | `2113` | The port at which to expose metrics. |
| tetragon.tetragonOperator.prometheus.serviceMonitor.enabled | bool | `false` | Whether to create a 'ServiceMonitor' resource targeting the tetragonOperator pods. |
| tetragon.tetragonOperator.prometheus.serviceMonitor.extraLabels | object | `{}` | Extra labels to be added on the Tetragon Operator ServiceMonitor. |
| tetragon.tetragonOperator.prometheus.serviceMonitor.labelsOverride | object | `{}` | The set of labels to place on the 'ServiceMonitor' resource. |
| tetragon.tetragonOperator.prometheus.serviceMonitor.scrapeInterval | string | `"60s"` | Interval at which metrics should be scraped. If not specified, Prometheus' global scrape interval is used. |
| tetragon.tetragonOperator.replicas | int | `1` | Number of replicas to run for the tetragon-operator deployment |
| tetragon.tetragonOperator.resources | object | `{"limits":{"cpu":"500m","memory":"128Mi"},"requests":{"cpu":"10m","memory":"64Mi"}}` | resources for the Tetragon Operator Deployment Pod container. |
| tetragon.tetragonOperator.securityContext | object | `{}` | securityContext for the Tetragon Operator Deployment Pod container. (DEPRECATED: Use containerSecurityContext instead. TODO: Remove in v1.6.0) |
| tetragon.tetragonOperator.serviceAccount | object | `{"annotations":{},"create":true,"name":""}` | tetragon-operator service account. |
| tetragon.tetragonOperator.strategy | object | `{"rollingUpdate":{"maxSurge":1,"maxUnavailable":0},"type":"RollingUpdate"}` | resources for the Tetragon Operator Deployment update strategy |
| tetragon.tetragonOperator.tolerations | list | `[]` |  |
| tetragon.tetragonOperator.tracingPolicy.enabled | bool | `true` | Enables the TracingPolicy and TracingPolicyNamespaced CRD creation. |
| tetragon.tolerations[0].operator | string | `"Exists"` |  |
| tetragon.updateStrategy | object | `{}` |  |
| tracingPolicies.enabled | bool | `true` | Render the TracingPolicy resources of this chart. The CRDs they need are created by the Tetragon operator (`crds.installMethod`) |
| tracingPolicies.enforcement.enabled | bool | `false` | Install the bundled enforcement policies. These policies SIGKILL the process that matched, which can take down a legitimate workload if its behaviour was not reviewed first — keep this off until it was |
| tracingPolicies.enforcement.namespaces | list | `[]` | Namespaces the enforcement policies are installed into, as TracingPolicyNamespaced resources. An empty list enforces nothing, which is what keeps enforcement opt-in per workload namespace instead of cluster-wide |
| tracingPolicies.enforcement.policies | list | `[]` | Bundled enforcement policies to install, by file name (without the extension) in `resources/tracing-policies/enforcement` |
| tracingPolicies.extra | list | `[]` | Policies defined inline instead of coming from the bundles. Each item: `name` (required), `spec` (required, a TracingPolicy spec), `namespace` (optional — when set the policy is rendered as a TracingPolicyNamespaced in that namespace instead of cluster-wide) |
| tracingPolicies.observation.enabled | bool | `true` | Install the bundled observation policies. They carry no enforcing action, they only make the matching kernel events show up in the Tetragon event stream |
| tracingPolicies.observation.policies | list | `["sensitive-file-access","process-credential-changes"]` | Bundled observation policies to install, by file name (without the extension) in `resources/tracing-policies/observation`. Installed cluster-wide as TracingPolicy resources |
| victoriaMetrics.enabled | bool | `false` | Render VMServiceScrape and VMRule resources instead of Prometheus Operator resources |
| victoriaMetrics.rules.enabled | bool | `true` | Render the bundled alert groups as VMRules |
| victoriaMetrics.serviceScrapes.enabled | bool | `true` | Scrape both the Tetragon agent and its operator |
| victoriaMetrics.serviceScrapes.interval | string | `"30s"` | Interval used for both metrics endpoints |

## Runtime security posture

The chart installs the Tetragon agent DaemonSet and the operator that owns the
TracingPolicy CRDs, and on top of them two bundles of policies that this
repository ships in `resources/tracing-policies`:

| Bundle | Rendered as | Default | Effect |
|--------|-------------|---------|--------|
| `observation` | `TracingPolicy` (cluster-wide) | installed | reports the matching kernel events, changes no workload behaviour |
| `enforcement` | `TracingPolicyNamespaced` (per namespace) | not installed | **SIGKILLs** the process that matched |

Process execution and exit visibility needs no policy at all: the agent reports
`PROCESS_EXEC` and `PROCESS_EXIT` for every container as soon as it runs.

Enforcement takes two explicit decisions, a policy and a namespace, and stays
off until both are made:

```yaml
tracingPolicies:
  enforcement:
    enabled: true
    policies:
      - block-sensitive-file-write
    namespaces:
      - a-namespace-whose-workloads-you-have-already-observed
```

Policies that are not in either bundle go to `tracingPolicies.extra`, which
renders a `TracingPolicy` (or a `TracingPolicyNamespaced`, when `namespace` is
set) from an inline spec.

### Notes on the node

* The agent runs privileged, on the host network and with the host `/proc`
  mounted. That is what the eBPF sensor needs; on a cluster with Pod Security
  admission the namespace it runs in must be labelled
  `pod-security.kubernetes.io/enforce: privileged`.
* `crds.installMethod` is left at the upstream default, `operator`: the Tetragon
  operator creates the CRDs. The policy resources of this chart carry an Argo CD
  sync wave so they are applied after the operator, not before it.
* Talos Linux 1.12+ needs the upstream chart's `tetragon.extraHostPathMounts`
  setting for `/sys/kernel/tracing` on the agent DaemonSet.

## Monitoring

The upstream chart's `ServiceMonitor` resources and this wrapper's
`PrometheusRule` resources require Prometheus Operator CRDs. On a cluster with
VictoriaMetrics only, leave `prometheus.enabled: false`, enable the wrapper's
`victoriaMetrics` resources, and turn off both upstream `serviceMonitor`
switches. Keep the upstream metrics endpoints enabled so their Services exist:

```yaml
prometheus:
  enabled: false
victoriaMetrics:
  enabled: true
tetragon:
  tetragon:
    prometheus:
      enabled: true
      serviceMonitor:
        enabled: false
  tetragonOperator:
    prometheus:
      enabled: true
      serviceMonitor:
        enabled: false
```

The wrapper then renders two `VMServiceScrape` resources and the bundled alerts
as `VMRule` resources. The dashboard ConfigMap is available in either mode.

## Installing the Chart

### With Helm

To install the chart with the release name `my-release`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/tetragon
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: tetragon
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.1"
    chart: tetragon
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
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/tetragon --config /charts/charts/tetragon/ct.yaml
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template tetragon . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```
