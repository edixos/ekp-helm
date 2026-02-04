# grafana-stack

![Version: 0.1.4](https://img.shields.io/badge/Version-0.1.4-informational?style=flat-square) ![AppVersion: 11.3.1](https://img.shields.io/badge/AppVersion-11.3.1-informational?style=flat-square)

----

[[_TOC_]]

----

## Prerequisites

- Helm v3.1+

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://grafana.github.io/helm-charts | grafana | 10.5.15 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| ilyasabdellaoui | <ilyas.abdellaoui21@gmail.com> | <https://github.com/ilyasabdellaoui> |

## Description

Deploys Grafana instance. Pre-configured values from [upstream grafana chart](https://github.com/helm/charts/tree/master/stable/grafana)

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| dashboards.k8s.create | bool | `false` | Create grafana dashboards to monitor kubernetes cluster |
| dashboards.labels | object | `{}` | Labels added to configmap dashboards |
| fullnameOverride | string | `""` |  |
| global.enableArgocdAnnotations | bool | `false` | Annotate Custom Resources with `argocd.argoproj.io/sync-options: SkipDryRunOnMissingResource=true` for Argocd |
| grafana."grafana.ini".analytics.check_for_updates | bool | `true` |  |
| grafana."grafana.ini".log.mode | string | `"console"` |  |
| grafana."grafana.ini".paths.data | string | `"/var/lib/grafana/"` |  |
| grafana."grafana.ini".paths.logs | string | `"/var/log/grafana"` |  |
| grafana."grafana.ini".paths.plugins | string | `"/var/lib/grafana/plugins"` |  |
| grafana."grafana.ini".paths.provisioning | string | `"/etc/grafana/provisioning"` |  |
| grafana."grafana.ini".server.domain | string | `"{{ if (and .Values.ingress.enabled .Values.ingress.hosts) }}{{ tpl (.Values.ingress.hosts | first) . }}{{ else if (and .Values.route.main.enabled .Values.route.main.hostnames) }}{{ tpl (.Values.route.main.hostnames | first) . }}{{ else }}''{{ end }}"` |  |
| grafana."grafana.ini".unified_storage.index_path | string | `"/var/lib/grafana-search/bleve"` |  |
| grafana.admin.existingSecret | string | `""` |  |
| grafana.admin.passwordKey | string | `"admin-password"` |  |
| grafana.admin.userKey | string | `"admin-user"` |  |
| grafana.adminUser | string | `"admin"` |  |
| grafana.affinity | object | `{}` |  |
| grafana.alerting | object | `{}` |  |
| grafana.assertNoLeakedSecrets | bool | `true` |  |
| grafana.automountServiceAccountToken | bool | `true` |  |
| grafana.autoscaling.behavior | object | `{}` |  |
| grafana.autoscaling.enabled | bool | `false` |  |
| grafana.autoscaling.maxReplicas | int | `5` |  |
| grafana.autoscaling.minReplicas | int | `1` |  |
| grafana.autoscaling.targetCPU | string | `"60"` |  |
| grafana.autoscaling.targetMemory | string | `""` |  |
| grafana.containerSecurityContext.allowPrivilegeEscalation | bool | `false` |  |
| grafana.containerSecurityContext.capabilities.drop[0] | string | `"ALL"` |  |
| grafana.containerSecurityContext.privileged | bool | `false` |  |
| grafana.containerSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| grafana.createConfigmap | bool | `true` |  |
| grafana.dashboardProviders | object | `{}` |  |
| grafana.dashboards | object | `{}` |  |
| grafana.dashboardsConfigMaps | object | `{}` |  |
| grafana.datasources | object | `{}` |  |
| grafana.defaultCurlOptions | string | `"-skf"` |  |
| grafana.deploymentStrategy.type | string | `"RollingUpdate"` |  |
| grafana.dnsConfig | object | `{}` |  |
| grafana.dnsPolicy | string | `nil` |  |
| grafana.downloadDashboards.env | object | `{}` |  |
| grafana.downloadDashboards.envFromSecret | string | `""` |  |
| grafana.downloadDashboards.envValueFrom | object | `{}` |  |
| grafana.downloadDashboards.resources | object | `{}` |  |
| grafana.downloadDashboards.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| grafana.downloadDashboards.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| grafana.downloadDashboards.securityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| grafana.downloadDashboardsImage.pullPolicy | string | `"IfNotPresent"` |  |
| grafana.downloadDashboardsImage.registry | string | `"docker.io"` | The Docker registry |
| grafana.downloadDashboardsImage.repository | string | `"curlimages/curl"` |  |
| grafana.downloadDashboardsImage.sha | string | `""` |  |
| grafana.downloadDashboardsImage.tag | string | `"8.9.1"` |  |
| grafana.enableKubeBackwardCompatibility | bool | `false` |  |
| grafana.enableServiceLinks | bool | `true` |  |
| grafana.env | object | `{}` |  |
| grafana.envFromConfigMaps | list | `[]` |  |
| grafana.envFromSecret | string | `""` |  |
| grafana.envFromSecrets | list | `[]` |  |
| grafana.envRenderSecret | object | `{}` |  |
| grafana.envValueFrom | object | `{}` |  |
| grafana.extraConfigmapMounts | list | `[]` |  |
| grafana.extraContainerVolumes | list | `[]` |  |
| grafana.extraContainers | string | `""` |  |
| grafana.extraEmptyDirMounts | list | `[]` |  |
| grafana.extraExposePorts | list | `[]` |  |
| grafana.extraInitContainers | list | `[]` |  |
| grafana.extraLabels | object | `{}` |  |
| grafana.extraObjects | list | `[]` |  |
| grafana.extraSecretMounts | list | `[]` |  |
| grafana.extraVolumeMounts | list | `[]` |  |
| grafana.extraVolumes | list | `[]` |  |
| grafana.global.imagePullSecrets | list | `[]` |  |
| grafana.global.imageRegistry | string | `nil` | Overrides the Docker registry globally for all images |
| grafana.gossipPortName | string | `"gossip"` |  |
| grafana.headlessService | bool | `false` |  |
| grafana.hostAliases | list | `[]` |  |
| grafana.hostUsers | string | `nil` |  |
| grafana.image.pullPolicy | string | `"IfNotPresent"` |  |
| grafana.image.pullSecrets | list | `[]` |  |
| grafana.image.registry | string | `"docker.io"` | The Docker registry |
| grafana.image.repository | string | `"grafana/grafana"` | Docker image repository |
| grafana.image.sha | string | `""` |  |
| grafana.image.tag | string | `""` |  |
| grafana.imageRenderer.affinity | object | `{}` |  |
| grafana.imageRenderer.automountServiceAccountToken | bool | `false` |  |
| grafana.imageRenderer.autoscaling.behavior | object | `{}` |  |
| grafana.imageRenderer.autoscaling.enabled | bool | `false` |  |
| grafana.imageRenderer.autoscaling.maxReplicas | int | `5` |  |
| grafana.imageRenderer.autoscaling.minReplicas | int | `1` |  |
| grafana.imageRenderer.autoscaling.targetCPU | string | `"60"` |  |
| grafana.imageRenderer.autoscaling.targetMemory | string | `""` |  |
| grafana.imageRenderer.containerSecurityContext.allowPrivilegeEscalation | bool | `false` |  |
| grafana.imageRenderer.containerSecurityContext.capabilities.drop[0] | string | `"ALL"` |  |
| grafana.imageRenderer.containerSecurityContext.readOnlyRootFilesystem | bool | `true` |  |
| grafana.imageRenderer.containerSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| grafana.imageRenderer.deploymentStrategy | object | `{}` |  |
| grafana.imageRenderer.enabled | bool | `false` |  |
| grafana.imageRenderer.env.HTTP_HOST | string | `"0.0.0.0"` |  |
| grafana.imageRenderer.env.XDG_CACHE_HOME | string | `"/tmp/.chromium"` |  |
| grafana.imageRenderer.env.XDG_CONFIG_HOME | string | `"/tmp/.chromium"` |  |
| grafana.imageRenderer.envValueFrom | object | `{}` |  |
| grafana.imageRenderer.extraConfigmapMounts | list | `[]` |  |
| grafana.imageRenderer.extraSecretMounts | list | `[]` |  |
| grafana.imageRenderer.extraVolumeMounts | list | `[]` |  |
| grafana.imageRenderer.extraVolumes | list | `[]` |  |
| grafana.imageRenderer.grafanaProtocol | string | `"http"` |  |
| grafana.imageRenderer.grafanaSubPath | string | `""` |  |
| grafana.imageRenderer.hostAliases | list | `[]` |  |
| grafana.imageRenderer.hostUsers | string | `nil` |  |
| grafana.imageRenderer.image.pullPolicy | string | `"Always"` |  |
| grafana.imageRenderer.image.pullSecrets | list | `[]` |  |
| grafana.imageRenderer.image.registry | string | `"docker.io"` | The Docker registry |
| grafana.imageRenderer.image.repository | string | `"grafana/grafana-image-renderer"` |  |
| grafana.imageRenderer.image.sha | string | `""` |  |
| grafana.imageRenderer.image.tag | string | `"latest"` |  |
| grafana.imageRenderer.networkPolicy.extraIngressSelectors | list | `[]` |  |
| grafana.imageRenderer.networkPolicy.limitEgress | bool | `false` |  |
| grafana.imageRenderer.networkPolicy.limitIngress | bool | `true` |  |
| grafana.imageRenderer.nodeSelector | object | `{}` |  |
| grafana.imageRenderer.podAnnotations | object | `{}` |  |
| grafana.imageRenderer.podPortName | string | `"http"` |  |
| grafana.imageRenderer.priorityClassName | string | `""` |  |
| grafana.imageRenderer.renderingCallbackURL | string | `""` |  |
| grafana.imageRenderer.replicas | int | `1` |  |
| grafana.imageRenderer.resources | object | `{}` |  |
| grafana.imageRenderer.revisionHistoryLimit | int | `10` |  |
| grafana.imageRenderer.securityContext | object | `{}` |  |
| grafana.imageRenderer.serverURL | string | `""` |  |
| grafana.imageRenderer.service.appProtocol | string | `""` |  |
| grafana.imageRenderer.service.enabled | bool | `true` |  |
| grafana.imageRenderer.service.port | int | `8081` |  |
| grafana.imageRenderer.service.portName | string | `"http"` |  |
| grafana.imageRenderer.service.targetPort | int | `8081` |  |
| grafana.imageRenderer.serviceAccountName | string | `""` |  |
| grafana.imageRenderer.serviceMonitor.enabled | bool | `false` |  |
| grafana.imageRenderer.serviceMonitor.interval | string | `"1m"` |  |
| grafana.imageRenderer.serviceMonitor.labels | object | `{}` |  |
| grafana.imageRenderer.serviceMonitor.path | string | `"/metrics"` |  |
| grafana.imageRenderer.serviceMonitor.relabelings | list | `[]` |  |
| grafana.imageRenderer.serviceMonitor.scheme | string | `"http"` |  |
| grafana.imageRenderer.serviceMonitor.scrapeTimeout | string | `"30s"` |  |
| grafana.imageRenderer.serviceMonitor.targetLabels | list | `[]` |  |
| grafana.imageRenderer.serviceMonitor.tlsConfig | object | `{}` |  |
| grafana.imageRenderer.tolerations | list | `[]` |  |
| grafana.ingress.annotations | object | `{}` |  |
| grafana.ingress.enabled | bool | `false` |  |
| grafana.ingress.extraPaths | list | `[]` |  |
| grafana.ingress.hosts[0] | string | `"chart-example.local"` |  |
| grafana.ingress.labels | object | `{}` |  |
| grafana.ingress.path | string | `"/"` |  |
| grafana.ingress.pathType | string | `"Prefix"` |  |
| grafana.ingress.tls | list | `[]` |  |
| grafana.initChownData.enabled | bool | `true` |  |
| grafana.initChownData.image.pullPolicy | string | `"IfNotPresent"` |  |
| grafana.initChownData.image.registry | string | `"docker.io"` | The Docker registry |
| grafana.initChownData.image.repository | string | `"library/busybox"` |  |
| grafana.initChownData.image.sha | string | `""` |  |
| grafana.initChownData.image.tag | string | `"1.31.1"` |  |
| grafana.initChownData.resources | object | `{}` |  |
| grafana.initChownData.securityContext.capabilities.add[0] | string | `"CHOWN"` |  |
| grafana.initChownData.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| grafana.initChownData.securityContext.readOnlyRootFilesystem | bool | `false` |  |
| grafana.initChownData.securityContext.runAsNonRoot | bool | `false` |  |
| grafana.initChownData.securityContext.runAsUser | int | `0` |  |
| grafana.initChownData.securityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| grafana.ldap.config | string | `""` |  |
| grafana.ldap.enabled | bool | `false` |  |
| grafana.ldap.existingSecret | string | `""` |  |
| grafana.lifecycleHooks | object | `{}` |  |
| grafana.livenessProbe.failureThreshold | int | `10` |  |
| grafana.livenessProbe.httpGet.path | string | `"/api/health"` |  |
| grafana.livenessProbe.httpGet.port | string | `"grafana"` |  |
| grafana.livenessProbe.initialDelaySeconds | int | `60` |  |
| grafana.livenessProbe.timeoutSeconds | int | `30` |  |
| grafana.namespaceOverride | string | `""` |  |
| grafana.networkPolicy.allowExternal | bool | `true` |  |
| grafana.networkPolicy.egress.blockDNSResolution | bool | `false` |  |
| grafana.networkPolicy.egress.enabled | bool | `false` |  |
| grafana.networkPolicy.egress.ports | list | `[]` |  |
| grafana.networkPolicy.egress.to | list | `[]` |  |
| grafana.networkPolicy.enabled | bool | `false` |  |
| grafana.networkPolicy.explicitNamespacesSelector | object | `{}` |  |
| grafana.networkPolicy.ingress | bool | `true` |  |
| grafana.nodeSelector | object | `{}` |  |
| grafana.notifiers | object | `{}` |  |
| grafana.persistence.accessModes[0] | string | `"ReadWriteOnce"` |  |
| grafana.persistence.disableWarning | bool | `false` |  |
| grafana.persistence.enabled | bool | `false` |  |
| grafana.persistence.extraPvcLabels | object | `{}` |  |
| grafana.persistence.finalizers[0] | string | `"kubernetes.io/pvc-protection"` |  |
| grafana.persistence.inMemory.enabled | bool | `false` |  |
| grafana.persistence.lookupVolumeName | bool | `true` |  |
| grafana.persistence.size | string | `"10Gi"` |  |
| grafana.persistence.type | string | `"pvc"` |  |
| grafana.persistence.volumeName | string | `""` |  |
| grafana.plugins | list | `[]` |  |
| grafana.podDisruptionBudget | object | `{}` |  |
| grafana.podPortName | string | `"grafana"` |  |
| grafana.rbac.create | bool | `true` |  |
| grafana.rbac.extraClusterRoleRules | list | `[]` |  |
| grafana.rbac.extraRoleRules | list | `[]` |  |
| grafana.rbac.namespaced | bool | `false` |  |
| grafana.rbac.pspEnabled | bool | `false` |  |
| grafana.rbac.pspUseAppArmor | bool | `false` |  |
| grafana.readinessProbe.httpGet.path | string | `"/api/health"` |  |
| grafana.readinessProbe.httpGet.port | string | `"grafana"` |  |
| grafana.replicas | int | `1` |  |
| grafana.resources | object | `{}` |  |
| grafana.revisionHistoryLimit | int | `10` |  |
| grafana.route | object | `{"main":{"additionalRules":[],"annotations":{},"apiVersion":"gateway.networking.k8s.io/v1","enabled":false,"filters":[],"hostnames":[],"httpsRedirect":false,"kind":"HTTPRoute","labels":{},"matches":[{"path":{"type":"PathPrefix","value":"/"}}],"parentRefs":[]}}` | BETA: Configure the gateway routes for the chart here. More routes can be added by adding a dictionary key like the 'main' route. Be aware that this is an early beta of this feature, kube-prometheus-stack does not guarantee this works and is subject to change. Being BETA this can/will change in the future without notice, do not use unless you want to take that risk [[ref]](https://gateway-api.sigs.k8s.io/references/spec/#gateway.networking.k8s.io%2fv1alpha2) |
| grafana.route.main.apiVersion | string | `"gateway.networking.k8s.io/v1"` | Set the route apiVersion, e.g. gateway.networking.k8s.io/v1 or gateway.networking.k8s.io/v1alpha2 |
| grafana.route.main.enabled | bool | `false` | Enables or disables the route |
| grafana.route.main.kind | string | `"HTTPRoute"` | Set the route kind Valid options are GRPCRoute, HTTPRoute, TCPRoute, TLSRoute, UDPRoute |
| grafana.securityContext.fsGroup | int | `472` |  |
| grafana.securityContext.runAsGroup | int | `472` |  |
| grafana.securityContext.runAsNonRoot | bool | `true` |  |
| grafana.securityContext.runAsUser | int | `472` |  |
| grafana.service.annotations | object | `{}` |  |
| grafana.service.appProtocol | string | `""` |  |
| grafana.service.enabled | bool | `true` |  |
| grafana.service.ipFamilies | list | `[]` |  |
| grafana.service.ipFamilyPolicy | string | `""` |  |
| grafana.service.labels | object | `{}` |  |
| grafana.service.loadBalancerClass | string | `""` |  |
| grafana.service.loadBalancerIP | string | `""` |  |
| grafana.service.loadBalancerSourceRanges | list | `[]` |  |
| grafana.service.port | int | `80` |  |
| grafana.service.portName | string | `"service"` |  |
| grafana.service.sessionAffinity | string | `""` |  |
| grafana.service.targetPort | int | `3000` |  |
| grafana.service.type | string | `"ClusterIP"` |  |
| grafana.serviceAccount.automountServiceAccountToken | bool | `false` |  |
| grafana.serviceAccount.create | bool | `true` |  |
| grafana.serviceAccount.labels | object | `{}` |  |
| grafana.serviceAccount.name | string | `nil` |  |
| grafana.serviceAccount.nameTest | string | `nil` |  |
| grafana.serviceMonitor.basicAuth | object | `{}` |  |
| grafana.serviceMonitor.enabled | bool | `false` |  |
| grafana.serviceMonitor.interval | string | `"30s"` |  |
| grafana.serviceMonitor.labels | object | `{}` |  |
| grafana.serviceMonitor.metricRelabelings | list | `[]` |  |
| grafana.serviceMonitor.path | string | `"/metrics"` |  |
| grafana.serviceMonitor.relabelings | list | `[]` |  |
| grafana.serviceMonitor.scheme | string | `"http"` |  |
| grafana.serviceMonitor.scrapeTimeout | string | `"30s"` |  |
| grafana.serviceMonitor.targetLabels | list | `[]` |  |
| grafana.serviceMonitor.tlsConfig | object | `{}` |  |
| grafana.shareProcessNamespace | bool | `false` |  |
| grafana.sidecar.alerts.enabled | bool | `false` |  |
| grafana.sidecar.alerts.env | object | `{}` |  |
| grafana.sidecar.alerts.envValueFrom | object | `{}` |  |
| grafana.sidecar.alerts.extraMounts | list | `[]` |  |
| grafana.sidecar.alerts.initAlerts | bool | `false` |  |
| grafana.sidecar.alerts.label | string | `"grafana_alert"` |  |
| grafana.sidecar.alerts.labelValue | string | `""` |  |
| grafana.sidecar.alerts.reloadURL | string | `"http://localhost:3000/api/admin/provisioning/alerting/reload"` |  |
| grafana.sidecar.alerts.resource | string | `"both"` |  |
| grafana.sidecar.alerts.resourceName | string | `""` |  |
| grafana.sidecar.alerts.script | string | `nil` |  |
| grafana.sidecar.alerts.searchNamespace | string | `nil` |  |
| grafana.sidecar.alerts.sizeLimit | string | `""` |  |
| grafana.sidecar.alerts.skipReload | bool | `false` |  |
| grafana.sidecar.alerts.watchMethod | string | `"WATCH"` |  |
| grafana.sidecar.dashboards.SCProvider | bool | `true` |  |
| grafana.sidecar.dashboards.defaultFolderName | string | `nil` |  |
| grafana.sidecar.dashboards.enabled | bool | `false` |  |
| grafana.sidecar.dashboards.env | object | `{}` |  |
| grafana.sidecar.dashboards.envValueFrom | object | `{}` |  |
| grafana.sidecar.dashboards.extraMounts | list | `[]` |  |
| grafana.sidecar.dashboards.folder | string | `"/tmp/dashboards"` |  |
| grafana.sidecar.dashboards.folderAnnotation | string | `nil` |  |
| grafana.sidecar.dashboards.initDashboards | bool | `false` |  |
| grafana.sidecar.dashboards.label | string | `"grafana_dashboard"` |  |
| grafana.sidecar.dashboards.labelValue | string | `""` |  |
| grafana.sidecar.dashboards.provider.allowUiUpdates | bool | `false` |  |
| grafana.sidecar.dashboards.provider.disableDelete | bool | `false` |  |
| grafana.sidecar.dashboards.provider.folder | string | `""` |  |
| grafana.sidecar.dashboards.provider.folderUid | string | `""` |  |
| grafana.sidecar.dashboards.provider.foldersFromFilesStructure | bool | `false` |  |
| grafana.sidecar.dashboards.provider.name | string | `"sidecarProvider"` |  |
| grafana.sidecar.dashboards.provider.orgid | int | `1` |  |
| grafana.sidecar.dashboards.provider.type | string | `"file"` |  |
| grafana.sidecar.dashboards.reloadURL | string | `"http://localhost:3000/api/admin/provisioning/dashboards/reload"` |  |
| grafana.sidecar.dashboards.resource | string | `"both"` |  |
| grafana.sidecar.dashboards.resourceName | string | `""` |  |
| grafana.sidecar.dashboards.script | string | `nil` |  |
| grafana.sidecar.dashboards.searchNamespace | string | `nil` |  |
| grafana.sidecar.dashboards.sizeLimit | string | `""` |  |
| grafana.sidecar.dashboards.skipReload | bool | `false` |  |
| grafana.sidecar.dashboards.watchMethod | string | `"WATCH"` |  |
| grafana.sidecar.datasources.enabled | bool | `false` |  |
| grafana.sidecar.datasources.env | object | `{}` |  |
| grafana.sidecar.datasources.envValueFrom | object | `{}` |  |
| grafana.sidecar.datasources.extraMounts | list | `[]` |  |
| grafana.sidecar.datasources.initDatasources | bool | `false` |  |
| grafana.sidecar.datasources.label | string | `"grafana_datasource"` |  |
| grafana.sidecar.datasources.labelValue | string | `""` |  |
| grafana.sidecar.datasources.reloadURL | string | `"http://localhost:3000/api/admin/provisioning/datasources/reload"` |  |
| grafana.sidecar.datasources.resource | string | `"both"` |  |
| grafana.sidecar.datasources.resourceName | string | `""` |  |
| grafana.sidecar.datasources.script | string | `nil` |  |
| grafana.sidecar.datasources.searchNamespace | string | `nil` |  |
| grafana.sidecar.datasources.sizeLimit | string | `""` |  |
| grafana.sidecar.datasources.skipReload | bool | `false` |  |
| grafana.sidecar.datasources.watchMethod | string | `"WATCH"` |  |
| grafana.sidecar.enableUniqueFilenames | bool | `false` |  |
| grafana.sidecar.image.registry | string | `"quay.io"` | The Docker registry |
| grafana.sidecar.image.repository | string | `"kiwigrid/k8s-sidecar"` |  |
| grafana.sidecar.image.sha | string | `""` |  |
| grafana.sidecar.image.tag | string | `"2.5.0"` |  |
| grafana.sidecar.imagePullPolicy | string | `"IfNotPresent"` |  |
| grafana.sidecar.livenessProbe | object | `{}` |  |
| grafana.sidecar.notifiers.enabled | bool | `false` |  |
| grafana.sidecar.notifiers.env | object | `{}` |  |
| grafana.sidecar.notifiers.extraMounts | list | `[]` |  |
| grafana.sidecar.notifiers.initNotifiers | bool | `false` |  |
| grafana.sidecar.notifiers.label | string | `"grafana_notifier"` |  |
| grafana.sidecar.notifiers.labelValue | string | `""` |  |
| grafana.sidecar.notifiers.reloadURL | string | `"http://localhost:3000/api/admin/provisioning/notifications/reload"` |  |
| grafana.sidecar.notifiers.resource | string | `"both"` |  |
| grafana.sidecar.notifiers.resourceName | string | `""` |  |
| grafana.sidecar.notifiers.script | string | `nil` |  |
| grafana.sidecar.notifiers.searchNamespace | string | `nil` |  |
| grafana.sidecar.notifiers.sizeLimit | string | `""` |  |
| grafana.sidecar.notifiers.skipReload | bool | `false` |  |
| grafana.sidecar.notifiers.watchMethod | string | `"WATCH"` |  |
| grafana.sidecar.plugins.enabled | bool | `false` |  |
| grafana.sidecar.plugins.env | object | `{}` |  |
| grafana.sidecar.plugins.extraMounts | list | `[]` |  |
| grafana.sidecar.plugins.initPlugins | bool | `false` |  |
| grafana.sidecar.plugins.label | string | `"grafana_plugin"` |  |
| grafana.sidecar.plugins.labelValue | string | `""` |  |
| grafana.sidecar.plugins.reloadURL | string | `"http://localhost:3000/api/admin/provisioning/plugins/reload"` |  |
| grafana.sidecar.plugins.resource | string | `"both"` |  |
| grafana.sidecar.plugins.resourceName | string | `""` |  |
| grafana.sidecar.plugins.script | string | `nil` |  |
| grafana.sidecar.plugins.searchNamespace | string | `nil` |  |
| grafana.sidecar.plugins.sizeLimit | string | `""` |  |
| grafana.sidecar.plugins.skipReload | bool | `false` |  |
| grafana.sidecar.plugins.watchMethod | string | `"WATCH"` |  |
| grafana.sidecar.readinessProbe | object | `{}` |  |
| grafana.sidecar.resources | object | `{}` |  |
| grafana.sidecar.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| grafana.sidecar.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| grafana.sidecar.securityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| grafana.smtp.existingSecret | string | `""` |  |
| grafana.smtp.passwordKey | string | `"password"` |  |
| grafana.smtp.userKey | string | `"user"` |  |
| grafana.testFramework.containerSecurityContext | object | `{}` |  |
| grafana.testFramework.enabled | bool | `true` |  |
| grafana.testFramework.image.registry | string | `"docker.io"` | The Docker registry |
| grafana.testFramework.image.repository | string | `"bats/bats"` |  |
| grafana.testFramework.image.tag | string | `"v1.4.1"` |  |
| grafana.testFramework.imagePullPolicy | string | `"IfNotPresent"` |  |
| grafana.testFramework.resources | object | `{}` |  |
| grafana.testFramework.securityContext | object | `{}` |  |
| grafana.tolerations | list | `[]` |  |
| grafana.topologySpreadConstraints | list | `[]` |  |
| grafana.useStatefulSet | bool | `false` |  |
| ingress.annotations | object | `{"kubernetes.io/ingress.allow-http":"false","kubernetes.io/ingress.class":"nginx","kubernetes.io/tls-acme":"true"}` | Map of annotations to apply to the ingress |
| ingress.enabled | bool | `false` | Enables ingress for alertmanager |
| ingress.host | string | `""` | FQDN of the grafana |
| ingress.path | string | `"/"` | Path of the incoming request (/* or / if used with nginx) |
| ingress.tls.secretName | string | `"grafana-tls"` | Name of the secret containing the certificates |
| nameOverride | string | `""` |  |
| prometheus.enabled | bool | `true` | Enables prometheus operator resources |
| prometheus.rules.labels | object | `{"prometheus":"prometheus-operator-prometheus"}` | Labels to affect to the Prometheus Rules, used to select prometheus target |
| prometheus.serviceMonitor.enabled | bool | `true` | Enables prometheus operator service monitor |
| prometheus.serviceMonitor.labels | object | `{"prometheus":"prometheus-operator-prometheus"}` | Map of labels to apply to the servicemonitor, used to select prometheus target |

## Installing the Chart

### With Helm

To install the chart with the release name `my-release`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/grafana-stack
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: grafana-stack
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.4"
    chart: grafana-stack
    path: ''

    helm:
      values: |
        ingress:
          enabled: true
          host: grafana.example.com

        grafana:
          sidecar:
            dashboards:
                searchNamespace: "ALL"
          grafana.ini:
            server:
              root_url: "https://grafana.example.com/"

  destination:
    server: https://kubernetes.default.svc
    namespace: "infra-monitoring"
```

## Develop

### Add grafana dashboard

To deploy new dashboard, copy dashboard as json file into [./resources/grafana/](./resources/grafana/) directory.
if `grafana.sidecar.dashboards.enabled` is set, json content will be copied to configmap.
By default, only configmap in current namespace will be searched. Configure `grafana.sidecar.dashboards.searchNamespace` variable to define namespace.
It's also possible to specify `ALL` to search in all namespaces.

Dashboards can be sorted by folder. Set `k8s-sidecar-target-directory: \{\{ .Values.grafana.sidecar.dashboards.folder \}\}/custom_folder` annotations to customize dashboard folder.

### Add prometheus rules and alerts

To deploy new rules, copy your rules (without the group) into [.resources/prometheus-rules/grafana-records.yaml](.resources/prometheus-rules/grafana-records.yaml).
To deploy new alerts, copy your alerts (without the group) into [.resources/prometheus-rules/grafana-up.yaml](.resources/prometheus-rules/grafana-up.yaml).

Some rules and alerts come from the grafana github repository:
- https://github.com/grafana/grafana/blob/master/grafana-mixin/rules/rules.yaml
- https://github.com/grafana/grafana/blob/master/grafana-mixin/alerts/alerts.yaml

### Update documentation

Chart documentation is generated with [helm-docs](https://github.com/norwoodj/helm-docs) from `values.yaml` file.
After file modification, regenerate README.md with command:

```bash
docker run --rm -it -v $(pwd):/helm --workdir /helm jnorwood/helm-docs:v1.14.2 helm-docs
```

### Run linter

```bash
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/grafana-stack --config /charts/charts/grafana-stack/ct.yaml
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template grafana-stack . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
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