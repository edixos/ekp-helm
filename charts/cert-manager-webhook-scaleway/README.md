# cert-manager-webhook-scaleway

![Version: 0.2.2](https://img.shields.io/badge/Version-0.2.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.1.1](https://img.shields.io/badge/AppVersion-v0.1.1-informational?style=flat-square)

## Prerequisites

- Helm v3
- cert-manager installed

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://helm.scw.cloud/ | webhook(scaleway-certmanager-webhook) | 0.4.2 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| edixos |  |  |

## Description

A Helm chart for cert-manager-webhook-scaleway

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| clusterIssuer.email | string | `"user@example.com"` | Email address used for ACME registration |
| clusterIssuer.enabled | bool | `true` |  |
| clusterIssuer.name | string | `"letsencrypt-prod"` | Name of the ClusterIssuer |
| clusterIssuer.privateKeySecretRef | string | `"letsencrypt-prod"` | Name of the secret used to store the ACME account private key |
| clusterIssuer.server | string | `"https://acme-v02.api.letsencrypt.org/directory"` | Server URL for the ACME CA |
| externalSecrets | list | `[]` | List of ExternalSecret resources to create alongside the webhook. |
| webhook.affinity | object | `{}` |  |
| webhook.certManager.namespace | string | `"cert-manager"` |  |
| webhook.certManager.serviceAccountName | string | `"cert-manager"` |  |
| webhook.extraEnv | list | `[]` |  |
| webhook.fullnameOverride | string | `""` |  |
| webhook.groupName | string | `"acme.scaleway.com"` |  |
| webhook.image.imagePullSecrets | list | `[]` |  |
| webhook.image.pullPolicy | string | `"IfNotPresent"` |  |
| webhook.image.repository | string | `"scaleway/cert-manager-webhook-scaleway"` |  |
| webhook.image.tag | string | `""` |  |
| webhook.listenPort | int | `443` |  |
| webhook.nameOverride | string | `""` |  |
| webhook.nodeSelector | object | `{}` |  |
| webhook.pki.caDuration | string | `"43800h"` |  |
| webhook.pki.servingCertificateDuration | string | `"8760h"` |  |
| webhook.podLabels | object | `{}` |  |
| webhook.podSecurityContext | object | `{}` |  |
| webhook.replicaCount | int | `1` |  |
| webhook.resources | object | `{}` |  |
| webhook.secret.accessKey | string | `""` |  |
| webhook.secret.externalSecretName | string | `""` |  |
| webhook.secret.name | string | `"scaleway-webhook-secret"` |  |
| webhook.secret.secretKey | string | `""` |  |
| webhook.securityContext | object | `{}` |  |
| webhook.service.ipFamilies | list | `[]` |  |
| webhook.service.ipFamilyPolicy | string | `""` |  |
| webhook.service.port | int | `443` |  |
| webhook.service.type | string | `"ClusterIP"` |  |
| webhook.tolerations | list | `[]` |  |

## Installing the Chart

### With Helm

To install the chart with the release name `my-release`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/cert-manager-webhook-scaleway
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: cert-manager-webhook-scaleway
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.2.2"
    chart: cert-manager-webhook-scaleway
    path: ''
    helm:
      values: |
        webhook:
          secret:
            accessKey: "YOUR_ACCESS_KEY"
            secretKey: "YOUR_SECRET_KEY"

  destination:
    server: https://kubernetes.default.svc
    namespace: "cert-manager"
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
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/cert-manager-webhook-scaleway --config /charts/charts/cert-manager-webhook-scaleway/ct.yaml
```
