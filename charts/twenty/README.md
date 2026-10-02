# twenty

![Version: 0.1.1](https://img.shields.io/badge/Version-0.1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v2.26.0](https://img.shields.io/badge/AppVersion-v2.26.0-informational?style=flat-square)

## Prerequisites

- Helm v3
- External Secrets Operator (for `externalSecrets`)
- Gateway API CRDs and a Gateway to attach to (for `httpRoutes`)
- Envoy Gateway CRDs (for `securityPolicies`)
- A PostgreSQL 16+ database and role for Twenty, when `twenty.db.enabled` is false

## Upstream chart

The official Twenty chart lives in the Twenty monorepo
(`packages/twenty-docker/helm/twenty`) and is not published to any Helm or OCI
repository. It is therefore vendored under `charts/twenty`, pinned to the commit
in the `ekp-helm/upstream-source` annotation of `Chart.yaml`, and declared as a
dependency with an empty `repository` so Helm resolves it from that directory.

To update it, replace `charts/twenty` with the chart from a newer upstream
commit, update the annotation, and bump `version` in `Chart.yaml`. The automated
dependency bump cannot do this: it only understands published repositories.

## Requirements

| Repository | Name | Version |
|------------|------|---------|
|  | twenty(twenty) | 0.1.0 |

## Description

Twenty CRM, wired to an externally managed PostgreSQL and the platform Gateway

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| externalSecrets | list | `[]` | List of ExternalSecrets to deploy |
| httpRoutes | object | `{}` | Map of Gateway API HTTPRoutes to deploy, keyed by route name |
| networkPolicies | object | `{}` | Map of NetworkPolicies to deploy, keyed by policy name |
| securityPolicies | object | `{}` | Map of Envoy Gateway SecurityPolicies to deploy, keyed by policy name (e.g. an IP allowlist attached to an HTTPRoute) |
| twenty.db.enabled | bool | `true` |  |
| twenty.db.external.database | string | `"twenty"` |  |
| twenty.db.external.host | string | `""` |  |
| twenty.db.external.password | string | `""` |  |
| twenty.db.external.passwordKey | string | `""` |  |
| twenty.db.external.port | int | `5432` |  |
| twenty.db.external.secretName | string | `""` |  |
| twenty.db.external.ssl | bool | `false` |  |
| twenty.db.external.user | string | `"twenty_app_user"` |  |
| twenty.db.internal.appPassword | string | `""` |  |
| twenty.db.internal.appUser | string | `"twenty_app_user"` |  |
| twenty.db.internal.database | string | `"twenty"` |  |
| twenty.db.internal.env.ALLOW_NOSSL | string | `"true"` |  |
| twenty.db.internal.env.PGPASSWORD_SUPERUSER | string | `"postgres"` |  |
| twenty.db.internal.env.PGUSER_SUPERUSER | string | `"postgres"` |  |
| twenty.db.internal.env.SPILO_PROVIDER | string | `"local"` |  |
| twenty.db.internal.image.repository | string | `"twentycrm/twenty-postgres-spilo"` |  |
| twenty.db.internal.image.tag | string | `"3.3-p2"` |  |
| twenty.db.internal.persistence.accessModes[0] | string | `"ReadWriteOnce"` |  |
| twenty.db.internal.persistence.enabled | bool | `true` |  |
| twenty.db.internal.persistence.existingClaim | string | `""` |  |
| twenty.db.internal.persistence.size | string | `"10Gi"` |  |
| twenty.db.internal.persistence.storageClass | string | `""` |  |
| twenty.db.internal.resources.limits.cpu | string | `"1000m"` |  |
| twenty.db.internal.resources.limits.memory | string | `"1024Mi"` |  |
| twenty.db.internal.resources.requests.cpu | string | `"250m"` |  |
| twenty.db.internal.resources.requests.memory | string | `"256Mi"` |  |
| twenty.fullnameOverride | string | `""` |  |
| twenty.image.pullPolicy | string | `"IfNotPresent"` |  |
| twenty.image.repository | string | `"twentycrm/twenty"` |  |
| twenty.image.tag | string | `"v2.26.0"` |  |
| twenty.nameOverride | string | `""` |  |
| twenty.redis.external.host | string | `""` |  |
| twenty.redis.external.password | string | `""` |  |
| twenty.redis.external.passwordKey | string | `""` |  |
| twenty.redis.external.port | int | `6379` |  |
| twenty.redis.external.secretName | string | `""` |  |
| twenty.redisInternal.enabled | bool | `true` |  |
| twenty.redisInternal.image.pullPolicy | string | `"IfNotPresent"` |  |
| twenty.redisInternal.image.repository | string | `"redis/redis-stack-server"` |  |
| twenty.redisInternal.image.tag | string | `"7.2.0-v10"` |  |
| twenty.redisInternal.persistence.accessModes[0] | string | `"ReadWriteOnce"` |  |
| twenty.redisInternal.persistence.enabled | bool | `false` |  |
| twenty.redisInternal.persistence.existingClaim | string | `""` |  |
| twenty.redisInternal.persistence.size | string | `"1Gi"` |  |
| twenty.redisInternal.persistence.storageClass | string | `""` |  |
| twenty.redisInternal.resources.limits.cpu | string | `"500m"` |  |
| twenty.redisInternal.resources.limits.memory | string | `"2048Mi"` |  |
| twenty.redisInternal.resources.requests.cpu | string | `"250m"` |  |
| twenty.redisInternal.resources.requests.memory | string | `"1024Mi"` |  |
| twenty.redisInternal.service.port | int | `6379` |  |
| twenty.secrets.tokens.accessToken | string | `""` |  |
| twenty.secrets.tokens.create | bool | `false` |  |
| twenty.secrets.tokens.name | string | `"twenty-secrets"` |  |
| twenty.securityContext.fsGroup | int | `1000` |  |
| twenty.securityContext.runAsGroup | int | `1000` |  |
| twenty.securityContext.runAsNonRoot | bool | `true` |  |
| twenty.securityContext.runAsUser | int | `1000` |  |
| twenty.securityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| twenty.server.affinity | object | `{}` |  |
| twenty.server.dnsConfig | object | `{}` |  |
| twenty.server.dnsPolicy | string | `nil` |  |
| twenty.server.dockerDataPersistence.accessModes[0] | string | `"ReadWriteOnce"` |  |
| twenty.server.dockerDataPersistence.enabled | bool | `true` |  |
| twenty.server.dockerDataPersistence.existingClaim | string | `""` |  |
| twenty.server.dockerDataPersistence.size | string | `"100Mi"` |  |
| twenty.server.dockerDataPersistence.storageClass | string | `""` |  |
| twenty.server.enabled | bool | `true` |  |
| twenty.server.env.ACCESS_TOKEN_EXPIRES_IN | string | `"7d"` |  |
| twenty.server.env.LOGIN_TOKEN_EXPIRES_IN | string | `"1h"` |  |
| twenty.server.env.SIGN_IN_PREFILLED | string | `"false"` |  |
| twenty.server.extraEnv | list | `[]` |  |
| twenty.server.extraVolumeMounts | list | `[]` |  |
| twenty.server.image | object | `{}` |  |
| twenty.server.ingress.acme | bool | `true` |  |
| twenty.server.ingress.annotations | object | `{}` |  |
| twenty.server.ingress.className | string | `"nginx"` |  |
| twenty.server.ingress.enabled | bool | `false` |  |
| twenty.server.ingress.hosts[0].host | string | `"crm.example.com"` |  |
| twenty.server.ingress.hosts[0].paths[0].path | string | `"/"` |  |
| twenty.server.ingress.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| twenty.server.ingress.tls[0].hosts[0] | string | `"crm.example.com"` |  |
| twenty.server.ingress.tls[0].secretName | string | `"twenty-tls"` |  |
| twenty.server.livenessProbe.failureThreshold | int | `3` |  |
| twenty.server.livenessProbe.httpGet.path | string | `"/healthz"` |  |
| twenty.server.livenessProbe.httpGet.port | string | `"http-tcp"` |  |
| twenty.server.livenessProbe.periodSeconds | int | `30` |  |
| twenty.server.livenessProbe.timeoutSeconds | int | `5` |  |
| twenty.server.nodeSelector | object | `{}` |  |
| twenty.server.persistence.accessModes[0] | string | `"ReadWriteOnce"` |  |
| twenty.server.persistence.enabled | bool | `true` |  |
| twenty.server.persistence.existingClaim | string | `""` |  |
| twenty.server.persistence.size | string | `"10Gi"` |  |
| twenty.server.persistence.storageClass | string | `""` |  |
| twenty.server.readinessProbe.failureThreshold | int | `3` |  |
| twenty.server.readinessProbe.httpGet.path | string | `"/healthz"` |  |
| twenty.server.readinessProbe.httpGet.port | string | `"http-tcp"` |  |
| twenty.server.readinessProbe.periodSeconds | int | `10` |  |
| twenty.server.readinessProbe.timeoutSeconds | int | `5` |  |
| twenty.server.replicaCount | int | `1` |  |
| twenty.server.resources.limits.cpu | string | `"1000m"` |  |
| twenty.server.resources.limits.memory | string | `"1024Mi"` |  |
| twenty.server.resources.requests.cpu | string | `"250m"` |  |
| twenty.server.resources.requests.memory | string | `"256Mi"` |  |
| twenty.server.service.port | int | `3000` |  |
| twenty.server.service.type | string | `"ClusterIP"` |  |
| twenty.server.startupProbe.failureThreshold | int | `30` |  |
| twenty.server.startupProbe.httpGet.path | string | `"/healthz"` |  |
| twenty.server.startupProbe.httpGet.port | string | `"http-tcp"` |  |
| twenty.server.startupProbe.periodSeconds | int | `10` |  |
| twenty.server.startupProbe.timeoutSeconds | int | `5` |  |
| twenty.server.tolerations | list | `[]` |  |
| twenty.serviceAccount.annotations | object | `{}` |  |
| twenty.serviceAccount.automount | bool | `true` |  |
| twenty.serviceAccount.create | bool | `false` |  |
| twenty.serviceAccount.name | string | `""` |  |
| twenty.storage.s3.accessKeyId | string | `""` |  |
| twenty.storage.s3.bucket | string | `""` |  |
| twenty.storage.s3.endpoint | string | `""` |  |
| twenty.storage.s3.region | string | `""` |  |
| twenty.storage.s3.secretAccessKey | string | `""` |  |
| twenty.storage.type | string | `"local"` |  |
| twenty.worker.affinity | object | `{}` |  |
| twenty.worker.command[0] | string | `"yarn"` |  |
| twenty.worker.command[1] | string | `"worker:prod"` |  |
| twenty.worker.dnsConfig | object | `{}` |  |
| twenty.worker.dnsPolicy | string | `nil` |  |
| twenty.worker.enabled | bool | `true` |  |
| twenty.worker.extraEnv | list | `[]` |  |
| twenty.worker.image | object | `{}` |  |
| twenty.worker.nodeSelector | object | `{}` |  |
| twenty.worker.replicaCount | int | `1` |  |
| twenty.worker.resources.limits.cpu | string | `"1000m"` |  |
| twenty.worker.resources.limits.memory | string | `"2048Mi"` |  |
| twenty.worker.resources.requests.cpu | string | `"250m"` |  |
| twenty.worker.resources.requests.memory | string | `"1024Mi"` |  |
| twenty.worker.tolerations | list | `[]` |  |

## Installing the Chart

### With Helm

To install the chart with the release name `my-release`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/twenty
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: twenty
spec:
  project: dev

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.1"
    chart: twenty
    path: ''
    helm:
      values: |

  destination:
    server: https://kubernetes.default.svc
    namespace: "klastro-crm"
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
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/twenty --config /charts/charts/twenty/ct.yaml
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template twenty . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```

