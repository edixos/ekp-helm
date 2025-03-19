# configconnector-operator

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.129.2](https://img.shields.io/badge/AppVersion-1.129.2-informational?style=flat-square)

## Prerequisites

- Helm v3
- Namespace **configconnector-operator-system** with the following annotations / labels:

  ```yaml
  annotations:
    cnrm.cloud.google.com/operator-version: 1.129.2
  labels:
    cnrm.cloud.google.com/operator-system: "true"
  ```

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| ilyasabdellaoui | <ilyas.abdellaoui21@gmail.com> | <https://github.com/ilyasabdellaoui> |

## Description

Deploys Config Connector Operator as described here https://cloud.google.com/config-connector/docs/how-to/install-other-kubernetes

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| commonAnnotations | object | `{}` | Annotations to add to all the resources |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"Always"` | Image pull Policy |
| image.repository | string | `"gcr.io/gke-release/cnrm/operator"` | Image Repository |
| image.tag | string | `"3570282"` | Image tag |
| imagePullSecrets | list | `[]` | List of image pull secrets |
| isAutopilot | bool | `false` | Is the Cluster Autopilot |
| nameOverride | string | `""` |  |
| podAnnotations | object | `{}` | Annotations to add to to the Pod |
| podSecurityContext | object | `{}` | security context to apply to the pod ([documentation](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod)) |
| rbac.create | bool | `true` | Create ClusterRole and ClusterRoleBinding |
| resources | object | `{"limits":{"memory":"1Gi"},"requests":{"cpu":"100m","memory":"512Mi"}}` | Resources to apply to the configconnector container |
| securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["all"]},"runAsGroup":1000,"runAsNonRoot":true,"runAsUser":1000}` | security context to apply to the container ([documentation](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container)) |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |

## Installing the Chart

### With Helm

To install the chart with the release name `configconnector-operator`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/configconnector-operator
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: configconnector-operator
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.0"
    chart: configconnector-operator
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

## Integration with other charts

Add this chart as requirements in `requirements.yaml` file:

```yaml
dependencies:
  - name: configconnector-operator
    version: ~0.1.0
    repository: "https://edixos.github.io/ekp-helm"
    alias: configConnectorOperator
    condition: configConnectorOperator.enabled
```

and add configuration parameters in `values.yaml` file:

```yaml
configConnectorOperator:
  enabled: true
```

## Develop

### Upgrade to newest version

You must download the latest release through gsutil:

```bash
# List all version available
$ gsutil ls gs://configconnector-operator/
...
gs://configconnector-operator/1.116.0/
gs://configconnector-operator/1.117.0/
gs://configconnector-operator/1.118.1/
gs://configconnector-operator/latest/
# Select the last version (here 1.118.2)
$ gsutil cp gs://configconnector-operator/<LAST VERSION>/release-bundle.tar.gz latest-release-bundle.tar.gz
# Untar the release
mkdir <LAST VERSION> && cd <LAST VERSION>
tar -zxvf ../latest-release-bundle.tar.gz
```

Download the chart version

```bash
gsutil cp gs://configconnector-operator/1.129.2/release-bundle.tar.gz 1.129.2-release-bundle.tar.gz
# Untar the release
mkdir 1.129.2 && cd 1.129.2
tar -zxvf ../1.129.2-release-bundle.tar.gz
```

Through a diff tool (ex: [meld](https://meldmerge.org/)), check the diff between the 2 version and report the changes in the chart.

```bash
meld 1.129.2/operator-system/configconnector-operator.yaml <LAST VERSION>/operator-system/configconnector-operator.yaml
```

### Update documentation

Chart documentation is generated with [helm-docs](https://github.com/norwoodj/helm-docs) from `values.yaml` file.
After file modification, regenerate README.md with command:

```bash
docker run --rm -it -v $(pwd):/helm --workdir /helm jnorwood/helm-docs:v1.14.2 helm-docs
```

### Run linter

```bash
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/configconnector-operator --config /charts/charts/configconnector-operator/ct.yaml
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template configconnector-operator . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```
