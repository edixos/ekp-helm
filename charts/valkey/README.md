# valkey

![Version: 0.1.2](https://img.shields.io/badge/Version-0.1.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 9.1.3](https://img.shields.io/badge/AppVersion-9.1.3-informational?style=flat-square)

## Prerequisites

- Helm v3
- Config Connector installed (v1.6.0)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://valkey.io/valkey-helm/ | valkey(valkey) | 1.0.0 |

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
| valkey.deploymentStrategy | string | `"Recreate"` |  |
| valkey.extraConfig | string | `""` |  |
| valkey.extraContainers | list | `[]` |  |
| valkey.extraEnv | list | `[]` |  |
| valkey.extraInitContainers | list | `[]` |  |
| valkey.extraVolumeMounts | list | `[]` |  |
| valkey.extraVolumes | list | `[]` |  |
| valkey.fullnameOverride | string | `""` |  |
| valkey.global.imagePullSecrets | list | `[]` |  |
| valkey.global.imageRegistry | string | `""` |  |
| valkey.haproxy.affinity | object | `{}` |  |
| valkey.haproxy.checkUser | string | `""` |  |
| valkey.haproxy.config.checkInterval | string | `"2s"` |  |
| valkey.haproxy.config.checkTimeout | string | `"5s"` |  |
| valkey.haproxy.config.healthPort | int | `8404` |  |
| valkey.haproxy.config.maxconn | int | `4096` |  |
| valkey.haproxy.config.timeout.client | string | `"1m"` |  |
| valkey.haproxy.config.timeout.connect | string | `"5s"` |  |
| valkey.haproxy.config.timeout.server | string | `"1m"` |  |
| valkey.haproxy.config.timeout.tunnel | string | `"24d"` |  |
| valkey.haproxy.enabled | bool | `false` |  |
| valkey.haproxy.extraInitContainers | list | `[]` |  |
| valkey.haproxy.extraVolumeMounts | list | `[]` |  |
| valkey.haproxy.extraVolumes | list | `[]` |  |
| valkey.haproxy.image.pullPolicy | string | `"IfNotPresent"` |  |
| valkey.haproxy.image.registry | string | `"docker.io"` |  |
| valkey.haproxy.image.repository | string | `"haproxy"` |  |
| valkey.haproxy.image.tag | string | `"3.2-alpine"` |  |
| valkey.haproxy.nodeSelector | string | `nil` |  |
| valkey.haproxy.podAnnotations | object | `{}` |  |
| valkey.haproxy.podDisruptionBudget.enabled | bool | `false` |  |
| valkey.haproxy.podDisruptionBudget.maxUnavailable | int | `1` |  |
| valkey.haproxy.podDisruptionBudget.minAvailable | string | `nil` |  |
| valkey.haproxy.podDisruptionBudget.unhealthyPodEvictionPolicy | string | `""` |  |
| valkey.haproxy.podLabels | object | `{}` |  |
| valkey.haproxy.podSecurityContext.fsGroup | int | `99` |  |
| valkey.haproxy.podSecurityContext.runAsGroup | int | `99` |  |
| valkey.haproxy.podSecurityContext.runAsUser | int | `99` |  |
| valkey.haproxy.podSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| valkey.haproxy.replicas | int | `3` |  |
| valkey.haproxy.resources | object | `{}` |  |
| valkey.haproxy.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| valkey.haproxy.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| valkey.haproxy.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| valkey.haproxy.securityContext.runAsNonRoot | bool | `true` |  |
| valkey.haproxy.service.annotations | object | `{}` |  |
| valkey.haproxy.service.clusterIP | string | `""` |  |
| valkey.haproxy.service.loadBalancerClass | string | `""` |  |
| valkey.haproxy.service.loadBalancerSourceRanges | list | `[]` |  |
| valkey.haproxy.service.nodePort | int | `0` |  |
| valkey.haproxy.service.port | int | `6379` |  |
| valkey.haproxy.service.type | string | `"ClusterIP"` |  |
| valkey.haproxy.strategy | object | `{}` |  |
| valkey.haproxy.tls.clientCertFile | string | `""` |  |
| valkey.haproxy.tls.verify | string | `"required"` |  |
| valkey.haproxy.tolerations | string | `nil` |  |
| valkey.haproxy.topologySpreadConstraints | list | `[]` |  |
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
| valkey.metrics.exporter.extraEnv | list | `[]` |  |
| valkey.metrics.exporter.extraVolumeMounts | list | `[]` |  |
| valkey.metrics.exporter.image.pullPolicy | string | `"IfNotPresent"` |  |
| valkey.metrics.exporter.image.registry | string | `"ghcr.io"` |  |
| valkey.metrics.exporter.image.repository | string | `"oliver006/redis_exporter"` |  |
| valkey.metrics.exporter.image.tag | string | `"v1.88.0"` |  |
| valkey.metrics.exporter.port | int | `9121` |  |
| valkey.metrics.exporter.resources | object | `{}` |  |
| valkey.metrics.exporter.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| valkey.metrics.exporter.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| valkey.metrics.exporter.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| valkey.metrics.exporter.securityContext.runAsNonRoot | bool | `true` |  |
| valkey.metrics.exporter.tlsServerName | string | `""` |  |
| valkey.metrics.podMonitor.annotations | object | `{}` |  |
| valkey.metrics.podMonitor.enabled | bool | `false` |  |
| valkey.metrics.podMonitor.honorLabels | bool | `false` |  |
| valkey.metrics.podMonitor.interval | string | `"30s"` |  |
| valkey.metrics.podMonitor.labels | object | `{}` |  |
| valkey.metrics.podMonitor.metricRelabelings | list | `[]` |  |
| valkey.metrics.podMonitor.podTargetLabels | list | `[]` |  |
| valkey.metrics.podMonitor.port | string | `"metrics"` |  |
| valkey.metrics.podMonitor.relabelings | list | `[]` |  |
| valkey.metrics.podMonitor.sampleLimit | bool | `false` |  |
| valkey.metrics.podMonitor.scrapeTimeout | string | `""` |  |
| valkey.metrics.podMonitor.targetLimit | bool | `false` |  |
| valkey.metrics.prometheusRule.annotations | object | `{}` |  |
| valkey.metrics.prometheusRule.enabled | bool | `false` |  |
| valkey.metrics.prometheusRule.labels | object | `{}` |  |
| valkey.metrics.prometheusRule.rules | list | `[]` |  |
| valkey.metrics.service.annotations | object | `{}` |  |
| valkey.metrics.service.appProtocol | string | `""` |  |
| valkey.metrics.service.clusterIP | string | `""` |  |
| valkey.metrics.service.enabled | bool | `true` |  |
| valkey.metrics.service.labels | object | `{}` |  |
| valkey.metrics.service.loadBalancerClass | string | `""` |  |
| valkey.metrics.service.loadBalancerSourceRanges | list | `[]` |  |
| valkey.metrics.service.nodePort | int | `0` |  |
| valkey.metrics.service.port | int | `9121` |  |
| valkey.metrics.service.type | string | `"ClusterIP"` |  |
| valkey.metrics.serviceMonitor.annotations | object | `{}` |  |
| valkey.metrics.serviceMonitor.enabled | bool | `false` |  |
| valkey.metrics.serviceMonitor.honorLabels | bool | `false` |  |
| valkey.metrics.serviceMonitor.interval | string | `"30s"` |  |
| valkey.metrics.serviceMonitor.labels | object | `{}` |  |
| valkey.metrics.serviceMonitor.metricRelabelings | list | `[]` |  |
| valkey.metrics.serviceMonitor.podTargetLabels | list | `[]` |  |
| valkey.metrics.serviceMonitor.port | string | `"metrics"` |  |
| valkey.metrics.serviceMonitor.relabelings | list | `[]` |  |
| valkey.metrics.serviceMonitor.sampleLimit | bool | `false` |  |
| valkey.metrics.serviceMonitor.scrapeTimeout | string | `""` |  |
| valkey.metrics.serviceMonitor.targetLimit | bool | `false` |  |
| valkey.nameOverride | string | `""` |  |
| valkey.networkPolicy.allowExternal | bool | `true` |  |
| valkey.networkPolicy.allowExternalEgress | bool | `true` |  |
| valkey.networkPolicy.annotations | object | `{}` |  |
| valkey.networkPolicy.enabled | bool | `false` |  |
| valkey.networkPolicy.extraEgress | list | `[]` |  |
| valkey.networkPolicy.extraIngress | list | `[]` |  |
| valkey.networkPolicy.ingressNSMatchLabels | object | `{}` |  |
| valkey.networkPolicy.ingressNSPodMatchLabels | object | `{}` |  |
| valkey.networkPolicy.labels | object | `{}` |  |
| valkey.nodeSelector | object | `{}` |  |
| valkey.persistence.accessModes[0] | string | `"ReadWriteOnce"` |  |
| valkey.persistence.annotations | object | `{}` |  |
| valkey.persistence.enabled | bool | `false` |  |
| valkey.persistence.existingClaim | string | `""` |  |
| valkey.persistence.hostPath | string | `""` |  |
| valkey.persistence.keepOnUninstall | bool | `false` |  |
| valkey.persistence.labels | object | `{}` |  |
| valkey.persistence.size | string | `""` |  |
| valkey.persistence.storageClass | string | `""` |  |
| valkey.persistence.subPath | string | `""` |  |
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
| valkey.readinessProbe.enabled | bool | `true` |  |
| valkey.readinessProbe.failureThreshold | int | `3` |  |
| valkey.readinessProbe.initialDelaySeconds | int | `0` |  |
| valkey.readinessProbe.periodSeconds | int | `10` |  |
| valkey.readinessProbe.successThreshold | int | `1` |  |
| valkey.readinessProbe.timeoutSeconds | int | `1` |  |
| valkey.replica.disklessSync | bool | `false` |  |
| valkey.replica.enabled | bool | `false` |  |
| valkey.replica.minReplicasMaxLag | int | `10` |  |
| valkey.replica.minReplicasToWrite | int | `0` |  |
| valkey.replica.persistentVolumeClaimRetentionPolicy | object | `{}` |  |
| valkey.replica.replicas | int | `3` |  |
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
| valkey.sentinel.affinity | object | `{}` |  |
| valkey.sentinel.downAfterMilliseconds | int | `5000` |  |
| valkey.sentinel.enabled | bool | `false` |  |
| valkey.sentinel.existingSecret | string | `""` |  |
| valkey.sentinel.extraConfig | string | `""` |  |
| valkey.sentinel.failoverTimeout | int | `60000` |  |
| valkey.sentinel.initialTopologyWaitSeconds | int | `180` |  |
| valkey.sentinel.masterRecordRefreshSeconds | int | `1` |  |
| valkey.sentinel.masterSet | string | `"mymaster"` |  |
| valkey.sentinel.minReadySeconds | int | `15` |  |
| valkey.sentinel.monitorUser | string | `""` |  |
| valkey.sentinel.nodeSelector | string | `nil` |  |
| valkey.sentinel.orphanCheckSeconds | int | `30` |  |
| valkey.sentinel.parallelSyncs | int | `1` |  |
| valkey.sentinel.password | string | `""` |  |
| valkey.sentinel.passwordKey | string | `"sentinel"` |  |
| valkey.sentinel.persistence.accessModes[0] | string | `"ReadWriteOnce"` |  |
| valkey.sentinel.persistence.enabled | bool | `false` |  |
| valkey.sentinel.persistence.size | string | `"100Mi"` |  |
| valkey.sentinel.persistence.storageClass | string | `""` |  |
| valkey.sentinel.persistentVolumeClaimRetentionPolicy | object | `{}` |  |
| valkey.sentinel.podAnnotations | object | `{}` |  |
| valkey.sentinel.podDisruptionBudget.enabled | bool | `false` |  |
| valkey.sentinel.podDisruptionBudget.maxUnavailable | int | `1` |  |
| valkey.sentinel.podDisruptionBudget.minAvailable | string | `nil` |  |
| valkey.sentinel.podDisruptionBudget.unhealthyPodEvictionPolicy | string | `""` |  |
| valkey.sentinel.podLabels | object | `{}` |  |
| valkey.sentinel.port | int | `26379` |  |
| valkey.sentinel.preStopFailover | bool | `true` |  |
| valkey.sentinel.preStopFailoverTimeoutSeconds | int | `20` |  |
| valkey.sentinel.quorum | int | `2` |  |
| valkey.sentinel.replicas | int | `3` |  |
| valkey.sentinel.resources | object | `{}` |  |
| valkey.sentinel.restartFailoverWaitSeconds | int | `120` |  |
| valkey.sentinel.securityContext | object | `{}` |  |
| valkey.sentinel.service.annotations | object | `{}` |  |
| valkey.sentinel.service.appProtocol | string | `""` |  |
| valkey.sentinel.service.clusterIP | string | `""` |  |
| valkey.sentinel.service.enabled | bool | `true` |  |
| valkey.sentinel.service.loadBalancerClass | string | `""` |  |
| valkey.sentinel.service.loadBalancerSourceRanges | list | `[]` |  |
| valkey.sentinel.service.nodePort | int | `0` |  |
| valkey.sentinel.service.port | int | `26379` |  |
| valkey.sentinel.service.type | string | `"ClusterIP"` |  |
| valkey.sentinel.startupTimeoutSeconds | int | `60` |  |
| valkey.sentinel.tolerations | string | `nil` |  |
| valkey.sentinel.topologySpreadConstraints | list | `[]` |  |
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
| valkey.terminationGracePeriodSeconds | int | `30` |  |
| valkey.tls.caPublicKey | string | `"ca.crt"` |  |
| valkey.tls.dhParamKey | string | `""` |  |
| valkey.tls.enabled | bool | `false` |  |
| valkey.tls.existingSecret | string | `""` |  |
| valkey.tls.requireClientCertificate | bool | `false` |  |
| valkey.tls.serverKey | string | `"server.key"` |  |
| valkey.tls.serverPublicKey | string | `"server.crt"` |  |
| valkey.tls.volume | object | `{}` |  |
| valkey.tolerations | list | `[]` |  |
| valkey.topologySpreadConstraints | list | `[]` |  |
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
    targetRevision: "0.1.2"
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

