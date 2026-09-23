# zammad

![Version: 0.1.2](https://img.shields.io/badge/Version-0.1.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 7.1.3-0006](https://img.shields.io/badge/AppVersion-7.1.3--0006-informational?style=flat-square)

## Prerequisites

- Helm v3
- Config Connector installed (v1.6.0)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://zammad.github.io/zammad-helm | zammad(zammad) | 18.0.4 |

## Description

Zammad helpdesk, wired to an externally managed PostgreSQL and the platform Gateway

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| externalSecrets | list | `[]` | List of ExternalSecrets to deploy |
| httpRoutes | object | `{}` | Map of Gateway API HTTPRoutes to deploy, keyed by route name |
| vmServiceScrapes | list | `[]` | List of VictoriaMetrics VMServiceScrapes to deploy |
| zammad.affinity | object | `{}` |  |
| zammad.autoWizard.enabled | bool | `false` |  |
| zammad.commonAnnotations | object | `{}` |  |
| zammad.commonLabels | object | `{}` |  |
| zammad.elasticsearch.http.tls.selfSignedCertificate.disabled | bool | `true` |  |
| zammad.elasticsearch.nameOverride | string | `"es"` |  |
| zammad.elasticsearch.nodeSets[0].config."node.store.allow_mmap" | bool | `false` |  |
| zammad.elasticsearch.nodeSets[0].count | int | `1` |  |
| zammad.elasticsearch.nodeSets[0].name | string | `"default"` |  |
| zammad.elasticsearch.nodeSets[0].podTemplate.spec.containers[0].env[0].name | string | `"ES_JAVA_OPTS"` |  |
| zammad.elasticsearch.nodeSets[0].podTemplate.spec.containers[0].env[0].value | string | `"-Xms512m -Xmx512m"` |  |
| zammad.elasticsearch.nodeSets[0].podTemplate.spec.containers[0].name | string | `"elasticsearch"` |  |
| zammad.elasticsearch.nodeSets[0].podTemplate.spec.containers[0].resources.limits.memory | string | `"1Gi"` |  |
| zammad.elasticsearch.nodeSets[0].podTemplate.spec.containers[0].resources.requests.cpu | string | `"500m"` |  |
| zammad.elasticsearch.nodeSets[0].podTemplate.spec.containers[0].resources.requests.memory | string | `"1Gi"` |  |
| zammad.elasticsearch.nodeSets[0].volumeClaimTemplates[0].metadata.name | string | `"elasticsearch-data"` |  |
| zammad.elasticsearch.nodeSets[0].volumeClaimTemplates[0].spec.accessModes[0] | string | `"ReadWriteOnce"` |  |
| zammad.elasticsearch.nodeSets[0].volumeClaimTemplates[0].spec.resources.requests.storage | string | `"5Gi"` |  |
| zammad.extraEnv | list | `[]` |  |
| zammad.image.imagePullSecrets | list | `[]` |  |
| zammad.image.pullPolicy | string | `"IfNotPresent"` |  |
| zammad.image.repository | string | `"ghcr.io/zammad/zammad"` |  |
| zammad.image.tag | string | `""` |  |
| zammad.ingress.annotations | object | `{}` |  |
| zammad.ingress.className | string | `""` |  |
| zammad.ingress.enabled | bool | `false` |  |
| zammad.ingress.hosts[0].host | string | `"chart-example.local"` |  |
| zammad.ingress.hosts[0].paths[0].path | string | `"/"` |  |
| zammad.ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| zammad.ingress.labels | object | `{}` |  |
| zammad.ingress.tls | list | `[]` |  |
| zammad.initContainers | list | `[]` |  |
| zammad.memcached.replicaCount | int | `1` |  |
| zammad.memcached.resources | object | `{}` |  |
| zammad.minio.auth.rootPassword | string | `"zammadadmin"` |  |
| zammad.minio.auth.rootUser | string | `"zammadadmin"` |  |
| zammad.minio.clientImage.repository | string | `"bitnamilegacy/minio-client"` |  |
| zammad.minio.console.image.repository | string | `"bitnamilegacy/minio-object-browser"` |  |
| zammad.minio.defaultBuckets | string | `"zammad"` |  |
| zammad.minio.defaultInitContainers.volumePermissions.image.repository | string | `"bitnamilegacy/os-shell"` |  |
| zammad.minio.disableWebUI | bool | `true` |  |
| zammad.minio.global.security.allowInsecureImages | bool | `true` |  |
| zammad.minio.image.repository | string | `"bitnamilegacy/minio"` |  |
| zammad.nodeSelector | object | `{}` |  |
| zammad.podAnnotations | object | `{}` |  |
| zammad.podDisruptionBudget.enabled | bool | `false` |  |
| zammad.podDisruptionBudget.maxUnavailable | string | `""` |  |
| zammad.podDisruptionBudget.minAvailable | string | `""` |  |
| zammad.podLabels | object | `{}` |  |
| zammad.postgres.auth.database | string | `"zammad_production"` |  |
| zammad.postgres.auth.password | string | `"zammad"` |  |
| zammad.postgres.auth.username | string | `"zammad"` |  |
| zammad.postgres.resources | object | `{}` |  |
| zammad.redis.architecture | string | `"standalone"` |  |
| zammad.redis.auth.password | string | `"zammad"` |  |
| zammad.redis.resources | object | `{}` |  |
| zammad.redis.sentinel.enabled | bool | `false` |  |
| zammad.secrets.autowizard.secretKey | string | `"autowizard"` |  |
| zammad.secrets.autowizard.secretName | string | `"autowizard"` |  |
| zammad.secrets.autowizard.useExisting | bool | `false` |  |
| zammad.secrets.elasticsearch.secretKey | string | `"password"` |  |
| zammad.secrets.elasticsearch.secretName | string | `"elastic-credentials"` |  |
| zammad.secrets.elasticsearch.useExisting | bool | `false` |  |
| zammad.secrets.postgresql.secretKey | string | `"postgresql-pass"` |  |
| zammad.secrets.postgresql.secretName | string | `"postgresql-pass"` |  |
| zammad.secrets.postgresql.useExisting | bool | `false` |  |
| zammad.secrets.redis.secretKey | string | `"redis-password"` |  |
| zammad.secrets.redis.secretName | string | `"redis-pass"` |  |
| zammad.secrets.redis.sentinel.secretKey | string | `"redis-sentinel-password"` |  |
| zammad.secrets.redis.sentinel.secretName | string | `"redis-sentinel-pass"` |  |
| zammad.secrets.redis.sentinel.useExisting | bool | `false` |  |
| zammad.secrets.redis.useExisting | bool | `false` |  |
| zammad.secrets.s3.secretKey | string | `"s3-url"` |  |
| zammad.secrets.s3.secretName | string | `"s3-url"` |  |
| zammad.secrets.s3.useExisting | bool | `false` |  |
| zammad.securityContext.fsGroup | int | `1000` |  |
| zammad.securityContext.fsGroupChangePolicy | string | `"OnRootMismatch"` |  |
| zammad.securityContext.runAsGroup | int | `1000` |  |
| zammad.securityContext.runAsNonRoot | bool | `true` |  |
| zammad.securityContext.runAsUser | int | `1000` |  |
| zammad.securityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| zammad.service.appProtocol | string | `"kubernetes.io/ws"` |  |
| zammad.service.port | int | `8080` |  |
| zammad.service.type | string | `"ClusterIP"` |  |
| zammad.serviceAccount.annotations | object | `{}` |  |
| zammad.serviceAccount.create | bool | `false` |  |
| zammad.serviceAccount.name | string | `""` |  |
| zammad.tolerations | list | `[]` |  |
| zammad.topologySpreadConstraints | list | `[]` |  |
| zammad.zammadConfig.cronJob.reindex.annotations | object | `{}` |  |
| zammad.zammadConfig.cronJob.reindex.podAnnotations | object | `{}` |  |
| zammad.zammadConfig.cronJob.reindex.podLabels | object | `{}` |  |
| zammad.zammadConfig.cronJob.reindex.podSpec | object | `{}` |  |
| zammad.zammadConfig.cronJob.reindex.schedule | string | `"@weekly"` |  |
| zammad.zammadConfig.cronJob.reindex.suspend | bool | `true` |  |
| zammad.zammadConfig.customVolumeMounts | string | `nil` |  |
| zammad.zammadConfig.customVolumes | string | `nil` |  |
| zammad.zammadConfig.elasticsearch.enabled | bool | `true` |  |
| zammad.zammadConfig.elasticsearch.host | string | `"external-elasticsearch-host"` |  |
| zammad.zammadConfig.elasticsearch.initialisation | bool | `true` |  |
| zammad.zammadConfig.elasticsearch.pass | string | `""` |  |
| zammad.zammadConfig.elasticsearch.port | int | `9200` |  |
| zammad.zammadConfig.elasticsearch.reindex | bool | `false` |  |
| zammad.zammadConfig.elasticsearch.schema | string | `"http"` |  |
| zammad.zammadConfig.elasticsearch.user | string | `""` |  |
| zammad.zammadConfig.initContainers.elasticsearch.resources | object | `{}` |  |
| zammad.zammadConfig.initContainers.elasticsearch.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| zammad.zammadConfig.initContainers.elasticsearch.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| zammad.zammadConfig.initContainers.elasticsearch.securityContext.privileged | bool | `false` |  |
| zammad.zammadConfig.initContainers.elasticsearch.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| zammad.zammadConfig.initContainers.postgresql.resources | object | `{}` |  |
| zammad.zammadConfig.initContainers.postgresql.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| zammad.zammadConfig.initContainers.postgresql.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| zammad.zammadConfig.initContainers.postgresql.securityContext.privileged | bool | `false` |  |
| zammad.zammadConfig.initContainers.postgresql.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| zammad.zammadConfig.initContainers.volumePermissions.command[0] | string | `"/bin/sh"` |  |
| zammad.zammadConfig.initContainers.volumePermissions.command[1] | string | `"-cx"` |  |
| zammad.zammadConfig.initContainers.volumePermissions.command[2] | string | `"chmod 770 /opt/zammad/tmp\n"` |  |
| zammad.zammadConfig.initContainers.volumePermissions.enabled | bool | `true` |  |
| zammad.zammadConfig.initContainers.volumePermissions.image.pullPolicy | string | `"IfNotPresent"` |  |
| zammad.zammadConfig.initContainers.volumePermissions.image.repository | string | `"alpine"` |  |
| zammad.zammadConfig.initContainers.volumePermissions.image.tag | string | `"3.24.1"` |  |
| zammad.zammadConfig.initContainers.volumePermissions.resources | object | `{}` |  |
| zammad.zammadConfig.initContainers.volumePermissions.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| zammad.zammadConfig.initContainers.volumePermissions.securityContext.privileged | bool | `true` |  |
| zammad.zammadConfig.initContainers.volumePermissions.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| zammad.zammadConfig.initContainers.volumePermissions.securityContext.runAsNonRoot | bool | `false` |  |
| zammad.zammadConfig.initContainers.volumePermissions.securityContext.runAsUser | int | `0` |  |
| zammad.zammadConfig.initContainers.zammad.customInit | string | `""` |  |
| zammad.zammadConfig.initContainers.zammad.resources | object | `{}` |  |
| zammad.zammadConfig.initContainers.zammad.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| zammad.zammadConfig.initContainers.zammad.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| zammad.zammadConfig.initContainers.zammad.securityContext.privileged | bool | `false` |  |
| zammad.zammadConfig.initContainers.zammad.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| zammad.zammadConfig.initJob.affinity | object | `{}` |  |
| zammad.zammadConfig.initJob.annotations | object | `{}` |  |
| zammad.zammadConfig.initJob.enabled | bool | `true` |  |
| zammad.zammadConfig.initJob.nodeSelector | object | `{}` |  |
| zammad.zammadConfig.initJob.podAnnotations | object | `{}` |  |
| zammad.zammadConfig.initJob.podLabels | object | `{}` |  |
| zammad.zammadConfig.initJob.podSpec | object | `{}` |  |
| zammad.zammadConfig.initJob.tolerations | list | `[]` |  |
| zammad.zammadConfig.initJob.topologySpreadConstraints | list | `[]` |  |
| zammad.zammadConfig.initJob.ttlSecondsAfterFinished | int | `300` |  |
| zammad.zammadConfig.memcached.enabled | bool | `true` |  |
| zammad.zammadConfig.memcached.host | string | `"zammad-memcached"` |  |
| zammad.zammadConfig.memcached.port | int | `11211` |  |
| zammad.zammadConfig.minio.enabled | bool | `false` |  |
| zammad.zammadConfig.nginx.affinity | object | `{}` |  |
| zammad.zammadConfig.nginx.clientMaxBodySize | string | `"50M"` |  |
| zammad.zammadConfig.nginx.extraEnv | list | `[]` |  |
| zammad.zammadConfig.nginx.extraHeaders | list | `[]` |  |
| zammad.zammadConfig.nginx.knowledgeBaseUrl | string | `""` |  |
| zammad.zammadConfig.nginx.listenIpv4 | bool | `true` |  |
| zammad.zammadConfig.nginx.listenIpv6 | bool | `true` |  |
| zammad.zammadConfig.nginx.livenessProbe.failureThreshold | int | `5` |  |
| zammad.zammadConfig.nginx.livenessProbe.tcpSocket.port | int | `8080` |  |
| zammad.zammadConfig.nginx.livenessProbe.timeoutSeconds | int | `5` |  |
| zammad.zammadConfig.nginx.nodeSelector | object | `{}` |  |
| zammad.zammadConfig.nginx.podAnnotations | object | `{}` |  |
| zammad.zammadConfig.nginx.podLabels | object | `{}` |  |
| zammad.zammadConfig.nginx.readinessProbe.failureThreshold | int | `5` |  |
| zammad.zammadConfig.nginx.readinessProbe.httpGet.path | string | `"/"` |  |
| zammad.zammadConfig.nginx.readinessProbe.httpGet.port | int | `8080` |  |
| zammad.zammadConfig.nginx.readinessProbe.timeoutSeconds | int | `5` |  |
| zammad.zammadConfig.nginx.replicas | int | `1` |  |
| zammad.zammadConfig.nginx.resources | object | `{}` |  |
| zammad.zammadConfig.nginx.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| zammad.zammadConfig.nginx.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| zammad.zammadConfig.nginx.securityContext.privileged | bool | `false` |  |
| zammad.zammadConfig.nginx.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| zammad.zammadConfig.nginx.sidecars | list | `[]` |  |
| zammad.zammadConfig.nginx.startupProbe.failureThreshold | int | `20` |  |
| zammad.zammadConfig.nginx.startupProbe.periodSeconds | int | `4` |  |
| zammad.zammadConfig.nginx.startupProbe.tcpSocket.port | int | `8080` |  |
| zammad.zammadConfig.nginx.tolerations | list | `[]` |  |
| zammad.zammadConfig.nginx.topologySpreadConstraints | list | `[]` |  |
| zammad.zammadConfig.nginx.trustedProxies | list | `[]` |  |
| zammad.zammadConfig.nginx.websocketExtraHeaders | list | `[]` |  |
| zammad.zammadConfig.postgresql.db | string | `"zammad_production"` |  |
| zammad.zammadConfig.postgresql.enabled | bool | `true` |  |
| zammad.zammadConfig.postgresql.host | string | `"zammad-postgresql"` |  |
| zammad.zammadConfig.postgresql.options | string | `"pool=50"` |  |
| zammad.zammadConfig.postgresql.pass | string | `"zammad"` |  |
| zammad.zammadConfig.postgresql.port | int | `5432` |  |
| zammad.zammadConfig.postgresql.user | string | `"zammad"` |  |
| zammad.zammadConfig.railsserver.affinity | object | `{}` |  |
| zammad.zammadConfig.railsserver.extraEnv | list | `[]` |  |
| zammad.zammadConfig.railsserver.listenAddress | string | `"[::]"` |  |
| zammad.zammadConfig.railsserver.livenessProbe.failureThreshold | int | `5` |  |
| zammad.zammadConfig.railsserver.livenessProbe.tcpSocket.port | int | `3000` |  |
| zammad.zammadConfig.railsserver.livenessProbe.timeoutSeconds | int | `5` |  |
| zammad.zammadConfig.railsserver.nodeSelector | object | `{}` |  |
| zammad.zammadConfig.railsserver.podAnnotations | object | `{}` |  |
| zammad.zammadConfig.railsserver.podLabels | object | `{}` |  |
| zammad.zammadConfig.railsserver.readinessProbe.failureThreshold | int | `5` |  |
| zammad.zammadConfig.railsserver.readinessProbe.httpGet.path | string | `"/"` |  |
| zammad.zammadConfig.railsserver.readinessProbe.httpGet.port | int | `3000` |  |
| zammad.zammadConfig.railsserver.readinessProbe.timeoutSeconds | int | `5` |  |
| zammad.zammadConfig.railsserver.replicas | int | `1` |  |
| zammad.zammadConfig.railsserver.resources | object | `{}` |  |
| zammad.zammadConfig.railsserver.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| zammad.zammadConfig.railsserver.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| zammad.zammadConfig.railsserver.securityContext.privileged | bool | `false` |  |
| zammad.zammadConfig.railsserver.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| zammad.zammadConfig.railsserver.sidecars | list | `[]` |  |
| zammad.zammadConfig.railsserver.startupProbe.failureThreshold | int | `20` |  |
| zammad.zammadConfig.railsserver.startupProbe.periodSeconds | int | `4` |  |
| zammad.zammadConfig.railsserver.startupProbe.tcpSocket.port | int | `3000` |  |
| zammad.zammadConfig.railsserver.tmpdir | string | `"/opt/zammad/tmp"` |  |
| zammad.zammadConfig.railsserver.tolerations | list | `[]` |  |
| zammad.zammadConfig.railsserver.topologySpreadConstraints | list | `[]` |  |
| zammad.zammadConfig.railsserver.trustedProxies | string | `"['127.0.0.1', '::1']"` |  |
| zammad.zammadConfig.railsserver.webConcurrency | int | `0` |  |
| zammad.zammadConfig.redis.enabled | bool | `true` |  |
| zammad.zammadConfig.redis.host | string | `"zammad-redis-master"` |  |
| zammad.zammadConfig.redis.pass | string | `"zammad"` |  |
| zammad.zammadConfig.redis.port | int | `6379` |  |
| zammad.zammadConfig.redis.sentinel.enabled | bool | `false` |  |
| zammad.zammadConfig.redis.sentinel.masterName | string | `"mymaster"` |  |
| zammad.zammadConfig.redis.sentinel.pass | string | `"zammad"` |  |
| zammad.zammadConfig.redis.sentinel.sentinels[0] | string | `"zammad-redis:26379"` |  |
| zammad.zammadConfig.redis.sentinel.username | string | `nil` |  |
| zammad.zammadConfig.redis.tls | bool | `false` |  |
| zammad.zammadConfig.redis.username | string | `nil` |  |
| zammad.zammadConfig.scheduler.affinity | object | `{}` |  |
| zammad.zammadConfig.scheduler.extraEnv | list | `[]` |  |
| zammad.zammadConfig.scheduler.nodeSelector | object | `{}` |  |
| zammad.zammadConfig.scheduler.podAnnotations | object | `{}` |  |
| zammad.zammadConfig.scheduler.podLabels | object | `{}` |  |
| zammad.zammadConfig.scheduler.replicas | int | `1` |  |
| zammad.zammadConfig.scheduler.resources | object | `{}` |  |
| zammad.zammadConfig.scheduler.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| zammad.zammadConfig.scheduler.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| zammad.zammadConfig.scheduler.securityContext.privileged | bool | `false` |  |
| zammad.zammadConfig.scheduler.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| zammad.zammadConfig.scheduler.sidecars | list | `[]` |  |
| zammad.zammadConfig.scheduler.tolerations | list | `[]` |  |
| zammad.zammadConfig.scheduler.topologySpreadConstraints | list | `[]` |  |
| zammad.zammadConfig.storageVolume.enabled | bool | `false` |  |
| zammad.zammadConfig.tmpDirVolume.emptyDir.sizeLimit | string | `"100Mi"` |  |
| zammad.zammadConfig.websocket.affinity | object | `{}` |  |
| zammad.zammadConfig.websocket.extraEnv | list | `[]` |  |
| zammad.zammadConfig.websocket.listenAddress | string | `"::"` |  |
| zammad.zammadConfig.websocket.livenessProbe.failureThreshold | int | `10` |  |
| zammad.zammadConfig.websocket.livenessProbe.tcpSocket.port | int | `6042` |  |
| zammad.zammadConfig.websocket.livenessProbe.timeoutSeconds | int | `5` |  |
| zammad.zammadConfig.websocket.nodeSelector | object | `{}` |  |
| zammad.zammadConfig.websocket.podAnnotations | object | `{}` |  |
| zammad.zammadConfig.websocket.podLabels | object | `{}` |  |
| zammad.zammadConfig.websocket.readinessProbe.failureThreshold | int | `5` |  |
| zammad.zammadConfig.websocket.readinessProbe.tcpSocket.port | int | `6042` |  |
| zammad.zammadConfig.websocket.readinessProbe.timeoutSeconds | int | `5` |  |
| zammad.zammadConfig.websocket.replicas | int | `1` |  |
| zammad.zammadConfig.websocket.resources | object | `{}` |  |
| zammad.zammadConfig.websocket.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| zammad.zammadConfig.websocket.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| zammad.zammadConfig.websocket.securityContext.privileged | bool | `false` |  |
| zammad.zammadConfig.websocket.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| zammad.zammadConfig.websocket.sidecars | list | `[]` |  |
| zammad.zammadConfig.websocket.startupProbe.failureThreshold | int | `20` |  |
| zammad.zammadConfig.websocket.startupProbe.periodSeconds | int | `4` |  |
| zammad.zammadConfig.websocket.startupProbe.tcpSocket.port | int | `6042` |  |
| zammad.zammadConfig.websocket.tolerations | list | `[]` |  |
| zammad.zammadConfig.websocket.topologySpreadConstraints | list | `[]` |  |

## Installing the Chart

### With Helm

To install the chart with the release name `my-release`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/zammad
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: zammad
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.2"
    chart: zammad
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
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/zammad --config /charts/charts/zammad/ct.yaml
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template zammad . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```

