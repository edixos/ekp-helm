# victoria-metrics-k8s-stack

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.148.0](https://img.shields.io/badge/AppVersion-v1.148.0-informational?style=flat-square)

## Prerequisites

- Helm v3
- Kubernetes 1.25 or newer
- A default StorageClass, or explicit storage configuration in the chart values

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://victoriametrics.github.io/helm-charts/ | vmstack(victoria-metrics-k8s-stack) | 0.87.0 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| hamzatalbi | <hamzatalbi831@gmail.com> | <https://github.com/TalbiHamza> |

## Description

Kubernetes monitoring on VictoriaMetrics, packaged for the Edixos Kubernetes Platform. Wraps the upstream VictoriaMetrics K8s Stack chart, including the VictoriaMetrics Operator and CRDs, VMAgent, VictoriaMetrics storage, VMAlert, Grafana, kube-state-metrics, node-exporter, Kubernetes scrape resources, recording and alerting rules, and curated dashboards. Adds optional EKP file-backed Grafana dashboards, PrometheusRule resources, and ExternalSecrets for GitOps and externally managed monitoring integrations. All upstream settings are available under the vmstack values key.

The upstream chart is exposed through the `vmstack` dependency alias. Prefix
all upstream values with `vmstack`, for example:

```yaml
vmstack:
  nameOverride: vmks
  vmsingle:
    spec:
      retentionPeriod: "30d"
```

The upstream defaults deploy `VMSingle`. To use VictoriaMetrics cluster mode:

```yaml
vmstack:
  nameOverride: vmks
  vmsingle:
    enabled: false
  vmcluster:
    enabled: true
    spec:
      retentionPeriod: "30d"
      replicationFactor: 2
      vmstorage:
        replicaCount: 3
        storage:
          volumeClaimTemplate:
            spec:
              storageClassName: your-storage-class
              resources:
                requests:
                  storage: 20Gi
```

### Optional EKP dashboards and Prometheus rules

The upstream K8s Stack already creates dashboards and `VMRule` resources with
its sync job. The EKP wrapper also packages the same curated VMCluster,
vmagent, and process-health content as files. Enable this alternative when an
external Grafana sidecar or Prometheus Operator should own those resources:

```yaml
global:
  enableArgocdAnnotations: true

prometheus:
  enabled: true
  rules:
    labels:
      prometheus: prometheus-operator-prometheus

vmstack:
  # Prevent duplicate dashboard UIDs and alert names.
  syncJob:
    enabled: false
```

The `PrometheusRule` CRD must exist when `prometheus.enabled` is true. Leave
the EKP resources disabled when using the stack's native `VMRule` resources.

### ExternalSecrets

`externalSecrets` can create credentials before the stack consumes them. For
example, provision Grafana's admin Secret without storing credentials in Git:

```yaml
externalSecrets:
  - name: vmstack-grafana-admin
    namespace: monitoring
    syncWave: "-1"
    spec:
      secretStoreRef:
        kind: ClusterSecretStore
        name: scaleway-secret-manager
      target:
        name: vmstack-grafana-admin
      data:
        - secretKey: admin-user
          remoteRef:
            key: vmstack-grafana-admin-user
        - secretKey: admin-password
          remoteRef:
            key: vmstack-grafana-admin-password

vmstack:
  grafana:
    admin:
      existingSecret: vmstack-grafana-admin
      userKey: admin-user
      passwordKey: admin-password
```

## Source Code

* <https://github.com/VictoriaMetrics/helm-charts/tree/master/charts/victoria-metrics-k8s-stack>
* <https://docs.victoriametrics.com/helm/victoria-metrics-k8s-stack/>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| externalSecrets | list | `[]` | ExternalSecrets rendered for credentials consumed by the stack, such as Grafana admin credentials, VictoriaMetrics enterprise licenses, authenticated external read/write endpoints, VMAuth users, or Alertmanager integrations. Each item accepts `name`, optional `namespace` and `syncWave`, plus the ExternalSecret `spec` verbatim. |
| global.enableArgocdAnnotations | bool | `false` | Annotate the platform extension resources with Argo CD sync options, so Argo CD does not dry-run them against CRDs that are not installed yet |
| prometheus.enabled | bool | `false` | Render the EKP PrometheusRule and Grafana dashboard resources |
| prometheus.grafanaDashboard.enabled | bool | `true` | Render the official VMCluster and vmagent dashboards in a ConfigMap |
| prometheus.grafanaDashboard.label | object | `{"grafana_dashboard":"1"}` | Labels used by a Grafana dashboard sidecar to discover the ConfigMap |
| prometheus.rules.enabled | bool | `true` | Render curated PrometheusRule resources for VMCluster, vmagent and VictoriaMetrics process health |
| prometheus.rules.labels | object | `{"prometheus":"prometheus-operator-prometheus"}` | Labels applied to every PrometheusRule. Adjust these to match the Prometheus ruleSelector in the target cluster. |
| vmstack.additionalVictoriaMetricsMap | object | `{}` | deprecated. use extraRules instead |
| vmstack.alertmanager.annotations | object | `{}` | VMAlertmanager annotations |
| vmstack.alertmanager.config | object | `{"receivers":[{"name":"blackhole"}],"route":{"receiver":"blackhole"}}` | VMAlertmanager configuration |
| vmstack.alertmanager.enabled | bool | `true` | Create VMAlertmanager CR |
| vmstack.alertmanager.ingress | object | `{"annotations":{},"enabled":false,"extraPaths":[],"hosts":["alertmanager.domain.com"],"labels":{},"path":"{{ .Values.alertmanager.spec.routePrefix | default \"/\" }}","pathType":"Prefix","tls":[]}` | VMAlertmanager ingress configuration |
| vmstack.alertmanager.ingress.extraPaths | list | `[]` | Extra paths to prepend to every host configuration. This is useful when working with annotation based services. |
| vmstack.alertmanager.labels | object | `{}` | VMAlertmanager labels |
| vmstack.alertmanager.monzoTemplate | object | `{"enabled":true}` | Better alert templates for [slack source](https://gist.github.com/milesbxf/e2744fc90e9c41b47aa47925f8ff6512) |
| vmstack.alertmanager.route | object | `{"annotations":{},"enabled":false,"extraRules":[],"filters":[],"hostnames":[],"labels":{},"matches":[{"path":{"type":"PathPrefix","value":"{{ .Values.alertmanager.spec.routePrefix | default \"/\" }}"}}],"parentRefs":[],"port":"{{ .Values.alertmanager.spec.port }}"}` | VMAlertmanager route configuration |
| vmstack.alertmanager.route.annotations | object | `{}` | HTTPRoute annotations |
| vmstack.alertmanager.route.enabled | bool | `false` | Enable deployment of HTTPRoute for alertmanager component |
| vmstack.alertmanager.route.extraRules | list | `[]` | Extra rules to prepend to route. This is useful when working with annotation based services. |
| vmstack.alertmanager.route.filters | list | `[]` | Filters for a default rule in HTTPRoute |
| vmstack.alertmanager.route.hostnames | list | `[]` | Array of hostnames |
| vmstack.alertmanager.route.labels | object | `{}` | HTTPRoute extra labels |
| vmstack.alertmanager.route.matches | list | `[{"path":{"type":"PathPrefix","value":"{{ .Values.alertmanager.spec.routePrefix | default \"/\" }}"}}]` | Matches for a default rule in HTTPRoute |
| vmstack.alertmanager.route.parentRefs | list | `[]` | HTTPGateway objects refs |
| vmstack.alertmanager.route.port | string | `"{{ .Values.alertmanager.spec.port }}"` | Route port |
| vmstack.alertmanager.spec | object | `{"configSecret":"","externalURL":"","image":{"tag":"v0.32.1"},"port":"9093","replicaCount":1,"routePrefix":"/","selectAllByDefault":true}` | Full spec for VMAlertmanager CRD. Allowed values described [here](https://docs.victoriametrics.com/operator/api/#vmalertmanagerspec) |
| vmstack.alertmanager.spec.configSecret | string | `""` | If this one defined, it will be used for alertmanager configuration and config parameter will be ignored |
| vmstack.alertmanager.templateFiles | object | `{}` | Extra alert templates |
| vmstack.alertmanager.useManagedConfig | bool | `false` |
enable storing .Values.alertmanager.config in VMAlertmanagerConfig instead of k8s Secret.
Note: VMAlertmanagerConfig and plain VMAlertmanager config structures are not equal.
If you're migrating existing config, please make sure that `.Values.alertmanager.config`:
- with `useManagedConfig: false` has structure described [here](https://prometheus.io/docs/alerting/latest/configuration/).
- with `useManagedConfig: true` has structure described [here](https://docs.victoriametrics.com/operator/api/#vmalertmanagerconfig). |
| vmstack.argocdReleaseOverride | string | `""` | If this chart is used in "Argocd" with "releaseName" field then VMServiceScrapes couldn't select the proper services. For correct working need set value 'argocdReleaseOverride=$ARGOCD_APP_NAME' |
| vmstack.coreDns.enabled | bool | `true` | Enabled CoreDNS metrics scraping |
| vmstack.coreDns.service.enabled | bool | `true` | Create service for CoreDNS metrics |
| vmstack.coreDns.service.labels | object | `{}` | CoreDNS service labels |
| vmstack.coreDns.service.port | int | `9153` | CoreDNS service port |
| vmstack.coreDns.service.selector | object | `{"k8s-app":"kube-dns"}` | CoreDNS service pod selector |
| vmstack.coreDns.service.targetPort | int | `9153` | CoreDNS service target port |
| vmstack.coreDns.vmScrape | object | `{"spec":{"endpoints":[{"bearerTokenFile":"/var/run/secrets/kubernetes.io/serviceaccount/token","port":"http-metrics"}],"jobLabel":"app.kubernetes.io/component","namespaceSelector":{"matchNames":[]}}}` | Spec for VMServiceScrape CRD is [here](https://docs.victoriametrics.com/operator/api/#vmservicescrapespec) |
| vmstack.defaultDashboards.annotations | object | `{}` | Additional annotations for dashboard resources |
| vmstack.defaultDashboards.dashboards | object | `{"alertmanager-overview":{"enabled":"{{ .Values.alertmanager.enabled }}"},"controller-manager":{"enabled":"{{ .Values.kubeControllerManager.enabled }}"},"grafana-overview":{"enabled":"{{ .Values.grafana.enabled }}"},"kubelet":{"enabled":"{{ .Values.kubelet.enabled }}"},"node-exporter-full":{"clusterMetric":"node_uname_info","enabled":true},"proxy":{"enabled":"{{ .Values.kubeProxy.enabled }}"},"scheduler":{"enabled":"{{ .Values.kubeScheduler.enabled }}"},"victorialogs-cluster":{"clusterMetric":"vm_app_version"},"victorialogs-single-node":{"clusterMetric":"vm_app_version"},"victorialogs-vlagent":{"clusterMetric":"vm_app_version"},"victoriametrics-cluster":{"clusterMetric":"vm_app_version"},"victoriametrics-operator":{"clusterMetric":"vm_app_version","enabled":true},"victoriametrics-single-node":{"clusterMetric":"vm_app_version"},"victoriametrics-vmagent":{"clusterMetric":"vm_app_version"},"victoriametrics-vmalert":{"clusterMetric":"vm_app_version","enabled":true},"victoriatraces-cluster":{"clusterMetric":"vm_app_version"},"victoriatraces-single-node":{"clusterMetric":"vm_app_version"}}` | Per-dashboard configuration. Keys match dashboard names from JSON content. Set enabled: false to skip a dashboard. Set clusterMetric to patch the cluster variable query. |
| vmstack.defaultDashboards.enabled | bool | `true` | Enable dashboard sync via sync-job |
| vmstack.defaultDashboards.grafanaOperator.enabled | bool | `false` | Create GrafanaDashboard CRDs instead of ConfigMaps (requires grafana-operator) |
| vmstack.defaultDashboards.grafanaOperator.spec.allowCrossNamespaceImport | bool | `false` |  |
| vmstack.defaultDashboards.grafanaOperator.spec.instanceSelector.matchLabels.dashboards | string | `"grafana"` |  |
| vmstack.defaultDashboards.labels | object | `{}` | Additional labels for dashboard resources (ConfigMaps or GrafanaDashboard CRDs) |
| vmstack.defaultDashboards.sources | object | `{"etcd":{"enabled":"{{ .Values.kubeEtcd.enabled }}","url":"https://raw.githubusercontent.com/monitoring-mixins/website/master/assets/etcd/dashboards/etcd.json"},"kube-prometheus":{"url":"https://raw.githubusercontent.com/prometheus-operator/kube-prometheus/main/manifests/grafana-dashboardDefinitions.yaml"},"kubernetes-system-api-server":{"enabled":"{{ .Values.kubeApiServer.enabled }}","url":"https://raw.githubusercontent.com/dotdc/grafana-dashboards-kubernetes/master/dashboards/k8s-system-api-server.json"},"kubernetes-system-coredns":{"enabled":"{{ .Values.coreDns.enabled }}","url":"https://raw.githubusercontent.com/dotdc/grafana-dashboards-kubernetes/master/dashboards/k8s-system-coredns.json"},"kubernetes-views-global":{"url":"https://raw.githubusercontent.com/dotdc/grafana-dashboards-kubernetes/master/dashboards/k8s-views-global.json"},"kubernetes-views-namespaces":{"url":"https://raw.githubusercontent.com/dotdc/grafana-dashboards-kubernetes/master/dashboards/k8s-views-namespaces.json"},"kubernetes-views-nodes":{"url":"https://raw.githubusercontent.com/dotdc/grafana-dashboards-kubernetes/master/dashboards/k8s-views-nodes.json"},"kubernetes-views-pods":{"url":"https://raw.githubusercontent.com/dotdc/grafana-dashboards-kubernetes/master/dashboards/k8s-views-pods.json"},"node-exporter-full":{"enabled":"{{ index .Values \"prometheus-node-exporter\" \"enabled\" }}","url":"https://raw.githubusercontent.com/rfmoz/grafana-dashboards/master/prometheus/node-exporter-full.json"},"victorialogs-cluster":{"enabled":"{{ .Values.vlcluster.enabled }}","url":"https://raw.githubusercontent.com/VictoriaMetrics/VictoriaLogs/master/dashboards/victorialogs-cluster.json"},"victorialogs-single-node":{"enabled":"{{ .Values.vlsingle.enabled }}","url":"https://raw.githubusercontent.com/VictoriaMetrics/VictoriaLogs/master/dashboards/victorialogs.json"},"victorialogs-vlagent":{"enabled":"{{ .Values.vlagent.enabled }}","url":"https://raw.githubusercontent.com/VictoriaMetrics/VictoriaLogs/master/dashboards/vlagent.json"},"victoriametrics-backupmanager":{"enabled":"{{ or (not (empty (dig \"spec\" \"vmBackup\" \"destination\" \"\" .Values.vmsingle))) (not (empty (dig \"spec\" \"storage\" \"vmBackup\" \"destination\" \"\" .Values.vmcluster))) }}","url":"https://raw.githubusercontent.com/VictoriaMetrics/VictoriaMetrics/master/dashboards/backupmanager.json"},"victoriametrics-cluster":{"enabled":"{{ .Values.vmcluster.enabled }}","url":"https://raw.githubusercontent.com/VictoriaMetrics/VictoriaMetrics/master/dashboards/victoriametrics-cluster.json"},"victoriametrics-operator":{"enabled":"{{ index .Values \"victoria-metrics-operator\" \"enabled\" }}","url":"https://raw.githubusercontent.com/VictoriaMetrics/VictoriaMetrics/master/dashboards/operator.json"},"victoriametrics-single-node":{"enabled":"{{ .Values.vmsingle.enabled }}","url":"https://raw.githubusercontent.com/VictoriaMetrics/VictoriaMetrics/master/dashboards/victoriametrics.json"},"victoriametrics-vmagent":{"enabled":"{{ .Values.vmagent.enabled }}","url":"https://raw.githubusercontent.com/VictoriaMetrics/VictoriaMetrics/master/dashboards/vmagent.json"},"victoriametrics-vmalert":{"enabled":"{{ .Values.vmalert.enabled }}","url":"https://raw.githubusercontent.com/VictoriaMetrics/VictoriaMetrics/master/dashboards/vmalert.json"},"victoriatraces-cluster":{"enabled":"{{ .Values.vtcluster.enabled }}","url":"https://raw.githubusercontent.com/VictoriaMetrics/VictoriaTraces/master/dashboards/victoriatraces-cluster.json"},"victoriatraces-single-node":{"enabled":"{{ .Values.vtsingle.enabled }}","url":"https://raw.githubusercontent.com/VictoriaMetrics/VictoriaTraces/master/dashboards/victoriatraces.json"}}` | Dashboard sources. Set enabled: false on any entry to disable it. Add new keys to extend. |
| vmstack.defaultDatasources.alertmanager | object | `{"datasources":[{"access":"proxy","jsonData":{"implementation":"prometheus"},"name":"Alertmanager","uid":"Alertmanager"}]}` | List of alertmanager datasources. VMAlertmanager generated `url` will be added to each datasource in template if alertmanager is enabled |
| vmstack.defaultDatasources.extra | list | `[]` | Configure additional grafana datasources (passed through tpl). Check [here](https://grafana.com/docs/grafana/latest/administration/provisioning/#data-sources) for details |
| vmstack.defaultDatasources.grafanaOperator.annotations | object | `{}` |  |
| vmstack.defaultDatasources.grafanaOperator.enabled | bool | `false` | Create datasources as CRDs (requires grafana-operator to be installed) |
| vmstack.defaultDatasources.grafanaOperator.spec.allowCrossNamespaceImport | bool | `false` |  |
| vmstack.defaultDatasources.grafanaOperator.spec.instanceSelector.matchLabels.dashboards | string | `"grafana"` |  |
| vmstack.defaultDatasources.victorialogs.datasources | list | `[{"access":"proxy","name":"VictoriaLogs (DS)","type":"victoriametrics-logs-datasource","uid":"VictoriaLogs"}]` | List of VictoriaLogs datasource configurations. VL `url` will be added to each of them in templates. |
| vmstack.defaultDatasources.victoriametrics.datasources | list | `[{"access":"proxy","isDefault":true,"name":"VictoriaMetrics","type":"prometheus","uid":"VictoriaMetrics"},{"access":"proxy","isDefault":false,"name":"VictoriaMetrics (DS)","type":"victoriametrics-metrics-datasource","uid":"VictoriaMetricsDS"}]` | List of prometheus compatible datasource configurations. VM `url` will be added to each of them in templates. |
| vmstack.defaultDatasources.victoriatraces.datasources | list | `[{"access":"proxy","name":"VictoriaTraces","type":"jaeger","uid":"VictoriaTraces"}]` | List of VictoriaTraces (Jaeger-compatible) datasource configurations. VT `url` will be added to each of them in templates. |
| vmstack.defaultRules | object | `{"alerting":{"spec":{"annotations":{},"labels":{}}},"annotations":{},"enabled":true,"extraGroupByLabels":[],"group":{"spec":{}},"groups":{"alertmanager.rules":{"rules":{}},"etcd":{"alerting":{},"enabled":true,"recording":{},"rules":{}},"general.rules":{"rules":{}},"k8s.rules.container_cpu_limits":{"rules":{}},"k8s.rules.container_cpu_requests":{"rules":{}},"k8s.rules.container_cpu_usage_seconds_total":{"rules":{}},"k8s.rules.container_memory_cache":{"rules":{}},"k8s.rules.container_memory_limits":{"rules":{}},"k8s.rules.container_memory_requests":{"rules":{}},"k8s.rules.container_memory_rss":{"rules":{}},"k8s.rules.container_memory_swap":{"rules":{}},"k8s.rules.container_memory_working_set_bytes":{"rules":{}},"k8s.rules.pod_owner":{"rules":{}},"kube-apiserver-burnrate.rules":{"rules":{}},"kube-apiserver-histogram.rules":{"rules":{}},"kube-apiserver-slos":{"rules":{}},"kube-prometheus-general.rules":{"rules":{}},"kube-prometheus-node-recording.rules":{"rules":{}},"kube-scheduler.rules":{"rules":{}},"kube-state-metrics":{"rules":{}},"kubelet.rules":{"rules":{}},"kubernetes-apps":{"jobNamespaces":{"kube-state-metrics":".*"},"rules":{}},"kubernetes-resources":{"rules":{}},"kubernetes-storage":{"jobNamespaces":{"kubelet":".*"},"rules":{}},"kubernetes-system":{"rules":{}},"kubernetes-system-apiserver":{"rules":{}},"kubernetes-system-controller-manager":{"rules":{}},"kubernetes-system-kubelet":{"rules":{}},"kubernetes-system-scheduler":{"rules":{}},"node-exporter":{"rules":{}},"node-exporter.rules":{"rules":{}},"node-network":{"rules":{}},"node.rules":{"rules":{}},"vm-health":{"rules":{}},"vmagent":{"rules":{}},"vmalert":{"rules":{}},"vmcluster":{"rules":{}},"vmoperator":{"rules":{}},"vmsingle":{"rules":{}}},"jobNamespaces":{},"labels":{},"recording":{"spec":{"annotations":{},"labels":{}}},"rule":{"spec":{"annotations":{},"labels":{}}},"rules":{},"runbookUrl":"https://runbooks.prometheus-operator.dev/runbooks","sources":{"alertmanager":{"enabled":"{{ .Values.alertmanager.enabled }}","url":"https://raw.githubusercontent.com/prometheus-operator/kube-prometheus/main/manifests/alertmanager-prometheusRule.yaml"},"etcd":{"enabled":"{{ .Values.kubeEtcd.enabled }}","url":"https://raw.githubusercontent.com/monitoring-mixins/website/master/assets/etcd/alerts.yaml"},"kube-state-metrics":{"enabled":"{{ index .Values \"kube-state-metrics\" \"enabled\" }}","url":"https://raw.githubusercontent.com/prometheus-operator/kube-prometheus/main/manifests/kubeStateMetrics-prometheusRule.yaml"},"kubernetes":{"url":"https://raw.githubusercontent.com/prometheus-operator/kube-prometheus/main/manifests/kubePrometheus-prometheusRule.yaml"},"kubernetes-control-plane":{"url":"https://raw.githubusercontent.com/prometheus-operator/kube-prometheus/main/manifests/kubernetesControlPlane-prometheusRule.yaml"},"node-exporter":{"enabled":"{{ index .Values \"prometheus-node-exporter\" \"enabled\" }}","url":"https://raw.githubusercontent.com/prometheus-operator/kube-prometheus/main/manifests/nodeExporter-prometheusRule.yaml"},"victorialogs":{"enabled":"{{ or .Values.vlsingle.enabled .Values.vlcluster.enabled }}","url":"https://raw.githubusercontent.com/VictoriaMetrics/VictoriaLogs/master/deployment/docker/rules/alerts-vlogs.yml"},"victoriatraces":{"enabled":"{{ or .Values.vtsingle.enabled .Values.vtcluster.enabled }}","url":"https://raw.githubusercontent.com/VictoriaMetrics/VictoriaTraces/master/deployment/docker/rules/alerts-vtraces.yml"},"vlagent":{"enabled":"{{ .Values.vlagent.enabled }}","url":"https://raw.githubusercontent.com/VictoriaMetrics/VictoriaLogs/master/deployment/docker/rules/alerts-vlagent.yml"},"vlhealth":{"enabled":"{{ or .Values.vlsingle.enabled .Values.vlcluster.enabled .Values.vlagent.enabled }}","url":"https://raw.githubusercontent.com/VictoriaMetrics/VictoriaLogs/master/deployment/docker/rules/alerts-health.yml"},"vmagent":{"enabled":"{{ .Values.vmagent.enabled }}","url":"https://raw.githubusercontent.com/VictoriaMetrics/VictoriaMetrics/master/deployment/docker/rules/alerts-vmagent.yml"},"vmalert":{"enabled":"{{ .Values.vmalert.enabled }}","url":"https://raw.githubusercontent.com/VictoriaMetrics/VictoriaMetrics/master/deployment/docker/rules/alerts-vmalert.yml"},"vmcluster":{"enabled":"{{ .Values.vmcluster.enabled }}","url":"https://raw.githubusercontent.com/VictoriaMetrics/VictoriaMetrics/master/deployment/docker/rules/alerts-cluster.yml"},"vmhealth":{"enabled":"{{ or .Values.vmsingle.enabled .Values.vmcluster.enabled }}","url":"https://raw.githubusercontent.com/VictoriaMetrics/VictoriaMetrics/master/deployment/docker/rules/alerts-health.yml"},"vmoperator":{"enabled":"{{ index .Values \"victoria-metrics-operator\" \"enabled\" }}","url":"https://raw.githubusercontent.com/VictoriaMetrics/operator/master/config/alerting/vmoperator-rules.yaml"},"vmsingle":{"enabled":"{{ .Values.vmsingle.enabled }}","url":"https://raw.githubusercontent.com/VictoriaMetrics/VictoriaMetrics/master/deployment/docker/rules/alerts-single-node.yml"},"vthealth":{"enabled":"{{ or .Values.vtsingle.enabled .Values.vtcluster.enabled }}","url":"https://raw.githubusercontent.com/VictoriaMetrics/VictoriaTraces/master/deployment/docker/rules/alerts-health.yml"}}}` | Create default rules for monitoring the cluster |
| vmstack.defaultRules.alerting | object | `{"spec":{"annotations":{},"labels":{}}}` | Common properties for VMRules alerts |
| vmstack.defaultRules.alerting.spec.annotations | object | `{}` | Additional annotations for VMRule alerts |
| vmstack.defaultRules.alerting.spec.labels | object | `{}` | Additional labels for VMRule alerts |
| vmstack.defaultRules.annotations | object | `{}` | Annotations for default rules |
| vmstack.defaultRules.extraGroupByLabels | list | `[]` | Labels, which are used for grouping results of the queries. Note that these labels are joined with `.Values.global.clusterLabel` |
| vmstack.defaultRules.group | object | `{"spec":{}}` | Common properties for VMRule groups |
| vmstack.defaultRules.groups | object | `{"alertmanager.rules":{"rules":{}},"etcd":{"alerting":{},"enabled":true,"recording":{},"rules":{}},"general.rules":{"rules":{}},"k8s.rules.container_cpu_limits":{"rules":{}},"k8s.rules.container_cpu_requests":{"rules":{}},"k8s.rules.container_cpu_usage_seconds_total":{"rules":{}},"k8s.rules.container_memory_cache":{"rules":{}},"k8s.rules.container_memory_limits":{"rules":{}},"k8s.rules.container_memory_requests":{"rules":{}},"k8s.rules.container_memory_rss":{"rules":{}},"k8s.rules.container_memory_swap":{"rules":{}},"k8s.rules.container_memory_working_set_bytes":{"rules":{}},"k8s.rules.pod_owner":{"rules":{}},"kube-apiserver-burnrate.rules":{"rules":{}},"kube-apiserver-histogram.rules":{"rules":{}},"kube-apiserver-slos":{"rules":{}},"kube-prometheus-general.rules":{"rules":{}},"kube-prometheus-node-recording.rules":{"rules":{}},"kube-scheduler.rules":{"rules":{}},"kube-state-metrics":{"rules":{}},"kubelet.rules":{"rules":{}},"kubernetes-apps":{"jobNamespaces":{"kube-state-metrics":".*"},"rules":{}},"kubernetes-resources":{"rules":{}},"kubernetes-storage":{"jobNamespaces":{"kubelet":".*"},"rules":{}},"kubernetes-system":{"rules":{}},"kubernetes-system-apiserver":{"rules":{}},"kubernetes-system-controller-manager":{"rules":{}},"kubernetes-system-kubelet":{"rules":{}},"kubernetes-system-scheduler":{"rules":{}},"node-exporter":{"rules":{}},"node-exporter.rules":{"rules":{}},"node-network":{"rules":{}},"node.rules":{"rules":{}},"vm-health":{"rules":{}},"vmagent":{"rules":{}},"vmalert":{"rules":{}},"vmcluster":{"rules":{}},"vmoperator":{"rules":{}},"vmsingle":{"rules":{}}}` | Rule group properties. Keys must match upstream group names exactly. |
| vmstack.defaultRules.groups.etcd.alerting | object | `{}` | Common properties for all alerting rules in a group |
| vmstack.defaultRules.groups.etcd.enabled | bool | `true` | Enable/disable rule group |
| vmstack.defaultRules.groups.etcd.recording | object | `{}` | Common properties for all recording rules in a group |
| vmstack.defaultRules.groups.etcd.rules | object | `{}` | Common properties for all rules in a group |
| vmstack.defaultRules.jobNamespaces | object | `{}` | Inject namespace=~"<value>" filter into metric selectors for metrics scraped by the given job. Merged with per-group jobNamespaces (per-group wins on conflict). Only use for jobs whose metrics are always namespace-scoped. |
| vmstack.defaultRules.labels | object | `{}` | Labels for default rules |
| vmstack.defaultRules.recording | object | `{"spec":{"annotations":{},"labels":{}}}` | Common properties for VMRules recording rules |
| vmstack.defaultRules.recording.spec.annotations | object | `{}` | Additional annotations for VMRule recording rules |
| vmstack.defaultRules.recording.spec.labels | object | `{}` | Additional labels for VMRule recording rules |
| vmstack.defaultRules.rule | object | `{"spec":{"annotations":{},"labels":{}}}` | Common properties for all VMRules |
| vmstack.defaultRules.rule.spec.annotations | object | `{}` | Additional annotations for all VMRules |
| vmstack.defaultRules.rule.spec.labels | object | `{}` | Additional labels for all VMRules |
| vmstack.defaultRules.rules | object | `{}` | Per rule properties |
| vmstack.defaultRules.runbookUrl | string | `"https://runbooks.prometheus-operator.dev/runbooks"` | Runbook url prefix for default rules |
| vmstack.defaultRules.sources | object | `{"alertmanager":{"enabled":"{{ .Values.alertmanager.enabled }}","url":"https://raw.githubusercontent.com/prometheus-operator/kube-prometheus/main/manifests/alertmanager-prometheusRule.yaml"},"etcd":{"enabled":"{{ .Values.kubeEtcd.enabled }}","url":"https://raw.githubusercontent.com/monitoring-mixins/website/master/assets/etcd/alerts.yaml"},"kube-state-metrics":{"enabled":"{{ index .Values \"kube-state-metrics\" \"enabled\" }}","url":"https://raw.githubusercontent.com/prometheus-operator/kube-prometheus/main/manifests/kubeStateMetrics-prometheusRule.yaml"},"kubernetes":{"url":"https://raw.githubusercontent.com/prometheus-operator/kube-prometheus/main/manifests/kubePrometheus-prometheusRule.yaml"},"kubernetes-control-plane":{"url":"https://raw.githubusercontent.com/prometheus-operator/kube-prometheus/main/manifests/kubernetesControlPlane-prometheusRule.yaml"},"node-exporter":{"enabled":"{{ index .Values \"prometheus-node-exporter\" \"enabled\" }}","url":"https://raw.githubusercontent.com/prometheus-operator/kube-prometheus/main/manifests/nodeExporter-prometheusRule.yaml"},"victorialogs":{"enabled":"{{ or .Values.vlsingle.enabled .Values.vlcluster.enabled }}","url":"https://raw.githubusercontent.com/VictoriaMetrics/VictoriaLogs/master/deployment/docker/rules/alerts-vlogs.yml"},"victoriatraces":{"enabled":"{{ or .Values.vtsingle.enabled .Values.vtcluster.enabled }}","url":"https://raw.githubusercontent.com/VictoriaMetrics/VictoriaTraces/master/deployment/docker/rules/alerts-vtraces.yml"},"vlagent":{"enabled":"{{ .Values.vlagent.enabled }}","url":"https://raw.githubusercontent.com/VictoriaMetrics/VictoriaLogs/master/deployment/docker/rules/alerts-vlagent.yml"},"vlhealth":{"enabled":"{{ or .Values.vlsingle.enabled .Values.vlcluster.enabled .Values.vlagent.enabled }}","url":"https://raw.githubusercontent.com/VictoriaMetrics/VictoriaLogs/master/deployment/docker/rules/alerts-health.yml"},"vmagent":{"enabled":"{{ .Values.vmagent.enabled }}","url":"https://raw.githubusercontent.com/VictoriaMetrics/VictoriaMetrics/master/deployment/docker/rules/alerts-vmagent.yml"},"vmalert":{"enabled":"{{ .Values.vmalert.enabled }}","url":"https://raw.githubusercontent.com/VictoriaMetrics/VictoriaMetrics/master/deployment/docker/rules/alerts-vmalert.yml"},"vmcluster":{"enabled":"{{ .Values.vmcluster.enabled }}","url":"https://raw.githubusercontent.com/VictoriaMetrics/VictoriaMetrics/master/deployment/docker/rules/alerts-cluster.yml"},"vmhealth":{"enabled":"{{ or .Values.vmsingle.enabled .Values.vmcluster.enabled }}","url":"https://raw.githubusercontent.com/VictoriaMetrics/VictoriaMetrics/master/deployment/docker/rules/alerts-health.yml"},"vmoperator":{"enabled":"{{ index .Values \"victoria-metrics-operator\" \"enabled\" }}","url":"https://raw.githubusercontent.com/VictoriaMetrics/operator/master/config/alerting/vmoperator-rules.yaml"},"vmsingle":{"enabled":"{{ .Values.vmsingle.enabled }}","url":"https://raw.githubusercontent.com/VictoriaMetrics/VictoriaMetrics/master/deployment/docker/rules/alerts-single-node.yml"},"vthealth":{"enabled":"{{ or .Values.vtsingle.enabled .Values.vtcluster.enabled }}","url":"https://raw.githubusercontent.com/VictoriaMetrics/VictoriaTraces/master/deployment/docker/rules/alerts-health.yml"}}` | Rule sources. Set enabled: false on any entry to disable it. Add new keys to extend. |
| vmstack.defaultScrapeService.namespace | string | `"kube-system"` |  |
| vmstack.external.grafana.datasource | string | `"VictoriaMetrics"` | External Grafana datasource name |
| vmstack.external.grafana.host | string | `""` | External Grafana host |
| vmstack.external.vl | object | `{"read":{"url":""},"write":{"url":""}}` | External VL read and write URLs |
| vmstack.external.vm | object | `{"read":{"url":""},"write":{"url":""}}` | External VM read and write URLs |
| vmstack.external.vt | object | `{"read":{"url":""},"write":{"url":""}}` | External VT read and write URLs |
| vmstack.extraObjects | list | `[]` | Add extra objects dynamically to this chart |
| vmstack.extraRules | object | `{}` | Provide custom recording or alerting rules to be deployed into the cluster. |
| vmstack.fullnameOverride | string | `""` | Resource full name override |
| vmstack.global.cluster.dnsDomain | string | `"cluster.local."` | K8s cluster domain suffix, uses for building storage pods' FQDN. Details are [here](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/) |
| vmstack.global.clusterLabel | string | `"cluster"` | Cluster label to use for dashboards and rules |
| vmstack.global.extraAnnotations | object | `{}` | Annotations added to all resources |
| vmstack.global.extraLabels | object | `{}` | Labels added to all resources |
| vmstack.global.license | object | `{"key":"","keyRef":{}}` | Global license configuration |
| vmstack.grafana | object | `{"enabled":true,"forceDeployDatasource":false,"ingress":{"annotations":{},"enabled":false,"extraPaths":[],"hosts":["grafana.domain.com"],"labels":{},"path":"/","pathType":"Prefix","tls":[]},"sidecar":{"dashboards":{"defaultFolderName":"default","enabled":true,"folder":"/var/lib/grafana/dashboards","label":"grafana_dashboard","labelValue":"1","multicluster":false,"provider":{"name":"default","orgid":1}},"datasources":{"enabled":true,"label":"grafana_datasource","labelValue":"1"}},"vmScrape":{"enabled":true,"spec":{"endpoints":[{"port":"{{ .Values.grafana.service.portName }}"}],"selector":{"matchLabels":{"app.kubernetes.io/name":"{{ include \"grafana.name\" .Subcharts.grafana }}"}}}}}` | Grafana dependency chart configuration. For possible values refer [here](https://github.com/grafana-community/helm-charts/tree/main/charts/grafana#configuration) |
| vmstack.grafana.forceDeployDatasource | bool | `false` | Create datasource configmap even if grafana deployment has been disabled |
| vmstack.grafana.ingress.extraPaths | list | `[]` | Extra paths to prepend to every host configuration. This is useful when working with annotation based services. |
| vmstack.grafana.vmScrape | object | `{"enabled":true,"spec":{"endpoints":[{"port":"{{ .Values.grafana.service.portName }}"}],"selector":{"matchLabels":{"app.kubernetes.io/name":"{{ include \"grafana.name\" .Subcharts.grafana }}"}}}}` | Grafana VM scrape config |
| vmstack.grafana.vmScrape.spec | object | `{"endpoints":[{"port":"{{ .Values.grafana.service.portName }}"}],"selector":{"matchLabels":{"app.kubernetes.io/name":"{{ include \"grafana.name\" .Subcharts.grafana }}"}}}` | [Scrape configuration](https://docs.victoriametrics.com/operator/api/#vmservicescrapespec) for Grafana |
| vmstack.internal.vmauth.name | string | `"{{ .fullname }}-internal"` | name is a template for the internal VMAuth CR used for vmalert datasource routing |
| vmstack.internal.vmauth.spec | object | `{"port":"8427","unauthorizedUserAccessSpec":{"url_map":[{"src_paths":["/select/logsql/.*"],"url_prefix":["{{ urlJoin (omit .vl.read \"path\") }}/"]},{"src_paths":["/.*"],"url_prefix":["{{ (include \"vm.prometheus.read\" . | fromYaml).url }}/"]}]}}` | Spec for internal VMAuth CRD used as a vmalert datasource proxy. It's possible to use given below predefined variables in spec: * `{{ .vm.read }}` - parsed vmselect, vmsingle or external.vm.read URL * `{{ .vl.read }}` - parsed vlselect, vlsingle or external.vl.read URL * `{{ .vt.read }}` - parsed vtselect, vtsingle or external.vt.read URL |
| vmstack.kube-state-metrics | object | `{"enabled":true,"vmScrape":{"enabled":true,"spec":{"endpoints":[{"honorLabels":true,"metricRelabelConfigs":[{"action":"labeldrop","regex":"(uid|container_id|image_id)"}],"port":"http"}],"jobLabel":"app.kubernetes.io/name","selector":{"matchLabels":{"app.kubernetes.io/instance":"{{ include \"vm.release\" . }}","app.kubernetes.io/name":"{{ include \"kube-state-metrics.name\" (index .Subcharts \"kube-state-metrics\") }}"}}}}}` | kube-state-metrics dependency chart configuration. For possible values check [here](https://github.com/prometheus-community/helm-charts/blob/main/charts/kube-state-metrics/values.yaml) |
| vmstack.kube-state-metrics.vmScrape | object | `{"enabled":true,"spec":{"endpoints":[{"honorLabels":true,"metricRelabelConfigs":[{"action":"labeldrop","regex":"(uid|container_id|image_id)"}],"port":"http"}],"jobLabel":"app.kubernetes.io/name","selector":{"matchLabels":{"app.kubernetes.io/instance":"{{ include \"vm.release\" . }}","app.kubernetes.io/name":"{{ include \"kube-state-metrics.name\" (index .Subcharts \"kube-state-metrics\") }}"}}}}` | [Scrape configuration](https://docs.victoriametrics.com/operator/api/#vmservicescrapespec) for Kube State Metrics |
| vmstack.kubeApiServer.enabled | bool | `true` | Enable Kube Api Server metrics scraping |
| vmstack.kubeApiServer.vmScrape | object | `{"spec":{"endpoints":[{"bearerTokenFile":"/var/run/secrets/kubernetes.io/serviceaccount/token","port":"https","scheme":"https","tlsConfig":{"caFile":"/var/run/secrets/kubernetes.io/serviceaccount/ca.crt","serverName":"kubernetes"}}],"jobLabel":"component","namespaceSelector":{"matchNames":["default"]},"selector":{"matchLabels":{"component":"apiserver","provider":"kubernetes"}}}}` | Spec for VMServiceScrape CRD is [here](https://docs.victoriametrics.com/operator/api/#vmservicescrapespec) |
| vmstack.kubeControllerManager.enabled | bool | `true` | Enable kube controller manager metrics scraping |
| vmstack.kubeControllerManager.endpoints | list | `[]` | If your kube controller manager is not deployed as a pod, specify IPs it can be found on |
| vmstack.kubeControllerManager.service.enabled | bool | `true` | Create service for kube controller manager metrics scraping |
| vmstack.kubeControllerManager.service.labels | object | `{}` | Kube controller manager service labels |
| vmstack.kubeControllerManager.service.port | int | `10257` | Kube controller manager service port |
| vmstack.kubeControllerManager.service.selector | object | `{"component":"kube-controller-manager"}` | Kube controller manager service pod selector |
| vmstack.kubeControllerManager.service.targetPort | int | `10257` | Kube controller manager service target port |
| vmstack.kubeControllerManager.vmScrape | object | `{"spec":{"endpoints":[{"bearerTokenFile":"/var/run/secrets/kubernetes.io/serviceaccount/token","port":"http-metrics","scheme":"https","tlsConfig":{"caFile":"/var/run/secrets/kubernetes.io/serviceaccount/ca.crt","serverName":"kubernetes"}}],"jobLabel":"app.kubernetes.io/component","namespaceSelector":{"matchNames":[]}}}` | Spec for VMServiceScrape CRD is [here](https://docs.victoriametrics.com/operator/api/#vmservicescrapespec) |
| vmstack.kubeDns.enabled | bool | `false` | Enabled KubeDNS metrics scraping |
| vmstack.kubeDns.service.enabled | bool | `false` | Create Service for KubeDNS metrics |
| vmstack.kubeDns.service.labels | object | `{}` | KubeDNS service labels |
| vmstack.kubeDns.service.ports | object | `{"dnsmasq":{"port":10054,"targetPort":10054},"skydns":{"port":10055,"targetPort":10055}}` | KubeDNS service ports |
| vmstack.kubeDns.service.selector | object | `{"k8s-app":"kube-dns"}` | KubeDNS service pods selector |
| vmstack.kubeDns.vmScrape | object | `{"spec":{"endpoints":[{"bearerTokenFile":"/var/run/secrets/kubernetes.io/serviceaccount/token","port":"http-metrics-dnsmasq"},{"bearerTokenFile":"/var/run/secrets/kubernetes.io/serviceaccount/token","port":"http-metrics-skydns"}],"jobLabel":"app.kubernetes.io/component","namespaceSelector":{"matchNames":[]}}}` | Spec for VMServiceScrape CRD is [here](https://docs.victoriametrics.com/operator/api/#vmservicescrapespec) |
| vmstack.kubeEtcd.enabled | bool | `true` | Enabled KubeETCD metrics scraping |
| vmstack.kubeEtcd.endpoints | list | `[]` | If your etcd is not deployed as a pod, specify IPs it can be found on |
| vmstack.kubeEtcd.service.enabled | bool | `true` | Enable service for ETCD metrics scraping |
| vmstack.kubeEtcd.service.labels | object | `{}` | ETCD service labels |
| vmstack.kubeEtcd.service.port | int | `2379` | ETCD service port |
| vmstack.kubeEtcd.service.selector | object | `{"component":"etcd"}` | ETCD service pods selector |
| vmstack.kubeEtcd.service.targetPort | int | `2379` | ETCD service target port |
| vmstack.kubeEtcd.vmScrape | object | `{"spec":{"endpoints":[{"bearerTokenFile":"/var/run/secrets/kubernetes.io/serviceaccount/token","port":"http-metrics","scheme":"https","tlsConfig":{"caFile":"/var/run/secrets/kubernetes.io/serviceaccount/ca.crt"}}],"jobLabel":"app.kubernetes.io/component","namespaceSelector":{"matchNames":[]}}}` | Spec for VMServiceScrape CRD is [here](https://docs.victoriametrics.com/operator/api/#vmservicescrapespec) |
| vmstack.kubeProxy.enabled | bool | `false` | Enable kube proxy metrics scraping |
| vmstack.kubeProxy.endpoints | list | `[]` | If your kube proxy is not deployed as a pod, specify IPs it can be found on |
| vmstack.kubeProxy.service.enabled | bool | `true` | Enable service for kube proxy metrics scraping |
| vmstack.kubeProxy.service.labels | object | `{}` | Kube proxy service labels |
| vmstack.kubeProxy.service.port | int | `10249` | Kube proxy service port |
| vmstack.kubeProxy.service.selector | object | `{"k8s-app":"kube-proxy"}` | Kube proxy service pod selector |
| vmstack.kubeProxy.service.targetPort | int | `10249` | Kube proxy service target port |
| vmstack.kubeProxy.vmScrape | object | `{"spec":{"endpoints":[{"bearerTokenFile":"/var/run/secrets/kubernetes.io/serviceaccount/token","port":"http-metrics","scheme":"https","tlsConfig":{"caFile":"/var/run/secrets/kubernetes.io/serviceaccount/ca.crt"}}],"jobLabel":"app.kubernetes.io/component","namespaceSelector":{"matchNames":[]}}}` | Spec for VMServiceScrape CRD is [here](https://docs.victoriametrics.com/operator/api/#vmservicescrapespec) |
| vmstack.kubeScheduler.enabled | bool | `true` | Enable KubeScheduler metrics scraping |
| vmstack.kubeScheduler.endpoints | list | `[]` | If your kube scheduler is not deployed as a pod, specify IPs it can be found on |
| vmstack.kubeScheduler.service.enabled | bool | `true` | Enable service for KubeScheduler metrics scrape |
| vmstack.kubeScheduler.service.labels | object | `{}` | KubeScheduler service labels |
| vmstack.kubeScheduler.service.port | int | `10259` | KubeScheduler service port |
| vmstack.kubeScheduler.service.selector | object | `{"component":"kube-scheduler"}` | KubeScheduler service pod selector |
| vmstack.kubeScheduler.service.targetPort | int | `10259` | KubeScheduler service target port |
| vmstack.kubeScheduler.vmScrape | object | `{"spec":{"endpoints":[{"bearerTokenFile":"/var/run/secrets/kubernetes.io/serviceaccount/token","port":"http-metrics","scheme":"https","tlsConfig":{"caFile":"/var/run/secrets/kubernetes.io/serviceaccount/ca.crt"}}],"jobLabel":"app.kubernetes.io/component","namespaceSelector":{"matchNames":[]}}}` | Spec for VMServiceScrape CRD is [here](https://docs.victoriametrics.com/operator/api/#vmservicescrapespec) |
| vmstack.kubelet | object | `{"enabled":true,"vmScrape":{"kind":"VMNodeScrape","spec":{"bearerTokenFile":"/var/run/secrets/kubernetes.io/serviceaccount/token","honorLabels":true,"honorTimestamps":false,"interval":"30s","metricRelabelConfigs":[{"action":"labeldrop","regex":"(uid)"},{"action":"labeldrop","regex":"(id|name)"},{"action":"drop","regex":"(rest_client_request_duration_seconds_bucket|rest_client_request_duration_seconds_sum|rest_client_request_duration_seconds_count)","source_labels":["__name__"]}],"relabelConfigs":[{"action":"labelmap","regex":"__meta_kubernetes_node_label_(.+)"},{"sourceLabels":["__metrics_path__"],"targetLabel":"metrics_path"},{"replacement":"kubelet","targetLabel":"job"}],"scheme":"https","scrapeTimeout":"5s","tlsConfig":{"caFile":"/var/run/secrets/kubernetes.io/serviceaccount/ca.crt","insecureSkipVerify":true}}},"vmScrapes":{"cadvisor":{"enabled":true,"spec":{"path":"/metrics/cadvisor"}},"kubelet":{"spec":{}},"probes":{"enabled":true,"spec":{"path":"/metrics/probes"}},"resources":{"enabled":true,"spec":{"path":"/metrics/resource"}}}}` | Component scraping the kubelets |
| vmstack.kubelet.vmScrape | object | `{"kind":"VMNodeScrape","spec":{"bearerTokenFile":"/var/run/secrets/kubernetes.io/serviceaccount/token","honorLabels":true,"honorTimestamps":false,"interval":"30s","metricRelabelConfigs":[{"action":"labeldrop","regex":"(uid)"},{"action":"labeldrop","regex":"(id|name)"},{"action":"drop","regex":"(rest_client_request_duration_seconds_bucket|rest_client_request_duration_seconds_sum|rest_client_request_duration_seconds_count)","source_labels":["__name__"]}],"relabelConfigs":[{"action":"labelmap","regex":"__meta_kubernetes_node_label_(.+)"},{"sourceLabels":["__metrics_path__"],"targetLabel":"metrics_path"},{"replacement":"kubelet","targetLabel":"job"}],"scheme":"https","scrapeTimeout":"5s","tlsConfig":{"caFile":"/var/run/secrets/kubernetes.io/serviceaccount/ca.crt","insecureSkipVerify":true}}}` | Spec for VMNodeScrape CRD is [here](https://docs.victoriametrics.com/operator/api/#vmnodescrapespec) |
| vmstack.kubelet.vmScrapes.cadvisor | object | `{"enabled":true,"spec":{"path":"/metrics/cadvisor"}}` | Enable scraping /metrics/cadvisor from kubelet's service |
| vmstack.kubelet.vmScrapes.probes | object | `{"enabled":true,"spec":{"path":"/metrics/probes"}}` | Enable scraping /metrics/probes from kubelet's service |
| vmstack.kubelet.vmScrapes.resources | object | `{"enabled":true,"spec":{"path":"/metrics/resource"}}` | Enabled scraping /metrics/resource from kubelet's service |
| vmstack.nameOverride | string | `""` | Override chart name |
| vmstack.prometheus-node-exporter | object | `{"enabled":true,"extraArgs":["--collector.filesystem.mount-points-exclude=^/(dev|proc|sys|var/lib/docker/.+|var/lib/kubelet/.+)($|/)","--collector.filesystem.fs-types-exclude=^(autofs|binfmt_misc|bpf|cgroup2?|configfs|debugfs|devpts|devtmpfs|fusectl|hugetlbfs|iso9660|mqueue|nsfs|overlay|proc|procfs|pstore|rpc_pipefs|securityfs|selinuxfs|squashfs|erofs|sysfs|tracefs)$"],"service":{"labels":{"jobLabel":"node-exporter"}},"vmScrape":{"enabled":true,"spec":{"endpoints":[{"metricRelabelConfigs":[{"action":"drop","regex":"/var/lib/kubelet/pods.+","source_labels":["mountpoint"]}],"port":"metrics"}],"jobLabel":"jobLabel","selector":{"matchLabels":{"app.kubernetes.io/name":"{{ include \"prometheus-node-exporter.name\" (index .Subcharts \"prometheus-node-exporter\") }}"}}}}}` | prometheus-node-exporter dependency chart configuration. For possible values check [here](https://github.com/prometheus-community/helm-charts/blob/main/charts/prometheus-node-exporter/values.yaml) |
| vmstack.prometheus-node-exporter.vmScrape | object | `{"enabled":true,"spec":{"endpoints":[{"metricRelabelConfigs":[{"action":"drop","regex":"/var/lib/kubelet/pods.+","source_labels":["mountpoint"]}],"port":"metrics"}],"jobLabel":"jobLabel","selector":{"matchLabels":{"app.kubernetes.io/name":"{{ include \"prometheus-node-exporter.name\" (index .Subcharts \"prometheus-node-exporter\") }}"}}}}` | Node Exporter VM scrape config |
| vmstack.prometheus-node-exporter.vmScrape.spec | object | `{"endpoints":[{"metricRelabelConfigs":[{"action":"drop","regex":"/var/lib/kubelet/pods.+","source_labels":["mountpoint"]}],"port":"metrics"}],"jobLabel":"jobLabel","selector":{"matchLabels":{"app.kubernetes.io/name":"{{ include \"prometheus-node-exporter.name\" (index .Subcharts \"prometheus-node-exporter\") }}"}}}` | [Scrape configuration](https://docs.victoriametrics.com/operator/api/#vmservicescrapespec) for Node Exporter |
| vmstack.syncJob.affinity | object | `{}` | Affinity for sync-job Pod scheduling |
| vmstack.syncJob.backoffLimit | int | `3` | Maximum number of retries before the Job is considered failed |
| vmstack.syncJob.containerSecurityContext | object | `{}` | Security context for the sync-job container |
| vmstack.syncJob.dnsConfig | object | `{}` | Custom dns config for the sync job Pod. |
| vmstack.syncJob.dnsPolicy | string | `""` | Alternative DNS policy for the sync job Pod |
| vmstack.syncJob.enabled | bool | `true` | Fetch dashboards and rules from upstream sources at deploy time. Creates ConfigMaps (for Grafana sidecar) or GrafanaDashboard CRDs and VMRules directly in the cluster. A new Job runs automatically whenever this config changes. |
| vmstack.syncJob.env | list | `[]` | Extra env variables for sync job |
| vmstack.syncJob.image.pullPolicy | string | `"IfNotPresent"` |  |
| vmstack.syncJob.image.repository | string | `"ghcr.io/victoriametrics/sync-job"` |  |
| vmstack.syncJob.image.tag | string | `"v0.0.11"` |  |
| vmstack.syncJob.nodeSelector | object | `{}` |  |
| vmstack.syncJob.podAnnotations | object | `{}` | Annotations to add to the sync-job Pod |
| vmstack.syncJob.podSecurityContext | object | `{}` | Security context for the sync-job Pod |
| vmstack.syncJob.prune | bool | `true` | Delete managed resources that are no longer in the current config |
| vmstack.syncJob.resourcePrefix | string | `""` | Prefix for managed resource names (VMRules, ConfigMaps, GrafanaDashboards). Defaults to the Helm release name when empty. |
| vmstack.syncJob.resources | object | `{}` | Override multicluster mode for dashboard and rule patching. Falls back to grafana.sidecar.dashboards.multicluster when not set. multicluster: false |
| vmstack.syncJob.tolerations | list | `[]` |  |
| vmstack.syncJob.ttlSecondsAfterFinished | int | `600` | Seconds to keep a finished job before automatic deletion |
| vmstack.syncJob.useOwnerReferences | bool | `true` | Set owner references on managed resources so they are automatically garbage-collected by Kubernetes when the chart is uninstalled, regardless of the deployment tool (Helm, ArgoCD, etc.) |
| vmstack.tenant | string | `"0"` | Tenant to use for Grafana datasources and remote write |
| vmstack.victoria-metrics-operator | object | `{"admissionWebhooks":{"policy":"Ignore"},"crds":{"cleanup":{"enabled":true,"image":{"pullPolicy":"IfNotPresent","repository":"registry.k8s.io/kubectl"}},"plain":true},"enabled":true,"operator":{"disable_prometheus_converter":false},"serviceMonitor":{"enabled":true}}` | VictoriaMetrics Operator dependency chart configuration. More values can be found [here](https://docs.victoriametrics.com/helm/victoria-metrics-operator/#parameters). Also checkout [here](https://docs.victoriametrics.com/operator/configuration/#environment-variables) possible ENV variables to configure operator behaviour |
| vmstack.victoria-metrics-operator.admissionWebhooks.policy | string | `"Ignore"` | Default the validating webhook `failurePolicy` to `Ignore` so the stack can be installed/upgraded in a single pass without races against the operator's webhook server. Override to `Fail` for strict validation once the operator is in steady state. |
| vmstack.victoria-metrics-operator.operator.disable_prometheus_converter | bool | `false` | By default, operator converts prometheus-operator objects. |
| vmstack.vlagent.additionalRemoteWrites | list | `[]` | Remote write configuration of VLAgent, allowed parameters defined in a [spec](https://docs.victoriametrics.com/operator/api/#vlagentremotewritespec) |
| vmstack.vlagent.annotations | object | `{}` | VLAgent annotations |
| vmstack.vlagent.enabled | bool | `false` | Create VLAgent CR |
| vmstack.vlagent.ingress | object | `{"annotations":{},"enabled":false,"extraPaths":[],"hosts":["vlagent.domain.com"],"labels":{},"path":"","pathType":"Prefix","tls":[]}` | VLAgent ingress configuration |
| vmstack.vlagent.labels | object | `{}` | VLAgent labels |
| vmstack.vlagent.rbac.annotations | object | `{}` | Role/RoleBinding annotations |
| vmstack.vlagent.rbac.extraLabels | object | `{}` | Role/RoleBinding labels |
| vmstack.vlagent.rbac.namespaced | bool | `true` | Defines if ClusterRole or Role with respective bindings should be created |
| vmstack.vlagent.rbac.rules | list | `[]` | additional rules for a role |
| vmstack.vlagent.route | object | `{"annotations":{},"enabled":false,"extraRules":[],"filters":[],"hostnames":[],"labels":{},"matches":[{"path":{"type":"PathPrefix","value":"{{ dig \"spec\" \"extraArgs\" \"http.pathPrefix\" \"/\" .Values.vlagent }}"}}],"parentRefs":[],"port":"{{ .Values.vlagent.spec.port }}"}` | VLAgent route configuration |
| vmstack.vlagent.route.annotations | object | `{}` | HTTPRoute annotations |
| vmstack.vlagent.route.enabled | bool | `false` | Enable deployment of HTTPRoute for vlagent component |
| vmstack.vlagent.route.extraRules | list | `[]` | Extra rules to prepend to route. This is useful when working with annotation based services. |
| vmstack.vlagent.route.filters | list | `[]` | Filters for a default rule in HTTPRoute |
| vmstack.vlagent.route.hostnames | list | `[]` | Array of hostnames |
| vmstack.vlagent.route.labels | object | `{}` | HTTPRoute extra labels |
| vmstack.vlagent.route.matches | list | `[{"path":{"type":"PathPrefix","value":"{{ dig \"spec\" \"extraArgs\" \"http.pathPrefix\" \"/\" .Values.vlagent }}"}}]` | Matches for a default rule in HTTPRoute |
| vmstack.vlagent.route.parentRefs | list | `[]` | HTTPGateway objects refs |
| vmstack.vlagent.route.port | string | `"{{ .Values.vlagent.spec.port }}"` | Route port |
| vmstack.vlagent.spec | object | `{"image":{"tag":"v1.52.0"},"k8sCollector":{"enabled":true},"port":"9429"}` | Full spec for VLAgent CRD. Allowed values described [here](https://docs.victoriametrics.com/operator/api/#vlagentspec) |
| vmstack.vlcluster.annotations | object | `{}` | VLCluster annotations |
| vmstack.vlcluster.enabled | bool | `false` | Create VLCluster CR |
| vmstack.vlcluster.ingress.vlinsert.annotations | object | `{}` | Ingress annotations |
| vmstack.vlcluster.ingress.vlinsert.enabled | bool | `false` | Enable deployment of ingress for server component |
| vmstack.vlcluster.ingress.vlinsert.extraPaths | list | `[]` | Extra paths to prepend to every host configuration. This is useful when working with annotation based services. |
| vmstack.vlcluster.ingress.vlinsert.hosts | list | `[]` | Array of host objects |
| vmstack.vlcluster.ingress.vlinsert.ingressClassName | string | `""` | Ingress controller class name |
| vmstack.vlcluster.ingress.vlinsert.labels | object | `{}` | Ingress extra labels |
| vmstack.vlcluster.ingress.vlinsert.path | string | `"{{ dig \"extraArgs\" \"http.pathPrefix\" \"/\" .Values.vlcluster.spec.vlinsert }}"` | Ingress default path |
| vmstack.vlcluster.ingress.vlinsert.pathType | string | `"Prefix"` | Ingress path type |
| vmstack.vlcluster.ingress.vlinsert.tls | list | `[]` | Array of TLS objects |
| vmstack.vlcluster.ingress.vlselect.annotations | object | `{}` | Ingress annotations |
| vmstack.vlcluster.ingress.vlselect.enabled | bool | `false` | Enable deployment of ingress for server component |
| vmstack.vlcluster.ingress.vlselect.extraPaths | list | `[]` | Extra paths to prepend to every host configuration. This is useful when working with annotation based services. |
| vmstack.vlcluster.ingress.vlselect.hosts | list | `[]` | Array of host objects |
| vmstack.vlcluster.ingress.vlselect.ingressClassName | string | `""` | Ingress controller class name |
| vmstack.vlcluster.ingress.vlselect.labels | object | `{}` | Ingress extra labels |
| vmstack.vlcluster.ingress.vlselect.path | string | `"{{ dig \"extraArgs\" \"http.pathPrefix\" \"/\" .Values.vlcluster.spec.vlselect }}"` | Ingress default path |
| vmstack.vlcluster.ingress.vlselect.pathType | string | `"Prefix"` | Ingress path type |
| vmstack.vlcluster.ingress.vlselect.tls | list | `[]` | Array of TLS objects |
| vmstack.vlcluster.ingress.vlstorage.annotations | object | `{}` | Ingress annotations |
| vmstack.vlcluster.ingress.vlstorage.enabled | bool | `false` | Enable deployment of ingress for server component |
| vmstack.vlcluster.ingress.vlstorage.extraPaths | list | `[]` | Extra paths to prepend to every host configuration. This is useful when working with annotation based services. |
| vmstack.vlcluster.ingress.vlstorage.hosts | list | `[]` | Array of host objects |
| vmstack.vlcluster.ingress.vlstorage.ingressClassName | string | `""` | Ingress controller class name |
| vmstack.vlcluster.ingress.vlstorage.labels | object | `{}` | Ingress extra labels |
| vmstack.vlcluster.ingress.vlstorage.path | string | `""` | Ingress default path |
| vmstack.vlcluster.ingress.vlstorage.pathType | string | `"Prefix"` | Ingress path type |
| vmstack.vlcluster.ingress.vlstorage.tls | list | `[]` | Array of TLS objects |
| vmstack.vlcluster.labels | object | `{}` | VLCluster labels |
| vmstack.vlcluster.route.vlinsert.annotations | object | `{}` | HTTPRoute annotations |
| vmstack.vlcluster.route.vlinsert.enabled | bool | `false` | Enable deployment of HTTPRoute for insert component |
| vmstack.vlcluster.route.vlinsert.extraRules | list | `[]` | Extra rules to prepend to route. This is useful when working with annotation based services. |
| vmstack.vlcluster.route.vlinsert.filters | list | `[]` | Filters for a default rule in HTTPRoute |
| vmstack.vlcluster.route.vlinsert.hostnames | list | `[]` | Array of hostnames |
| vmstack.vlcluster.route.vlinsert.labels | object | `{}` | HTTPRoute extra labels |
| vmstack.vlcluster.route.vlinsert.matches | list | `[{"path":{"type":"PathPrefix","value":"{{ dig \"extraArgs\" \"http.pathPrefix\" \"/\" .Values.vlcluster.spec.vlinsert }}"}}]` | Matches for a default rule in HTTPRoute |
| vmstack.vlcluster.route.vlinsert.parentRefs | list | `[]` | HTTPGateway objects refs |
| vmstack.vlcluster.route.vlinsert.port | string | `"{{ .Values.vlcluster.spec.vlinsert.port }}"` | Route port |
| vmstack.vlcluster.route.vlselect.annotations | object | `{}` | HTTPRoute annotations |
| vmstack.vlcluster.route.vlselect.enabled | bool | `false` | Enable deployment of HTTPRoute for select component |
| vmstack.vlcluster.route.vlselect.extraRules | list | `[]` | Extra rules to prepend to route. This is useful when working with annotation based services. |
| vmstack.vlcluster.route.vlselect.filters | list | `[]` | Filters for a default rule in HTTPRoute |
| vmstack.vlcluster.route.vlselect.hostnames | list | `[]` | Array of hostnames |
| vmstack.vlcluster.route.vlselect.labels | object | `{}` | HTTPRoute extra labels |
| vmstack.vlcluster.route.vlselect.matches | list | `[{"path":{"type":"PathPrefix","value":"{{ dig \"extraArgs\" \"http.pathPrefix\" \"/\" .Values.vlcluster.spec.vlselect }}"}}]` | Matches for a default rule in HTTPRoute |
| vmstack.vlcluster.route.vlselect.parentRefs | list | `[]` | HTTPGateway objects refs |
| vmstack.vlcluster.route.vlselect.port | string | `"{{ .Values.vlcluster.spec.vlselect.port }}"` | Route port |
| vmstack.vlcluster.route.vlstorage.annotations | object | `{}` | HTTPRoute annotations |
| vmstack.vlcluster.route.vlstorage.enabled | bool | `false` | Enable deployment of HTTPRoute for storage component |
| vmstack.vlcluster.route.vlstorage.extraRules | list | `[]` | Extra rules to prepend to route. This is useful when working with annotation based services. |
| vmstack.vlcluster.route.vlstorage.filters | list | `[]` | Filters for a default rule in HTTPRoute |
| vmstack.vlcluster.route.vlstorage.hostnames | list | `[]` | Array of hostnames |
| vmstack.vlcluster.route.vlstorage.labels | object | `{}` | HTTPRoute extra labels |
| vmstack.vlcluster.route.vlstorage.matches | list | `[{"path":{"type":"PathPrefix","value":"{{ dig \"extraArgs\" \"http.pathPrefix\" \"/\" .Values.vlcluster.spec.vlstorage }}"}}]` | Matches for a default rule in HTTPRoute |
| vmstack.vlcluster.route.vlstorage.parentRefs | list | `[]` | HTTPGateway objects refs |
| vmstack.vlcluster.route.vlstorage.port | string | `"{{ .Values.vlcluster.spec.vlstorage.port }}"` | Route port |
| vmstack.vlcluster.spec | object | `{"clusterVersion":"v1.52.0","vlinsert":{"enabled":true,"extraArgs":{},"port":"9481","replicaCount":2,"resources":{}},"vlselect":{"enabled":true,"extraArgs":{},"port":"9471","replicaCount":2,"resources":{}},"vlstorage":{"port":"9491","replicaCount":2,"resources":{},"retentionPeriod":"14d","storage":{"volumeClaimTemplate":{"spec":{"resources":{"requests":{"storage":"10Gi"}}}}},"storageDataPath":"/vl-data"}}` | Full spec for VLCluster CRD. Allowed values described [here](https://docs.victoriametrics.com/operator/api/#vlclusterspec) |
| vmstack.vlcluster.spec.vlinsert.enabled | bool | `true` | Set this value to false to disable VMInsert |
| vmstack.vlcluster.spec.vlselect.enabled | bool | `true` | Set this value to false to disable VMSelect |
| vmstack.vlcluster.spec.vlstorage.retentionPeriod | string | `"14d"` | Data retention period. Possible units character: h(ours), d(ays), w(eeks), y(ears), if no unit character specified - month. The minimum retention period is 24h. See these [docs](https://docs.victoriametrics.com/victorialogs/#retention) |
| vmstack.vlsingle.annotations | object | `{}` | VLSingle annotations |
| vmstack.vlsingle.enabled | bool | `false` | Create VLSingle CR |
| vmstack.vlsingle.ingress.annotations | object | `{}` | Ingress annotations |
| vmstack.vlsingle.ingress.enabled | bool | `false` | Enable deployment of ingress for server component |
| vmstack.vlsingle.ingress.extraPaths | list | `[]` | Extra paths to prepend to every host configuration. This is useful when working with annotation based services. |
| vmstack.vlsingle.ingress.hosts | list | `[]` | Array of host objects |
| vmstack.vlsingle.ingress.ingressClassName | string | `""` | Ingress controller class name |
| vmstack.vlsingle.ingress.labels | object | `{}` | Ingress extra labels |
| vmstack.vlsingle.ingress.path | string | `""` | Ingress default path |
| vmstack.vlsingle.ingress.pathType | string | `"Prefix"` | Ingress path type |
| vmstack.vlsingle.ingress.tls | list | `[]` | Array of TLS objects |
| vmstack.vlsingle.labels | object | `{}` | VLSingle labels |
| vmstack.vlsingle.route.annotations | object | `{}` | HTTPRoute annotations |
| vmstack.vlsingle.route.enabled | bool | `false` | Enable deployment of HTTPRoute for server component |
| vmstack.vlsingle.route.extraRules | list | `[]` | Extra rules to prepend to route. This is useful when working with annotation based services. |
| vmstack.vlsingle.route.filters | list | `[]` | Filters for a default rule in HTTPRoute |
| vmstack.vlsingle.route.hostnames | list | `[]` | Array of hostnames |
| vmstack.vlsingle.route.labels | object | `{}` | HTTPRoute extra labels |
| vmstack.vlsingle.route.matches | list | `[{"path":{"type":"PathPrefix","value":"{{ dig \"spec\" \"extraArgs\" \"http.pathPrefix\" \"/\" .Values.vlsingle }}"}}]` | Matches for a default rule in HTTPRoute |
| vmstack.vlsingle.route.parentRefs | list | `[]` | HTTPGateway objects refs |
| vmstack.vlsingle.route.port | string | `"{{ .Values.vlsingle.spec.port }}"` | Route port |
| vmstack.vlsingle.spec | object | `{"extraArgs":{},"image":{"tag":"v1.52.0"},"port":"9428","replicaCount":1,"retentionPeriod":"1","storage":{"accessModes":["ReadWriteOnce"],"resources":{"requests":{"storage":"20Gi"}}}}` | Full spec for VLSingle CRD. Allowed values describe [here](https://docs.victoriametrics.com/operator/api/#vlsinglespec) |
| vmstack.vlsingle.spec.retentionPeriod | string | `"1"` | Data retention period. Possible units character: h(ours), d(ays), w(eeks), y(ears), if no unit character specified - month. The minimum retention period is 24h. See these [docs](https://docs.victoriametrics.com/victoriametrics/single-server-victoriametrics/#retention) |
| vmstack.vmagent.additionalRemoteWrites | list | `[]` | Remote write configuration of VMAgent, allowed parameters defined in a [spec](https://docs.victoriametrics.com/operator/api/#vmagentremotewritespec) |
| vmstack.vmagent.annotations | object | `{}` | VMAgent annotations |
| vmstack.vmagent.enabled | bool | `true` | Create VMAgent CR |
| vmstack.vmagent.ingress | object | `{"annotations":{},"enabled":false,"extraPaths":[],"hosts":["vmagent.domain.com"],"labels":{},"path":"","pathType":"Prefix","tls":[]}` | VMAgent ingress configuration |
| vmstack.vmagent.labels | object | `{}` | VMAgent labels |
| vmstack.vmagent.rbac.annotations | object | `{}` | Role/RoleBinding annotations |
| vmstack.vmagent.rbac.extraLabels | object | `{}` | Role/RoleBinding labels |
| vmstack.vmagent.rbac.namespaced | bool | `true` | Defines if ClusterRole or Role with respective bindings should be created |
| vmstack.vmagent.rbac.rules | list | `[]` | additional rules for a role |
| vmstack.vmagent.route | object | `{"annotations":{},"enabled":false,"extraRules":[],"filters":[],"hostnames":[],"labels":{},"matches":[{"path":{"type":"PathPrefix","value":"{{ dig \"spec\" \"extraArgs\" \"http.pathPrefix\" \"/\" .Values.vmagent }}"}}],"parentRefs":[],"port":"{{ .Values.vmagent.spec.port }}"}` | VMAgent route configuration |
| vmstack.vmagent.route.annotations | object | `{}` | HTTPRoute annotations |
| vmstack.vmagent.route.enabled | bool | `false` | Enable deployment of HTTPRoute for vmagent component |
| vmstack.vmagent.route.extraRules | list | `[]` | Extra rules to prepend to route. This is useful when working with annotation based services. |
| vmstack.vmagent.route.filters | list | `[]` | Filters for a default rule in HTTPRoute |
| vmstack.vmagent.route.hostnames | list | `[]` | Array of hostnames |
| vmstack.vmagent.route.labels | object | `{}` | HTTPRoute extra labels |
| vmstack.vmagent.route.matches | list | `[{"path":{"type":"PathPrefix","value":"{{ dig \"spec\" \"extraArgs\" \"http.pathPrefix\" \"/\" .Values.vmagent }}"}}]` | Matches for a default rule in HTTPRoute |
| vmstack.vmagent.route.parentRefs | list | `[]` | HTTPGateway objects refs |
| vmstack.vmagent.route.port | string | `"{{ .Values.vmagent.spec.port }}"` | Route port |
| vmstack.vmagent.spec | object | `{"externalLabels":{},"extraArgs":{"promscrape.streamParse":"true"},"port":"8429","scrapeInterval":"20s","selectAllByDefault":true}` | Full spec for VMAgent CRD. Allowed values described [here](https://docs.victoriametrics.com/operator/api/#vmagentspec) |
| vmstack.vmalert.additionalNotifierConfigs | object | `{}` | Allows to configure static notifiers, discover notifiers via Consul and DNS, see specification [here](https://docs.victoriametrics.com/victoriametrics/vmalert/#notifier-configuration-file). This configuration will be created as separate secret and mounted to VMAlert pod. |
| vmstack.vmalert.annotations | object | `{}` | VMAlert annotations |
| vmstack.vmalert.enabled | bool | `true` | Create VMAlert CR |
| vmstack.vmalert.ingress | object | `{"annotations":{},"enabled":false,"extraPaths":[],"hosts":["vmalert.domain.com"],"labels":{},"path":"","pathType":"Prefix","tls":[]}` | VMAlert ingress config |
| vmstack.vmalert.ingress.extraPaths | list | `[]` | Extra paths to prepend to every host configuration. This is useful when working with annotation based services. |
| vmstack.vmalert.labels | object | `{}` | VMAlert labels |
| vmstack.vmalert.remoteWriteVMAgent | bool | `false` | Controls whether VMAlert should use VMAgent or VMInsert as a target for remotewrite |
| vmstack.vmalert.route | object | `{"annotations":{},"enabled":false,"extraRules":[],"filters":[],"hostnames":[],"labels":{},"matches":[{"path":{"type":"PathPrefix","value":"{{ dig \"spec\" \"extraArgs\" \"http.pathPrefix\" \"/\" .Values.vmalert }}"}}],"parentRefs":[],"port":"{{ .Values.vmalert.spec.port }}"}` | VMAlert route configuration |
| vmstack.vmalert.route.annotations | object | `{}` | HTTPRoute annotations |
| vmstack.vmalert.route.enabled | bool | `false` | Enable deployment of HTTPRoute for vmalert component |
| vmstack.vmalert.route.extraRules | list | `[]` | Extra rules to prepend to route. This is useful when working with annotation based services. |
| vmstack.vmalert.route.filters | list | `[]` | Filters for a default rule in HTTPRoute |
| vmstack.vmalert.route.hostnames | list | `[]` | Array of hostnames |
| vmstack.vmalert.route.labels | object | `{}` | HTTPRoute extra labels |
| vmstack.vmalert.route.matches | list | `[{"path":{"type":"PathPrefix","value":"{{ dig \"spec\" \"extraArgs\" \"http.pathPrefix\" \"/\" .Values.vmalert }}"}}]` | Matches for a default rule in HTTPRoute |
| vmstack.vmalert.route.parentRefs | list | `[]` | HTTPGateway objects refs |
| vmstack.vmalert.route.port | string | `"{{ .Values.vmalert.spec.port }}"` | Route port |
| vmstack.vmalert.spec | object | `{"evaluationInterval":"20s","externalLabels":{},"extraArgs":{"http.pathPrefix":"/"},"port":"8080","selectAllByDefault":true}` | Full spec for VMAlert CRD. Allowed values described [here](https://docs.victoriametrics.com/operator/api/#vmalertspec) |
| vmstack.vmalert.templateFiles | object | `{}` | Extra VMAlert annotation templates |
| vmstack.vmauth.annotations | object | `{}` | VMAuth annotations |
| vmstack.vmauth.enabled | bool | `false` | Enable VMAuth CR |
| vmstack.vmauth.labels | object | `{}` | VMAuth labels |
| vmstack.vmauth.spec | object | `{"port":"8427","unauthorizedUserAccessSpec":{"disabled":false,"discover_backend_ips":true,"url_map":[{"src_paths":["{{ .vm.read.path }}/.*"],"url_prefix":["{{ urlJoin (omit .vm.read \"path\") }}/"]},{"src_paths":["{{ .vm.write.path }}/.*"],"url_prefix":["{{ urlJoin (omit .vm.write \"path\") }}/"]}]}}` | Full spec for VMAuth CRD. Allowed values described [here](https://docs.victoriametrics.com/operator/api/#vmauthspec) It's possible to use given below predefined variables in spec: * `{{ .vm.read }}` - parsed vmselect, vmsingle or external.vm.read URL * `{{ .vm.write }}` - parsed vminsert, vmsingle or external.vm.write URL * `{{ .vl.read }}` - parsed vlselect, vlsingle or external.vl.read URL * `{{ .vl.write }}` - parsed vlinsert, vlsingle or external.vl.write URL * `{{ .vt.read }}` - parsed vtselect, vtsingle or external.vt.read URL * `{{ .vt.write }}` - parsed vtinsert, vtsingle or external.vt.write URL |
| vmstack.vmauth.spec.unauthorizedUserAccessSpec.disabled | bool | `false` | Flag, that allows to disable default VMAuth unauthorized user access config |
| vmstack.vmcluster.annotations | object | `{}` | VMCluster annotations |
| vmstack.vmcluster.enabled | bool | `false` | Create VMCluster CR |
| vmstack.vmcluster.ingress.insert.annotations | object | `{}` | Ingress annotations |
| vmstack.vmcluster.ingress.insert.enabled | bool | `false` | Enable deployment of ingress for server component |
| vmstack.vmcluster.ingress.insert.extraPaths | list | `[]` | Extra paths to prepend to every host configuration. This is useful when working with annotation based services. |
| vmstack.vmcluster.ingress.insert.hosts | list | `[]` | Array of host objects |
| vmstack.vmcluster.ingress.insert.ingressClassName | string | `""` | Ingress controller class name |
| vmstack.vmcluster.ingress.insert.labels | object | `{}` | Ingress extra labels |
| vmstack.vmcluster.ingress.insert.path | string | `"{{ dig \"extraArgs\" \"http.pathPrefix\" \"/\" .Values.vmcluster.spec.vminsert }}"` | Ingress default path |
| vmstack.vmcluster.ingress.insert.pathType | string | `"Prefix"` | Ingress path type |
| vmstack.vmcluster.ingress.insert.tls | list | `[]` | Array of TLS objects |
| vmstack.vmcluster.ingress.select.annotations | object | `{}` | Ingress annotations |
| vmstack.vmcluster.ingress.select.enabled | bool | `false` | Enable deployment of ingress for server component |
| vmstack.vmcluster.ingress.select.extraPaths | list | `[]` | Extra paths to prepend to every host configuration. This is useful when working with annotation based services. |
| vmstack.vmcluster.ingress.select.hosts | list | `[]` | Array of host objects |
| vmstack.vmcluster.ingress.select.ingressClassName | string | `""` | Ingress controller class name |
| vmstack.vmcluster.ingress.select.labels | object | `{}` | Ingress extra labels |
| vmstack.vmcluster.ingress.select.path | string | `"{{ dig \"extraArgs\" \"http.pathPrefix\" \"/\" .Values.vmcluster.spec.vmselect }}"` | Ingress default path |
| vmstack.vmcluster.ingress.select.pathType | string | `"Prefix"` | Ingress path type |
| vmstack.vmcluster.ingress.select.tls | list | `[]` | Array of TLS objects |
| vmstack.vmcluster.ingress.storage.annotations | object | `{}` | Ingress annotations |
| vmstack.vmcluster.ingress.storage.enabled | bool | `false` | Enable deployment of ingress for server component |
| vmstack.vmcluster.ingress.storage.extraPaths | list | `[]` | Extra paths to prepend to every host configuration. This is useful when working with annotation based services. |
| vmstack.vmcluster.ingress.storage.hosts | list | `[]` | Array of host objects |
| vmstack.vmcluster.ingress.storage.ingressClassName | string | `""` | Ingress controller class name |
| vmstack.vmcluster.ingress.storage.labels | object | `{}` | Ingress extra labels |
| vmstack.vmcluster.ingress.storage.path | string | `""` | Ingress default path |
| vmstack.vmcluster.ingress.storage.pathType | string | `"Prefix"` | Ingress path type |
| vmstack.vmcluster.ingress.storage.tls | list | `[]` | Array of TLS objects |
| vmstack.vmcluster.labels | object | `{}` | VMCluster labels |
| vmstack.vmcluster.route.insert.annotations | object | `{}` | HTTPRoute annotations |
| vmstack.vmcluster.route.insert.enabled | bool | `false` | Enable deployment of HTTPRoute for insert component |
| vmstack.vmcluster.route.insert.extraRules | list | `[]` | Extra rules to prepend to route. This is useful when working with annotation based services. |
| vmstack.vmcluster.route.insert.filters | list | `[]` | Filters for a default rule in HTTPRoute |
| vmstack.vmcluster.route.insert.hostnames | list | `[]` | Array of hostnames |
| vmstack.vmcluster.route.insert.labels | object | `{}` | HTTPRoute extra labels |
| vmstack.vmcluster.route.insert.matches | list | `[{"path":{"type":"PathPrefix","value":"{{ dig \"extraArgs\" \"http.pathPrefix\" \"/\" .Values.vmcluster.spec.vminsert }}"}}]` | Matches for a default rule in HTTPRoute |
| vmstack.vmcluster.route.insert.parentRefs | list | `[]` | HTTPGateway objects refs |
| vmstack.vmcluster.route.insert.port | string | `"{{ .Values.vmcluster.spec.vminsert.port }}"` | Route port |
| vmstack.vmcluster.route.select.annotations | object | `{}` | HTTPRoute annotations |
| vmstack.vmcluster.route.select.enabled | bool | `false` | Enable deployment of HTTPRoute for select component |
| vmstack.vmcluster.route.select.extraRules | list | `[]` | Extra rules to prepend to route. This is useful when working with annotation based services. |
| vmstack.vmcluster.route.select.filters | list | `[]` | Filters for a default rule in HTTPRoute |
| vmstack.vmcluster.route.select.hostnames | list | `[]` | Array of hostnames |
| vmstack.vmcluster.route.select.labels | object | `{}` | HTTPRoute extra labels |
| vmstack.vmcluster.route.select.matches | list | `[{"path":{"type":"PathPrefix","value":"{{ dig \"extraArgs\" \"http.pathPrefix\" \"/\" .Values.vmcluster.spec.vmselect }}"}}]` | Matches for a default rule in HTTPRoute |
| vmstack.vmcluster.route.select.parentRefs | list | `[]` | HTTPGateway objects refs |
| vmstack.vmcluster.route.select.port | string | `"{{ .Values.vmcluster.spec.vmselect.port }}"` | Route port |
| vmstack.vmcluster.route.storage.annotations | object | `{}` | HTTPRoute annotations |
| vmstack.vmcluster.route.storage.enabled | bool | `false` | Enable deployment of HTTPRoute for storage component |
| vmstack.vmcluster.route.storage.extraRules | list | `[]` | Extra rules to prepend to route. This is useful when working with annotation based services. |
| vmstack.vmcluster.route.storage.filters | list | `[]` | Filters for a default rule in HTTPRoute |
| vmstack.vmcluster.route.storage.hostnames | list | `[]` | Array of hostnames |
| vmstack.vmcluster.route.storage.labels | object | `{}` | HTTPRoute extra labels |
| vmstack.vmcluster.route.storage.matches | list | `[{"path":{"type":"PathPrefix","value":"{{ dig \"extraArgs\" \"http.pathPrefix\" \"/\" .Values.vmcluster.spec.vmstorage }}"}}]` | Matches for a default rule in HTTPRoute |
| vmstack.vmcluster.route.storage.parentRefs | list | `[]` | HTTPGateway objects refs |
| vmstack.vmcluster.route.storage.port | string | `"{{ .Values.vmcluster.spec.vmstorage.port }}"` | Route port |
| vmstack.vmcluster.spec | object | `{"replicationFactor":2,"retentionPeriod":"1","vminsert":{"enabled":true,"extraArgs":{},"port":"8480","replicaCount":2,"resources":{}},"vmselect":{"cacheMountPath":"/select-cache","enabled":true,"extraArgs":{},"port":"8481","replicaCount":2,"resources":{},"storage":{"volumeClaimTemplate":{"spec":{"resources":{"requests":{"storage":"2Gi"}}}}}},"vmstorage":{"replicaCount":2,"resources":{},"storage":{"volumeClaimTemplate":{"spec":{"resources":{"requests":{"storage":"10Gi"}}}}},"storageDataPath":"/vm-data"}}` | Full spec for VMCluster CRD. Allowed values described [here](https://docs.victoriametrics.com/operator/api/#vmclusterspec) |
| vmstack.vmcluster.spec.retentionPeriod | string | `"1"` | Data retention period. Possible units character: h(ours), d(ays), w(eeks), y(ears), if no unit character specified - month. The minimum retention period is 24h. See these [docs](https://docs.victoriametrics.com/victoriametrics/single-server-victoriametrics/#retention) |
| vmstack.vmcluster.spec.vminsert.enabled | bool | `true` | Set this value to false to disable VMInsert |
| vmstack.vmcluster.spec.vmselect.enabled | bool | `true` | Set this value to false to disable VMSelect |
| vmstack.vmdistributed.annotations | object | `{}` | VMDistributed annotations |
| vmstack.vmdistributed.enabled | bool | `false` | Create VMDistributed CR |
| vmstack.vmdistributed.labels | object | `{}` | VMDistributed labels |
| vmstack.vmdistributed.spec | object | `{"vmauth":{"spec":{"port":"8427"}},"zoneCommon":{"vmcluster":{"spec":{"vminsert":{"replicaCount":2},"vmselect":{"cacheMountPath":"/select-cache","replicaCount":2,"storage":{"volumeClaimTemplate":{"spec":{"resources":{"requests":{"storage":"2Gi"}}}}}},"vmstorage":{"replicaCount":2,"storage":{"volumeClaimTemplate":{"spec":{"resources":{"requests":{"storage":"10Gi"}}}}},"storageDataPath":"/vm-data"}}}},"zones":[{"name":"us-east-1"}]}` | Full spec for VMDistributed CRD. Allowed values described [here](https://docs.victoriametrics.com/operator/api/#vmdistributedspec) |
| vmstack.vmsingle.annotations | object | `{}` | VMSingle annotations |
| vmstack.vmsingle.enabled | bool | `true` | Create VMSingle CR |
| vmstack.vmsingle.ingress.annotations | object | `{}` | Ingress annotations |
| vmstack.vmsingle.ingress.enabled | bool | `false` | Enable deployment of ingress for server component |
| vmstack.vmsingle.ingress.extraPaths | list | `[]` | Extra paths to prepend to every host configuration. This is useful when working with annotation based services. |
| vmstack.vmsingle.ingress.hosts | list | `[]` | Array of host objects |
| vmstack.vmsingle.ingress.ingressClassName | string | `""` | Ingress controller class name |
| vmstack.vmsingle.ingress.labels | object | `{}` | Ingress extra labels |
| vmstack.vmsingle.ingress.path | string | `""` | Ingress default path |
| vmstack.vmsingle.ingress.pathType | string | `"Prefix"` | Ingress path type |
| vmstack.vmsingle.ingress.tls | list | `[]` | Array of TLS objects |
| vmstack.vmsingle.labels | object | `{}` | VMSingle labels |
| vmstack.vmsingle.route.annotations | object | `{}` | HTTPRoute annotations |
| vmstack.vmsingle.route.enabled | bool | `false` | Enable deployment of HTTPRoute for server component |
| vmstack.vmsingle.route.extraRules | list | `[]` | Extra rules to prepend to route. This is useful when working with annotation based services. |
| vmstack.vmsingle.route.filters | list | `[]` | Filters for a default rule in HTTPRoute |
| vmstack.vmsingle.route.hostnames | list | `[]` | Array of hostnames |
| vmstack.vmsingle.route.labels | object | `{}` | HTTPRoute extra labels |
| vmstack.vmsingle.route.matches | list | `[{"path":{"type":"PathPrefix","value":"{{ dig \"spec\" \"extraArgs\" \"http.pathPrefix\" \"/\" .Values.vmsingle }}"}}]` | Matches for a default rule in HTTPRoute |
| vmstack.vmsingle.route.parentRefs | list | `[]` | HTTPGateway objects refs |
| vmstack.vmsingle.route.port | string | `"{{ .Values.vmsingle.spec.port }}"` | Route port |
| vmstack.vmsingle.spec | object | `{"extraArgs":{},"port":"8428","replicaCount":1,"retentionPeriod":"1","storage":{"accessModes":["ReadWriteOnce"],"resources":{"requests":{"storage":"20Gi"}}}}` | Full spec for VMSingle CRD. Allowed values describe [here](https://docs.victoriametrics.com/operator/api/#vmsinglespec) |
| vmstack.vmsingle.spec.retentionPeriod | string | `"1"` | Data retention period. Possible units character: h(ours), d(ays), w(eeks), y(ears), if no unit character specified - month. The minimum retention period is 24h. See these [docs](https://docs.victoriametrics.com/victoriametrics/single-server-victoriametrics/#retention) |
| vmstack.vtcluster.annotations | object | `{}` | VTCluster annotations |
| vmstack.vtcluster.enabled | bool | `false` | Create VTCluster CR |
| vmstack.vtcluster.ingress.vtinsert.annotations | object | `{}` | Ingress annotations |
| vmstack.vtcluster.ingress.vtinsert.enabled | bool | `false` | Enable deployment of ingress for insert component |
| vmstack.vtcluster.ingress.vtinsert.extraPaths | list | `[]` | Extra paths to prepend to every host configuration. This is useful when working with annotation based services. |
| vmstack.vtcluster.ingress.vtinsert.hosts | list | `[]` | Array of host objects |
| vmstack.vtcluster.ingress.vtinsert.ingressClassName | string | `""` | Ingress controller class name |
| vmstack.vtcluster.ingress.vtinsert.labels | object | `{}` | Ingress extra labels |
| vmstack.vtcluster.ingress.vtinsert.path | string | `"{{ dig \"extraArgs\" \"http.pathPrefix\" \"/\" .Values.vtcluster.spec.vtinsert }}"` | Ingress default path |
| vmstack.vtcluster.ingress.vtinsert.pathType | string | `"Prefix"` | Ingress path type |
| vmstack.vtcluster.ingress.vtinsert.tls | list | `[]` | Array of TLS objects |
| vmstack.vtcluster.ingress.vtselect.annotations | object | `{}` | Ingress annotations |
| vmstack.vtcluster.ingress.vtselect.enabled | bool | `false` | Enable deployment of ingress for select component |
| vmstack.vtcluster.ingress.vtselect.extraPaths | list | `[]` | Extra paths to prepend to every host configuration. This is useful when working with annotation based services. |
| vmstack.vtcluster.ingress.vtselect.hosts | list | `[]` | Array of host objects |
| vmstack.vtcluster.ingress.vtselect.ingressClassName | string | `""` | Ingress controller class name |
| vmstack.vtcluster.ingress.vtselect.labels | object | `{}` | Ingress extra labels |
| vmstack.vtcluster.ingress.vtselect.path | string | `"{{ dig \"extraArgs\" \"http.pathPrefix\" \"/\" .Values.vtcluster.spec.vtselect }}"` | Ingress default path |
| vmstack.vtcluster.ingress.vtselect.pathType | string | `"Prefix"` | Ingress path type |
| vmstack.vtcluster.ingress.vtselect.tls | list | `[]` | Array of TLS objects |
| vmstack.vtcluster.ingress.vtstorage.annotations | object | `{}` | Ingress annotations |
| vmstack.vtcluster.ingress.vtstorage.enabled | bool | `false` | Enable deployment of ingress for storage component |
| vmstack.vtcluster.ingress.vtstorage.extraPaths | list | `[]` | Extra paths to prepend to every host configuration. This is useful when working with annotation based services. |
| vmstack.vtcluster.ingress.vtstorage.hosts | list | `[]` | Array of host objects |
| vmstack.vtcluster.ingress.vtstorage.ingressClassName | string | `""` | Ingress controller class name |
| vmstack.vtcluster.ingress.vtstorage.labels | object | `{}` | Ingress extra labels |
| vmstack.vtcluster.ingress.vtstorage.path | string | `""` | Ingress default path |
| vmstack.vtcluster.ingress.vtstorage.pathType | string | `"Prefix"` | Ingress path type |
| vmstack.vtcluster.ingress.vtstorage.tls | list | `[]` | Array of TLS objects |
| vmstack.vtcluster.labels | object | `{}` | VTCluster labels |
| vmstack.vtcluster.route.vtinsert.annotations | object | `{}` | HTTPRoute annotations |
| vmstack.vtcluster.route.vtinsert.enabled | bool | `false` | Enable deployment of HTTPRoute for insert component |
| vmstack.vtcluster.route.vtinsert.extraRules | list | `[]` | Extra rules to prepend to route. This is useful when working with annotation based services. |
| vmstack.vtcluster.route.vtinsert.filters | list | `[]` | Filters for a default rule in HTTPRoute |
| vmstack.vtcluster.route.vtinsert.hostnames | list | `[]` | Array of hostnames |
| vmstack.vtcluster.route.vtinsert.labels | object | `{}` | HTTPRoute extra labels |
| vmstack.vtcluster.route.vtinsert.matches | list | `[{"path":{"type":"PathPrefix","value":"{{ dig \"extraArgs\" \"http.pathPrefix\" \"/\" .Values.vtcluster.spec.vtinsert }}"}}]` | Matches for a default rule in HTTPRoute |
| vmstack.vtcluster.route.vtinsert.parentRefs | list | `[]` | HTTPGateway objects refs |
| vmstack.vtcluster.route.vtinsert.port | string | `"{{ .Values.vtcluster.spec.vtinsert.port }}"` | Route port |
| vmstack.vtcluster.route.vtselect.annotations | object | `{}` | HTTPRoute annotations |
| vmstack.vtcluster.route.vtselect.enabled | bool | `false` | Enable deployment of HTTPRoute for select component |
| vmstack.vtcluster.route.vtselect.extraRules | list | `[]` | Extra rules to prepend to route. This is useful when working with annotation based services. |
| vmstack.vtcluster.route.vtselect.filters | list | `[]` | Filters for a default rule in HTTPRoute |
| vmstack.vtcluster.route.vtselect.hostnames | list | `[]` | Array of hostnames |
| vmstack.vtcluster.route.vtselect.labels | object | `{}` | HTTPRoute extra labels |
| vmstack.vtcluster.route.vtselect.matches | list | `[{"path":{"type":"PathPrefix","value":"{{ dig \"extraArgs\" \"http.pathPrefix\" \"/\" .Values.vtcluster.spec.vtselect }}"}}]` | Matches for a default rule in HTTPRoute |
| vmstack.vtcluster.route.vtselect.parentRefs | list | `[]` | HTTPGateway objects refs |
| vmstack.vtcluster.route.vtselect.port | string | `"{{ .Values.vtcluster.spec.vtselect.port }}"` | Route port |
| vmstack.vtcluster.route.vtstorage.annotations | object | `{}` | HTTPRoute annotations |
| vmstack.vtcluster.route.vtstorage.enabled | bool | `false` | Enable deployment of HTTPRoute for storage component |
| vmstack.vtcluster.route.vtstorage.extraRules | list | `[]` | Extra rules to prepend to route. This is useful when working with annotation based services. |
| vmstack.vtcluster.route.vtstorage.filters | list | `[]` | Filters for a default rule in HTTPRoute |
| vmstack.vtcluster.route.vtstorage.hostnames | list | `[]` | Array of hostnames |
| vmstack.vtcluster.route.vtstorage.labels | object | `{}` | HTTPRoute extra labels |
| vmstack.vtcluster.route.vtstorage.matches | list | `[{"path":{"type":"PathPrefix","value":"{{ dig \"extraArgs\" \"http.pathPrefix\" \"/\" .Values.vtcluster.spec.vtstorage }}"}}]` | Matches for a default rule in HTTPRoute |
| vmstack.vtcluster.route.vtstorage.parentRefs | list | `[]` | HTTPGateway objects refs |
| vmstack.vtcluster.route.vtstorage.port | string | `"{{ .Values.vtcluster.spec.vtstorage.port }}"` | Route port |
| vmstack.vtcluster.spec | object | `{"clusterVersion":"v0.9.4","vtinsert":{"enabled":true,"extraArgs":{},"port":"10481","replicaCount":2,"resources":{}},"vtselect":{"enabled":true,"extraArgs":{},"port":"10471","replicaCount":2,"resources":{}},"vtstorage":{"port":"10491","replicaCount":2,"resources":{},"retentionPeriod":"14d","storage":{"volumeClaimTemplate":{"spec":{"resources":{"requests":{"storage":"10Gi"}}}}},"storageDataPath":"/vt-data"}}` | Full spec for VTCluster CRD. Allowed values described [here](https://docs.victoriametrics.com/operator/api/#vtclusterspec) |
| vmstack.vtcluster.spec.vtinsert.enabled | bool | `true` | Set this value to false to disable VTInsert |
| vmstack.vtcluster.spec.vtselect.enabled | bool | `true` | Set this value to false to disable VTSelect |
| vmstack.vtcluster.spec.vtstorage.retentionPeriod | string | `"14d"` | Data retention period. Possible units character: h(ours), d(ays), w(eeks), y(ears), if no unit character specified - month. The minimum retention period is 24h. |
| vmstack.vtsingle.annotations | object | `{}` | VTSingle annotations |
| vmstack.vtsingle.enabled | bool | `false` | Create VTSingle CR |
| vmstack.vtsingle.ingress.annotations | object | `{}` | Ingress annotations |
| vmstack.vtsingle.ingress.enabled | bool | `false` | Enable deployment of ingress for server component |
| vmstack.vtsingle.ingress.extraPaths | list | `[]` | Extra paths to prepend to every host configuration. This is useful when working with annotation based services. |
| vmstack.vtsingle.ingress.hosts | list | `[]` | Array of host objects |
| vmstack.vtsingle.ingress.ingressClassName | string | `""` | Ingress controller class name |
| vmstack.vtsingle.ingress.labels | object | `{}` | Ingress extra labels |
| vmstack.vtsingle.ingress.path | string | `""` | Ingress default path |
| vmstack.vtsingle.ingress.pathType | string | `"Prefix"` | Ingress path type |
| vmstack.vtsingle.ingress.tls | list | `[]` | Array of TLS objects |
| vmstack.vtsingle.labels | object | `{}` | VTSingle labels |
| vmstack.vtsingle.route.annotations | object | `{}` | HTTPRoute annotations |
| vmstack.vtsingle.route.enabled | bool | `false` | Enable deployment of HTTPRoute for server component |
| vmstack.vtsingle.route.extraRules | list | `[]` | Extra rules to prepend to route. This is useful when working with annotation based services. |
| vmstack.vtsingle.route.filters | list | `[]` | Filters for a default rule in HTTPRoute |
| vmstack.vtsingle.route.hostnames | list | `[]` | Array of hostnames |
| vmstack.vtsingle.route.labels | object | `{}` | HTTPRoute extra labels |
| vmstack.vtsingle.route.matches | list | `[{"path":{"type":"PathPrefix","value":"{{ dig \"spec\" \"extraArgs\" \"http.pathPrefix\" \"/\" .Values.vtsingle }}"}}]` | Matches for a default rule in HTTPRoute |
| vmstack.vtsingle.route.parentRefs | list | `[]` | HTTPGateway objects refs |
| vmstack.vtsingle.route.port | string | `"{{ .Values.vtsingle.spec.port }}"` | Route port |
| vmstack.vtsingle.spec | object | `{"extraArgs":{},"image":{"tag":"v0.9.4"},"port":"10428","replicaCount":1,"retentionPeriod":"1","storage":{"accessModes":["ReadWriteOnce"],"resources":{"requests":{"storage":"20Gi"}}}}` | Full spec for VTSingle CRD. Allowed values described [here](https://docs.victoriametrics.com/operator/api/#vtsinglespec) |
| vmstack.vtsingle.spec.retentionPeriod | string | `"1"` | Data retention period. Possible units character: h(ours), d(ays), w(eeks), y(ears), if no unit character specified - month. The minimum retention period is 24h. |

## Installing the Chart

### With Helm

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm repo update
helm upgrade --install vmks ekp-helm/victoria-metrics-k8s-stack \
  --namespace monitoring \
  --create-namespace
```

### With Argo CD

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: victoria-metrics-k8s-stack
  namespace: argocd
spec:
  project: infra
  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.0"
    chart: victoria-metrics-k8s-stack
    helm:
      releaseName: vmks
      values: |
        vmstack:
          nameOverride: vmks
          defaultDashboards:
            annotations:
              argocd.argoproj.io/sync-options: ServerSideApply=true
  destination:
    server: https://kubernetes.default.svc
    namespace: monitoring
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
      - CreateNamespace=true
      - ServerSideApply=true
```

The stack creates cluster-scoped CRDs and RBAC. Review the upstream
[Argo CD guidance](https://docs.victoriametrics.com/helm/victoria-metrics-k8s-stack/#argocd-issues)
when configuring webhook certificates, Grafana credentials, or removal.

## Develop

### Update documentation

```bash
helm-docs
```

### Run linter

```bash
docker run --rm -it -w /charts -v $(pwd)/../../:/charts \
  quay.io/helmpack/chart-testing:v3.12.0 \
  ct lint --charts /charts/charts/victoria-metrics-k8s-stack \
  --config /charts/charts/victoria-metrics-k8s-stack/ct.yaml
```

### Run Pluto

```bash
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto \
  alpine/helm:3.17 template victoria-metrics-k8s-stack . \
  -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data \
  us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 \
  detect-files -d /data -o wide \
  --ignore-deprecations \
  -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0"
docker volume rm pluto
```
