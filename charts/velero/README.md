# velero

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.15.2](https://img.shields.io/badge/AppVersion-1.15.2-informational?style=flat-square)

## Prerequisites

- Helm v3
- Config Connector installed (v1.6.0)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://edixos.github.io/ekp-helm | gcpbucket(gcp-bucket) | 0.1.0 |
| https://edixos.github.io/ekp-helm | iamCustomRole(gcp-iam-custom-role) | 0.1.0 |
| https://edixos.github.io/ekp-helm | iamPolicyMembers(gcp-iam-policy-memebers) | 0.1.0 |
| https://edixos.github.io/ekp-helm | workloadIdentity(workload-identity) | 0.1.0 |
| https://vmware-tanzu.github.io/helm-charts | velero | 8.5.0 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| wiemaouadi | <wiem.aouadi3@gmail.com> | <https://github.com/wiemaouadi> |
| smileisak | <ikaboubi@gmail.com> | <https://github.com/smileisak> |

## Description

A Helm chart for Kubernetes

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| backups.enabled | bool | `false` | Enables creation of a velero schedule |
| backups.namespaces | list | `["default"]` | List of namespace backuped by velero |
| backups.schedule | string | `"@every 24h"` | Period of backup |
| backups.ttl | string | `"96h0m0s"` | ttl of the backup |
| gcpbucket | object | `{"accessControl":{"createCloudIamPolicy":true,"iamPolicy":[{"member":"serviceAccount:sa-name@${gcpProjectId?}.iam.gserviceaccount.com","role":"roles/storage.admin"}],"publicAccessPrevention":"inherited","uniformBucketLevelAccess":false},"bucketName":"","global":{"abandon":false,"cnrmNamespace":"","gcpProjectId":"myprojectid","location":"EUROPE-WEST1","skipUnspecifiedFields":false}}` | `tags.configConnector` must be set to `true` |
| iamCustomRole | object | `{"customRoleName":"velero","description":"The description of the custom role resource","global":{"cnrmNamespace":"","gcpOrganisationId":"","gcpProjectId":"myprojectid","skipUnspecifiedFields":false},"permissions":["compute.disks.create","compute.disks.createSnapshot","compute.disks.get","compute.snapshots.create","compute.snapshots.delete","compute.snapshots.get","compute.snapshots.useReadOnly","compute.zones.get"],"title":"velero"}` | `tags.configConnector` must be set to `true` |
| iamCustomRole.customRoleName | string | `"velero"` | The name of the IAM Custom Role |
| iamCustomRole.description | string | `"The description of the custom role resource"` | A human-readable description for the role |
| iamCustomRole.permissions | list | `["compute.disks.create","compute.disks.createSnapshot","compute.disks.get","compute.snapshots.create","compute.snapshots.delete","compute.snapshots.get","compute.snapshots.useReadOnly","compute.zones.get"]` | custom role permissions |
| iamCustomRole.title | string | `"velero"` | A human-readable title for the role |
| iamPolicyMembers | object | `{"global":{"abandon":false,"cnrmNamespace":"","gcpProjectId":"myprojectid"},"iamPolicyMembers":[]}` | `tags.configConnector` must be set to `true` |
| iamPolicyMembers.global.abandon | bool | `false` | Keep the resource even after the kcc resource deletion. |
| iamPolicyMembers.global.cnrmNamespace | string | nil | Allows to deploy in another namespace than the release one |
| iamPolicyMembers.global.gcpProjectId | string | `"myprojectid"` | Google Project ID |
| prometheus.enabled | bool | `true` | Enables Prometheus Operator monitoring |
| prometheus.rules.labels | object | `{"prometheus":"prometheus-operator-prometheus"}` | Labels to affect to the Prometheus Rules |
| tags.configConnector | bool | `false` | Enables Config Connector features |
| velero.configuration.backupStorageLocation | list | `[{"config":{},"name":"default","prefix":"backups","provider":"gcp"}]` | Provider used for backups |
| velero.configuration.backupStorageLocation[0] | object | `{"config":{},"name":"default","prefix":"backups","provider":"gcp"}` | Name of the provider used for default backup location |
| velero.configuration.backupStorageLocation[0].config | object | `{}` | Additional provider-specific configuration. See the [link](https://velero.io/docs/v1.5/supported-providers/) for further informations |
| velero.configuration.backupStorageLocation[0].prefix | string | `"backups"` | Path in the bucket for velero backup |
| velero.configuration.volumeSnapshotLocation[0] | object | `{"config":{"snapshotLocation":"europe-west1"},"name":"default","provider":"gcp"}` | Name of the provider used for default snapshot location |
| velero.configuration.volumeSnapshotLocation[0].config.snapshotLocation | string | `"europe-west1"` | Snapshot location |
| velero.credentials.existingSecret | string | `"velero-bucket"` | Name of the existing secret containing gcp creds |
| velero.credentials.useSecret | bool | `false` | Use secret for bucket credentials (deactivate if used with workload identity) |
| velero.initContainers | list | `[{"image":"velero/velero-plugin-for-gcp:v1.3.0","imagePullPolicy":"IfNotPresent","name":"velero-plugin-for-gcp","resources":{"requests":{"cpu":"100m","memory":"512Mi"}},"volumeMounts":[{"mountPath":"/target","name":"plugins"}]}]` | List of init containers for velero plugin |
| velero.metrics.enabled | bool | `true` | Enables prometheus metrics |
| velero.metrics.serviceMonitor.additionalLabels | object | `{"prometheus":"prometheus-operator-prometheus"}` | Labels to add to the velero service monitor |
| velero.metrics.serviceMonitor.enabled | bool | `true` | Enables prometheus-operator service monitor |
| velero.rbac.create | bool | `true` | Creates RBAC for velero |
| velero.serviceAccount.server.annotations | object | `{}` | Annotations to add to the velero service account |
| velero.serviceAccount.server.create | bool | `true` | Create Velero SA through velero helm chart (does not allow workload identity - SA created through this Chart helm) |
| velero.serviceAccount.server.name | string | `"velero"` | Name of the service Account |
| workloadIdentity | object | `{"global":{"abandon":false,"cnrmNamespace":"","gcpProjectId":"myprojectid","gsa":{"create":true,"name":"velero","project":""},"ksa":{"name":"velero","namespace":"velero"}}}` | `tags.configConnector` must be set to `true` |

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
    targetRevision: "0.1.0"
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

