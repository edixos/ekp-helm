# cert-manager-webhook-scaleway

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.1.1](https://img.shields.io/badge/AppVersion-v0.1.1-informational?style=flat-square)

## Prerequisites

- Helm v3
- cert-manager installed

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://helm.scw.cloud/ | webhook(scaleway-certmanager-webhook) | 0.4.1 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| edixos |  |  |

## Description
| Key | Type | Default | Description |
|-----|------|---------|-------------|
| clusterIssuer.email | string | `"user@example.com"` | Email address used for ACME registration |
| clusterIssuer.enabled | bool | `true` |  |
| clusterIssuer.name | string | `"letsencrypt-prod"` | Name of the ClusterIssuer |
| clusterIssuer.privateKeySecretRef | string | `"letsencrypt-prod"` | Name of the secret used to store the ACME account private key |
| clusterIssuer.server | string | `"https://acme-v02.api.letsencrypt.org/directory"` | Server URL for the ACME CA |
| webhook.affinity | object | `{}` | Affinities |
| webhook.certManager.namespace | string | `"cert-manager"` | Namespace under which cert-manager is installed |
| webhook.certManager.serviceAccountName | string | `"cert-manager"` | Name of the cert-manager service account |
| webhook.extraEnv | list | `[]` | Additional environment variables to pass to the webhook deployment |
| webhook.fullnameOverride | string | `""` | Override charts and release name |
| webhook.groupName | string | `"acme.scaleway.com"` | Name under which the webhook will be available |
| webhook.image.imagePullSecrets | list | `[]` | Image pull secrets |
| webhook.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| webhook.image.repository | string | `"scaleway/cert-manager-webhook-scaleway"` | Repository for the webhook image |
| webhook.image.tag | string | `""` | Tag for the webhook image, defaults to AppVersion |
| webhook.extraEnv | list | `[]` | Additional environment variables to pass to the webhook deployment |
| webhook.listenPort | int | `443` | Port the webhook listens on |
| webhook.nameOverride | string | `""` | Override charts name |
| webhook.nodeSelector | object | `{}` | Node selector |
| webhook.pki.caDuration | string | `"43800h"` | Webhook ca duration |
| webhook.pki.servingCertificateDuration | string | `"8760h"` | Webhook certificate duration |
| webhook.podLabels | object | `{}` | Pod labels |
| webhook.podSecurityContext | object | `{}` | Pod security context |
| webhook.replicaCount | int | `1` | Number of replica |
| webhook.resources | object | `{}` | Resources definition |
| webhook.secret.accessKey | string | `""` | Default scaleway access key (optional) |
| webhook.secret.externalSecretName | string | `""` | Existing secret name for the default scaleway credentials |
| webhook.secret.name | string | `"scaleway-webhook-secret"` | Secret name for the default scaleway credentials |
| webhook.secret.secretKey | string | `""` | Default scaleway secret key (optional) |
| webhook.securityContext | object | `{}` | Container security context |
| webhook.service.ipFamilies | list | `[]` | Service ipFamilies. Can be IPv4 and/or IPv6. |
| webhook.service.ipFamilyPolicy | string | `""` | Service ipFamilyPolicy set the ip family policy to configure dual-stack |
| webhook.service.port | int | `443` | Service port exposing the webhook |
| webhook.service.type | string | `"ClusterIP"` | Service type exposing the webhook |
| webhook.tolerations | list | `[]` | Tolerations |

| webhook.tolerations | list | `[]` | Tolerations |
| webhook.affinity | object | `{}` | Affinities |
| webhook.securityContext | object | `{}` | Container security context |
| webhook.podSecurityContext | object | `{}` | Pod security context |

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
    targetRevision: "0.1.0"
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
