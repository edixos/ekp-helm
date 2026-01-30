# keto

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![AppVersion: v25.4.0](https://img.shields.io/badge/AppVersion-v25.4.0-informational?style=flat-square)

## Prerequisites

- Helm v3
- Config Connector installed (v1.6.0)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://k8s.ory.sh/helm/charts | keto(keto) | 0.60.1 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| hamzatalbi | <hamzatalbi831@gmail.com> | <https://github.com/TalbiHamza> |

## Description

A Helm chart for Kubernetes

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| keto.configmap.hashSumEnabled | bool | `true` | switch to false to prevent checksum annotations being maintained and propogated to the pods |
| keto.deployment.affinity | object | `{}` |  |
| keto.deployment.annotations | object | `{}` |  |
| keto.deployment.automigration | object | `{"extraEnv":[]}` | Parameters for the automigration initContainer |
| keto.deployment.automigration.extraEnv | list | `[]` | Array of extra envs to be passed to the initContainer. Kubernetes format is expected. Value is processed with Helm `tpl` - name: FOO   value: BAR |
| keto.deployment.automountServiceAccountToken | bool | `true` |  |
| keto.deployment.autoscaling | object | `{"behavior":{},"enabled":false,"extraMetrics":[],"maxReplicas":100,"minReplicas":1,"targetCPU":{},"targetMemory":{}}` | Autoscaling for keto deployment |
| keto.deployment.autoscaling.behavior | object | `{}` | Set custom behavior https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/#configurable-scaling-behavior |
| keto.deployment.autoscaling.extraMetrics | list | `[]` | Add extraContainer container resource metrics https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/#container-resource-metrics |
| keto.deployment.customLivenessProbe | object | `{}` |  |
| keto.deployment.customReadinessProbe | object | `{}` |  |
| keto.deployment.customStartupProbe | object | `{}` |  |
| keto.deployment.dnsConfig | object | `{}` | Configure pod dnsConfig. |
| keto.deployment.extraContainers | string | `""` | If you want to add extra sidecar containers. |
| keto.deployment.extraEnv | list | `[]` | Array of extra Envs to be added to the deployment. Kubernetes format expected. Value is processed with Helm `tpl` - name: FOO   value: BAR |
| keto.deployment.extraInitContainers | object | `{}` | If you want to add extra init containers. These are processed before the migration init container. |
| keto.deployment.extraLabels | object | `{}` | Extra labels to be added to the deployment, and pods. K8s object format expected foo: bar my.special.label/type: value |
| keto.deployment.extraPorts | list | `[]` | Extra ports to be exposed by the main deployment |
| keto.deployment.extraVolumeMounts | list | `[]` | Array of extra VolumeMounts to be added to the deployment. K8s format expected - name: my-volume   mountPath: /etc/secrets/my-secret   readOnly: true |
| keto.deployment.extraVolumes | list | `[]` | Array of extra Volumes to be added to the deployment. K8s format expected - name: my-volume   secret:     secretName: my-secret |
| keto.deployment.lifecycle | object | `{}` |  |
| keto.deployment.minReadySeconds | int | `0` |  |
| keto.deployment.nodeSelector | object | `{}` |  |
| keto.deployment.podAnnotations | object | `{}` |  |
| keto.deployment.podMetadata.annotations | object | `{}` |  |
| keto.deployment.podMetadata.labels | object | `{}` |  |
| keto.deployment.podSecurityContext | object | `{}` |  |
| keto.deployment.readinessProbe.failureThreshold | int | `5` |  |
| keto.deployment.readinessProbe.initialDelaySeconds | int | `5` |  |
| keto.deployment.readinessProbe.periodSeconds | int | `10` |  |
| keto.deployment.resources | object | `{}` |  |
| keto.deployment.revisionHistoryLimit | int | `5` | Number of revisions kept in history |
| keto.deployment.startupProbe.failureThreshold | int | `5` |  |
| keto.deployment.startupProbe.initialDelaySeconds | int | `1` |  |
| keto.deployment.startupProbe.periodSeconds | int | `1` |  |
| keto.deployment.startupProbe.successThreshold | int | `1` |  |
| keto.deployment.startupProbe.timeoutSeconds | int | `2` |  |
| keto.deployment.strategy.rollingUpdate.maxSurge | string | `"25%"` |  |
| keto.deployment.strategy.rollingUpdate.maxUnavailable | string | `"25%"` |  |
| keto.deployment.strategy.type | string | `"RollingUpdate"` |  |
| keto.deployment.terminationGracePeriodSeconds | int | `60` |  |
| keto.deployment.tolerations | list | `[]` |  |
| keto.deployment.topologySpreadConstraints | list | `[]` | Configure pod topologySpreadConstraints. |
| keto.extraServices | object | `{}` |  |
| keto.fullnameOverride | string | `""` |  |
| keto.global | object | `{"podMetadata":{"annotations":{},"labels":{}}}` | Global setting, passed down to all pods |
| keto.global.podMetadata | object | `{"annotations":{},"labels":{}}` | Specify pod metadata, this metadata is added directly to the pod, and not higher objects |
| keto.global.podMetadata.annotations | object | `{}` | Extra pod level annotations |
| keto.global.podMetadata.labels | object | `{}` | Extra pod level labels |
| keto.image.pullPolicy | string | `"IfNotPresent"` | Default image pull policy |
| keto.image.repository | string | `"oryd/keto"` | Ory KETO image |
| keto.image.tag | string | `"v25.4.0"` | Ory KETO version |
| keto.imagePullSecrets | list | `[]` |  |
| keto.ingress.read.annotations | object | `{}` |  |
| keto.ingress.read.className | string | `""` |  |
| keto.ingress.read.enabled | bool | `false` |  |
| keto.ingress.read.hosts[0].host | string | `"chart-example.local"` |  |
| keto.ingress.read.hosts[0].paths[0].path | string | `"/read"` |  |
| keto.ingress.read.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| keto.ingress.read.tls | list | `[]` |  |
| keto.ingress.write.annotations | object | `{}` |  |
| keto.ingress.write.className | string | `""` |  |
| keto.ingress.write.enabled | bool | `false` |  |
| keto.ingress.write.hosts[0].host | string | `"chart-example.local"` |  |
| keto.ingress.write.hosts[0].paths[0].path | string | `"/write"` |  |
| keto.ingress.write.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| keto.ingress.write.tls | list | `[]` |  |
| keto.job.annotations | object | `{"helm.sh/hook":"pre-install, pre-upgrade","helm.sh/hook-delete-policy":"before-hook-creation,hook-succeeded","helm.sh/hook-weight":"1"}` | If you do want to specify annotations, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'annotations:'. |
| keto.job.automountServiceAccountToken | bool | `false` | Set automounting of the SA token |
| keto.job.extraContainers | string | `""` | If you want to add extra sidecar containers. |
| keto.job.extraEnv | list | `[]` | Array of extra envs to be passed to the job. This takes precedence over deployment variables. Kubernetes format is expected. Value is processed with Helm `tpl` - name: FOO   value: BAR |
| keto.job.extraInitContainers | string | `""` | If you want to add extra init containers. |
| keto.job.lifecycle | string | `""` | If you want to add lifecycle hooks. |
| keto.job.nodeSelector | object | `{}` | Node labels for pod assignment. |
| keto.job.podMetadata | object | `{"annotations":{},"labels":{}}` | Specify pod metadata, this metadata is added directly to the pod, and not higher objects |
| keto.job.podMetadata.annotations | object | `{}` | Extra pod level annotations |
| keto.job.podMetadata.labels | object | `{}` | Extra pod level labels |
| keto.job.resources | object | `{}` | Job resources |
| keto.job.serviceAccount | object | `{"annotations":{"helm.sh/hook":"pre-install, pre-upgrade","helm.sh/hook-delete-policy":"before-hook-creation","helm.sh/hook-weight":"0"},"create":true,"name":""}` | Specify the serviceAccountName value. In some situations it is needed to provides specific permissions to Hydra deployments Like for example installing Hydra on a cluster with a PosSecurityPolicy and Istio. Uncoment if it is needed to provide a ServiceAccount for the Hydra deployment. |
| keto.job.serviceAccount.annotations | object | `{"helm.sh/hook":"pre-install, pre-upgrade","helm.sh/hook-delete-policy":"before-hook-creation","helm.sh/hook-weight":"0"}` | Annotations to add to the service account |
| keto.job.serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| keto.job.serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| keto.job.shareProcessNamespace | bool | `false` | Set sharing process namespace |
| keto.job.spec.backoffLimit | int | `10` | Set job back off limit |
| keto.job.tolerations | list | `[]` | Configure node tolerations. |
| keto.keto.automigration | object | `{"customArgs":[],"customCommand":[],"enabled":false,"resources":{},"type":"job"}` | Enables database migration |
| keto.keto.automigration.customArgs | list | `[]` | Ability to override arguments of the entrypoint. Can be used in-depended of customCommand eg: - sleep 5;   - keto |
| keto.keto.automigration.customCommand | list | `[]` | Ability to override the entrypoint of the automigration container (e.g. to source dynamic secrets or export environment dynamic variables) |
| keto.keto.automigration.resources | object | `{}` | resource requests and limits for the automigration initcontainer |
| keto.keto.automigration.type | string | `"job"` | Configure the way to execute database migration. Possible values: job, initContainer When set to job, the migration will be executed as a job on release or upgrade. When set to initContainer, the migration will be executed when kratos pod is created Defaults to job |
| keto.keto.command | list | `["keto"]` | Ability to override the entrypoint of keto container (e.g. to source dynamic secrets or export environment dynamic variables) |
| keto.keto.config | object | `{"dsn":"memory","namespaces":[{"id":0,"name":"sample"}],"serve":{"metrics":{"port":4468},"read":{"port":4466},"write":{"port":4467}}}` | Direct keto config. Full documentation can be found in https://www.ory.sh/keto/docs/reference/configuration |
| keto.keto.customArgs | list | `[]` | Ability to override arguments of the entrypoint. Can be used in-depended of customCommand |
| keto.keto.customMigrations.jobs.example-job.customArgs[0] | string | `"migrate"` |  |
| keto.keto.customMigrations.jobs.example-job.customArgs[1] | string | `"up"` |  |
| keto.keto.customMigrations.jobs.example-job.customArgs[2] | string | `"-y"` |  |
| keto.keto.customMigrations.jobs.example-job.customArgs[3] | string | `"--config"` |  |
| keto.keto.customMigrations.jobs.example-job.customArgs[4] | string | `"/etc/config/keto.yaml"` |  |
| keto.keto.customMigrations.jobs.example-job.enabled | bool | `false` |  |
| keto.keto.customMigrations.jobs.example-job.extraEnv | list | `[]` |  |
| keto.keto.customMigrations.jobs.example-job.nodeSelector | object | `{}` |  |
| keto.keto.customMigrations.jobs.example-job.resources | object | `{}` |  |
| keto.nameOverride | string | `""` |  |
| keto.pdb.enabled | bool | `false` |  |
| keto.pdb.spec.maxUnavailable | string | `""` |  |
| keto.pdb.spec.minAvailable | string | `""` |  |
| keto.podSecurityContext.fsGroup | int | `65534` |  |
| keto.podSecurityContext.fsGroupChangePolicy | string | `"OnRootMismatch"` |  |
| keto.podSecurityContext.runAsGroup | int | `65534` |  |
| keto.podSecurityContext.runAsNonRoot | bool | `true` |  |
| keto.podSecurityContext.runAsUser | int | `65534` |  |
| keto.podSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| keto.priorityClassName | string | `""` | Pod priority https://kubernetes.io/docs/concepts/configuration/pod-priority-preemption/ |
| keto.replicaCount | int | `1` | Number of replicas in deployment |
| keto.secret.enableDefaultAnnotations | bool | `true` | enableDefaultAnnotations set to `true` will add default annotations to the secret. As such the Secret will be managed by helm hooks. |
| keto.secret.enabled | bool | `true` | switch to false to prevent creating the secret |
| keto.secret.extraAnnotations | object | `{}` | extraAnnotations to be added to secret. |
| keto.secret.hashSumEnabled | bool | `true` | switch to false to prevent checksum annotations being maintained and propogated to the pods |
| keto.secret.nameOverride | string | `""` | Provide custom name of existing secret, or custom name of secret to be created |
| keto.secret.secretAnnotations | object | `{"helm.sh/hook":"pre-install, pre-upgrade","helm.sh/hook-delete-policy":"before-hook-creation","helm.sh/hook-weight":"0","helm.sh/resource-policy":"keep"}` | Annotations to be added to secret. Annotations are added only when secret is being created. Existing secret will not be modified. |
| keto.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| keto.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| keto.securityContext.privileged | bool | `false` |  |
| keto.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| keto.securityContext.runAsGroup | int | `65534` |  |
| keto.securityContext.runAsNonRoot | bool | `true` |  |
| keto.securityContext.runAsUser | int | `65534` |  |
| keto.securityContext.seLinuxOptions.level | string | `"s0:c123,c456"` |  |
| keto.securityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| keto.service.metrics.annotations | object | `{}` | If you do want to specify annotations, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'annotations:'. |
| keto.service.metrics.enabled | bool | `false` |  |
| keto.service.metrics.loadBalancerIP | string | `""` |  |
| keto.service.metrics.name | string | `"http-metrics"` |  |
| keto.service.metrics.port | int | `80` |  |
| keto.service.metrics.type | string | `"ClusterIP"` |  |
| keto.service.read.annotations | object | `{}` | If you do want to specify annotations, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'annotations:'. |
| keto.service.read.appProtocol | string | `"grpc"` |  |
| keto.service.read.clusterIP | string | `""` |  |
| keto.service.read.enabled | bool | `true` |  |
| keto.service.read.externalTrafficPolicy | string | `""` | https://kubernetes.io/docs/reference/networking/virtual-ips/#traffic-policies |
| keto.service.read.headless.enabled | bool | `true` |  |
| keto.service.read.internalTrafficPolicy | string | `""` | https://kubernetes.io/docs/reference/networking/virtual-ips/#traffic-policies |
| keto.service.read.loadBalancerIP | string | `""` |  |
| keto.service.read.name | string | `"grpc-read"` |  |
| keto.service.read.port | int | `80` |  |
| keto.service.read.type | string | `"ClusterIP"` |  |
| keto.service.write.annotations | object | `{}` | If you do want to specify annotations, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'annotations:'. |
| keto.service.write.appProtocol | string | `"grpc"` |  |
| keto.service.write.clusterIP | string | `""` |  |
| keto.service.write.enabled | bool | `true` |  |
| keto.service.write.externalTrafficPolicy | string | `""` | https://kubernetes.io/docs/reference/networking/virtual-ips/#traffic-policies |
| keto.service.write.headless.enabled | bool | `true` |  |
| keto.service.write.internalTrafficPolicy | string | `""` | https://kubernetes.io/docs/reference/networking/virtual-ips/#traffic-policies |
| keto.service.write.loadBalancerIP | string | `""` |  |
| keto.service.write.name | string | `"grpc-write"` |  |
| keto.service.write.port | int | `80` |  |
| keto.service.write.type | string | `"ClusterIP"` |  |
| keto.serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| keto.serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| keto.serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| keto.serviceMonitor.labels | object | `{}` | Provide additionnal labels to the ServiceMonitor ressource metadata |
| keto.serviceMonitor.metricRelabelings | list | `[]` | Metric relabeling is applied to samples as the last step before ingestion. Reference: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs |
| keto.serviceMonitor.relabelings | list | `[]` | Relabeling is a powerful tool to dynamically rewrite the label set of a target before it gets scraped. Reference: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config |
| keto.serviceMonitor.scheme | string | `"http"` | HTTP scheme to use for scraping. |
| keto.serviceMonitor.scrapeInterval | string | `"60s"` | Interval at which metrics should be scraped |
| keto.serviceMonitor.scrapeTimeout | string | `"30s"` | Timeout after which the scrape is ended |
| keto.serviceMonitor.tlsConfig | object | `{}` | TLS configuration to use when scraping the endpoint |
| keto.test.busybox | object | `{"repository":"busybox","tag":1}` | use a busybox image from another repository |
| keto.test.labels | object | `{}` | Provide additional labels to the test pod |
| keto.watcher.automountServiceAccountToken | bool | `true` |  |
| keto.watcher.enabled | bool | `false` |  |
| keto.watcher.image | string | `"oryd/k8s-toolbox:v0.0.7"` |  |
| keto.watcher.mountFile | string | `""` | Path to mounted file, which wil be monitored for changes. eg: /etc/secrets/my-secret/foo |
| keto.watcher.podMetadata | object | `{"annotations":{},"labels":{}}` | Specify pod metadata, this metadata is added directly to the pod, and not higher objects |
| keto.watcher.podMetadata.annotations | object | `{}` | Extra pod level annotations |
| keto.watcher.podMetadata.labels | object | `{}` | Extra pod level labels |
| keto.watcher.resources | object | `{}` |  |
| keto.watcher.revisionHistoryLimit | int | `5` | Number of revisions kept in history |
| keto.watcher.watchLabelKey | string | `"ory.sh/watcher"` | Label key used for managing applications |
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
helm install ekp-helm/keto
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: keto
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.0"
    chart: keto
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
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/keto --config /charts/charts/keto/ct.yaml
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template keto . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```

