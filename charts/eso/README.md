# eso

![Version: 0.1.1](https://img.shields.io/badge/Version-0.1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.14.2](https://img.shields.io/badge/AppVersion-0.14.2-informational?style=flat-square)

## Prerequisites

- Helm v3
- Config Connector installed (v1.6.0)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.external-secrets.io | eso(external-secrets) | 0.14.2 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| wiemaouadi | <wiem.aouadi3@gmail.com> | <https://github.com/wiemaouadi> |
| smileisak | <ikaboubi@gmail.com> | <https://github.com/smileisak> |

## Description

A Helm chart ESO for Kubernetes

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| prometheus.enabled | bool | `false` | Enables Prometheus Operator monitoring |
| prometheus.rules.enabled | bool | `true` | Enables prometheus operator rules |
| prometheus.rules.labels | object | `{"prometheus":"prometheus-operator-prometheus"}` | Labels to affect to the Prometheus Rules |
| prometheus.grafanaDashboard.enabled | bool | `true` | Add grafana dashboard as a configmap |
| prometheus.grafanaDashboard.label | object | `{"grafana_dashboard":"1"}` | label to apply to the config map. Used by Grafana sidecar to automatically install the dashboard |
| eso.replicaCount | int | `1` |  |
| eso.bitwarden-sdk-server.enabled | bool | `false` |  |
| eso.revisionHistoryLimit | int | `10` | Specifies the amount of historic ReplicaSets k8s should keep (see https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#clean-up-policy) |
| eso.image.repository | string | `"oci.external-secrets.io/external-secrets/external-secrets"` |  |
| eso.image.pullPolicy | string | `"IfNotPresent"` |  |
| eso.image.tag | string | `""` | The image tag to use. The default is the chart appVersion. |
| eso.image.flavour | string | `""` | The flavour of tag you want to use There are different image flavours available, like distroless and ubi. Please see GitHub release notes for image tags for these flavors. By default, the distroless image is used. |
| eso.installCRDs | bool | `true` | If set, install and upgrade CRDs through helm chart. |
| eso.crds.createClusterExternalSecret | bool | `true` | If true, create CRDs for Cluster External Secret. |
| eso.crds.createClusterSecretStore | bool | `true` | If true, create CRDs for Cluster Secret Store. |
| eso.crds.createClusterGenerator | bool | `true` | If true, create CRDs for Cluster Generator. |
| eso.crds.createPushSecret | bool | `true` | If true, create CRDs for Push Secret. |
| eso.crds.annotations | object | `{}` |  |
| eso.crds.conversion.enabled | bool | `true` | If webhook is set to false this also needs to be set to false otherwise the kubeapi will be hammered because the conversion is looking for a webhook endpoint. |
| eso.imagePullSecrets | list | `[]` |  |
| eso.nameOverride | string | `""` |  |
| eso.fullnameOverride | string | `""` |  |
| eso.namespaceOverride | string | `""` |  |
| eso.commonLabels | object | `{}` | Additional labels added to all helm chart resources. |
| eso.leaderElect | bool | `false` | If true, external-secrets will perform leader election between instances to ensure no more than one instance of external-secrets operates at a time. |
| eso.controllerClass | string | `""` | If set external secrets will filter matching Secret Stores with the appropriate controller values. |
| eso.extendedMetricLabels | bool | `false` | If true external secrets will use recommended kubernetes annotations as prometheus metric labels. |
| eso.scopedNamespace | string | `""` | If set external secrets are only reconciled in the provided namespace |
| eso.scopedRBAC | bool | `false` | Must be used with scopedNamespace. If true, create scoped RBAC roles under the scoped namespace and implicitly disable cluster stores and cluster external secrets |
| eso.processClusterExternalSecret | bool | `true` | if true, the operator will process cluster external secret. Else, it will ignore them. |
| eso.processClusterStore | bool | `true` | if true, the operator will process cluster store. Else, it will ignore them. |
| eso.processPushSecret | bool | `true` | if true, the operator will process push secret. Else, it will ignore them. |
| eso.createOperator | bool | `true` | Specifies whether an external secret operator deployment be created. |
| eso.concurrent | int | `1` | Specifies the number of concurrent ExternalSecret Reconciles external-secret executes at a time. |
| eso.log | object | `{"level":"info","timeEncoding":"epoch"}` | Specifices Log Params to the External Secrets Operator |
| eso.service.ipFamilyPolicy | string | `""` | Set the ip family policy to configure dual-stack see [Configure dual-stack](https://kubernetes.io/docs/concepts/services-networking/dual-stack/#services) |
| eso.service.ipFamilies | list | `[]` | Sets the families that should be supported and the order in which they should be applied to ClusterIP as well. Can be IPv4 and/or IPv6. |
| eso.serviceAccount.create | bool | `true` | Specifies whether a service account should be created. |
| eso.serviceAccount.automount | bool | `true` | Automounts the service account token in all containers of the pod |
| eso.serviceAccount.annotations | object | `{}` | Annotations to add to the service account. |
| eso.serviceAccount.extraLabels | object | `{}` | Extra Labels to add to the service account. |
| eso.serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template. |
| eso.rbac.create | bool | `true` | Specifies whether role and rolebinding resources should be created. |
| eso.rbac.servicebindings.create | bool | `true` | Specifies whether a clusterrole to give servicebindings read access should be created. |
| eso.extraEnv | list | `[]` |  |
| eso.extraArgs | object | `{}` |  |
| eso.extraVolumes | list | `[]` |  |
| eso.extraObjects | list | `[]` |  |
| eso.extraVolumeMounts | list | `[]` |  |
| eso.extraContainers | list | `[]` |  |
| eso.deploymentAnnotations | object | `{}` | Annotations to add to Deployment |
| eso.podAnnotations | object | `{}` | Annotations to add to Pod |
| eso.podLabels | object | `{}` |  |
| eso.podSecurityContext.enabled | bool | `true` |  |
| eso.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| eso.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| eso.securityContext.enabled | bool | `true` |  |
| eso.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| eso.securityContext.runAsNonRoot | bool | `true` |  |
| eso.securityContext.runAsUser | int | `1000` |  |
| eso.securityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| eso.resources | object | `{}` |  |
| eso.serviceMonitor.enabled | bool | `false` | Specifies whether to create a ServiceMonitor resource for collecting Prometheus metrics |
| eso.serviceMonitor.namespace | string | `""` | namespace where you want to install ServiceMonitors |
| eso.serviceMonitor.additionalLabels | object | `{}` | Additional labels |
| eso.serviceMonitor.interval | string | `"30s"` | Interval to scrape metrics |
| eso.serviceMonitor.scrapeTimeout | string | `"25s"` | Timeout if metrics can't be retrieved in given time interval |
| eso.serviceMonitor.honorLabels | bool | `false` | Let prometheus add an exported_ prefix to conflicting labels |
| eso.serviceMonitor.metricRelabelings | list | `[]` | Metric relabel configs to apply to samples before ingestion. [Metric Relabeling](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs) |
| eso.serviceMonitor.relabelings | list | `[]` | Relabel configs to apply to samples before ingestion. [Relabeling](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config) |
| eso.metrics.listen.port | int | `8080` |  |
| eso.metrics.service.enabled | bool | `false` | Enable if you use another monitoring tool than Prometheus to scrape the metrics |
| eso.metrics.service.port | int | `8080` | Metrics service port to scrape |
| eso.metrics.service.annotations | object | `{}` | Additional service annotations |
| eso.nodeSelector | object | `{}` |  |
| eso.tolerations | list | `[]` |  |
| eso.topologySpreadConstraints | list | `[]` |  |
| eso.affinity | object | `{}` |  |
| eso.priorityClassName | string | `""` | Pod priority class name. |
| eso.podDisruptionBudget | object | `{"enabled":false,"minAvailable":1}` | Pod disruption budget - for more details see https://kubernetes.io/docs/concepts/workloads/pods/disruptions/ |
| eso.hostNetwork | bool | `false` | Run the controller on the host network |
| eso.webhook.create | bool | `true` | Specifies whether a webhook deployment be created. |
| eso.webhook.certCheckInterval | string | `"5m"` | Specifices the time to check if the cert is valid |
| eso.webhook.lookaheadInterval | string | `""` | Specifices the lookaheadInterval for certificate validity |
| eso.webhook.replicaCount | int | `1` |  |
| eso.webhook.log | object | `{"level":"info","timeEncoding":"epoch"}` | Specifices Log Params to the Webhook |
| eso.webhook.revisionHistoryLimit | int | `10` | Specifies the amount of historic ReplicaSets k8s should keep (see https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#clean-up-policy) |
| eso.webhook.certDir | string | `"/tmp/certs"` |  |
| eso.webhook.failurePolicy | string | `"Fail"` | Specifies whether validating webhooks should be created with failurePolicy: Fail or Ignore |
| eso.webhook.hostNetwork | bool | `false` | Specifies if webhook pod should use hostNetwork or not. |
| eso.webhook.image.repository | string | `"oci.external-secrets.io/external-secrets/external-secrets"` |  |
| eso.webhook.image.pullPolicy | string | `"IfNotPresent"` |  |
| eso.webhook.image.tag | string | `""` | The image tag to use. The default is the chart appVersion. |
| eso.webhook.image.flavour | string | `""` | The flavour of tag you want to use |
| eso.webhook.imagePullSecrets | list | `[]` |  |
| eso.webhook.nameOverride | string | `""` |  |
| eso.webhook.fullnameOverride | string | `""` |  |
| eso.webhook.port | int | `10250` | The port the webhook will listen to |
| eso.webhook.rbac.create | bool | `true` | Specifies whether role and rolebinding resources should be created. |
| eso.webhook.serviceAccount.create | bool | `true` | Specifies whether a service account should be created. |
| eso.webhook.serviceAccount.automount | bool | `true` | Automounts the service account token in all containers of the pod |
| eso.webhook.serviceAccount.annotations | object | `{}` | Annotations to add to the service account. |
| eso.webhook.serviceAccount.extraLabels | object | `{}` | Extra Labels to add to the service account. |
| eso.webhook.serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template. |
| eso.webhook.nodeSelector | object | `{}` |  |
| eso.webhook.certManager.enabled | bool | `false` | Enabling cert-manager support will disable the built in secret and switch to using cert-manager (installed separately) to automatically issue and renew the webhook certificate. This chart does not install cert-manager for you, See https://cert-manager.io/docs/ |
| eso.webhook.certManager.addInjectorAnnotations | bool | `true` | Automatically add the cert-manager.io/inject-ca-from annotation to the webhooks and CRDs. As long as you have the cert-manager CA Injector enabled, this will automatically setup your webhook's CA to the one used by cert-manager. See https://cert-manager.io/docs/concepts/ca-injector |
| eso.webhook.certManager.cert.create | bool | `true` | Create a certificate resource within this chart. See https://cert-manager.io/docs/usage/certificate/ |
| eso.webhook.certManager.cert.issuerRef | object | `{"group":"cert-manager.io","kind":"Issuer","name":"my-issuer"}` | For the Certificate created by this chart, setup the issuer. See https://cert-manager.io/docs/reference/api-docs/#cert-manager.io/v1.IssuerSpec |
| eso.webhook.certManager.cert.duration | string | `"8760h"` | Set the requested duration (i.e. lifetime) of the Certificate. See https://cert-manager.io/docs/reference/api-docs/#cert-manager.io/v1.CertificateSpec One year by default. |
| eso.webhook.certManager.cert.revisionHistoryLimit | string | `""` | Set the revisionHistoryLimit on the Certificate. See https://cert-manager.io/docs/reference/api-docs/#cert-manager.io/v1.CertificateSpec Defaults to nil. |
| eso.webhook.certManager.cert.renewBefore | string | `""` | How long before the currently issued certificate’s expiry cert-manager should renew the certificate. See https://cert-manager.io/docs/reference/api-docs/#cert-manager.io/v1.CertificateSpec Note that renewBefore should be greater than .webhook.lookaheadInterval since the webhook will check this far in advance that the certificate is valid. |
| eso.webhook.certManager.cert.annotations | object | `{}` | Add extra annotations to the Certificate resource. |
| eso.webhook.tolerations | list | `[]` |  |
| eso.webhook.topologySpreadConstraints | list | `[]` |  |
| eso.webhook.affinity | object | `{}` |  |
| eso.webhook.priorityClassName | string | `""` | Pod priority class name. |
| eso.webhook.podDisruptionBudget | object | `{"enabled":false,"minAvailable":1}` | Pod disruption budget - for more details see https://kubernetes.io/docs/concepts/workloads/pods/disruptions/ |
| eso.webhook.metrics.listen.port | int | `8080` |  |
| eso.webhook.metrics.service.enabled | bool | `false` | Enable if you use another monitoring tool than Prometheus to scrape the metrics |
| eso.webhook.metrics.service.port | int | `8080` | Metrics service port to scrape |
| eso.webhook.metrics.service.annotations | object | `{}` | Additional service annotations |
| eso.webhook.readinessProbe.address | string | `""` | Address for readiness probe |
| eso.webhook.readinessProbe.port | int | `8081` | ReadinessProbe port for kubelet |
| eso.webhook.extraEnv | list | `[]` |  |
| eso.webhook.extraArgs | object | `{}` |  |
| eso.webhook.extraVolumes | list | `[]` |  |
| eso.webhook.extraVolumeMounts | list | `[]` |  |
| eso.webhook.secretAnnotations | object | `{}` | Annotations to add to Secret |
| eso.webhook.deploymentAnnotations | object | `{}` | Annotations to add to Deployment |
| eso.webhook.podAnnotations | object | `{}` | Annotations to add to Pod |
| eso.webhook.podLabels | object | `{}` |  |
| eso.webhook.podSecurityContext.enabled | bool | `true` |  |
| eso.webhook.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| eso.webhook.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| eso.webhook.securityContext.enabled | bool | `true` |  |
| eso.webhook.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| eso.webhook.securityContext.runAsNonRoot | bool | `true` |  |
| eso.webhook.securityContext.runAsUser | int | `1000` |  |
| eso.webhook.securityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| eso.webhook.resources | object | `{}` |  |
| eso.webhook.service | object | `{"annotations":{},"enabled":true,"labels":{},"loadBalancerIP":"","type":"ClusterIP"}` | Manage the service through which the webhook is reached. |
| eso.webhook.service.enabled | bool | `true` | Whether the service object should be enabled or not (it is expected to exist). |
| eso.webhook.service.annotations | object | `{}` | Custom annotations for the webhook service. |
| eso.webhook.service.labels | object | `{}` | Custom labels for the webhook service. |
| eso.webhook.service.type | string | `"ClusterIP"` | The service type of the webhook service. |
| eso.webhook.service.loadBalancerIP | string | `""` | If the webhook service type is LoadBalancer, you can assign a specific load balancer IP here. Check the documentation of your load balancer provider to see if/how this should be used. |
| eso.certController.create | bool | `true` | Specifies whether a certificate controller deployment be created. |
| eso.certController.requeueInterval | string | `"5m"` |  |
| eso.certController.replicaCount | int | `1` |  |
| eso.certController.log | object | `{"level":"info","timeEncoding":"epoch"}` | Specifices Log Params to the Certificate Controller |
| eso.certController.revisionHistoryLimit | int | `10` | Specifies the amount of historic ReplicaSets k8s should keep (see https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#clean-up-policy) |
| eso.certController.image.repository | string | `"oci.external-secrets.io/external-secrets/external-secrets"` |  |
| eso.certController.image.pullPolicy | string | `"IfNotPresent"` |  |
| eso.certController.image.tag | string | `""` |  |
| eso.certController.image.flavour | string | `""` |  |
| eso.certController.imagePullSecrets | list | `[]` |  |
| eso.certController.nameOverride | string | `""` |  |
| eso.certController.fullnameOverride | string | `""` |  |
| eso.certController.rbac.create | bool | `true` | Specifies whether role and rolebinding resources should be created. |
| eso.certController.serviceAccount.create | bool | `true` | Specifies whether a service account should be created. |
| eso.certController.serviceAccount.automount | bool | `true` | Automounts the service account token in all containers of the pod |
| eso.certController.serviceAccount.annotations | object | `{}` | Annotations to add to the service account. |
| eso.certController.serviceAccount.extraLabels | object | `{}` | Extra Labels to add to the service account. |
| eso.certController.serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template. |
| eso.certController.nodeSelector | object | `{}` |  |
| eso.certController.tolerations | list | `[]` |  |
| eso.certController.topologySpreadConstraints | list | `[]` |  |
| eso.certController.affinity | object | `{}` |  |
| eso.certController.hostNetwork | bool | `false` | Run the certController on the host network |
| eso.certController.priorityClassName | string | `""` | Pod priority class name. |
| eso.certController.podDisruptionBudget | object | `{"enabled":false,"minAvailable":1}` | Pod disruption budget - for more details see https://kubernetes.io/docs/concepts/workloads/pods/disruptions/ |
| eso.certController.metrics.listen.port | int | `8080` |  |
| eso.certController.metrics.service.enabled | bool | `false` | Enable if you use another monitoring tool than Prometheus to scrape the metrics |
| eso.certController.metrics.service.port | int | `8080` | Metrics service port to scrape |
| eso.certController.metrics.service.annotations | object | `{}` | Additional service annotations |
| eso.certController.readinessProbe.address | string | `""` | Address for readiness probe |
| eso.certController.readinessProbe.port | int | `8081` | ReadinessProbe port for kubelet |
| eso.certController.extraEnv | list | `[]` |  |
| eso.certController.extraArgs | object | `{}` |  |
| eso.certController.extraVolumes | list | `[]` |  |
| eso.certController.extraVolumeMounts | list | `[]` |  |
| eso.certController.deploymentAnnotations | object | `{}` | Annotations to add to Deployment |
| eso.certController.podAnnotations | object | `{}` | Annotations to add to Pod |
| eso.certController.podLabels | object | `{}` |  |
| eso.certController.podSecurityContext.enabled | bool | `true` |  |
| eso.certController.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| eso.certController.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| eso.certController.securityContext.enabled | bool | `true` |  |
| eso.certController.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| eso.certController.securityContext.runAsNonRoot | bool | `true` |  |
| eso.certController.securityContext.runAsUser | int | `1000` |  |
| eso.certController.securityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| eso.certController.resources | object | `{}` |  |
| eso.dnsPolicy | string | `"ClusterFirst"` | Specifies `dnsPolicy` to deployment |
| eso.dnsConfig | object | `{}` | Specifies `dnsOptions` to deployment |
| eso.podSpecExtra | object | `{}` | Any extra pod spec on the deployment |

## Installing the Chart

### With Helm

To install the chart with the release name `my-release`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/eso
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: eso
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.1"
    chart: eso
    path: ''

    helm:

      values: |
        name: mysa

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
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/eso --config /charts/charts/eso/ct.yaml
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template eso . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```

