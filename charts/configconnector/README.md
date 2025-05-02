# configconnector

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.129.2](https://img.shields.io/badge/AppVersion-1.129.2-informational?style=flat-square)

## Prerequisites

- Helm v3

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| ilyasabdellaoui | <ilyas.abdellaoui21@gmail.com> | <https://github.com/ilyasabdellaoui> |

## Description

Deploys Config Connector as described here https://cloud.google.com/config-connector/docs/how-to/install-other-kubernetes

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| installationMode | string | `"namespaced"` | Config Connector installation Mode. Values in  ["cluster","namespaced"] Namespaced mode allows to deploy a config connector for specific namespace. Allowing a mapping 1 google projetc = 1 namespace |
| authentication | object | `{"gsaEmail":null,"gsaKeySecretName":null,"type":"workloadIdentity"}` | **Only if installationMode=cluster** |
| authentication.type | string | `"workloadIdentity"` | Type of authentication used by the KSA to connect to GCP. Values in ["key","workloadIdentity"] |
| authentication.gsaEmail | string | `nil` | **Only if type=workloadIdentity**. GSA Email to map with config connector KSA |
| authentication.gsaKeySecretName | string | `nil` | **Only if type=key**. Name of the secret containing the GSA key |

## Installing the Chart

### With Helm

To install the chart with the release name `configconnector`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/configconnector
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: configconnector
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.0"
    chart: configconnector
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
  - name: configconnector
    version: ~0.1.0
    repository: "https://edixos.github.io/ekp-helm"
    alias: configConnector
    condition: configConnector.enabled
```

and add configuration parameters in `values.yaml` file:

```yaml
configConnector:
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
$ gsutil cp gs://configconnector-operator/<LAST VERSION>/release-bundle.tar.gz last-release-bundle.tar.gz
# Untar the release
mkdir <LAST VERSION> && cd <LAST VERSION>
tar -zxvf ../last-release-bundle.tar.gz
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
meld 1.129.2/samples/configconnector_*mode*.yaml <LAST VERSION>/samples/configconnector_*mode*.yaml
```

### Update documentation

Chart documentation is generated with [helm-docs](https://github.com/norwoodj/helm-docs) from `values.yaml` file.
After file modification, regenerate README.md with command:

```bash
docker run --rm -it -v $(pwd):/helm --workdir /helm jnorwood/helm-docs:v1.14.2 helm-docs
```

### Run linter

```bash
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/configconnector --config /charts/charts/configconnector/ct.yaml
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template configconnector . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```
