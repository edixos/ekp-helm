# velero

![Version: 0.1.5](https://img.shields.io/badge/Version-0.1.5-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.15.2](https://img.shields.io/badge/AppVersion-1.15.2-informational?style=flat-square)

## Prerequisites

- Helm v3
- Config Connector installed (v1.6.0)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://edixos.github.io/ekp-helm | gcpbucket(gcp-bucket) | 0.1.0 |
| https://edixos.github.io/ekp-helm | iamCustomRole(gcp-iam-custom-role) | 0.1.0 |
| https://edixos.github.io/ekp-helm | iamPolicyMembers(gcp-iam-policy-members) | 0.1.2 |
| https://edixos.github.io/ekp-helm | workloadIdentity(gcp-workload-identity) | 0.1.1 |
| https://vmware-tanzu.github.io/helm-charts | velero | 10.0.8 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| wiemaouadi | <wiem.aouadi3@gmail.com> | <https://github.com/wiemaouadi> |
| smileisak | <ikaboubi@gmail.com> | <https://github.com/smileisak> |

## Description

A Helm chart for velero

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| backups.enabled | bool | `true` | Enables creation of a velero schedule |
| backups.namespaces | list | `["*"]` | List of namespace backuped by velero |
| backups.schedule | string | `"@every 24h"` | Period of backup |
| backups.ttl | string | `"96h0m0s"` | ttl of the backup |
| gcpbucket | object | `{"accessControl":{"createCloudIamPolicy":true,"iamPolicy":[{"member":"serviceAccount:sa-name@${gcpProjectId?}.iam.gserviceaccount.com","role":"roles/storage.admin"}],"publicAccessPrevention":"inherited","uniformBucketLevelAccess":false},"bucketName":"ekp-velero-bkp"}` | `tags.configConnector` must be set to `true` |
| iamCustomRole | object | `{"customRoleName":"velero","description":"The description of the custom role resource","permissions":["compute.disks.create","compute.disks.createSnapshot","compute.disks.get","compute.snapshots.create","compute.snapshots.delete","compute.snapshots.get","compute.snapshots.useReadOnly","compute.zones.get"],"title":"velero"}` | `tags.configConnector` must be set to `true` |
| iamCustomRole.customRoleName | string | `"velero"` | The name of the IAM Custom Role |
| iamCustomRole.description | string | `"The description of the custom role resource"` | A human-readable description for the role |
| iamCustomRole.permissions | list | `["compute.disks.create","compute.disks.createSnapshot","compute.disks.get","compute.snapshots.create","compute.snapshots.delete","compute.snapshots.get","compute.snapshots.useReadOnly","compute.zones.get"]` | custom role permissions |
| iamCustomRole.title | string | `"velero"` | A human-readable title for the role |
| iamPolicyMembers | object | `{"members":[]}` | `tags.configConnector` must be set to `true` |
| prometheus.enabled | bool | `true` | Enables Prometheus Operator monitoring |
| prometheus.rules.labels | object | `{"prometheus":"prometheus-operator-prometheus"}` | Labels to affect to the Prometheus Rules |
| tags.configConnector | bool | `false` | Enables Config Connector features |
| velero.affinity | object | `{}` |  |
| velero.annotations | object | `{}` |  |
| velero.backupsEnabled | bool | `true` |  |
| velero.cleanUpCRDs | bool | `false` |  |
| velero.configMaps | object | `{}` |  |
| velero.configuration.backupStorageLocation[0].accessMode | string | `"ReadWrite"` |  |
| velero.configuration.backupStorageLocation[0].annotations | object | `{}` |  |
| velero.configuration.backupStorageLocation[0].bucket | string | `""` |  |
| velero.configuration.backupStorageLocation[0].caCert | string | `nil` |  |
| velero.configuration.backupStorageLocation[0].config | object | `{}` |  |
| velero.configuration.backupStorageLocation[0].credential.key | string | `nil` |  |
| velero.configuration.backupStorageLocation[0].credential.name | string | `nil` |  |
| velero.configuration.backupStorageLocation[0].default | bool | `false` |  |
| velero.configuration.backupStorageLocation[0].name | string | `nil` |  |
| velero.configuration.backupStorageLocation[0].prefix | string | `nil` |  |
| velero.configuration.backupStorageLocation[0].provider | string | `""` |  |
| velero.configuration.backupStorageLocation[0].validationFrequency | string | `nil` |  |
| velero.configuration.backupSyncPeriod | string | `nil` |  |
| velero.configuration.clientBurst | string | `nil` |  |
| velero.configuration.clientPageSize | string | `nil` |  |
| velero.configuration.clientQPS | string | `nil` |  |
| velero.configuration.dataMoverPrepareTimeout | string | `nil` |  |
| velero.configuration.defaultBackupStorageLocation | string | `nil` |  |
| velero.configuration.defaultBackupTTL | string | `nil` |  |
| velero.configuration.defaultItemOperationTimeout | string | `nil` |  |
| velero.configuration.defaultRepoMaintainFrequency | string | `nil` |  |
| velero.configuration.defaultSnapshotMoveData | string | `nil` |  |
| velero.configuration.defaultVolumeSnapshotLocations | string | `nil` |  |
| velero.configuration.defaultVolumesToFsBackup | string | `nil` |  |
| velero.configuration.disableControllers | string | `nil` |  |
| velero.configuration.disableInformerCache | bool | `false` |  |
| velero.configuration.extraArgs | list | `[]` |  |
| velero.configuration.extraEnvVars | list | `[]` |  |
| velero.configuration.features | string | `nil` |  |
| velero.configuration.fsBackupTimeout | string | `nil` |  |
| velero.configuration.garbageCollectionFrequency | string | `nil` |  |
| velero.configuration.itemBlockWorkerCount | string | `nil` |  |
| velero.configuration.logFormat | string | `nil` |  |
| velero.configuration.logLevel | string | `nil` |  |
| velero.configuration.metricsAddress | string | `nil` |  |
| velero.configuration.namespace | string | `nil` |  |
| velero.configuration.pluginDir | string | `nil` |  |
| velero.configuration.profilerAddress | string | `nil` |  |
| velero.configuration.repositoryMaintenanceJob.latestJobsCount | int | `3` |  |
| velero.configuration.repositoryMaintenanceJob.limits | string | `nil` |  |
| velero.configuration.repositoryMaintenanceJob.requests | string | `nil` |  |
| velero.configuration.restoreOnlyMode | string | `nil` |  |
| velero.configuration.restoreResourcePriorities | string | `nil` |  |
| velero.configuration.storeValidationFrequency | string | `nil` |  |
| velero.configuration.terminatingResourceTimeout | string | `nil` |  |
| velero.configuration.uploaderType | string | `nil` | ------------------ `velero server` default: kopia |
| velero.configuration.volumeSnapshotLocation[0].annotations | object | `{}` |  |
| velero.configuration.volumeSnapshotLocation[0].config | object | `{}` |  |
| velero.configuration.volumeSnapshotLocation[0].credential.key | string | `nil` |  |
| velero.configuration.volumeSnapshotLocation[0].credential.name | string | `nil` |  |
| velero.configuration.volumeSnapshotLocation[0].name | string | `nil` |  |
| velero.configuration.volumeSnapshotLocation[0].provider | string | `""` |  |
| velero.containerSecurityContext | object | `{}` |  |
| velero.credentials.existingSecret | string | `nil` |  |
| velero.credentials.extraEnvVars | object | `{}` |  |
| velero.credentials.extraSecretRef | string | `""` |  |
| velero.credentials.name | string | `nil` |  |
| velero.credentials.secretContents | object | `{}` |  |
| velero.credentials.useSecret | bool | `true` |  |
| velero.deployNodeAgent | bool | `false` |  |
| velero.dnsConfig | object | `{}` |  |
| velero.dnsPolicy | string | `"ClusterFirst"` |  |
| velero.extraObjects | list | `[]` |  |
| velero.extraVolumeMounts | list | `[]` |  |
| velero.extraVolumes | list | `[]` |  |
| velero.fullnameOverride | string | `""` |  |
| velero.hostAliases | list | `[]` |  |
| velero.image.imagePullSecrets | list | `[]` |  |
| velero.image.pullPolicy | string | `"IfNotPresent"` |  |
| velero.image.repository | string | `"velero/velero"` |  |
| velero.image.tag | string | `"v1.16.1"` |  |
| velero.initContainers | string | `nil` |  |
| velero.kubectl.annotations | object | `{}` |  |
| velero.kubectl.containerSecurityContext | object | `{}` |  |
| velero.kubectl.extraVolumeMounts | list | `[]` |  |
| velero.kubectl.extraVolumes | list | `[]` |  |
| velero.kubectl.image.repository | string | `"docker.io/bitnami/kubectl"` |  |
| velero.kubectl.labels | object | `{}` |  |
| velero.kubectl.resources | object | `{}` |  |
| velero.labels | object | `{}` |  |
| velero.lifecycle | object | `{}` |  |
| velero.livenessProbe.failureThreshold | int | `5` |  |
| velero.livenessProbe.httpGet.path | string | `"/metrics"` |  |
| velero.livenessProbe.httpGet.port | string | `"http-monitoring"` |  |
| velero.livenessProbe.httpGet.scheme | string | `"HTTP"` |  |
| velero.livenessProbe.initialDelaySeconds | int | `10` |  |
| velero.livenessProbe.periodSeconds | int | `30` |  |
| velero.livenessProbe.successThreshold | int | `1` |  |
| velero.livenessProbe.timeoutSeconds | int | `5` |  |
| velero.metrics.enabled | bool | `true` |  |
| velero.metrics.nodeAgentPodMonitor.additionalLabels | object | `{}` |  |
| velero.metrics.nodeAgentPodMonitor.annotations | object | `{}` |  |
| velero.metrics.nodeAgentPodMonitor.autodetect | bool | `true` |  |
| velero.metrics.nodeAgentPodMonitor.enabled | bool | `false` |  |
| velero.metrics.podAnnotations."prometheus.io/path" | string | `"/metrics"` |  |
| velero.metrics.podAnnotations."prometheus.io/port" | string | `"8085"` |  |
| velero.metrics.podAnnotations."prometheus.io/scrape" | string | `"true"` |  |
| velero.metrics.prometheusRule.additionalLabels | object | `{}` |  |
| velero.metrics.prometheusRule.autodetect | bool | `true` |  |
| velero.metrics.prometheusRule.enabled | bool | `false` |  |
| velero.metrics.prometheusRule.spec | list | `[]` |  |
| velero.metrics.scrapeInterval | string | `"30s"` |  |
| velero.metrics.scrapeTimeout | string | `"10s"` |  |
| velero.metrics.service.annotations | object | `{}` |  |
| velero.metrics.service.externalTrafficPolicy | string | `""` |  |
| velero.metrics.service.internalTrafficPolicy | string | `""` |  |
| velero.metrics.service.labels | object | `{}` |  |
| velero.metrics.service.nodePort | string | `nil` |  |
| velero.metrics.service.type | string | `"ClusterIP"` |  |
| velero.metrics.serviceMonitor.additionalLabels | object | `{}` |  |
| velero.metrics.serviceMonitor.annotations | object | `{}` |  |
| velero.metrics.serviceMonitor.autodetect | bool | `true` |  |
| velero.metrics.serviceMonitor.enabled | bool | `false` |  |
| velero.nameOverride | string | `""` |  |
| velero.namespace.labels | object | `{}` |  |
| velero.nodeAgent.affinity | object | `{}` |  |
| velero.nodeAgent.annotations | object | `{}` |  |
| velero.nodeAgent.containerSecurityContext | object | `{}` |  |
| velero.nodeAgent.dnsConfig | object | `{}` |  |
| velero.nodeAgent.dnsPolicy | string | `"ClusterFirst"` |  |
| velero.nodeAgent.extraArgs | list | `[]` |  |
| velero.nodeAgent.extraEnvVars | list | `[]` |  |
| velero.nodeAgent.extraVolumeMounts | list | `[]` |  |
| velero.nodeAgent.extraVolumes | list | `[]` |  |
| velero.nodeAgent.hostAliases | list | `[]` |  |
| velero.nodeAgent.labels | object | `{}` |  |
| velero.nodeAgent.lifecycle | object | `{}` |  |
| velero.nodeAgent.nodeSelector | object | `{}` |  |
| velero.nodeAgent.pluginVolumePath | string | `"/var/lib/kubelet/plugins"` |  |
| velero.nodeAgent.podLabels | object | `{}` |  |
| velero.nodeAgent.podSecurityContext.runAsUser | int | `0` |  |
| velero.nodeAgent.podVolumePath | string | `"/var/lib/kubelet/pods"` |  |
| velero.nodeAgent.priorityClassName | string | `""` |  |
| velero.nodeAgent.resources | object | `{}` |  |
| velero.nodeAgent.runtimeClassName | string | `""` |  |
| velero.nodeAgent.tolerations | list | `[]` |  |
| velero.nodeAgent.updateStrategy | object | `{}` |  |
| velero.nodeAgent.useScratchEmptyDir | bool | `true` |  |
| velero.nodeSelector | object | `{}` |  |
| velero.podAnnotations | object | `{}` |  |
| velero.podLabels | object | `{}` |  |
| velero.podSecurityContext | object | `{}` |  |
| velero.priorityClassName | string | `""` |  |
| velero.rbac.clusterAdministrator | bool | `true` |  |
| velero.rbac.clusterAdministratorName | string | `"cluster-admin"` |  |
| velero.rbac.create | bool | `true` |  |
| velero.readinessProbe.failureThreshold | int | `5` |  |
| velero.readinessProbe.httpGet.path | string | `"/metrics"` |  |
| velero.readinessProbe.httpGet.port | string | `"http-monitoring"` |  |
| velero.readinessProbe.httpGet.scheme | string | `"HTTP"` |  |
| velero.readinessProbe.initialDelaySeconds | int | `10` |  |
| velero.readinessProbe.periodSeconds | int | `30` |  |
| velero.readinessProbe.successThreshold | int | `1` |  |
| velero.readinessProbe.timeoutSeconds | int | `5` |  |
| velero.resources | object | `{}` |  |
| velero.runtimeClassName | string | `""` |  |
| velero.schedules | object | `{}` |  |
| velero.secretAnnotations | object | `{}` |  |
| velero.serviceAccount.server.annotations | string | `nil` |  |
| velero.serviceAccount.server.automountServiceAccountToken | bool | `true` |  |
| velero.serviceAccount.server.create | bool | `true` |  |
| velero.serviceAccount.server.imagePullSecrets | list | `[]` |  |
| velero.serviceAccount.server.labels | string | `nil` |  |
| velero.serviceAccount.server.name | string | `nil` |  |
| velero.snapshotsEnabled | bool | `true` |  |
| velero.terminationGracePeriodSeconds | int | `3600` |  |
| velero.tolerations | list | `[]` |  |
| velero.upgradeCRDs | bool | `true` |  |
| velero.upgradeCRDsJob.automountServiceAccountToken | bool | `true` |  |
| velero.upgradeCRDsJob.extraEnvVars | list | `[]` |  |
| velero.upgradeCRDsJob.extraVolumeMounts | list | `[]` |  |
| velero.upgradeCRDsJob.extraVolumes | list | `[]` |  |
| velero.upgradeJobResources | object | `{}` |  |
| workloadIdentity | object | `{"global":{"gsa":{"create":true,"name":"wi-velero","project":""},"ksa":{"name":"default","namespace":""}}}` | `tags.configConnector` must be set to `true` |

## Installing the Chart

### With Helm

To install the chart with the release name `my-release`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/velero
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: velero
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.5"
    chart: velero
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
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/velero --config /charts/charts/velero/ct.yaml
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template velero . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```

