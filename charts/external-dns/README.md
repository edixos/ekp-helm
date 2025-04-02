# external-dns

![Version: 0.1.1](https://img.shields.io/badge/Version-0.1.1-informational?style=flat-square) ![AppVersion: 0.16.1](https://img.shields.io/badge/AppVersion-0.16.1-informational?style=flat-square)

## Prerequisites

- Helm v3
- Config Connector installed (v1.6.0)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://edixos.github.io/ekp-helm | iamPolicyMembers(gcp-iam-policy-members) | 0.1.2 |
| https://edixos.github.io/ekp-helm | workloadIdentity(gcp-workload-identity) | 0.1.1 |
| https://kubernetes-sigs.github.io/external-dns/ | externaldns(external-dns) | 1.16.0 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| ilyasabdellaoui | <ilyas.abdellaoui21@gmail.com> | <https://github.com/ilyasabdellaoui> |

## Description

Deploys external-dns and its monitoring

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| externaldns.affinity | object | `{}` | Affinity settings for `Pod` [scheduling](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/). If an explicit label selector is not provided for pod affinity or pod anti-affinity one will be created from the pod selector labels. |
| externaldns.automountServiceAccountToken | bool | `nil` | Set this to `false` to [opt out of API credential automounting](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#opt-out-of-api-credential-automounting) for the `Pod`. |
| externaldns.commonLabels | object | `{}` | Labels to add to all chart resources. |
| externaldns.deploymentAnnotations | object | `{}` | Annotations to add to the `Deployment`. |
| externaldns.deploymentStrategy | object | `{"type":"Recreate"}` | [Deployment Strategy](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy). |
| externaldns.dnsConfig | object | `nil` | [DNS config](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#pod-dns-config) for the pod, if not set the default will be used. |
| externaldns.dnsPolicy | string | `nil` | [DNS policy](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#pod-s-dns-policy) for the pod, if not set the default will be used. |
| externaldns.domainFilters | list | `[]` | Limit possible target zones by domain suffixes. |
| externaldns.env | list | `[]` | [Environment variables](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/) for the `external-dns` container. |
| externaldns.excludeDomains | list | `[]` | Intentionally exclude domains from being managed. |
| externaldns.extraArgs | list | `[]` | Extra arguments to provide to _ExternalDNS_. |
| externaldns.extraContainers | object | `{}` | Extra containers to add to the `Deployment`. |
| externaldns.extraVolumeMounts | list | `[]` | Extra [volume mounts](https://kubernetes.io/docs/concepts/storage/volumes/) for the `external-dns` container. |
| externaldns.extraVolumes | list | `[]` | Extra [volumes](https://kubernetes.io/docs/concepts/storage/volumes/) for the `Pod`. |
| externaldns.fullnameOverride | string | `nil` | Override the full name of the chart. |
| externaldns.global.imagePullSecrets | list | `[]` | Global image pull secrets. |
| externaldns.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy for the `external-dns` container. |
| externaldns.image.repository | string | `"registry.k8s.io/external-dns/external-dns"` | Image repository for the `external-dns` container. |
| externaldns.image.tag | string | `nil` | Image tag for the `external-dns` container, this will default to `.Chart.AppVersion` if not set. |
| externaldns.imagePullSecrets | list | `[]` | Image pull secrets. |
| externaldns.initContainers | list | `[]` | [Init containers](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) to add to the `Pod` definition. |
| externaldns.interval | string | `"1m"` | Interval for DNS updates. |
| externaldns.labelFilter | string | `nil` | Filter resources queried for endpoints by label selector |
| externaldns.livenessProbe | object | See _values.yaml_ | [Liveness probe](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) configuration for the `external-dns` container. |
| externaldns.logFormat | string | `"text"` | Log format. |
| externaldns.logLevel | string | `"info"` | Log level. |
| externaldns.managedRecordTypes | list | `[]` | Record types to manage (default: A, AAAA, CNAME) |
| externaldns.nameOverride | string | `nil` | Override the name of the chart. |
| externaldns.namespaced | bool | `false` | if `true`, _ExternalDNS_ will run in a namespaced scope (`Role`` and `Rolebinding`` will be namespaced too). |
| externaldns.nodeSelector | object | `{}` | Node labels to match for `Pod` [scheduling](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/). |
| externaldns.podAnnotations | object | `{}` | Annotations to add to the `Pod`. |
| externaldns.podLabels | object | `{}` | Labels to add to the `Pod`. |
| externaldns.podSecurityContext | object | See _values.yaml_ | [Pod security context](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.22/#podsecuritycontext-v1-core), this supports full customisation. |
| externaldns.policy | string | `"upsert-only"` | How DNS records are synchronized between sources and providers; available values are `sync` & `upsert-only`. |
| externaldns.priorityClassName | string | `nil` | Priority class name for the `Pod`. |
| externaldns.provider.name | string | `"aws"` | _ExternalDNS_ provider name; for the available providers and how to configure them see [README](https://github.com/kubernetes-sigs/external-dns/blob/master/charts/external-dns/README.md#providers). |
| externaldns.provider.webhook.args | list | `[]` | Extra arguments to provide for the `webhook` container. |
| externaldns.provider.webhook.env | list | `[]` | [Environment variables](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/) for the `webhook` container. |
| externaldns.provider.webhook.extraVolumeMounts | list | `[]` | Extra [volume mounts](https://kubernetes.io/docs/concepts/storage/volumes/) for the `webhook` container. |
| externaldns.provider.webhook.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy for the `webhook` container. |
| externaldns.provider.webhook.image.repository | string | `nil` | Image repository for the `webhook` container. |
| externaldns.provider.webhook.image.tag | string | `nil` | Image tag for the `webhook` container. |
| externaldns.provider.webhook.livenessProbe | object | See _values.yaml_ | [Liveness probe](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) configuration for the `external-dns` container. |
| externaldns.provider.webhook.readinessProbe | object | See _values.yaml_ | [Readiness probe](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) configuration for the `webhook` container. |
| externaldns.provider.webhook.resources | object | `{}` | [Resources](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/) for the `webhook` container. |
| externaldns.provider.webhook.securityContext | object | See _values.yaml_ | [Pod security context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container) for the `webhook` container. |
| externaldns.provider.webhook.service.port | int | `8080` | Webhook exposed HTTP port for the service. |
| externaldns.provider.webhook.serviceMonitor | object | See _values.yaml_ | Optional [Service Monitor](https://prometheus-operator.dev/docs/operator/design/#servicemonitor) configuration for the `webhook` container. |
| externaldns.rbac.additionalPermissions | list | `[]` | Additional rules to add to the `ClusterRole`. |
| externaldns.rbac.create | bool | `true` | If `true`, create a `ClusterRole` & `ClusterRoleBinding` with access to the Kubernetes API. |
| externaldns.readinessProbe | object | See _values.yaml_ | [Readiness probe](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) configuration for the `external-dns` container. |
| externaldns.registry | string | `"txt"` | Specify the registry for storing ownership and labels. Valid values are `txt`, `aws-sd`, `dynamodb` & `noop`. |
| externaldns.resources | object | `{}` | [Resources](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/) for the `external-dns` container. |
| externaldns.revisionHistoryLimit | int | `nil` | Specify the number of old `ReplicaSets` to retain to allow rollback of the `Deployment``. |
| externaldns.secretConfiguration.data | object | `{}` | `Secret` data. |
| externaldns.secretConfiguration.enabled | bool | `false` | If `true`, create a `Secret` to store sensitive provider configuration (**DEPRECATED**). |
| externaldns.secretConfiguration.mountPath | string | `nil` | Mount path for the `Secret`, this can be templated. |
| externaldns.secretConfiguration.subPath | string | `nil` | Sub-path for mounting the `Secret`, this can be templated. |
| externaldns.securityContext | object | See _values.yaml_ | [Security context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container) for the `external-dns` container. |
| externaldns.service.annotations | object | `{}` | Service annotations. |
| externaldns.service.ipFamilies | list | `[]` | Service IP families (e.g. IPv4 and/or IPv6). |
| externaldns.service.ipFamilyPolicy | string | `nil` | Service IP family policy. |
| externaldns.service.port | int | `7979` | Service HTTP port. |
| externaldns.serviceAccount.annotations | object | `{}` | Annotations to add to the service account. Templates are allowed in both the key and the value. Example: `example.com/annotation/{{ .Values.nameOverride }}: {{ .Values.nameOverride }}` |
| externaldns.serviceAccount.automountServiceAccountToken | string | `nil` | Set this to `false` to [opt out of API credential automounting](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#opt-out-of-api-credential-automounting) for the `ServiceAccount`. |
| externaldns.serviceAccount.create | bool | `true` | If `true`, create a new `ServiceAccount`. |
| externaldns.serviceAccount.labels | object | `{}` | Labels to add to the service account. |
| externaldns.serviceAccount.name | string | `nil` | If this is set and `serviceAccount.create` is `true` this will be used for the created `ServiceAccount` name, if set and `serviceAccount.create` is `false` then this will define an existing `ServiceAccount` to use. |
| externaldns.serviceMonitor.additionalLabels | object | `{}` | Additional labels for the `ServiceMonitor`. |
| externaldns.serviceMonitor.annotations | object | `{}` | Annotations to add to the `ServiceMonitor`. |
| externaldns.serviceMonitor.bearerTokenFile | string | `nil` | Provide a bearer token file for the `ServiceMonitor`. |
| externaldns.serviceMonitor.enabled | bool | `false` | If `true`, create a `ServiceMonitor` resource to support the _Prometheus Operator_. |
| externaldns.serviceMonitor.interval | string | `nil` | If set override the _Prometheus_ default interval. |
| externaldns.serviceMonitor.metricRelabelings | list | `[]` | [Metric relabel configs](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs) to apply to samples before ingestion. |
| externaldns.serviceMonitor.namespace | string | `nil` | If set create the `ServiceMonitor` in an alternate namespace. |
| externaldns.serviceMonitor.relabelings | list | `[]` | [Relabel configs](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config) to apply to samples before ingestion. |
| externaldns.serviceMonitor.scheme | string | `nil` | If set overrides the _Prometheus_ default scheme. |
| externaldns.serviceMonitor.scrapeTimeout | string | `nil` | If set override the _Prometheus_ default scrape timeout. |
| externaldns.serviceMonitor.targetLabels | list | `[]` | Provide target labels for the `ServiceMonitor`. |
| externaldns.serviceMonitor.tlsConfig | object | `{}` | Configure the `ServiceMonitor` [TLS config](https://github.com/coreos/prometheus-operator/blob/master/Documentation/api.md#tlsconfig). |
| externaldns.shareProcessNamespace | bool | `false` | If `true`, the `Pod` will have [process namespace sharing](https://kubernetes.io/docs/tasks/configure-pod-container/share-process-namespace/) enabled. |
| externaldns.sources | list | `["service","ingress"]` | _Kubernetes_ resources to monitor for DNS entries. |
| externaldns.terminationGracePeriodSeconds | int | `nil` | Termination grace period for the `Pod` in seconds. |
| externaldns.tolerations | list | `[]` | Node taints which will be tolerated for `Pod` [scheduling](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/). |
| externaldns.topologySpreadConstraints | list | `[]` | Topology spread constraints for `Pod` [scheduling](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/). If an explicit label selector is not provided one will be created from the pod selector labels. |
| externaldns.triggerLoopOnEvent | bool | `false` | If `true`, triggers run loop on create/update/delete events in addition of regular interval. |
| externaldns.txtOwnerId | string | `nil` | Specify an identifier for this instance of _ExternalDNS_ wWhen using a registry other than `noop`. |
| externaldns.txtPrefix | string | `nil` | Specify a prefix for the domain names of TXT records created for the `txt` registry. Mutually exclusive with `txtSuffix`. |
| externaldns.txtSuffix | string | `nil` | Specify a suffix for the domain names of TXT records created for the `txt` registry. Mutually exclusive with `txtPrefix`. |
| global.abandon | bool | `false` | Activate abandon of the resources (If true, the GCP resources will be keep after deleting k8s resources) |
| global.cnrmNamespace | string | `"cnrm-system"` | Allows to deploy in another namespace than the release one |
| global.gcpProjectId | string | `""` |  |
| iamPolicyMembers.members[0].member | string | `""` |  |
| iamPolicyMembers.members[0].name | string | `"external-dns-gsa"` |  |
| iamPolicyMembers.members[0].resourceRef.external | string | `""` |  |
| iamPolicyMembers.members[0].resourceRef.kind | string | `"Project"` |  |
| iamPolicyMembers.members[0].role | string | `"roles/dns.admin"` | Roles to apply to external-dns google service account |
| prometheus.enabled | bool | `false` | Enables Prometheus Operator monitoring |
| prometheus.grafanaDashboard.enabled | bool | `true` | Add grafana dashboard as a configmap |
| prometheus.grafanaDashboard.label | object | `{"grafana_dashboard":"1"}` | label to apply to the config map. Used by Grafana sidecar to automatically install the dashboard |
| prometheus.rules.enabled | bool | `true` | Enables prometheus operator rules |
| prometheus.rules.labels | object | `{"prometheus":"prometheus-operator-prometheus"}` | Labels to affect to the Prometheus Rules |
| tags.configConnector | bool | `false` | Enables Config Connector features |
| workloadIdentity.global.gsa.create | bool | `true` |  |
| workloadIdentity.global.gsa.name | string | `"wi-k8s"` |  |
| workloadIdentity.global.gsa.project | string | `""` |  |
| workloadIdentity.global.ksa.name | string | `"default"` |  |
| workloadIdentity.global.ksa.namespace | string | `""` |  |

## Installing the Chart

### With Helm

To install the chart with the release name `my-release`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/external-dns
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: external-dns
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.1"
    chart: external-dns
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
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/external-dns --config /charts/charts/external-dns/ct.yaml
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template external-dns . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```

