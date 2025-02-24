# gcp-subnetwork

![Version: 0.1.3](https://img.shields.io/badge/Version-0.1.3-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.3](https://img.shields.io/badge/AppVersion-0.1.3-informational?style=flat-square)

**Homepage:** <https://github.com/edixos/ekp-helm>

## Prerequisites

- Helm v3
- Config Connector installed (v1.6.0)

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| smileisak | <ikaboubi@gmail.com> | <https://github.com/smileisak> |

## Description

Chart for compute-subnetwork resource with config connector

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.abandon | bool | `true` | Abandon resource if the manifests are deleted. Allow deleting a resource from config connector without deleting it from GCP |
| global.cnrmNamespace | string | `nil` | Allows to deploy in another namespace than the release one |
| global.description | string | `""` | subNework description (use helm tpl) |
| global.gcpProjectId | string | `"myprojectid"` | Project ID where to deploy the cluster |
| global.skipUnspecifiedFields | bool | `false` | This skips populating unspecified fields into the Kubernetes resource spec. |
| ipCidrRange | string | `"10.3.192.0/23"` | The range of internal addresses that are owned by this subnetwork. Only IPv4 is supported. |
| ipv6AccessType | string | `""` | The access type of IPv6 address this subnet holds. Possible values: ["EXTERNAL", "INTERNAL"]. |
| name | string | `"test-subnetwork"` | The name of the resource. |
| networkRef | object | `{}` | The network this subnet belongs to. Only networks that are in the distributed mode can have subnetworks. |
| privateIpGoogleAccess | string | `""` | When enabled, VMs in this subnetwork without external IP addresses can access Google APIs and services by using Private Google Access. |
| privateIpv6GoogleAccess | string | `nil` | The private IPv6 google access type for the VMs in this subnet. |
| purpose | string | `"REGIONAL_MANAGED_PROXY"` | The purpose of the resource.  This field can be either 'PRIVATE_RFC_1918', 'REGIONAL_MANAGED_PROXY', 'GLOBAL_MANAGED_PROXY', or 'PRIVATE_SERVICE_CONNECT'. |
| region | string | `"europe-west1"` | The GCP region for this subnetwork. |
| resourceID | string | `nil` | The name of the resource. Used for creation and acquisition. When unset, the value of `metadata.name` is used as the default. |
| role | string | `"ACTIVE"` |  |
| secondaryIpRange | list | `[]` | The secondary range of the subnetwork. |
| stackType | string | `""` | The stack type for this subnet to identify whether the IPv6 feature is enabled or not. Possible values: ["IPV4_ONLY", "IPV4_IPV6"]. |

## Installing the Chart

### With Helm

To install the chart with the release name `my-release`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/gcp-subnetwork
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: gcp-subnetwork
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.3"
    chart: gcp-subnetwork
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
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/gcp-subnetwork --config /charts/charts/gcp-subnetwork/ct.yaml
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template gcp-subnetwork . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```

