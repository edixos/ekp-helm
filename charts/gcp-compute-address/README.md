# gcp-compute-address

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

## Prerequisites

- Helm v3
- Config Connector installed (v1.6.0)

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| ilyasabdellaoui | <ilyas.abdellaoui21@gmail.com> | <https://github.com/ilyasabdellaoui> |

## Description

A Helm chart to provision a Compute Address via Config Connector

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.cnrmNamespace | string | `nil` | Allows to deploy in another namespace than the release one |
| global.gcpProjectId | string | `"myprojectid"` | Google Project ID |
| global.abandon | bool | `true` | If true, Keep the Compute Address even after the kcc resource deletion. |
| annotations | object | `{}` | Add annotations to the Compute Address. |
| name | string | `"gcp-static-ip"` | Name of Compute Address |
| address | string | `""` | Optional: The static external IP address represented by this resource.    Must be inside the specified subnetwork if defined. |
| addressType | string | `"EXTERNAL"` | The type of address to reserve.    Valid options: "INTERNAL" or "EXTERNAL". Default: "EXTERNAL". |
| description | string | `"Compute Address configuration for Google Compute Router"` | A text description of the Compute Address.    Must be less than or equal to 256 UTF-8 bytes. |
| ipVersion | string | `"IPV4"` | The IP Version that will be used by this address.    Valid options: "IPV4", "IPV6". Default: "IPV4". |
| ipv6EndpointType | string | `""` | The endpoint type for an IPv6 address.    Valid options: "VM", "NETLB". |
| location | string | `"europe-west1-b"` | The geographical location for the Compute Address.    Specify a region (e.g., "us-central1") or "global" for global resources. |
| networkTier | string | `"STANDARD"` | The networking tier used for configuring this address.    Valid options: "PREMIUM", "STANDARD".    Should not be used with INTERNAL addresses. |
| prefixLength | string | `nil` | The prefix length if the resource represents an IP range. |
| purpose | string | `nil` | The purpose of this resource.    Valid options include:      "GCE_ENDPOINT", "SHARED_LOADBALANCER_VIP", "VPC_PEERING",      "IPSEC_INTERCONNECT", "PRIVATE_SERVICE_CONNECT" |
| networkRef | object | `{"external":"","name":"","namespace":""}` | Optional: Network reference configuration.    Only applicable for INTERNAL addresses with VPC_PEERING or IPSEC_INTERCONNECT purposes. |
| networkRef.external | string | `""` | The selfLink of the ComputeNetwork resource. |
| networkRef.name | string | `""` | The name of the referent. |
| networkRef.namespace | string | `""` | The namespace of the referent. |
| subnetworkRef | object | `{"external":"","name":"","namespace":""}` | Optional: Subnetwork reference configuration.    Only applicable for INTERNAL addresses with GCE_ENDPOINT/DNS_RESOLVER purposes. |
| subnetworkRef.external | string | `""` | The selfLink of the ComputeSubnetwork resource. |
| subnetworkRef.name | string | `""` | The name of the referent. |
| subnetworkRef.namespace | string | `""` | The namespace of the referent. |

## Installing the Chart

### With Helm

To install the chart with the release name `my-release`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/gcp-compute-address
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: gcp-compute-address
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.0"
    chart: gcp-compute-address
    path: ''

    helm:

      values:

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
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/gcp-compute-address --config /charts/charts/gcp-compute-address/ct.yaml
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template gcp-compute-address . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```

