# kargo

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.16.0](https://img.shields.io/badge/AppVersion-1.16.0-informational?style=flat-square)

## Prerequisites

- Helm v3
- Config Connector installed (v1.6.0)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| oci://ghcr.io/akuity/kargo-charts | kargo(kargo) | 1.10.4 |

## Description

A Helm chart for Kubernetes

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| kargo.api.adminAccount.enabled | bool | `true` |  |
| kargo.api.adminAccount.passwordHash | string | `"$2b$12$qvkOxcQGZCzXcSAmdMIXcuUsofdJYE/behRanuRcVqD/8pBORj.Ze"` |  |
| kargo.api.adminAccount.tokenSigningKey | string | `"dummy-token-signing-key"` |  |
| kargo.api.adminAccount.tokenTTL | string | `"24h"` |  |
| kargo.api.affinity | object | `{}` |  |
| kargo.api.annotations | object | `{}` |  |
| kargo.api.argocd.urls | string | `nil` |  |
| kargo.api.cabundle.configMapName | string | `""` |  |
| kargo.api.cabundle.secretName | string | `""` |  |
| kargo.api.clusterRoles.admin.additionalRules | string | `nil` |  |
| kargo.api.clusterRoles.projectCreator.additionalRules | string | `nil` |  |
| kargo.api.clusterRoles.user.additionalRules | string | `nil` |  |
| kargo.api.clusterRoles.viewer.additionalRules | string | `nil` |  |
| kargo.api.enabled | bool | `true` |  |
| kargo.api.env | list | `[]` |  |
| kargo.api.envFrom | list | `[]` |  |
| kargo.api.host | string | `"localhost"` |  |
| kargo.api.ingress.annotations | object | `{}` |  |
| kargo.api.ingress.enabled | bool | `false` |  |
| kargo.api.ingress.ingressClassName | string | `nil` |  |
| kargo.api.ingress.pathType | string | `"ImplementationSpecific"` |  |
| kargo.api.ingress.tls.enabled | bool | `true` |  |
| kargo.api.ingress.tls.secretName | string | `"kargo-api-ingress-cert"` |  |
| kargo.api.ingress.tls.selfSignedCert | bool | `true` |  |
| kargo.api.labels | object | `{}` |  |
| kargo.api.logFormat | string | `"CONSOLE"` |  |
| kargo.api.logLevel | string | `"INFO"` |  |
| kargo.api.nodeSelector | object | `{}` |  |
| kargo.api.oidc.additionalScopes[0] | string | `"groups"` |  |
| kargo.api.oidc.admins.claims | object | `{}` |  |
| kargo.api.oidc.cliClientID | string | `nil` |  |
| kargo.api.oidc.clientID | string | `nil` |  |
| kargo.api.oidc.dex.affinity | object | `{}` |  |
| kargo.api.oidc.dex.annotations | object | `{}` |  |
| kargo.api.oidc.dex.connectors | list | `[]` |  |
| kargo.api.oidc.dex.enabled | bool | `false` |  |
| kargo.api.oidc.dex.env | list | `[]` |  |
| kargo.api.oidc.dex.envFrom | list | `[]` |  |
| kargo.api.oidc.dex.image.pullPolicy | string | `"IfNotPresent"` |  |
| kargo.api.oidc.dex.image.pullSecrets | list | `[]` |  |
| kargo.api.oidc.dex.image.repository | string | `"ghcr.io/dexidp/dex"` |  |
| kargo.api.oidc.dex.image.tag | string | `"v2.44.0"` |  |
| kargo.api.oidc.dex.nodeSelector | object | `{}` |  |
| kargo.api.oidc.dex.probes.enabled | bool | `true` |  |
| kargo.api.oidc.dex.resources | object | `{}` |  |
| kargo.api.oidc.dex.securityContext | object | `{}` |  |
| kargo.api.oidc.dex.serviceAccount.annotations | object | `{}` |  |
| kargo.api.oidc.dex.serviceAccount.labels | object | `{}` |  |
| kargo.api.oidc.dex.skipApprovalScreen | bool | `true` |  |
| kargo.api.oidc.dex.tls.secretName | string | `"kargo-dex-server-cert"` |  |
| kargo.api.oidc.dex.tls.selfSignedCert | bool | `true` |  |
| kargo.api.oidc.dex.tolerations | list | `[]` |  |
| kargo.api.oidc.dex.volumeMounts | string | `nil` |  |
| kargo.api.oidc.dex.volumes | list | `[]` |  |
| kargo.api.oidc.enabled | bool | `false` |  |
| kargo.api.oidc.globalServiceAccounts.namespaces | list | `[]` |  |
| kargo.api.oidc.issuerURL | string | `nil` |  |
| kargo.api.oidc.projectCreators.claims | object | `{}` |  |
| kargo.api.oidc.usernameClaim | string | `"email"` |  |
| kargo.api.oidc.users.claims | object | `{}` |  |
| kargo.api.oidc.viewers.claims | object | `{}` |  |
| kargo.api.permissiveCORSPolicyEnabled | bool | `false` |  |
| kargo.api.podAnnotations | object | `{}` |  |
| kargo.api.podLabels | object | `{}` |  |
| kargo.api.probes.enabled | bool | `true` |  |
| kargo.api.replicas | int | `1` |  |
| kargo.api.resources | object | `{}` |  |
| kargo.api.rollouts.integrationEnabled | bool | `true` |  |
| kargo.api.rollouts.logs.enabled | bool | `false` |  |
| kargo.api.rollouts.logs.httpHeaders | object | `{}` |  |
| kargo.api.rollouts.logs.tokenSecret.key | string | `nil` |  |
| kargo.api.rollouts.logs.tokenSecret.name | string | `nil` |  |
| kargo.api.rollouts.logs.urlTemplate | string | `""` |  |
| kargo.api.secret.name | string | `""` |  |
| kargo.api.secretManagementEnabled | bool | `true` |  |
| kargo.api.securityContext | object | `{}` |  |
| kargo.api.service.annotations | object | `{}` |  |
| kargo.api.service.type | string | `"ClusterIP"` |  |
| kargo.api.serviceAccount.annotations | object | `{}` |  |
| kargo.api.serviceAccount.labels | object | `{}` |  |
| kargo.api.tls.enabled | bool | `true` |  |
| kargo.api.tls.secretName | string | `"kargo-api-cert"` |  |
| kargo.api.tls.selfSignedCert | bool | `true` |  |
| kargo.api.tls.terminatedUpstream | bool | `false` |  |
| kargo.api.tolerations | list | `[]` |  |
| kargo.controller.affinity | object | `{}` |  |
| kargo.controller.allowCredentialsOverHTTP | bool | `false` |  |
| kargo.controller.annotations | object | `{}` |  |
| kargo.controller.argocd.integrationEnabled | bool | `true` |  |
| kargo.controller.argocd.namespace | string | `"argocd"` |  |
| kargo.controller.argocd.watchArgocdNamespaceOnly | bool | `false` |  |
| kargo.controller.cabundle.configMapName | string | `""` |  |
| kargo.controller.cabundle.secretName | string | `""` |  |
| kargo.controller.enabled | bool | `true` |  |
| kargo.controller.env | list | `[]` |  |
| kargo.controller.envFrom | list | `[]` |  |
| kargo.controller.gitClient.email | string | `"no-reply@kargo.io"` |  |
| kargo.controller.gitClient.name | string | `"Kargo"` |  |
| kargo.controller.gitClient.pushIntegrationPolicy | string | `"AlwaysRebase"` |  |
| kargo.controller.gitClient.signingKeySecret.name | string | `""` |  |
| kargo.controller.gitClient.signingKeySecret.type | string | `""` |  |
| kargo.controller.githubPush.maxRevisions | int | `10` |  |
| kargo.controller.githubPush.verifyUntrustedCommits | bool | `false` |  |
| kargo.controller.globalCredentials.namespaces | list | `[]` |  |
| kargo.controller.images.cache.cacheByTagPolicy | string | `"Allow"` |  |
| kargo.controller.images.cache.maxEntries | int | `100000` |  |
| kargo.controller.images.push.maxArtifactSize | int | `1073741824` |  |
| kargo.controller.images.registries.rateLimit | int | `20` |  |
| kargo.controller.initContainers | list | `[]` |  |
| kargo.controller.isDefault | bool | `false` |  |
| kargo.controller.labels | object | `{}` |  |
| kargo.controller.logFormat | string | `"CONSOLE"` |  |
| kargo.controller.logLevel | string | `"INFO"` |  |
| kargo.controller.nodeSelector | object | `{}` |  |
| kargo.controller.podAnnotations | object | `{}` |  |
| kargo.controller.podLabels | object | `{}` |  |
| kargo.controller.reconcilers.controlFlowStages.maxConcurrentReconciles | string | `nil` |  |
| kargo.controller.reconcilers.maxConcurrentReconciles | int | `4` |  |
| kargo.controller.reconcilers.promotions.maxConcurrentReconciles | string | `nil` |  |
| kargo.controller.reconcilers.stages.maxConcurrentReconciles | string | `nil` |  |
| kargo.controller.reconcilers.warehouses.maxConcurrentReconciles | string | `nil` |  |
| kargo.controller.reconcilers.warehouses.minReconciliationInterval | string | `"5m0s"` |  |
| kargo.controller.resources | object | `{}` |  |
| kargo.controller.rollouts.controllerInstanceID | string | `""` |  |
| kargo.controller.rollouts.integrationEnabled | bool | `true` |  |
| kargo.controller.securityContext | object | `{}` |  |
| kargo.controller.serviceAccount.annotations | object | `{}` |  |
| kargo.controller.serviceAccount.clusterWideSecretReadingEnabled | bool | `false` |  |
| kargo.controller.serviceAccount.iamRole | string | `""` |  |
| kargo.controller.serviceAccount.labels | object | `{}` |  |
| kargo.controller.tolerations | list | `[]` |  |
| kargo.controller.volumeMounts | list | `[]` |  |
| kargo.controller.volumes | list | `[]` |  |
| kargo.crds.install | bool | `true` |  |
| kargo.crds.keep | bool | `true` |  |
| kargo.externalWebhooksServer.affinity | object | `{}` |  |
| kargo.externalWebhooksServer.annotations | object | `{}` |  |
| kargo.externalWebhooksServer.enabled | bool | `true` |  |
| kargo.externalWebhooksServer.env | list | `[]` |  |
| kargo.externalWebhooksServer.envFrom | list | `[]` |  |
| kargo.externalWebhooksServer.host | string | `"localhost"` |  |
| kargo.externalWebhooksServer.ingress.annotations | object | `{}` |  |
| kargo.externalWebhooksServer.ingress.enabled | bool | `false` |  |
| kargo.externalWebhooksServer.ingress.ingressClassName | string | `nil` |  |
| kargo.externalWebhooksServer.ingress.pathType | string | `"ImplementationSpecific"` |  |
| kargo.externalWebhooksServer.ingress.tls.enabled | bool | `true` |  |
| kargo.externalWebhooksServer.ingress.tls.secretName | string | `"kargo-external-webhooks-server-ingress-cert"` |  |
| kargo.externalWebhooksServer.ingress.tls.selfSignedCert | bool | `true` |  |
| kargo.externalWebhooksServer.labels | object | `{}` |  |
| kargo.externalWebhooksServer.logFormat | string | `"CONSOLE"` |  |
| kargo.externalWebhooksServer.logLevel | string | `"INFO"` |  |
| kargo.externalWebhooksServer.nodeSelector | object | `{}` |  |
| kargo.externalWebhooksServer.podAnnotations | object | `{}` |  |
| kargo.externalWebhooksServer.podLabels | object | `{}` |  |
| kargo.externalWebhooksServer.probes.enabled | bool | `true` |  |
| kargo.externalWebhooksServer.replicas | int | `1` |  |
| kargo.externalWebhooksServer.resources | object | `{}` |  |
| kargo.externalWebhooksServer.securityContext | object | `{}` |  |
| kargo.externalWebhooksServer.service.annotations | object | `{}` |  |
| kargo.externalWebhooksServer.service.type | string | `"ClusterIP"` |  |
| kargo.externalWebhooksServer.serviceAccount.annotations | object | `{}` |  |
| kargo.externalWebhooksServer.serviceAccount.labels | object | `{}` |  |
| kargo.externalWebhooksServer.tls.enabled | bool | `true` |  |
| kargo.externalWebhooksServer.tls.secretName | string | `"kargo-external-webhooks-server-cert"` |  |
| kargo.externalWebhooksServer.tls.selfSignedCert | bool | `true` |  |
| kargo.externalWebhooksServer.tls.terminatedUpstream | bool | `false` |  |
| kargo.externalWebhooksServer.tolerations | list | `[]` |  |
| kargo.extraObjects | list | `[]` |  |
| kargo.garbageCollector.affinity | object | `{}` |  |
| kargo.garbageCollector.annotations | object | `{}` |  |
| kargo.garbageCollector.enabled | bool | `true` |  |
| kargo.garbageCollector.env | list | `[]` |  |
| kargo.garbageCollector.envFrom | list | `[]` |  |
| kargo.garbageCollector.labels | object | `{}` |  |
| kargo.garbageCollector.logFormat | string | `"CONSOLE"` |  |
| kargo.garbageCollector.logLevel | string | `"INFO"` |  |
| kargo.garbageCollector.maxRetainedFreight | int | `20` |  |
| kargo.garbageCollector.maxRetainedPromotions | int | `20` |  |
| kargo.garbageCollector.minFreightDeletionAge | string | `"336h"` |  |
| kargo.garbageCollector.minPromotionDeletionAge | string | `"336h"` |  |
| kargo.garbageCollector.nodeSelector | object | `{}` |  |
| kargo.garbageCollector.podAnnotations | object | `{}` |  |
| kargo.garbageCollector.podLabels | object | `{}` |  |
| kargo.garbageCollector.resources | object | `{}` |  |
| kargo.garbageCollector.schedule | string | `"0 * * * *"` |  |
| kargo.garbageCollector.securityContext | object | `{}` |  |
| kargo.garbageCollector.serviceAccount.annotations | object | `{}` |  |
| kargo.garbageCollector.serviceAccount.labels | object | `{}` |  |
| kargo.garbageCollector.tolerations | list | `[]` |  |
| kargo.garbageCollector.workers | int | `3` |  |
| kargo.global.affinity | object | `{}` |  |
| kargo.global.annotations | object | `{}` |  |
| kargo.global.clusterSecretsNamespace | string | `"kargo-cluster-secrets"` |  |
| kargo.global.createClusterSecretsNamespace | bool | `true` |  |
| kargo.global.env | list | `[]` |  |
| kargo.global.envFrom | list | `[]` |  |
| kargo.global.labels | object | `{}` |  |
| kargo.global.nodeSelector | object | `{}` |  |
| kargo.global.podAnnotations | object | `{}` |  |
| kargo.global.podLabels | object | `{}` |  |
| kargo.global.securityContext | object | `{}` |  |
| kargo.global.serviceAccount.annotations | object | `{}` |  |
| kargo.global.serviceAccount.labels | object | `{}` |  |
| kargo.global.sharedResources.createNamespace | bool | `true` |  |
| kargo.global.sharedResources.namespace | string | `"kargo-shared-resources"` |  |
| kargo.global.systemResources.createNamespace | bool | `true` |  |
| kargo.global.systemResources.namespace | string | `"kargo-system-resources"` |  |
| kargo.global.tolerations | list | `[]` |  |
| kargo.image.pullPolicy | string | `"IfNotPresent"` |  |
| kargo.image.pullSecrets | list | `[]` |  |
| kargo.image.repository | string | `"ghcr.io/akuity/kargo"` |  |
| kargo.image.tag | string | `""` |  |
| kargo.kubeconfigSecrets | object | `{}` |  |
| kargo.managementController.affinity | object | `{}` |  |
| kargo.managementController.annotations | object | `{}` |  |
| kargo.managementController.enabled | bool | `true` |  |
| kargo.managementController.env | list | `[]` |  |
| kargo.managementController.envFrom | list | `[]` |  |
| kargo.managementController.labels | object | `{}` |  |
| kargo.managementController.logFormat | string | `"CONSOLE"` |  |
| kargo.managementController.logLevel | string | `"INFO"` |  |
| kargo.managementController.nodeSelector | object | `{}` |  |
| kargo.managementController.podAnnotations | object | `{}` |  |
| kargo.managementController.podLabels | object | `{}` |  |
| kargo.managementController.reconcilers.maxConcurrentReconciles | int | `4` |  |
| kargo.managementController.reconcilers.namespaces.maxConcurrentReconciles | string | `nil` |  |
| kargo.managementController.reconcilers.projectConfigs.maxConcurrentReconciles | string | `nil` |  |
| kargo.managementController.reconcilers.projects.maxConcurrentReconciles | string | `nil` |  |
| kargo.managementController.reconcilers.serviceAccounts.maxConcurrentReconciles | string | `nil` |  |
| kargo.managementController.resources | object | `{}` |  |
| kargo.managementController.securityContext | object | `{}` |  |
| kargo.managementController.serviceAccount.annotations | object | `{}` |  |
| kargo.managementController.serviceAccount.labels | object | `{}` |  |
| kargo.managementController.tolerations | list | `[]` |  |
| kargo.rbac.installClusterRoleBindings | bool | `true` |  |
| kargo.rbac.installClusterRoles | bool | `true` |  |
| kargo.webhooks.register | bool | `true` |  |
| kargo.webhooksServer.affinity | object | `{}` |  |
| kargo.webhooksServer.annotations | object | `{}` |  |
| kargo.webhooksServer.controlplaneUserRegex | string | `""` |  |
| kargo.webhooksServer.enabled | bool | `true` |  |
| kargo.webhooksServer.env | list | `[]` |  |
| kargo.webhooksServer.envFrom | list | `[]` |  |
| kargo.webhooksServer.labels | object | `{}` |  |
| kargo.webhooksServer.logFormat | string | `"CONSOLE"` |  |
| kargo.webhooksServer.logLevel | string | `"INFO"` |  |
| kargo.webhooksServer.nodeSelector | object | `{}` |  |
| kargo.webhooksServer.podAnnotations | object | `{}` |  |
| kargo.webhooksServer.podLabels | object | `{}` |  |
| kargo.webhooksServer.replicas | int | `1` |  |
| kargo.webhooksServer.resources | object | `{}` |  |
| kargo.webhooksServer.securityContext | object | `{}` |  |
| kargo.webhooksServer.serviceAccount.annotations | object | `{}` |  |
| kargo.webhooksServer.serviceAccount.labels | object | `{}` |  |
| kargo.webhooksServer.tls.caBundle | string | `""` |  |
| kargo.webhooksServer.tls.secretName | string | `"kargo-webhooks-server-cert"` |  |
| kargo.webhooksServer.tls.selfSignedCert | bool | `true` |  |
| kargo.webhooksServer.tolerations | list | `[]` |  |

## Installing the Chart

### With Helm

To install the chart with the release name `my-release`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/kargo
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: kargo
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.0"
    chart: kargo
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
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/kargo --config /charts/charts/kargo/ct.yaml
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template kargo . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```

