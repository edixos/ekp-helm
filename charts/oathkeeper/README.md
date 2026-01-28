# oathkeeper

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v25.4.0](https://img.shields.io/badge/AppVersion-v25.4.0-informational?style=flat-square)

## Prerequisites

- Helm v3
- Config Connector installed (v1.6.0)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://k8s.ory.sh/helm/charts | oathkeeper(oathkeeper) | 0.60.1 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| hamzatalbi | <hamzatalbi831@gmail.com> | <https://github.com/TalbiHamza> |

## Description

A Helm chart for Kubernetes

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| oathkeeper.affinity | object | `{}` | Configure node affinity |
| oathkeeper.configmap.hashSumEnabled | bool | `true` | switch to false to prevent checksum annotations being maintained and propogated to the pods |
| oathkeeper.demo | bool | `false` | If enabled, a demo deployment with exemplary access rules and JSON Web Key Secrets will be generated. |
| oathkeeper.deployment.annotations | object | `{}` |  |
| oathkeeper.deployment.automountServiceAccountToken | bool | `true` |  |
| oathkeeper.deployment.autoscaling | object | `{"behavior":{},"enabled":false,"extraMetrics":[],"maxReplicas":5,"minReplicas":1,"targetCPU":{},"targetMemory":{}}` | Configure horizontal pod autoscaler for deployment |
| oathkeeper.deployment.autoscaling.behavior | object | `{}` | Set custom behavior https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/#configurable-scaling-behavior |
| oathkeeper.deployment.autoscaling.extraMetrics | list | `[]` | Add extraContainer container resource metrics https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/#container-resource-metrics |
| oathkeeper.deployment.customLivenessProbe | object | `{}` | Configure a custom livenessProbe. This overwrites the default object |
| oathkeeper.deployment.customReadinessProbe | object | `{}` | Configure a custom readinessProbe. This overwrites the default object |
| oathkeeper.deployment.customStartupProbe | object | `{}` | Configure a custom startupProbe. This overwrites the default object |
| oathkeeper.deployment.dnsConfig | object | `{}` | Configure pod dnsConfig. |
| oathkeeper.deployment.extraArgs | list | `[]` | Array of extra arguments to be passed down to the Deployment. Kubernetes args format is expected |
| oathkeeper.deployment.extraContainers | string | `""` | If you want to add extra sidecar containers. |
| oathkeeper.deployment.extraEnv | list | `[]` | Array of extra envs to be passed to the deployment. Kubernetes format is expected. Value is processed with Helm `tpl` - name: FOO   value: BAR |
| oathkeeper.deployment.extraInitContainers | string | `""` | If you want to add extra init containers. |
| oathkeeper.deployment.extraVolumeMounts | list | `[]` | Extra volume mounts, allows mounting the extraVolumes to the container. |
| oathkeeper.deployment.extraVolumes | list | `[]` | Extra volumes you can attach to the pod. |
| oathkeeper.deployment.labels | object | `{}` |  |
| oathkeeper.deployment.lifecycle | object | `{}` |  |
| oathkeeper.deployment.nodeSelector | object | `{}` | Node labels for pod assignment. |
| oathkeeper.deployment.podMetadata | object | `{"annotations":{},"labels":{}}` | Specify pod metadata, this metadata is added directly to the pod, and not higher objects |
| oathkeeper.deployment.podMetadata.annotations | object | `{}` | Extra pod level annotations |
| oathkeeper.deployment.podMetadata.labels | object | `{}` | Extra pod level labels |
| oathkeeper.deployment.readinessProbe | object | `{"failureThreshold":5,"initialDelaySeconds":5,"periodSeconds":10}` | Configure the readinessProbe parameters |
| oathkeeper.deployment.resources | object | `{}` |  |
| oathkeeper.deployment.serviceAccount | object | `{"annotations":{},"create":true,"name":""}` | Specify the serviceAccountName value. In some situations it is needed to provides specific permissions to Hydra deployments Like for example installing Hydra on a cluster with a PosSecurityPolicy and Istio. Uncoment if it is needed to provide a ServiceAccount for the Hydra deployment.** |
| oathkeeper.deployment.serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| oathkeeper.deployment.serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| oathkeeper.deployment.serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| oathkeeper.deployment.startupProbe | object | `{"failureThreshold":5,"initialDelaySeconds":1,"successThreshold":1,"timeoutSeconds":2}` | Configure the startupProbe parameters |
| oathkeeper.deployment.strategy.rollingUpdate | object | `{}` |  |
| oathkeeper.deployment.strategy.type | string | `"RollingUpdate"` |  |
| oathkeeper.deployment.terminationGracePeriodSeconds | int | `60` |  |
| oathkeeper.deployment.tolerations | list | `[]` | Configure node tolerations. |
| oathkeeper.deployment.topologySpreadConstraints | list | `[]` | Configure pod topologySpreadConstraints. |
| oathkeeper.fullnameOverride | string | `""` | Full chart name override |
| oathkeeper.global | object | `{"ory":{"oathkeeper":{"maester":{"mode":"controller"}}},"podMetadata":{"annotations":{},"labels":{}}}` | Global setting, passed down to all pods |
| oathkeeper.global.podMetadata | object | `{"annotations":{},"labels":{}}` | Specify pod metadata, this metadata is added directly to the pod, and not higher objects |
| oathkeeper.global.podMetadata.annotations | object | `{}` | Extra pod level annotations |
| oathkeeper.global.podMetadata.labels | object | `{}` | Extra pod level labels |
| oathkeeper.image.initContainer | object | `{"repository":"busybox","tag":1}` | use a busybox image from another repository |
| oathkeeper.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| oathkeeper.image.repository | string | `"oryd/oathkeeper"` | ORY Oathkeeper image |
| oathkeeper.image.tag | string | `"v25.4.0"` | ORY Oathkeeper version |
| oathkeeper.imagePullSecrets | list | `[]` | Image pull secrets |
| oathkeeper.ingress.api.annotations | object | `{}` |  |
| oathkeeper.ingress.api.className | string | `""` |  |
| oathkeeper.ingress.api.enabled | bool | `false` | En-/Disable the api ingress. |
| oathkeeper.ingress.api.hosts[0].host | string | `"api.oathkeeper.localhost"` |  |
| oathkeeper.ingress.api.hosts[0].paths[0].path | string | `"/"` |  |
| oathkeeper.ingress.api.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| oathkeeper.ingress.proxy | object | `{"annotations":{},"className":"","defaultBackend":{},"enabled":false,"hosts":[{"host":"proxy.oathkeeper.localhost","paths":[{"path":"/","pathType":"ImplementationSpecific"}]}]}` | Configure ingress for the proxy port. |
| oathkeeper.ingress.proxy.defaultBackend | object | `{}` | Configuration for custom default service. This service will be used to handle the response when the configured service in the Ingress rule does not have any active endpoints |
| oathkeeper.ingress.proxy.enabled | bool | `false` | En-/Disable the proxy ingress. |
| oathkeeper.maester.enabled | bool | `false` |  |
| oathkeeper.nameOverride | string | `""` | Chart name override |
| oathkeeper.oathkeeper.accessRules | string | `""` | If set, uses the given access rules. |
| oathkeeper.oathkeeper.accessRulesOverride | object | `{"nameOverride":""}` | Enables frontloading oathkeeper rules using an existing CM, or changing the name of the generated one |
| oathkeeper.oathkeeper.accessRulesOverride.nameOverride | string | `""` | Change the name of the configmap or specify the name of an existing configmap to be used |
| oathkeeper.oathkeeper.config | object | `{"access_rules":{"repositories":["file:///etc/rules/access-rules.json"]},"serve":{"api":{"port":4456},"prometheus":{"port":9000},"proxy":{"port":4455}}}` | The ORY Oathkeeper configuration. For a full list of available settings, check:   https://github.com/ory/oathkeeper/blob/master/docs/config.yaml |
| oathkeeper.oathkeeper.configFileOverride | object | `{"enabled":true,"nameOverride":""}` | Enables frontloading oathkeeper config using an existing CM, or changing the name of the generated one |
| oathkeeper.oathkeeper.configFileOverride.enabled | bool | `true` | Enable/Disable the creation of the config ConfigMap |
| oathkeeper.oathkeeper.configFileOverride.nameOverride | string | `""` | Change the name of the configmap or specify the name of an existing configmap to be used |
| oathkeeper.oathkeeper.helmTemplatedConfigEnabled | bool | `false` | Runs the `tpl` function on the config object. Warrning! This may break configuration settings that use go templates, like https://github.com/ory/k8s/issues/707 |
| oathkeeper.oathkeeper.managedAccessRules | bool | `true` | If you enable maester, the following value should be set to "false" to avoid overwriting the rules generated by the CDRs. Additionally, the value "accessRules" shouldn't be used as it will have no effect once "managedAccessRules" is disabled. |
| oathkeeper.oathkeeper.mutatorIdTokenJWKs | string | `""` | If set, uses the given JSON Web Key Set as the signing key for the ID Token Mutator. Requires secret.enabled to be set `true`. |
| oathkeeper.pdb.enabled | bool | `false` |  |
| oathkeeper.pdb.spec.maxUnavailable | string | `""` |  |
| oathkeeper.pdb.spec.minAvailable | string | `""` |  |
| oathkeeper.podSecurityContext.fsGroup | int | `65534` |  |
| oathkeeper.podSecurityContext.fsGroupChangePolicy | string | `"OnRootMismatch"` |  |
| oathkeeper.podSecurityContext.runAsGroup | int | `65534` |  |
| oathkeeper.podSecurityContext.runAsNonRoot | bool | `true` |  |
| oathkeeper.podSecurityContext.runAsUser | int | `65534` |  |
| oathkeeper.podSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| oathkeeper.priorityClassName | string | `""` | Pod priority https://kubernetes.io/docs/concepts/configuration/pod-priority-preemption/ |
| oathkeeper.replicaCount | int | `1` | Number of ORY Oathkeeper members |
| oathkeeper.revisionHistoryLimit | int | `5` | Number of revisions kept in history |
| oathkeeper.secret.enableDefaultAnnotations | bool | `true` | enableDefaultAnnotations set to `true` will add default annotations to the secret. As such the Secret will be managed by helm hooks. |
| oathkeeper.secret.enabled | bool | `false` | Switch to false to prevent using mutatorIdTokenJWKs secret |
| oathkeeper.secret.extraAnnotations | object | `{}` | extraAnnotations to be added to secret. |
| oathkeeper.secret.filename | string | `"mutator.id_token.jwks.json"` | default filename of JWKS (mounted as secret) |
| oathkeeper.secret.hashSumEnabled | bool | `true` | switch to false to prevent checksum annotations being maintained and propogated to the pods |
| oathkeeper.secret.mountPath | string | `"/etc/secrets"` | default mount path for the kubernetes secret |
| oathkeeper.secret.nameOverride | string | `""` | Provide custom name of existing secret if oathkeeper.mutatorIdTokenJWKs is left empty, or custom name of secret to be created |
| oathkeeper.secret.secretAnnotations | object | `{"helm.sh/hook":"pre-install, pre-upgrade","helm.sh/hook-delete-policy":"before-hook-creation","helm.sh/hook-weight":"0","helm.sh/resource-policy":"keep"}` | Annotations to be added to secret. Annotations are added only when secret is being created. Existing secret will not be modified. |
| oathkeeper.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| oathkeeper.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| oathkeeper.securityContext.privileged | bool | `false` |  |
| oathkeeper.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| oathkeeper.securityContext.runAsGroup | int | `65534` |  |
| oathkeeper.securityContext.runAsNonRoot | bool | `true` |  |
| oathkeeper.securityContext.runAsUser | int | `65534` |  |
| oathkeeper.securityContext.seLinuxOptions.level | string | `"s0:c123,c456"` |  |
| oathkeeper.securityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| oathkeeper.service.api | object | `{"annotations":{},"enabled":true,"externalTrafficPolicy":"","internalTrafficPolicy":"","labels":{},"loadBalancerIP":"","name":"http","port":4456,"type":"ClusterIP"}` | Configures the Kubernetes service for the api port. |
| oathkeeper.service.api.annotations | object | `{}` | If you do want to specify annotations, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'annotations:'. kubernetes.io/ingress.class: nginx kubernetes.io/tls-acme: "true" |
| oathkeeper.service.api.enabled | bool | `true` | En-/disable the service |
| oathkeeper.service.api.externalTrafficPolicy | string | `""` | https://kubernetes.io/docs/reference/networking/virtual-ips/#traffic-policies |
| oathkeeper.service.api.internalTrafficPolicy | string | `""` | https://kubernetes.io/docs/reference/networking/virtual-ips/#traffic-policies |
| oathkeeper.service.api.labels | object | `{}` | If you do want to specify additional labels, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'labels:'. e.g.  app: oathkeeper |
| oathkeeper.service.api.loadBalancerIP | string | `""` | The load balancer IP |
| oathkeeper.service.api.name | string | `"http"` | The service port name. Useful to set a custom service port name if it must follow a scheme (e.g. Istio) |
| oathkeeper.service.api.port | int | `4456` | The service port |
| oathkeeper.service.api.type | string | `"ClusterIP"` | The service type |
| oathkeeper.service.metrics | object | `{"annotations":{},"enabled":true,"labels":{},"loadBalancerIP":"","name":"http","port":80,"type":"ClusterIP"}` | Configures the Kubernetes service for the metrics port. |
| oathkeeper.service.metrics.annotations | object | `{}` | If you do want to specify annotations, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'annotations:'. kubernetes.io/ingress.class: nginx kubernetes.io/tls-acme: "true" |
| oathkeeper.service.metrics.enabled | bool | `true` | En-/disable the service |
| oathkeeper.service.metrics.labels | object | `{}` | If you do want to specify additional labels, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'labels:'. e.g.  app: oathkeeper |
| oathkeeper.service.metrics.loadBalancerIP | string | `""` | Load balancer IP |
| oathkeeper.service.metrics.name | string | `"http"` | The service port name. Useful to set a custom service port name if it must follow a scheme (e.g. Istio) |
| oathkeeper.service.metrics.port | int | `80` | The service port |
| oathkeeper.service.metrics.type | string | `"ClusterIP"` | The service type |
| oathkeeper.service.proxy | object | `{"annotations":{},"enabled":true,"externalTrafficPolicy":"","internalTrafficPolicy":"","labels":{},"loadBalancerIP":"","name":"http","port":4455,"type":"ClusterIP"}` | Configures the Kubernetes service for the proxy port. |
| oathkeeper.service.proxy.annotations | object | `{}` | If you do want to specify annotations, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'annotations:'. kubernetes.io/ingress.class: nginx kubernetes.io/tls-acme: "true" |
| oathkeeper.service.proxy.enabled | bool | `true` | En-/disable the service |
| oathkeeper.service.proxy.externalTrafficPolicy | string | `""` | https://kubernetes.io/docs/reference/networking/virtual-ips/#traffic-policies |
| oathkeeper.service.proxy.internalTrafficPolicy | string | `""` | https://kubernetes.io/docs/reference/networking/virtual-ips/#traffic-policies |
| oathkeeper.service.proxy.labels | object | `{}` | If you do want to specify additional labels, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'labels:'. e.g.  app: oathkeeper |
| oathkeeper.service.proxy.loadBalancerIP | string | `""` | The load balancer IP |
| oathkeeper.service.proxy.name | string | `"http"` | The service port name. Useful to set a custom service port name if it must follow a scheme (e.g. Istio) |
| oathkeeper.service.proxy.port | int | `4455` | The service port |
| oathkeeper.service.proxy.type | string | `"ClusterIP"` | The service type |
| oathkeeper.serviceMonitor.enabled | bool | `false` | switch to true to enable creating the ServiceMonitor |
| oathkeeper.serviceMonitor.labels | object | `{}` | Provide additional labels to the ServiceMonitor resource metadata |
| oathkeeper.serviceMonitor.metricRelabelings | list | `[]` | Provide additional metricRelabelings to apply to samples before ingestion. |
| oathkeeper.serviceMonitor.relabelings | list | `[]` | Provide additional relabelings to apply to samples before scraping |
| oathkeeper.serviceMonitor.scheme | string | `"http"` | HTTP scheme to use for scraping. |
| oathkeeper.serviceMonitor.scrapeInterval | string | `"60s"` | Interval at which metrics should be scraped |
| oathkeeper.serviceMonitor.scrapeTimeout | string | `"30s"` | Timeout after which the scrape is ended |
| oathkeeper.serviceMonitor.targetLabels | list | `[]` | Additional metric labels |
| oathkeeper.serviceMonitor.tlsConfig | object | `{}` | TLS configuration to use when scraping the endpoint |
| oathkeeper.sidecar.envs | object | `{}` |  |
| oathkeeper.sidecar.image.repository | string | `"oryd/oathkeeper-maester"` |  |
| oathkeeper.sidecar.image.tag | string | `"v0.1.12"` |  |
| oathkeeper.test.busybox | object | `{"repository":"busybox","tag":1}` | use a busybox image from another repository |
| oathkeeper.test.labels | object | `{}` | Provide additional labels to the test pod |
| prometheus.enabled | bool | `false` | Enables Prometheus Operator monitoring |
| prometheus.grafanaDashboard.enabled | bool | `false` | Add grafana dashboard as a configmap |
| prometheus.grafanaDashboard.label | object | `{"grafana_dashboard":"1"}` | label to apply to the config map. Used by Grafana sidecar to automatically install the dashboard |
| prometheus.rules.enabled | bool | `false` | Enables prometheus operator rules |
| prometheus.rules.labels | object | `{"prometheus":"prometheus-operator-prometheus"}` | Labels to affect to the Prometheus Rules |

## Installing the Chart

### With Helm

To install the chart with the release name `my-release`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/oathkeeper
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: oathkeeper
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.0"
    chart: oathkeeper
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
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/oathkeeper --config /charts/charts/oathkeeper/ct.yaml
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template oathkeeper . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```

