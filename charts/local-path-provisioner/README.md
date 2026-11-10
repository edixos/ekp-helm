# local-path-provisioner
![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.0.37](https://img.shields.io/badge/AppVersion-v0.0.37-informational?style=flat-square)

----
[[_TOC_]]
----

## Prerequisites

- Helm ≥ 3.8
- Kubernetes 1.12+
- A writable host path on each node that will hold volumes (see `localPathProvisioner.nodePathMap`)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
|  | localPathProvisioner(local-path-provisioner) | 0.0.37 |

## Description

Rancher local-path-provisioner, dynamic node-local PersistentVolumes backed by host paths

This chart deploys **local-path-provisioner** — dynamic, node-local PersistentVolumes backed by host paths.

The upstream chart is not published to any Helm repository, so it is vendored under
`charts/local-path-provisioner` (see the `ekp-helm/upstream-source` annotation in `Chart.yaml`).
All upstream values live under the `localPathProvisioner` key.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| localPathProvisioner.affinity | object | `{}` | Affinity for the provisioner Deployment. |
| localPathProvisioner.configmap.helperPod.tolerations | list | `[]` | Tolerations for the helper pods (they must be able to schedule on the node that holds the volume). |
| localPathProvisioner.fullnameOverride | string | `"local-path-provisioner"` | Base name of all resources. Must be set (see `nameOverride`). Also determines the default provisioner name `cluster.local/<fullname>` recorded on PVs, so do not change it once volumes exist. |
| localPathProvisioner.helperImage.repository | string | `"docker.io/library/busybox"` | Image used by the helper pods that create and delete volume directories. |
| localPathProvisioner.helperImage.tag | string | `"1.37.0"` | Helper image tag, pinned (never `latest`). |
| localPathProvisioner.image.pullPolicy | string | `"IfNotPresent"` | Provisioner image pull policy. |
| localPathProvisioner.image.repository | string | `"docker.io/rancher/local-path-provisioner"` | Provisioner image repository. |
| localPathProvisioner.image.tag | string | `"v0.0.37"` | Provisioner image tag. |
| localPathProvisioner.nameOverride | string | `"local-path-provisioner"` | Chart name used in labels. Must be set: the dependency alias (`localPathProvisioner`) would otherwise be used, and uppercase is invalid in resource names. |
| localPathProvisioner.nodePathMap | list | `[{"node":"DEFAULT_PATH_FOR_NON_LISTED_NODES","paths":["/opt/local-path-provisioner"]}]` | Where data is stored on each node. A node not listed uses the `DEFAULT_PATH_FOR_NON_LISTED_NODES` entry; a node listed with `paths: []` is refused. Mutually exclusive with `sharedFileSystemPath`. |
| localPathProvisioner.nodeSelector | object | `{}` | Node selector for the provisioner Deployment. |
| localPathProvisioner.replicaCount | int | `1` | Number of provisioner replicas. |
| localPathProvisioner.resources | object | `{}` | Resource requests and limits for the provisioner. |
| localPathProvisioner.storageClass.create | bool | `true` | Create the StorageClass. |
| localPathProvisioner.storageClass.defaultClass | bool | `false` | Mark the StorageClass as the cluster default. |
| localPathProvisioner.storageClass.defaultVolumeType | string | `"hostPath"` | Volume type created by the class, `hostPath` or `local`. With `local`, PVs carry node affinity natively. |
| localPathProvisioner.storageClass.name | string | `"local-path"` | StorageClass name. |
| localPathProvisioner.storageClass.reclaimPolicy | string | `"Delete"` | StorageClass reclaim policy, `Delete` or `Retain`. |
| localPathProvisioner.storageClass.volumeBindingMode | string | `"WaitForFirstConsumer"` | StorageClass volume binding mode, `Immediate` or `WaitForFirstConsumer`. |
| localPathProvisioner.tolerations | list | `[]` | Tolerations for the provisioner Deployment. |

## Installing the Chart

### With Helm

Add the repository and install with default values:

```bash
helm repo add ekp-helm [https://edixos.github.io/ekp-helm](https://edixos.github.io/ekp-helm)
helm repo update

helm install my-local-path-provisioner ekp-helm/local-path-provisioner \
  --namespace local-path-storage \
  --create-namespace
```

Or install with custom values:

```bash
helm install my-local-path-provisioner ekp-helm/local-path-provisioner \
  --namespace local-path-storage \
  --create-namespace \
  -f values.yaml
```

### With ArgoCD

#### Cluster k8s with access to public registry

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: local-path-provisioner
spec:
  project: infra

  source:
    repoURL: "[https://edixos.github.io/ekp-helm](https://edixos.github.io/ekp-helm)"
    targetRevision: "0.1.0"
    chart: local-path-provisioner
    path: ''

    helm:
      values: |
        ""

  destination:
    server: [https://kubernetes.default.svc](https://kubernetes.default.svc)
    namespace: "local-path-storage"

  syncPolicy:
    automated:
      prune: true
      selfHeal: true
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
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/local-path-provisioner --config /charts/charts/local-path-provisioner/ct.yaml
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```bash
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template local-path-provisioner . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```