# scaleway-csi

![Version: 0.1.1](https://img.shields.io/badge/Version-0.1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.3.4](https://img.shields.io/badge/AppVersion-v0.3.4-informational?style=flat-square)

## Prerequisites

- Helm v3
- Config Connector installed (v1.6.0)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://helm.scw.cloud/ | scaleway-csi | 0.2.2 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| ilyasabdellaoui | <ilyas.abdellaoui21@gmail.com> | <https://github.com/ilyasabdellaoui> |

## Description

A Helm chart for deploying Scaleway Container Storage Interface (CSI)

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| externalSecret.name | string | `"csi-mock-secret"` |  |
| externalSecret.refreshInterval | string | `"1h"` |  |
| externalSecret.remoteRef.key | string | `""` |  |
| externalSecret.secretStoreRef.kind | string | `"ClusterSecretStore"` |  |
| externalSecret.secretStoreRef.name | string | `"mock-secret-manager"` |  |
| region | string | `"fr-par"` |  |
| scaleway-csi.controller.affinity | object | `{}` |  |
| scaleway-csi.controller.attacher.enabled | bool | `true` |  |
| scaleway-csi.controller.attacher.image.pullPolicy | string | `"IfNotPresent"` |  |
| scaleway-csi.controller.attacher.image.repository | string | `"registry.k8s.io/sig-storage/csi-attacher"` |  |
| scaleway-csi.controller.attacher.image.tag | string | `"v4.9.0"` |  |
| scaleway-csi.controller.attacher.resources | object | `{}` |  |
| scaleway-csi.controller.driver.image.pullPolicy | string | `"IfNotPresent"` |  |
| scaleway-csi.controller.driver.image.repository | string | `"scaleway/scaleway-csi"` |  |
| scaleway-csi.controller.driver.image.tag | string | `""` |  |
| scaleway-csi.controller.driver.resources | object | `{}` |  |
| scaleway-csi.controller.enabled | bool | `true` |  |
| scaleway-csi.controller.liveness.enabled | bool | `true` |  |
| scaleway-csi.controller.liveness.image.pullPolicy | string | `"IfNotPresent"` |  |
| scaleway-csi.controller.liveness.image.repository | string | `"registry.k8s.io/sig-storage/livenessprobe"` |  |
| scaleway-csi.controller.liveness.image.tag | string | `"v2.16.0"` |  |
| scaleway-csi.controller.liveness.resources | object | `{}` |  |
| scaleway-csi.controller.nodeSelector | object | `{}` |  |
| scaleway-csi.controller.podAnnotations | object | `{}` |  |
| scaleway-csi.controller.podSecurityContext | object | `{}` |  |
| scaleway-csi.controller.priorityClassName | string | `"system-cluster-critical"` |  |
| scaleway-csi.controller.provisioner.defaultFSType | string | `"ext4"` |  |
| scaleway-csi.controller.provisioner.enabled | bool | `true` |  |
| scaleway-csi.controller.provisioner.image.pullPolicy | string | `"IfNotPresent"` |  |
| scaleway-csi.controller.provisioner.image.repository | string | `"registry.k8s.io/sig-storage/csi-provisioner"` |  |
| scaleway-csi.controller.provisioner.image.tag | string | `"v5.3.0"` |  |
| scaleway-csi.controller.provisioner.resources | object | `{}` |  |
| scaleway-csi.controller.replicaCount | int | `1` |  |
| scaleway-csi.controller.resizer.enabled | bool | `true` |  |
| scaleway-csi.controller.resizer.image.pullPolicy | string | `"IfNotPresent"` |  |
| scaleway-csi.controller.resizer.image.repository | string | `"registry.k8s.io/sig-storage/csi-resizer"` |  |
| scaleway-csi.controller.resizer.image.tag | string | `"v1.14.0"` |  |
| scaleway-csi.controller.resizer.resources | object | `{}` |  |
| scaleway-csi.controller.scaleway.env.SCW_ACCESS_KEY | string | `"ABCDEFGHIJKLMNOPQRST"` |  |
| scaleway-csi.controller.scaleway.env.SCW_DEFAULT_PROJECT_ID | string | `"11111111-1111-1111-1111-111111111111"` |  |
| scaleway-csi.controller.scaleway.env.SCW_DEFAULT_ZONE | string | `"fr-par-1"` |  |
| scaleway-csi.controller.scaleway.env.SCW_SECRET_KEY | string | `"11111111-1111-1111-1111-111111111111"` |  |
| scaleway-csi.controller.scaleway.existingSecretName | string | `""` |  |
| scaleway-csi.controller.snapshotController.enabled | bool | `true` |  |
| scaleway-csi.controller.snapshotController.image.pullPolicy | string | `"IfNotPresent"` |  |
| scaleway-csi.controller.snapshotController.image.repository | string | `"registry.k8s.io/sig-storage/snapshot-controller"` |  |
| scaleway-csi.controller.snapshotController.image.tag | string | `"v8.3.0"` |  |
| scaleway-csi.controller.snapshotController.resources | object | `{}` |  |
| scaleway-csi.controller.snapshotter.enabled | bool | `true` |  |
| scaleway-csi.controller.snapshotter.image.pullPolicy | string | `"IfNotPresent"` |  |
| scaleway-csi.controller.snapshotter.image.repository | string | `"registry.k8s.io/sig-storage/csi-snapshotter"` |  |
| scaleway-csi.controller.snapshotter.image.tag | string | `"v8.3.0"` |  |
| scaleway-csi.controller.snapshotter.resources | object | `{}` |  |
| scaleway-csi.controller.tolerations | list | `[]` |  |
| scaleway-csi.fullnameOverride | string | `""` |  |
| scaleway-csi.imagePullSecrets | list | `[]` |  |
| scaleway-csi.nameOverride | string | `""` |  |
| scaleway-csi.node.affinity | object | `{}` |  |
| scaleway-csi.node.driver.image.pullPolicy | string | `"IfNotPresent"` |  |
| scaleway-csi.node.driver.image.repository | string | `"scaleway/scaleway-csi"` |  |
| scaleway-csi.node.driver.image.tag | string | `""` |  |
| scaleway-csi.node.driver.resources | object | `{}` |  |
| scaleway-csi.node.enabled | bool | `true` |  |
| scaleway-csi.node.kubeletDir | string | `"/var/lib/kubelet"` |  |
| scaleway-csi.node.liveness.enabled | bool | `true` |  |
| scaleway-csi.node.liveness.image.pullPolicy | string | `"IfNotPresent"` |  |
| scaleway-csi.node.liveness.image.repository | string | `"registry.k8s.io/sig-storage/livenessprobe"` |  |
| scaleway-csi.node.liveness.image.tag | string | `"v2.16.0"` |  |
| scaleway-csi.node.liveness.resources | object | `{}` |  |
| scaleway-csi.node.nodeSelector."kubernetes.io/os" | string | `"linux"` |  |
| scaleway-csi.node.podAnnotations | object | `{}` |  |
| scaleway-csi.node.podSecurityContext | object | `{}` |  |
| scaleway-csi.node.priorityClassName | string | `"system-node-critical"` |  |
| scaleway-csi.node.registrar.enabled | bool | `true` |  |
| scaleway-csi.node.registrar.image.pullPolicy | string | `"IfNotPresent"` |  |
| scaleway-csi.node.registrar.image.repository | string | `"registry.k8s.io/sig-storage/csi-node-driver-registrar"` |  |
| scaleway-csi.node.registrar.image.tag | string | `"v2.14.0"` |  |
| scaleway-csi.node.registrar.resources | object | `{}` |  |
| scaleway-csi.node.tolerations | list | `[]` |  |
| scaleway-csi.serviceAccount.annotations | object | `{}` |  |
| scaleway-csi.serviceAccount.create | bool | `true` |  |
| scaleway-csi.serviceAccount.name | string | `""` |  |
| scaleway-csi.storageClasses[0].allowVolumeExpansion | bool | `true` |  |
| scaleway-csi.storageClasses[0].default | bool | `true` |  |
| scaleway-csi.storageClasses[0].name | string | `"scw-bssd"` |  |
| scaleway-csi.storageClasses[0].parameters | object | `{}` |  |
| scaleway-csi.storageClasses[0].reclaimPolicy | string | `"Delete"` |  |
| scaleway-csi.storageClasses[0].volumeBindingMode | string | `"WaitForFirstConsumer"` |  |
| scaleway-csi.storageClasses[1].allowVolumeExpansion | bool | `true` |  |
| scaleway-csi.storageClasses[1].default | bool | `false` |  |
| scaleway-csi.storageClasses[1].name | string | `"scw-bssd-retain"` |  |
| scaleway-csi.storageClasses[1].parameters | object | `{}` |  |
| scaleway-csi.storageClasses[1].reclaimPolicy | string | `"Retain"` |  |
| scaleway-csi.storageClasses[1].volumeBindingMode | string | `"WaitForFirstConsumer"` |  |
| scaleway-csi.volumeSnapshotClasses[0].default | bool | `true` |  |
| scaleway-csi.volumeSnapshotClasses[0].deletionPolicy | string | `"Delete"` |  |
| scaleway-csi.volumeSnapshotClasses[0].name | string | `"scw-snapshot"` |  |
| scaleway-csi.volumeSnapshotClasses[1].default | bool | `false` |  |
| scaleway-csi.volumeSnapshotClasses[1].deletionPolicy | string | `"Retain"` |  |
| scaleway-csi.volumeSnapshotClasses[1].name | string | `"scw-snapshot-retain"` |  |
| zone | string | `"fr-par-1"` |  |

## Installing the Chart

### With Helm

To install the chart with the release name `my-release`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/scaleway-csi
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: scaleway-csi
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.1"
    chart: scaleway-csi
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
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/scaleway-csi --config /charts/charts/scaleway-csi/ct.yaml
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template scaleway-csi . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```

