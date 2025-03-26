# grafana-stack

![Version: 0.1.1](https://img.shields.io/badge/Version-0.1.1-informational?style=flat-square) ![AppVersion: 11.3.1](https://img.shields.io/badge/AppVersion-11.3.1-informational?style=flat-square)

----

[[_TOC_]]

----

## Prerequisites

- Helm v3.1+

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://grafana.github.io/helm-charts | grafana | 8.10.4 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| ilyasabdellaoui | <ilyas.abdellaoui21@gmail.com> | <https://github.com/ilyasabdellaoui> |

## Description

Deploys Grafana instance. Pre-configured values from [upstream grafana chart](https://github.com/helm/charts/tree/master/stable/grafana)

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| dashboards.k8s.create | bool | `false` | Create grafana dashboards to monitor kubernetes cluster |
| dashboards.labels | object | `{}` | Labels added to configmap dashboards |
| fullnameOverride | string | `""` |  |
| global.enableArgocdAnnotations | bool | `false` | Annotate Custom Resources with `argocd.argoproj.io/sync-options: SkipDryRunOnMissingResource=true` for Argocd |
| grafana."grafana.ini" | object | `{"auth":{"disable_login_form":true,"oauth_auto_login":true},"auth.basic":{"enabled":false},"metrics":{"enabled":true},"server":{"root_url":"https://grafana.changeme.com"},"users":{"allow_sign_up":false,"auto_assign_org_role":"editor"}}` | Grafana's primary configuration, see [grafana configuration documentation](https://grafana.com/docs/grafana/latest/administration/configuration/) |
| grafana.dashboardProviders | object | `{"dashboardproviders.yaml":{"apiVersion":1,"providers":[{"disableDeletion":true,"editable":false,"folder":"Kubernetes","name":"Kubernetes","options":{"path":"/tmp/dashboards/k8s"},"orgId":1,"type":"file"},{"disableDeletion":true,"editable":false,"folder":"Grafana","name":"Grafana","options":{"path":"/tmp/dashboards/grafana"},"orgId":1,"type":"file"},{"disableDeletion":true,"editable":false,"folder":"Project","name":"Project","options":{"path":"/tmp/dashboards/project"},"orgId":1,"type":"file"}]}}` | Configure grafana dashboard providers, see [grafana documentation](https://grafana.com/docs/grafana/latest/administration/provisioning/#dashboards) |
| grafana.datasources | object | `{"datasources.yaml":{"apiVersion":1,"datasources":[{"access":"proxy","name":"Prometheus","type":"prometheus","url":"http://prometheus-operated.infra-prometheus-operator:9090"}]}}` | Configure grafana datasource providers, see [grafana documentation](https://grafana.com/docs/grafana/latest/administration/provisioning/#data-sources) |
| grafana.env.GF_AUTH_GENERIC_OAUTH_AUTH_URL | string | `""` | OAUTH auth url for OIDC integration |
| grafana.env.GF_AUTH_GENERIC_OAUTH_CLIENT_ID | string | `"grafana-infra"` | Client ID for OIDC integration, see `grafanadexclient.client.id` |
| grafana.env.GF_AUTH_GENERIC_OAUTH_ENABLED | bool | `true` | Enables OAUTH |
| grafana.env.GF_AUTH_GENERIC_OAUTH_SCOPES | string | `"email openid"` | OAUTH scopes for OIDC integration |
| grafana.env.GF_AUTH_GENERIC_OAUTH_TOKEN_URL | string | `""` | OAUTH token url for OIDC integration |
| grafana.image.repository | string | `"grafana/grafana"` | Image repository |
| grafana.image.sha | string | `""` | Image sha (optional) |
| grafana.persistence.enabled | bool | `false` |  |
| grafana.plugins | list | `["grafana-piechart-panel"]` | Plugins to be loaded along with Grafana |
| grafana.priorityClassName | string | `""` | Priority class assigned to the Pods |
| grafana.replicas | int | `1` | Number of instance of grafana |
| grafana.resources | object | `{"limits":{"cpu":"1000m","memory":"500Mi"},"requests":{"cpu":"100m","memory":"200Mi"}}` | Add resources limits and request to grafana container. |
| grafana.securityContext | object | `{"fsGroup":472,"runAsGroup":472,"runAsNonRoot":true,"runAsUser":472}` | [Security context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) for grafana |
| grafana.service.labels | object | `{"app.kubernetes.io/component":"grafana","app.kubernetes.io/name":"grafana-infra"}` | Custom labels to apply |
| grafana.service.portName | string | `"http-grafana"` | Name of the service |
| grafana.service.type | string | `"ClusterIP"` | Type of service for the grafana |
| grafana.sidecar.dashboards.enabled | bool | `true` | Enables the cluster wide search for dashboards and adds/updates/deletes them in grafana |
| grafana.sidecar.dashboards.folder | string | `"/tmp/dashboards"` | Folder in the pod that should hold the collected dashboards. This path will be mounted. |
| grafana.sidecar.dashboards.label | string | `"grafana_dashboard"` | Label that config maps with dashboards should have to be added |
| grafana.sidecar.dashboards.searchNamespace | string | `""` | If specified, the sidecar will search for dashboard config-maps inside this namespace. Otherwise the namespace in which the sidecar is running will be used. It's also possible to specify ALL to search in all namespaces |
| grafana.sidecar.datasources.enabled | bool | `true` | Enables the cluster wide search for datasources and adds/updates/deletes them in grafana |
| grafana.testFramework.enabled | bool | `false` |  |
| ingress.annotations | object | `{"kubernetes.io/ingress.allow-http":"false","kubernetes.io/ingress.class":"nginx","kubernetes.io/tls-acme":"true"}` | Map of annotations to apply to the ingress |
| ingress.enabled | bool | `false` | Enables ingress for alertmanager |
| ingress.host | string | `""` | FQDN of the grafana |
| ingress.path | string | `"/"` | Path of the incoming request (/* or / if used with nginx) |
| ingress.tls.secretName | string | `"grafana-tls"` | Name of the secret containing the certificates |
| nameOverride | string | `""` |  |
| prometheus.enabled | bool | `true` | Enables prometheus operator resources |
| prometheus.rules.labels | object | `{"prometheus":"prometheus-operator-prometheus"}` | Labels to affect to the Prometheus Rules, used to select prometheus target |
| prometheus.serviceMonitor.enabled | bool | `true` | Enables prometheus operator service monitor |
| prometheus.serviceMonitor.labels | object | `{"prometheus":"prometheus-operator-prometheus"}` | Map of labels to apply to the servicemonitor, used to select prometheus target |

## Installing the Chart

### With Helm

To install the chart with the release name `my-release`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/grafana-stack
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: grafana-stack
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.1"
    chart: grafana-stack
    path: ''

    helm:
      values: |
        ingress:
          enabled: true
          host: grafana.example.com

        grafana:
          sidecar:
            dashboards:
                searchNamespace: "ALL"
          grafana.ini:
            server:
              root_url: "https://grafana.example.com/"

  destination:
    server: https://kubernetes.default.svc
    namespace: "infra-monitoring"
```

## Develop

### Add grafana dashboard

To deploy new dashboard, copy dashboard as json file into [./resources/grafana/](./resources/grafana/) directory.
if `grafana.sidecar.dashboards.enabled` is set, json content will be copied to configmap.
By default, only configmap in current namespace will be searched. Configure `grafana.sidecar.dashboards.searchNamespace` variable to define namespace.
It's also possible to specify `ALL` to search in all namespaces.

Dashboards can be sorted by folder. Set `k8s-sidecar-target-directory: \{\{ .Values.grafana.sidecar.dashboards.folder \}\}/custom_folder` annotations to customize dashboard folder.

### Add prometheus rules and alerts

To deploy new rules, copy your rules (without the group) into [.resources/prometheus-rules/grafana-records.yaml](.resources/prometheus-rules/grafana-records.yaml).
To deploy new alerts, copy your alerts (without the group) into [.resources/prometheus-rules/grafana-up.yaml](.resources/prometheus-rules/grafana-up.yaml).

Some rules and alerts come from the grafana github repository:
- https://github.com/grafana/grafana/blob/master/grafana-mixin/rules/rules.yaml
- https://github.com/grafana/grafana/blob/master/grafana-mixin/alerts/alerts.yaml

### Update documentation

Chart documentation is generated with [helm-docs](https://github.com/norwoodj/helm-docs) from `values.yaml` file.
After file modification, regenerate README.md with command:

```bash
docker run --rm -it -v $(pwd):/helm --workdir /helm jnorwood/helm-docs:v1.14.2 helm-docs
```

### Run linter

```bash
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/grafana-stack --config /charts/charts/grafana-stack/ct.yaml
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto renaultdigital/helm:v3.4.0 template grafana-stack . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/pluto renaultdigital/pluto:v3.5.2 detect-files -d /pluto -o yaml --ignore-deprecations -t "k8s=v1.17.0,cert-manager=v0.15.1,istio=v1.6.0" -o wide
docker volume rm pluto
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