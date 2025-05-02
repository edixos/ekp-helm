# cert-manager

![Version: 0.1.2](https://img.shields.io/badge/Version-0.1.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.17.1](https://img.shields.io/badge/AppVersion-1.17.1-informational?style=flat-square)

## Prerequisites

- Helm v3
- Config Connector installed (v1.6.0)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.jetstack.io | certmanager(cert-manager) | 0.1.2 |
| https://edixos.github.io/ekp-helm | iamPolicyMembers(gcp-iam-policy-members) | 0.1.2 |
| https://edixos.github.io/ekp-helm | workloadIdentity(gcp-workload-identity) | 0.1.1 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| wiemaouadi | <wiem.aouadi3@gmail.com> | <https://github.com/wiemaouadi> |
| smileisak | <ikaboubi@gmail.com> | <https://github.com/smileisak> |

## Description

A Helm chart for cert-manager

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.gcpProjectId | string | `""` | Google Project ID of the Kubernetes Cluster hosting the service Account |
| global.cnrmNamespace | string | `""` | Allows to deploy in another namespace than the release one |
| global.abandon | bool | `false` | Activate abandon of the resources (If true, the GCP resources will be keep after deleting k8s resources) |
| grafanaDashboard.enabled | bool | `true` | Add grafana dashboard as a configmap |
| grafanaDashboard.label | object | `{"grafana_dashboard":"1"}` | label to apply to the config map. Used by Grafana sidecar to automatically install the dashboard |
| certmanager.global.imagePullSecrets | list | `[]` |  |
| certmanager.global.commonLabels | object | `{}` |  |
| certmanager.global.priorityClassName | string | `""` |  |
| certmanager.global.rbac.create | bool | `true` |  |
| certmanager.global.rbac.aggregateClusterRoles | bool | `true` |  |
| certmanager.global.podSecurityPolicy.enabled | bool | `false` |  |
| certmanager.global.podSecurityPolicy.useAppArmor | bool | `true` |  |
| certmanager.global.logLevel | int | `2` |  |
| certmanager.global.leaderElection.namespace | string | `"kube-system"` |  |
| certmanager.crds.enabled | bool | `true` |  |
| certmanager.crds.keep | bool | `true` |  |
| certmanager.replicaCount | int | `1` |  |
| certmanager.strategy | object | `{}` |  |
| certmanager.podDisruptionBudget.enabled | bool | `false` |  |
| certmanager.featureGates | string | `""` |  |
| certmanager.maxConcurrentChallenges | int | `60` |  |
| certmanager.image.repository | string | `"quay.io/jetstack/cert-manager-controller"` |  |
| certmanager.image.pullPolicy | string | `"IfNotPresent"` |  |
| certmanager.clusterResourceNamespace | string | `""` |  |
| certmanager.namespace | string | `""` |  |
| certmanager.nameOverride | string | `"cert-manager"` |  |
| certmanager.fullnameOverride | string | `"cert-manager"` |  |
| certmanager.serviceAccount.create | bool | `true` |  |
| certmanager.serviceAccount.automountServiceAccountToken | bool | `true` |  |
| certmanager.enableCertificateOwnerRef | bool | `false` |  |
| certmanager.config | object | `{}` |  |
| certmanager.dns01RecursiveNameservers | string | `""` |  |
| certmanager.dns01RecursiveNameserversOnly | bool | `false` |  |
| certmanager.disableAutoApproval | bool | `false` |  |
| certmanager.approveSignerNames[0] | string | `"issuers.cert-manager.io/*"` |  |
| certmanager.approveSignerNames[1] | string | `"clusterissuers.cert-manager.io/*"` |  |
| certmanager.extraArgs | list | `[]` |  |
| certmanager.extraEnv | list | `[]` |  |
| certmanager.securityContext.runAsNonRoot | bool | `true` |  |
| certmanager.securityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| certmanager.containerSecurityContext.allowPrivilegeEscalation | bool | `false` |  |
| certmanager.containerSecurityContext.capabilities.drop[0] | string | `"ALL"` |  |
| certmanager.containerSecurityContext.readOnlyRootFilesystem | bool | `true` |  |
| certmanager.volumes | list | `[]` |  |
| certmanager.volumeMounts | list | `[]` |  |
| certmanager.podLabels | object | `{}` |  |
| certmanager.hostAliases | list | `[]` |  |
| certmanager.nodeSelector."kubernetes.io/os" | string | `"linux"` |  |
| certmanager.ingressShim.defaultIssuerKind | string | `"ClusterIssuer"` |  |
| certmanager.ingressShim.defaultIssuerName | string | `"letsencrypt-dns-prd"` |  |
| certmanager.affinity | object | `{}` |  |
| certmanager.tolerations | list | `[]` |  |
| certmanager.topologySpreadConstraints | list | `[]` |  |
| certmanager.livenessProbe.enabled | bool | `true` |  |
| certmanager.livenessProbe.initialDelaySeconds | int | `10` |  |
| certmanager.livenessProbe.periodSeconds | int | `10` |  |
| certmanager.livenessProbe.timeoutSeconds | int | `15` |  |
| certmanager.livenessProbe.successThreshold | int | `1` |  |
| certmanager.livenessProbe.failureThreshold | int | `8` |  |
| certmanager.enableServiceLinks | bool | `false` |  |
| certmanager.prometheus.enabled | bool | `false` |  |
| certmanager.prometheus.servicemonitor.enabled | bool | `false` |  |
| certmanager.prometheus.servicemonitor.prometheusInstance | string | `"prometheus-operator-prometheus"` |  |
| certmanager.resources | object | `{"limits":{"cpu":"50m","memory":"64Mi"},"requests":{"cpu":"10m","memory":"32Mi"}}` | Requests and Limits to apply to the cert-manager pods |
| certmanager.webhook.replicaCount | int | `1` |  |
| certmanager.webhook.timeoutSeconds | int | `30` |  |
| certmanager.webhook.config | object | `{}` |  |
| certmanager.webhook.strategy | object | `{}` |  |
| certmanager.webhook.securityContext.fsGroup | int | `1001` | ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/ |
| certmanager.webhook.securityContext.runAsUser | int | `1001` |  |
| certmanager.webhook.securityContext.runAsNonRoot | bool | `true` |  |
| certmanager.webhook.containerSecurityContext.allowPrivilegeEscalation | bool | `false` |  |
| certmanager.webhook.containerSecurityContext.capabilities.drop[0] | string | `"ALL"` |  |
| certmanager.webhook.containerSecurityContext.readOnlyRootFilesystem | bool | `true` |  |
| certmanager.webhook.podDisruptionBudget.enabled | bool | `false` |  |
| certmanager.webhook.validatingWebhookConfiguration.namespaceSelector.matchExpressions[0].key | string | `"cert-manager.io/disable-validation"` |  |
| certmanager.webhook.validatingWebhookConfiguration.namespaceSelector.matchExpressions[0].operator | string | `"NotIn"` |  |
| certmanager.webhook.validatingWebhookConfiguration.namespaceSelector.matchExpressions[0].values[0] | string | `"true"` |  |
| certmanager.webhook.mutatingWebhookConfiguration.namespaceSelector | object | `{}` |  |
| certmanager.webhook.extraArgs | list | `[]` |  |
| certmanager.webhook.extraEnv | list | `[]` |  |
| certmanager.webhook.featureGates | string | `""` |  |
| certmanager.webhook.resources.requests.cpu | string | `"5m"` |  |
| certmanager.webhook.resources.requests.memory | string | `"5Mi"` |  |
| certmanager.webhook.resources.limits.cpu | string | `"150m"` |  |
| certmanager.webhook.resources.limits.memory | string | `"32Mi"` |  |
| certmanager.webhook.livenessProbe.failureThreshold | int | `3` |  |
| certmanager.webhook.livenessProbe.initialDelaySeconds | int | `60` |  |
| certmanager.webhook.livenessProbe.periodSeconds | int | `10` |  |
| certmanager.webhook.livenessProbe.successThreshold | int | `1` |  |
| certmanager.webhook.livenessProbe.timeoutSeconds | int | `1` |  |
| certmanager.webhook.readinessProbe.failureThreshold | int | `3` |  |
| certmanager.webhook.readinessProbe.initialDelaySeconds | int | `5` |  |
| certmanager.webhook.readinessProbe.periodSeconds | int | `5` |  |
| certmanager.webhook.readinessProbe.successThreshold | int | `1` |  |
| certmanager.webhook.readinessProbe.timeoutSeconds | int | `1` |  |
| certmanager.webhook.nodeSelector."kubernetes.io/os" | string | `"linux"` |  |
| certmanager.webhook.affinity | object | `{}` |  |
| certmanager.webhook.tolerations | list | `[]` |  |
| certmanager.webhook.topologySpreadConstraints | list | `[]` |  |
| certmanager.webhook.podLabels | object | `{}` |  |
| certmanager.webhook.serviceLabels | object | `{}` |  |
| certmanager.webhook.serviceIPFamilyPolicy | string | `""` |  |
| certmanager.webhook.serviceIPFamilies | list | `[]` |  |
| certmanager.webhook.image.repository | string | `"quay.io/jetstack/cert-manager-webhook"` |  |
| certmanager.webhook.image.pullPolicy | string | `"IfNotPresent"` |  |
| certmanager.webhook.serviceAccount.create | bool | `true` |  |
| certmanager.webhook.serviceAccount.name | string | `"cert-manager"` |  |
| certmanager.webhook.serviceAccount.automountServiceAccountToken | bool | `true` |  |
| certmanager.webhook.securePort | int | `10250` |  |
| certmanager.webhook.hostNetwork | bool | `false` |  |
| certmanager.webhook.serviceType | string | `"ClusterIP"` |  |
| certmanager.webhook.url | object | `{}` |  |
| certmanager.webhook.networkPolicy.enabled | bool | `false` |  |
| certmanager.webhook.networkPolicy.ingress[0].from[0].ipBlock.cidr | string | `"0.0.0.0/0"` |  |
| certmanager.webhook.networkPolicy.egress[0].ports[0].port | int | `80` |  |
| certmanager.webhook.networkPolicy.egress[0].ports[0].protocol | string | `"TCP"` |  |
| certmanager.webhook.networkPolicy.egress[0].ports[1].port | int | `443` |  |
| certmanager.webhook.networkPolicy.egress[0].ports[1].protocol | string | `"TCP"` |  |
| certmanager.webhook.networkPolicy.egress[0].ports[2].port | int | `53` |  |
| certmanager.webhook.networkPolicy.egress[0].ports[2].protocol | string | `"TCP"` |  |
| certmanager.webhook.networkPolicy.egress[0].ports[3].port | int | `53` |  |
| certmanager.webhook.networkPolicy.egress[0].ports[3].protocol | string | `"UDP"` |  |
| certmanager.webhook.networkPolicy.egress[0].ports[4].port | int | `6443` |  |
| certmanager.webhook.networkPolicy.egress[0].ports[4].protocol | string | `"TCP"` |  |
| certmanager.webhook.networkPolicy.egress[0].to[0].ipBlock.cidr | string | `"0.0.0.0/0"` |  |
| certmanager.webhook.volumes | list | `[]` |  |
| certmanager.webhook.volumeMounts | list | `[]` |  |
| certmanager.webhook.enableServiceLinks | bool | `false` |  |
| certmanager.cainjector.enabled | bool | `true` |  |
| certmanager.cainjector.replicaCount | int | `1` |  |
| certmanager.cainjector.config | object | `{}` |  |
| certmanager.cainjector.strategy | object | `{}` |  |
| certmanager.cainjector.securityContext.runAsNonRoot | bool | `true` |  |
| certmanager.cainjector.securityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| certmanager.cainjector.containerSecurityContext.allowPrivilegeEscalation | bool | `false` |  |
| certmanager.cainjector.containerSecurityContext.capabilities.drop[0] | string | `"ALL"` |  |
| certmanager.cainjector.containerSecurityContext.readOnlyRootFilesystem | bool | `true` |  |
| certmanager.cainjector.podDisruptionBudget.enabled | bool | `false` |  |
| certmanager.cainjector.extraArgs | list | `[]` |  |
| certmanager.cainjector.extraEnv | list | `[]` |  |
| certmanager.cainjector.featureGates | string | `""` |  |
| certmanager.cainjector.resources | object | `{}` |  |
| certmanager.cainjector.nodeSelector."kubernetes.io/os" | string | `"linux"` |  |
| certmanager.cainjector.affinity | object | `{}` |  |
| certmanager.cainjector.tolerations | list | `[]` |  |
| certmanager.cainjector.topologySpreadConstraints | list | `[]` |  |
| certmanager.cainjector.podLabels | object | `{}` |  |
| certmanager.cainjector.serviceLabels | object | `{}` |  |
| certmanager.cainjector.image.repository | string | `"quay.io/jetstack/cert-manager-cainjector"` |  |
| certmanager.cainjector.image.pullPolicy | string | `"IfNotPresent"` |  |
| certmanager.cainjector.serviceAccount.create | bool | `true` |  |
| certmanager.cainjector.serviceAccount.automountServiceAccountToken | bool | `true` |  |
| certmanager.cainjector.volumes | list | `[]` |  |
| certmanager.cainjector.volumeMounts | list | `[]` |  |
| certmanager.cainjector.enableServiceLinks | bool | `false` |  |
| certmanager.acmesolver.image.repository | string | `"quay.io/jetstack/cert-manager-acmesolver"` |  |
| certmanager.acmesolver.image.pullPolicy | string | `"IfNotPresent"` |  |
| certmanager.startupapicheck.enabled | bool | `true` |  |
| certmanager.startupapicheck.securityContext.runAsNonRoot | bool | `true` |  |
| certmanager.startupapicheck.securityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| certmanager.startupapicheck.containerSecurityContext.allowPrivilegeEscalation | bool | `false` |  |
| certmanager.startupapicheck.containerSecurityContext.capabilities.drop[0] | string | `"ALL"` |  |
| certmanager.startupapicheck.containerSecurityContext.readOnlyRootFilesystem | bool | `true` |  |
| certmanager.startupapicheck.timeout | string | `"1m"` |  |
| certmanager.startupapicheck.backoffLimit | int | `4` |  |
| certmanager.startupapicheck.jobAnnotations."helm.sh/hook" | string | `"post-install"` |  |
| certmanager.startupapicheck.jobAnnotations."helm.sh/hook-weight" | string | `"1"` |  |
| certmanager.startupapicheck.jobAnnotations."helm.sh/hook-delete-policy" | string | `"before-hook-creation,hook-succeeded"` |  |
| certmanager.startupapicheck.extraArgs[0] | string | `"-v"` |  |
| certmanager.startupapicheck.extraEnv | list | `[]` |  |
| certmanager.startupapicheck.resources | object | `{}` |  |
| certmanager.startupapicheck.nodeSelector."kubernetes.io/os" | string | `"linux"` |  |
| certmanager.startupapicheck.affinity | object | `{}` |  |
| certmanager.startupapicheck.tolerations | list | `[]` |  |
| certmanager.startupapicheck.podLabels | object | `{}` |  |
| certmanager.startupapicheck.image.repository | string | `"quay.io/jetstack/cert-manager-startupapicheck"` |  |
| certmanager.startupapicheck.image.pullPolicy | string | `"IfNotPresent"` |  |
| certmanager.startupapicheck.rbac.annotations."helm.sh/hook" | string | `"post-install"` |  |
| certmanager.startupapicheck.rbac.annotations."helm.sh/hook-weight" | string | `"-5"` |  |
| certmanager.startupapicheck.rbac.annotations."helm.sh/hook-delete-policy" | string | `"before-hook-creation,hook-succeeded"` |  |
| certmanager.startupapicheck.serviceAccount.create | bool | `true` |  |
| certmanager.startupapicheck.serviceAccount.annotations."helm.sh/hook" | string | `"post-install"` |  |
| certmanager.startupapicheck.serviceAccount.annotations."helm.sh/hook-weight" | string | `"-5"` |  |
| certmanager.startupapicheck.serviceAccount.annotations."helm.sh/hook-delete-policy" | string | `"before-hook-creation,hook-succeeded"` |  |
| certmanager.startupapicheck.serviceAccount.automountServiceAccountToken | bool | `true` |  |
| certmanager.startupapicheck.volumes | list | `[]` |  |
| certmanager.startupapicheck.volumeMounts | list | `[]` |  |
| certmanager.startupapicheck.enableServiceLinks | bool | `false` |  |
| certmanager.extraObjects | list | `[]` |  |
| certmanager.creator | string | `"helm"` |  |
| certmanager.enabled | bool | `true` |  |
| prometheusRules.rules.enabled | bool | `false` | Enables prometheus operator rules for cert-manager |
| prometheusRules.rules.labels | object | `{"prometheus":"prometheus-operator-prometheus"}` | Labels to affect to the Prometheus Rules |
| issuers | list | Please look at the `values.yaml` file | List of issuers to create. Please read the following [documentation](https://cert-manager.io/docs/concepts/issuer/) |
| certs | list | Please look at the `values.yaml` file | Generate basic certificates |
| tags.configConnector | bool | `false` | Enables Config Connector features |
| iamPolicyMembers.members[0].name | string | `"cert-manager-gsa"` |  |
| iamPolicyMembers.members[0].member | string | `""` |  |
| iamPolicyMembers.members[0].role | string | `"roles/dns.admin"` | Roles to apply to cert-manager google service account |
| iamPolicyMembers.members[0].resourceRef.kind | string | `"Project"` |  |
| iamPolicyMembers.members[0].resourceRef.external | string | `""` |  |
| workloadIdentity.global.gsa.create | bool | `true` |  |
| workloadIdentity.global.gsa.name | string | `"wi-k8s"` |  |
| workloadIdentity.global.gsa.project | string | `""` |  |
| workloadIdentity.global.ksa.namespace | string | `""` |  |
| workloadIdentity.global.ksa.name | string | `"default"` |  |

## Installing the Chart

### With Helm

To install the chart with the release name `my-release`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/cert-manager
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: cert-manager
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.2"
    chart: cert-manager
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
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/cert-manager --config /charts/charts/cert-manager/ct.yaml
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template cert-manager . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```

