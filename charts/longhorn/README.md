# longhorn-wrapper

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.6.0](https://img.shields.io/badge/AppVersion-1.6.0-informational?style=flat-square)

## Prerequisites

- Helm v3
- Kubernetes 1.21+
- open-iscsi installed on all nodes

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.longhorn.io | longhorn(longhorn) | 1.6.0 |

## Description

A Helm wrapper chart for Longhorn and associated resources

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| longhorn.csi.attacherReplicaCount | int | `3` |  |
| longhorn.csi.kubeletRootDir | string | `"/var/lib/kubelet"` |  |
| longhorn.csi.provisionerReplicaCount | int | `3` |  |
| longhorn.csi.resizerReplicaCount | int | `3` |  |
| longhorn.csi.snapshotterReplicaCount | int | `3` |  |
| longhorn.defaultSettings.createDefaultDiskLabeledNodes | bool | `true` |  |
| longhorn.defaultSettings.defaultDataPath | string | `"/var/lib/longhorn"` |  |
| longhorn.defaultSettings.replicaCount | int | `3` |  |
| longhorn.ingress.enabled | bool | `false` |  |
| longhorn.ingress.host | string | `"longhorn.local"` |  |
| longhorn.ingress.ingressClassName | string | `"nginx"` |  |
| longhorn.ingress.tls | bool | `false` |  |
| longhorn.persistence.defaultClass | bool | `true` |  |
| longhorn.persistence.defaultClassReplicaCount | int | `3` |  |
| storageClasses | list | `[]` | List of StorageClasses to deploy |
| volumeSnapshotClasses | list | `[]` | List of VolumeSnapshotClasses to deploy |

## Installing the Chart

### With Helm

To install the chart with the release name `my-release`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/longhorn-wrapper