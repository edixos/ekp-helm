# alertmanager

![Version: 0.1.1](https://img.shields.io/badge/Version-0.1.1-informational?style=flat-square) ![AppVersion: v0.27.0](https://img.shields.io/badge/AppVersion-v0.27.0-informational?style=flat-square)

----

[[_TOC_]]

----

## Prerequisites

- Helm v3
- [Prometheus-operator](https://github.com/edixos/ekp-helm/tree/main/charts/kube-prometheus-stack) deployed on the K8S Cluster

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://oauth2-proxy.github.io/manifests | oidc(oauth2-proxy) | 7.12.7 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| ilyasabdellaoui | <ilyas.abdellaoui21@gmail.com> | <https://github.com/ilyasabdellaoui> |

## Description

Deploies Alertmanager through Prometheus-Operator

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| nameOverride | string | `""` |  |
| fullnameOverride | string | `""` |  |
| commonLabels | object | `{}` | Labels to apply to all resources |
| imagePullSecrets | list | `[]` | Reference to one or more secrets to be used when pulling images ref: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/ |
| image.repository | string | `""` | Override alertmanager image name, use image defined by alertmanager controller if not defined |
| image.tag | string | `""` | Container image tag |
| global.enableArgocdAnnotations | bool | `false` | Annotate Custom Resources with `global.argocdAnnotations` |
| global.argocdAnnotations[0] | string | `"argocd.argoproj.io/sync-options: SkipDryRunOnMissingResource=true"` |  |
| replicaCount | int | `3` | Size is the expected size of the alertmanager cluster. The controller will eventually make the size of the running cluster equal to the expected size. |
| clusterName | string | `""` | Alertmanager name |
| podMetadata | object | `{}` | Standard object’s metadata. More info: https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#metadata Metadata Labels and Annotations gets propagated to the Alertmanager pods. |
| useExistingSecret | bool | `false` | If true then the user will be responsible to provide a secret with alertmanager configuration So when true the config part will be ignored (including templateFiles) and the one in the secret will be used See `configSecret` |
| secrets | list | `[]` | List of Secrets in the same namespace as the Alertmanager object, which shall be mounted into the Alertmanager Pods. The Secrets are mounted into /etc/alertmanager/secrets/. |
| configSecret | string | 'alertmanager-{{ fullname }}' | Name of a Kubernetes Secret in the same namespace as the Alertmanager object, which contains configuration for this Alertmanager instance. The secret is mounted into /etc/alertmanager/config and should contains `alertmanager.yaml` key. |
| configMaps | list | `[]` | List of ConfigMaps in the same namespace as the Alertmanager object, which shall be mounted into the Alertmanager Pods. The ConfigMaps are mounted into /etc/alertmanager/configmaps/. |
| logFormat | string | `"logfmt"` | Define Log Format Use logfmt (default) or json-formatted logging |
| logLevel | string | `"info"` | Log level for Alertmanager to be configured with. |
| retention | string | `"120h"` | Time duration Alertmanager shall retain data for. Default is '120h', and must match the regular expression [0-9]+(ms|s|m|h) (milliseconds seconds minutes hours). |
| storage | object | `{}` | Storage is the definition of how storage will be used by the Alertmanager instances. ref: https://github.com/prometheus-operator/prometheus-operator/blob/master/Documentation/user-guides/storage.md |
| volumes | list | `[]` | Additional volumes on the output StatefulSet definition. |
| volumeMounts | list | `[]` | Additional VolumeMounts on the output StatefulSet definition. |
| externalUrl | string | Use ingress host if enabled else generated from Chart name | The external URL the Alertmanager instances will be available under. This is necessary to generate correct URLs. This is necessary if Alertmanager is not served from root of a DNS name. |
| routePrefix | string | `"/"` | The route prefix Alertmanager registers HTTP handlers for. This is useful, if using ExternalURL and a proxy is rewriting HTTP routes of a request, and the actual ExternalURL is still true, but the server serves requests under a different route prefix. For example for use with kubectl proxy. |
| paused | bool | `false` | If set to true all actions on the underlying managed objects are not going to be performed, except for delete actions. |
| nodeSelector | object | `{}` | Define which Nodes the Pods are scheduled on. ref: https://kubernetes.io/docs/user-guide/node-selection/ |
| resources.requests.cpu | string | `"5m"` |  |
| resources.requests.memory | string | `"200Mi"` |  |
| resources.limits.cpu | string | `"100m"` |  |
| resources.limits.memory | string | `"500Mi"` |  |
| podAntiAffinity | string | `""` | Pod anti-affinity can prevent the scheduler from placing Prometheus replicas on the same node. The default value "soft" means that the scheduler should *prefer* to not schedule two replica pods onto the same node but no guarantee is provided. The value "hard" means that the scheduler is *required* to not schedule two replica pods onto the same node. The value "" will disable pod anti-affinity so that no anti-affinity rules will be configured. |
| podAntiAffinityTopologyKey | string | `"kubernetes.io/hostname"` | If anti-affinity is enabled sets the topologyKey to use for anti-affinity. This can be changed to, for example, failure-domain.beta.kubernetes.io/zone |
| affinity | object | `{}` | Assign custom affinity rules to the alertmanager instance ref: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/ |
| tolerations | list | `[]` | If specified, the pod's tolerations. ref: https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/ |
| securityContext | object | `{"fsGroup":2000,"runAsGroup":2000,"runAsNonRoot":true,"runAsUser":1000}` | SecurityContext holds pod-level security attributes and common container settings. This defaults to non root user with uid 1000 and gid 2000.	*v1.PodSecurityContext	false ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/ |
| listenLocal | bool | `false` | ListenLocal makes the Alertmanager server listen on loopback, so that it does not bind against the Pod IP. Note this is only for the Alertmanager UI, not the gossip communication. |
| containers | list | `[]` | Allows to inject additional containers. This is meant to allow adding an authentication proxy to an Alertmanager pod. |
| priorityClassName | string | `""` | Priority class assigned to the Pods |
| additionalPeers | list | `[]` | AdditionalPeers allows injecting a set of additional Alertmanagers to peer with to form a highly available cluster. |
| portName | string | `"web"` | PortName to use for Alert Manager. |
| clusterAdvertiseAddress | bool | `false` | Explicit address to advertise in cluster. Needs to be provided for non RFC1918 [1] (public) addresses. [1] RFC1918: https://tools.ietf.org/html/rfc1918 |
| service.labels | object | `{}` | Map of labels to apply to the service |
| service.annotations | object | `{}` | Map of annotations to apply to the service |
| service.clusterIP | string | `""` | Cluster IP Only use if service.type is "ClusterIP" |
| service.port | int | `9093` | Port for Prometheus Service to listen on |
| service.targetPort | int | `9093` | To be used with a proxy extraContainer port |
| service.externalIPs | list | `[]` | List of IP addresses at which the Prometheus server service is available Ref: https://kubernetes.io/docs/user-guide/services/#external-ips |
| service.nodePort | int | `30090` | Port to expose on each node Only used if service.type is 'NodePort' |
| service.loadBalancerIP | string | `""` | Loadbalancer IP Only use if service.type is "loadbalancer" |
| service.loadBalancerSourceRanges | list | `[]` |  |
| service.type | string | `"ClusterIP"` | Service type |
| service.sessionAffinity | string | `""` |  |
| istio.enabled | bool | `false` | Enables istio features |
| ingress.enabled | bool | `false` | Enables ingress for alertmanager |
| ingress.labels | object | `{}` | Map of labels to apply to the ingress |
| ingress.annotations."kubernetes.io/ingress.allow-http" | string | `"false"` |  |
| ingress.acme.enabled | bool | `true` | Manage certificates with ACME protocol |
| ingress.acme.annotations | list | `["kubernetes.io/tls-acme: \"true\""]` | Annotations to add when `ingress.acme.enabled` is true |
| ingress.extraAnnotations | object | `{}` | Map of annotations to add  to th ingress |
| ingress.host | string | `""` | FQDN of the prometheus |
| ingress.path | string | `"/*"` | Path of the incoming request (/* or / if used with nginx) |
| ingress.tls.secretName | string | Generated name based on chart release full name | Name of the secret containing the certificates |
| prometheus.enabled | bool | `true` | Enables prometheus operator resources |
| prometheus.serviceMonitor.enabled | bool | `true` | Enables prometheus operator service monitor |
| prometheus.serviceMonitor.labels | object | `{"prometheus":"prometheus-operator-prometheus"}` | Map of labels to apply to the servicemonitor |
| prometheus.serviceMonitor.interval | string | `""` | Scrape interval. If not set, the Prometheus default scrape interval is used. dd |
| prometheus.serviceMonitor.scheme | string | `""` | HTTP scheme to use for scraping. Can be used with `tlsConfig` for example if using istio mTLS. |
| prometheus.serviceMonitor.tlsConfig | object | `{}` | TLS configuration to use when scraping the endpoint. For example if using istio mTLS. Of type: https://github.com/prometheus-operator/prometheus-operator/blob/master/Documentation/api.md#tlsconfig |
| prometheus.serviceMonitor.bearerTokenFile | string | `nil` |  |
| prometheus.serviceMonitor.metricRelabelings | list | `[]` | metric relabel configs to apply to samples before ingestion. |
| prometheus.serviceMonitor.relabelings | list | `[]` | Relabel configs to apply to samples before ingestion. |
| prometheus.serviceMonitor.annotations | object | `{}` | Map of annotations to apply to the ServiceMonitor |
| prometheus.rules.labels | object | `{"prometheus":"prometheus-operator-prometheus"}` | Labels to affect to the Prometheus Rules |
| prometheus.grafanaDashboard.enabled | bool | `true` | If `true`, deploy grafana dashboard |
| prometheus.grafanaDashboard.label | object | `{"grafana_dashboard":"1"}` | Labels to apply to dashboard configmap |
| podDisruptionBudget | object | `{"enabled":true,"maxUnavailable":"","minAvailable":1}` | Configure pod disruption budgets for AlertManager ref: https://kubernetes.io/docs/tasks/run-application/configure-pdb/#specifying-a-poddisruptionbudget This configuration is immutable once created and will require the PDB to be deleted to be changed https://github.com/kubernetes/kubernetes/issues/45398 |
| serviceAccount.create | bool | `true` | When `true`, create alertmanager serviceAccount with `serviceAccount.name`. If `serviceAccount.name` is empty, use `.Chart.fullname` value. |
| serviceAccount.name | string | `""` | Name of the ServiceAccount to use to run the Prometheus Pods. If `prometheus.serviceAccount.create` is `false` and no name is defined, use `default`. |
| serviceAccount.annotations | object | `{}` | Annotations for ServiceAccount |
| serviceAccount.automountServiceAccountToken | bool | `false` | automountServiceAccountToken |
| oidc.enabled | bool | `false` | If `true`, enable oidc authentification with sidecar container |
| oidc.image.repository | string | `"quay.io/oauth2-proxy/oauth2-proxy"` | Container name for oauth2-proxy sidecar |
| oidc.image.pullPolicy | string | `"IfNotPresent"` | Container image pull policy for oauth2-proxy sidecar |
| oidc.portName | string | `"http-oidc"` | PortName to use for oidc proxy sidecar |
| oidc.port | int | `3000` | Port to listen by oidc proxy |
| oidc.serviceMonitor | bool | `true` | Deploy prometheus ServiceMonitor resource to scrape oidc proxy metrics. |
| oidc.metricsPortName | string | `"http-oauth-prom"` | PortName to use for oidc proxy sidecar metrics |
| oidc.metricsPort | int | `3090` | Port number where to expose prometheus proxy for oidc proxy |
| oidc.env | list | `[]` | Environment variables to inject into sidecar |
| oidc.configMap.create | bool | `false` | Create and configure configmap  with name `oidc.configMap.name` |
| oidc.configMap.name | string | Generated from release chart name | Configmap name to inject into sidecar |
| oidc.configMap.annotations | object | `{}` | Map of annotations to apply to the configMap |
| oidc.configMap.issuerUrl | string | `""` | Required, the OpenID Connect issuer URL, e.g. "https://accounts.google.com" |
| oidc.configMap.upstreamUrl | string | http://localhost:<service.targetPort> | Upstream service to proxy |
| oidc.configMap.providerDisplayName | string | `""` | Override the provider's name with the given string; used for the sign-in page |
| oidc.configMap.emailDomains | list | `["*"]` | Authenticate emails with the specified domain. Use * to authenticate any email |
| oidc.configMap.reverseProxy | bool | `true` | Are we running behind a reverse proxy, controls whether headers like X-Real-IP are accepted and allows X-Forwarded-{Proto,Host,Uri} headers to be used on redirect selection |
| oidc.configMap.passBasicAuth | bool | `true` | Pass HTTP Basic Auth, X-Forwarded-User and X-Forwarded-Email information to upstream |
| oidc.configMap.passUserHeaders | bool | `true` | Pass X-Forwarded-User, X-Forwarded-Groups, X-Forwarded-Email and X-Forwarded-Preferred-Username information to upstream |
| oidc.configMap.passAccessToken | bool | `true` | Pass OAuth Access token to upstream via "X-Forwarded-Access-Token" |
| oidc.configMap.setXauthrequest | bool | `false` | Set X-Auth-Request-User, X-Auth-Request-Groups, X-Auth-Request-Email and X-Auth-Request-Preferred-Username. When used with pass_access_token, X-Auth-Request-Access-Token is added to response headers |
| oidc.configMap.cookieName | string | `"_oauth2_proxy"` | the cookie name for use with an AES cipher when cookie_refresh or pass_access_token is set |
| oidc.configMap.cookieDomains | string | `""` | Cookie domain to force cookies to (ie: .yourcompany.com) |
| oidc.configMap.cookieExpire | string | `"12h"` | Expire timeframe for cookie |
| oidc.configMap.cookieRefresh | string | `""` | Refresh the cookie when duration has elapsed after cookie was initially set. Should be less than cookie_expire; set to 0 to disable. On refresh, OAuth token is re-validated. (ie: 1h means tokens are refreshed on request 1hr+ after it was set) |
| oidc.configMap.cookieSecure | bool | `true` | Secure cookies are only sent by the browser of a HTTPS connection (recommended) |
| oidc.configMap.cookieHttponly | bool | `true` | HttpOnly cookies are not readable by javascript (recommended) |
| oidc.configMap.extraConfig | string | `""` | Extra options to add to configuration file. See [oauth2-proxy documentation](https://oauth2-proxy.github.io/oauth2-proxy/docs/configuration/overview/#config-file) for details |
| oidc.secret.create | bool | `true` | Create and configure secrets with name `oidc.secret.name`. If `false`, use existing secret. |
| oidc.secret.name | string | Generated from release chart name | Secret name use to store oidc secrets |
| oidc.secret.annotations | object | `{}` | Map of annotations to apply to the Secret created |
| oidc.secret.cookieSecretKey | string | `"encryption_key"` | Secret key name for encryption key. If `oidc.secret.create` is `true`, a secret with this key will be generated. Else, this key matches existing key in `oidc.secret.name`. The value key length should be either 16 or 32 bytes, depending or whether you want AES-128 or AES-256 |
| oidc.secret.clientSecretKey | string | `"client_secret"` | Secret key name for OAUTH2 client secret. If `oidc.secret.create` is `true`, a secret with this key will be generated. Else, this key matches existing key in `oidc.secret.name`. |
| oidc.applicationId | string | release chart full name | OAUTH2 client id |
| oidc.dexClient.enabled | bool | `false` | Manage aplicationId/secret as Dex resource |
| oidc.dexClient.annotations | object | `{}` | Map of annotations to apply to the dex Client created |
| oidc.resources | object | `{"limits":{"cpu":"100m","memory":"50Mi"},"requests":{"cpu":"5m","memory":"30Mi"}}` | Add resources limits and request to oidc proxy side-car container. |
| authorizations.enabled | bool | `false` | Enable `envoy-proxy` sidecar to manage rbac access |
| authorizations.envoy.port | int | `8888` |  |
| authorizations.envoy.image.repository | string | `"docker.io/envoyproxy/envoy-distroless"` | Container name for envoy-proxy |
| authorizations.envoy.image.tag | string | `"v1.22-latest"` |  |
| authorizations.envoy.image.pullPolicy | string | `"Always"` | Container image pull policy |
| authorizations.envoy.resources | object | `{"limits":{"cpu":"100m","memory":"50Mi"},"requests":{"cpu":"5m","memory":"30Mi"}}` | Add resources limits and request to envoy proxy side-car container. |
| authorizations.envoy.configMap.create | bool | `true` | Create and configure configmap  with name `authorizations.envoy.configMap.name` |
| authorizations.envoy.configMap.name | string | Generated from release chart name | Configmap name to inject into envoy sidecar |
| authorizations.rbac.resources | object | `{}` | List of resources to protect (name: <rule_name>  ,uri: /<URI>, methods: [<METHOD>], roles: []) |
| karma.enabled | bool | `false` | Enable karma authentication with htpasswd file |
| karma.htpasswd.secretName | string | `"karma-secret"` | Secret name that contains htpasswd file used to share credentials with karma instance |
| karma.htpasswd.secretKey | string | `"htpasswd"` | Secret key that contains htpasswd file used to share credentials with karma instance |
| karma.groups | list | `["karma"]` | User groups set when authenticated with htpasswd file |

## Installing the Chart

### With Helm

To install the chart with the release name `my-release`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/alertmanager
```

### With ArgoCD

#### Cluster k8s with access to public registry

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: alertmanager
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.1"
    chart: alertmanager
    path: ''

    helm:

      values: |
        ""

  destination:
    server: https://kubernetes.default.svc
    namespace: "infra-monitoring"

  ignoreDifferences:
  - group: ""
    kind: Secret
    name: alertmanager-gatekeeper
    jsonPointers:
    - /data/secretId
    - /data/encyptionKey
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
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/alertmanager --config /charts/charts/alertmanager/ct.yaml
```

### Prometheus Rules

Check rules:

```bash
docker run --rm --entrypoint /bin/sh -v $(pwd):/workdir -w /workdir prom/prometheus -c -- "promtool check rules resources/prometheus-rules/*"
```

Test rules:

```bash
docker run --rm --entrypoint /bin/sh -v $(pwd):/workdir -w /workdir prom/prometheus -c -- "promtool test rules tests/prometheus/*"
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template alertmanager . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```
