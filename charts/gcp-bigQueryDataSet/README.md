# bigquery-dataset

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

- [bigquery-dataset](#bigQuery-dataset)
  - [Prerequisites](#prerequisites)
  - [BigQueryDatSet Immutable Fields](#bigquery-datset-immutable-fields)
  - [Important Usage Constraints](#Important-usage-constraints)
  - [Maintainers](#maintainers)
  - [Description](#description)
  - [Values](#values)
  - [Installing the Chart](#installing-the-chart)
    - [With Helm](#with-helm)
    - [With ArgoCD](#with-argocd)
  - [Develop](#develop)
    - [Config Connector ressources](#config-connector-ressources)
    - [Update documentation](#update-documentation)
    - [Run linter](#run-linter)
    - [Run pluto](#run-pluto)

## Prerequisites

- Helm v3
- Config-connector chart deployed >= v1.34.0

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| ilyasabdellaoui | <ilyas.abdellaoui21@gmail.com> | <https://github.com/ilyasabdellaoui> |

## Description

A Helm chart that Creates a BigQueryDataset through Config Connector

It will deploy the following GCP components:

- bigqueryDataset: Creates BigQuery rules

## BigQueryDatSet Immutable Fields

| Key  |  **Required** |  Type | Description  |
|-----|------|---------|-------------|
| .values.bigqueryDataset.resourceID |  | string | Immutable. Optional. The datasetId of the resource. Used for creation and acquisition. When unset, the value of `metadata.name` is used as the default. |
| .values.bigqueryDataset.location |  | string | Immutable. Optional. A regional location is a specific geographic place, such as Tokyo, and a multi-regional location is a large geographic area, such as the United States, that contains at least two geographic places. The default value is multi-regional location 'US'. Changing this forces a new resource to be created.. |

## Important Usage Constraints
- `values.bigqueryDatasets.defaultTableExpirationMs` should not set the tables should not expire in  case of billing dataset.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| bigqueryDataset.access[0].dataset | object | `{}` |  |
| bigqueryDataset.access[0].domain | string | `""` |  |
| bigqueryDataset.access[0].groupByEmail | string | `""` |  |
| bigqueryDataset.access[0].role | string | `""` | roles list for roles writer/reader/admin |
| bigqueryDataset.access[0].routine | object | `{}` |  |
| bigqueryDataset.access[0].specialGroup | string | `""` |  |
| bigqueryDataset.access[0].userByEmail | string | `""` | email id for the gke serviceaccount |
| bigqueryDataset.access[0].view | object | `{}` |  |
| bigqueryDataset.defaultCollation | string | `""` |  |
| bigqueryDataset.defaultEncryptionConfiguration | object | `{}` |  |
| bigqueryDataset.defaultPartitionExpirationMs | string | `""` |  |
| bigqueryDataset.defaultTableExpirationMs | string | `""` |  |
| bigqueryDataset.delete_contents_on_destroy | string | `"false"` |  |
| bigqueryDataset.description | string | `""` | user defines defination |
| bigqueryDataset.friendlyName | string | `""` | friendly defination |
| bigqueryDataset.isCaseInsensitive | string | `""` |  |
| bigqueryDataset.location | string | `""` | location of the dataset |
| bigqueryDataset.maxTimeTravelHours | string | `""` |  |
| bigqueryDataset.name | string | `"ekp-bigQueryDataset"` | name of the Dataset |
| bigqueryDataset.namespace | string | `"cnrm-gcp-dev"` |  |
| bigqueryDataset.projectRef | object | `{}` |  |
| bigqueryDataset.resourceID | string | `""` |  |
| bigqueryDataset.storageBillingModel | string | `""` |  |
| global.cnrmNamespace | string | `nil` | Allows to deploy in another namespace than the release one |
| global.deletion_policy | string | `"abandon"` | Keep the VPC even after the kcc resource deletion. |
| global.gcpProjectId | string | `"myprojectid"` | Google Project ID |

## Installing the Chart

### With Helm

To install the chart with the release name `my-release`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/bigquery-dataset
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: bigquery-dataset
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.0"
    chart: bigquery-dataset
    path: ''

    helm:
      values: |
        bigqueryDataset: "mydataset"
        description: "bigquery-dataset"
        friendlyName: "billing dataset"
        location: "europe"
        access:
        - role: OWNER
            userByEmail: bigquerydataset-dep@${PROJECT_ID?}.iam.gserviceaccount.com
        - role: WRITER
            specialGroup: projectWriters
        - role: READER
            domain: google.com

  destination:
    server: https://kubernetes.default.svc
    namespace: "cnrm-system"
  syncPolicy:
    automated:
      prune: true
```

## Develop

### Config Connector ressources

This chart is based on GCP config connector ressources. All CRDs description are available on [gcp documentation](https://cloud.google.com/config-connector/docs/reference/overview)

### Update documentation

This documentation was generated through [helm-docs](https://github.com/norwoodj/helm-docs). If you want to generate it:

```bash
docker run --rm -it -v $(pwd):/helm --workdir /helm jnorwood/helm-docs:v1.14.2 helm-docs
```

### Run linter

```bash
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/bigquery-dataset --config /charts/charts/bigquery-dataset/ct.yaml
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template bigquery-dataset . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```
