# valkey

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 9.1.2](https://img.shields.io/badge/AppVersion-9.1.2-informational?style=flat-square)

## Prerequisites

- Helm v3
- Config Connector installed (v1.6.0)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://valkey.io/valkey-helm/ | valkey(valkey) | 0.12.0 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| edixos |  |  |

## Description

Valkey, the open-source key/value store, from the official valkey-io chart

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| networkPolicies | object | `{}` | Map of NetworkPolicies to deploy, keyed by policy name. Each value: { namespace?, labels?, annotations?, spec }. The upstream pods carry `app.kubernetes.io/name: valkey` and `app.kubernetes.io/instance: <release>`. |
| valkey.affinity | object | `{}` |  |
| valkey.auth.aclConfig | string | `""` |  |
| valkey.auth.aclUsers | object | `{}` |  |
| valkey.auth.enabled | bool | `false` |  |
| valkey.auth.usersExistingSecret | string | `""` |  |
| valkey.clusterDomain | string | `"cluster.local"` |  |
| valkey.commonLabels | object | `{}` |  |
| valkey.dataStorage.accessModes[0] | string | `"ReadWriteOnce"` |  |
| valkey.dataStorage.annotations | object | `{}` |  |
| valkey.dataStorage.className | string | `""` |  |
| valkey.dataStorage.enabled | bool | `false` |  |
| valkey.dataStorage.hostPath | string | `""` |  |
| valkey.dataStorage.keepPvc | bool | `false` |  |
| valkey.dataStorage.labels | object | `{}` |  |
| valkey.dataStorage.persistentVolumeClaimName | string | `""` |  |
| valkey.dataStorage.requestedSize | string | `""` |  |
| valkey.dataStorage.subPath | string | `""` |  |
| valkey.dataStorage.volumeName | string | `"valkey-data"` |  |
| valkey.deploymentStrategy | string | `"RollingUpdate"` |  |
| valkey.env | object | `{}` |  |
| valkey.extraContainers | list | `[]` |  |
| valkey.extraInitContainers | list | `[]` |  |
| valkey.extraSecretValkeyConfigs | bool | `false` |  |
| valkey.extraValkeyConfigs | list | `[]` |  |
| valkey.extraValkeySecrets | list | `[]` |  |
| valkey.extraVolumeMounts | list | `[]` |  |
| valkey.extraVolumes | list | `[]` |  |
| valkey.fullnameOverride | string | `""` |  |
| valkey.global.imagePullSecrets | list | `[]` |  |
| valkey.global.imageRegistry | string | `""` |  |
| valkey.image.pullPolicy | string | `"IfNotPresent"` |  |
| valkey.image.registry | string | `"docker.io"` |  |
| valkey.image.repository | string | `"valkey/valkey"` |  |
| valkey.image.tag | string | `""` |  |
| valkey.imagePullSecrets | list | `[]` |  |
| valkey.initResources | object | `{}` |  |
| valkey.livenessProbe.customProbe | object | `{}` |  |
| valkey.livenessProbe.enabled | bool | `true` |  |
| valkey.livenessProbe.failureThreshold | int | `3` |  |
| valkey.livenessProbe.initialDelaySeconds | int | `0` |  |
| valkey.livenessProbe.periodSeconds | int | `10` |  |
| valkey.livenessProbe.timeoutSeconds | int | `1` |  |
| valkey.metrics.enabled | bool | `false` |  |
| valkey.metrics.exporter.args | list | `[]` |  |
| valkey.metrics.exporter.command | list | `[]` |  |
| valkey.metrics.exporter.extraEnvs | object | `{}` |  |
| valkey.metrics.exporter.extraExporterSecrets | list | `[]` |  |
| valkey.metrics.exporter.extraVolumeMounts | list | `[]` |  |
| valkey.metrics.exporter.image.pullPolicy | string | `"IfNotPresent"` |  |
| valkey.metrics.exporter.image.registry | string | `"ghcr.io"` |  |
| valkey.metrics.exporter.image.repository | string | `"oliver006/redis_exporter"` |  |
| valkey.metrics.exporter.image.tag | string | `"v1.79.0"` |  |
| valkey.metrics.exporter.port | int | `9121` |  |
| valkey.metrics.exporter.resources | object | `{}` |  |
| valkey.metrics.exporter.securityContext | object | `{}` |  |
| valkey.metrics.podMonitor.additionalLabels | object | `{}` |  |
| valkey.metrics.podMonitor.annotations | object | `{}` |  |
| valkey.metrics.podMonitor.enabled | bool | `false` |  |
| valkey.metrics.podMonitor.extraLabels | object | `{}` |  |
| valkey.metrics.podMonitor.honorLabels | bool | `false` |  |
| valkey.metrics.podMonitor.interval | string | `"30s"` |  |
| valkey.metrics.podMonitor.metricRelabelings | list | `[]` |  |
| valkey.metrics.podMonitor.podTargetLabels | list | `[]` |  |
| valkey.metrics.podMonitor.port | string | `"metrics"` |  |
| valkey.metrics.podMonitor.relabelings | list | `[]` |  |
| valkey.metrics.podMonitor.sampleLimit | bool | `false` |  |
| valkey.metrics.podMonitor.scrapeTimeout | string | `""` |  |
| valkey.metrics.podMonitor.targetLimit | bool | `false` |  |
| valkey.metrics.prometheusRule.enabled | bool | `false` |  |
| valkey.metrics.prometheusRule.extraAnnotations | object | `{}` |  |
| valkey.metrics.prometheusRule.extraLabels | object | `{}` |  |
| valkey.metrics.prometheusRule.rules | list | `[]` |  |
| valkey.metrics.service.annotations | object | `{}` |  |
| valkey.metrics.service.appProtocol | string | `""` |  |
| valkey.metrics.service.enabled | bool | `true` |  |
| valkey.metrics.service.extraLabels | object | `{}` |  |
| valkey.metrics.service.ports.http | int | `9121` |  |
| valkey.metrics.service.type | string | `"ClusterIP"` |  |
| valkey.metrics.serviceMonitor.additionalLabels | object | `{}` |  |
| valkey.metrics.serviceMonitor.annotations | object | `{}` |  |
| valkey.metrics.serviceMonitor.enabled | bool | `false` |  |
| valkey.metrics.serviceMonitor.extraLabels | object | `{}` |  |
| valkey.metrics.serviceMonitor.honorLabels | bool | `false` |  |
| valkey.metrics.serviceMonitor.interval | string | `"30s"` |  |
| valkey.metrics.serviceMonitor.metricRelabelings | list | `[]` |  |
| valkey.metrics.serviceMonitor.podTargetLabels | list | `[]` |  |
| valkey.metrics.serviceMonitor.port | string | `"metrics"` |  |
| valkey.metrics.serviceMonitor.relabelings | list | `[]` |  |
| valkey.metrics.serviceMonitor.sampleLimit | bool | `false` |  |
| valkey.metrics.serviceMonitor.scrapeTimeout | string | `""` |  |
| valkey.metrics.serviceMonitor.targetLimit | bool | `false` |  |
| valkey.nameOverride | string | `""` |  |
| valkey.networkPolicy | object | `{}` |  |
| valkey.nodeSelector | object | `{}` |  |
| valkey.podAnnotations | object | `{}` |  |
| valkey.podDisruptionBudget.enabled | bool | `false` |  |
| valkey.podDisruptionBudget.maxUnavailable | int | `1` |  |
| valkey.podDisruptionBudget.minAvailable | string | `nil` |  |
| valkey.podDisruptionBudget.unhealthyPodEvictionPolicy | string | `""` |  |
| valkey.podLabels | object | `{}` |  |
| valkey.podSecurityContext.fsGroup | int | `1000` |  |
| valkey.podSecurityContext.runAsGroup | int | `1000` |  |
| valkey.podSecurityContext.runAsUser | int | `1000` |  |
| valkey.podSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| valkey.priorityClassName | string | `""` |  |
| valkey.readinessProbe.customProbe | object | `{}` |  |
| valkey.readinessProbe.enabled | bool | `false` |  |
| valkey.readinessProbe.failureThreshold | int | `3` |  |
| valkey.readinessProbe.initialDelaySeconds | int | `0` |  |
| valkey.readinessProbe.periodSeconds | int | `10` |  |
| valkey.readinessProbe.successThreshold | int | `1` |  |
| valkey.readinessProbe.timeoutSeconds | int | `1` |  |
| valkey.replica.disklessSync | bool | `false` |  |
| valkey.replica.enabled | bool | `false` |  |
| valkey.replica.minReplicasMaxLag | int | `10` |  |
| valkey.replica.minReplicasToWrite | int | `0` |  |
| valkey.replica.persistence.accessModes[0] | string | `"ReadWriteOnce"` |  |
| valkey.replica.persistence.size | string | `""` |  |
| valkey.replica.persistence.storageClass | string | `""` |  |
| valkey.replica.persistentVolumeClaimRetentionPolicy | object | `{}` |  |
| valkey.replica.replicas | int | `2` |  |
| valkey.replica.replicationUser | string | `"default"` |  |
| valkey.replica.service.annotations | object | `{}` |  |
| valkey.replica.service.appProtocol | string | `""` |  |
| valkey.replica.service.clusterIP | string | `""` |  |
| valkey.replica.service.enabled | bool | `true` |  |
| valkey.replica.service.loadBalancerClass | string | `""` |  |
| valkey.replica.service.loadBalancerSourceRanges | list | `[]` |  |
| valkey.replica.service.nodePort | int | `0` |  |
| valkey.replica.service.port | int | `6379` |  |
| valkey.replica.service.type | string | `"ClusterIP"` |  |
| valkey.resources | object | `{}` |  |
| valkey.runtimeClassName | string | `""` |  |
| valkey.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| valkey.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| valkey.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| valkey.securityContext.runAsNonRoot | bool | `true` |  |
| valkey.securityContext.runAsUser | int | `1000` |  |
| valkey.service.annotations | object | `{}` |  |
| valkey.service.appProtocol | string | `""` |  |
| valkey.service.clusterIP | string | `""` |  |
| valkey.service.loadBalancerClass | string | `""` |  |
| valkey.service.loadBalancerSourceRanges | list | `[]` |  |
| valkey.service.nodePort | int | `0` |  |
| valkey.service.port | int | `6379` |  |
| valkey.service.type | string | `"ClusterIP"` |  |
| valkey.serviceAccount.annotations | object | `{}` |  |
| valkey.serviceAccount.automount | bool | `false` |  |
| valkey.serviceAccount.create | bool | `true` |  |
| valkey.serviceAccount.name | string | `""` |  |
| valkey.startupProbe.customProbe | object | `{}` |  |
| valkey.startupProbe.enabled | bool | `true` |  |
| valkey.startupProbe.failureThreshold | int | `3` |  |
| valkey.startupProbe.initialDelaySeconds | int | `0` |  |
| valkey.startupProbe.periodSeconds | int | `10` |  |
| valkey.startupProbe.timeoutSeconds | int | `1` |  |
| valkey.tls.caPublicKey | string | `"ca.crt"` |  |
| valkey.tls.dhParamKey | string | `""` |  |
| valkey.tls.enabled | bool | `false` |  |
| valkey.tls.existingSecret | string | `""` |  |
| valkey.tls.requireClientCertificate | bool | `false` |  |
| valkey.tls.serverKey | string | `"server.key"` |  |
| valkey.tls.serverPublicKey | string | `"server.crt"` |  |
| valkey.tolerations | list | `[]` |  |
| valkey.topologySpreadConstraints | list | `[]` |  |
| valkey.valkeyConfig | string | `""` |  |
| valkey.valkeyLogLevel | string | `"notice"` |  |
| valkey.workloadAnnotations | object | `{}` |  |

## Installing the Chart

### With Helm

To install the chart with the release name `my-release`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/valkey
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: valkey
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.0"
    chart: valkey
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
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/valkey --config /charts/charts/valkey/ct.yaml
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template valkey . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```

