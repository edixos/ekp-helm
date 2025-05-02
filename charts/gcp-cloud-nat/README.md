# gcp-cloud-nat

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

## Prerequisites

- Helm v3
- Config Connector installed (v1.6.0)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://edixos.github.io/ekp-helm | gcpCloudRouter(gcp-compute-router) | 0.1.1 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| ilyasabdellaoui | <ilyas.abdellaoui21@gmail.com> | <https://github.com/ilyasabdellaoui> |

## Description

A Helm chart to provision a Cloud NAT (ComputeRouterNAT) via Config Connector

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.cnrmNamespace | string | `nil` | Allows to deploy in another namespace than the release one |
| global.gcpProjectId | string | `"myprojectid"` | Google Project ID |
| global.abandon | bool | `true` | If true, Keep the Cloud NAT even after the kcc resource deletion. |
| annotations | object | `{}` | Add annotations to the Cloud NAT. |
| name | string | `"ekp-cloud-nat"` | Name of the Compute Router. |
| description | string | `"Cloud NAT configuration for Google Compute Router"` | A text description of the Cloud NAT. Must be less than or equal to 256 UTF-8 bytes. |
| drainNatIps | list | `[]` | A list of IP resources to be drained. These IPs must be valid static external IPs that have been assigned to the NAT. |
| enableDynamicPortAllocation | bool | `false` | Enable Dynamic Port Allocation. If minPortsPerVm is set, minPortsPerVm must be set to a power of two greater than or equal to 32. If minPortsPerVm is not set, a minimum of 32 ports will be allocated to a VM from this NAT config. If maxPortsPerVm is set, maxPortsPerVm must be set to a power of two greater than minPortsPerVm. If maxPortsPerVm is not set, a maximum of 65536 ports will be allocated to a VM from this NAT config. Mutually exclusive with enableEndpointIndependentMapping. |
| enableEndpointIndependentMapping | bool | `true` | Specifies if endpoint independent mapping is enabled. This is enabled by default. For more information see the [official documentation](https://cloud.google.com/nat/docs/overview#specs-rfcs). |
| icmpIdleTimeoutSec | int | `30` | Timeout (in seconds) for ICMP connections. Defaults to 30s if not set. |
| logConfig | object | `{"enable":false,"filter":"ALL"}` | Configuration for logging on NAT. |
| logConfig.enable | bool | `false` | Indicates whether or not to export logs. |
| logConfig.filter | string | `"ALL"` | Specifies the desired filtering of logs on this NAT. Possible values: ["ERRORS_ONLY", "TRANSLATIONS_ONLY", "ALL"]. |
| maxPortsPerVm | int | `0` | Maximum number of ports allocated to a VM from this NAT. This field can only be set when enableDynamicPortAllocation is enabled. |
| minPortsPerVm | int | `0` | Minimum number of ports allocated to a VM from this NAT. |
| natIpAllocateOption | string | `"AUTO_ONLY"` | How external IPs should be allocated for this NAT. Valid values are 'AUTO_ONLY' for only allowing NAT IPs allocated by Google Cloud Platform, or 'MANUAL_ONLY' for only user-allocated NAT IP addresses. Possible values: ["MANUAL_ONLY", "AUTO_ONLY"]. |
| natIps | list | `[]` | NAT IPs. Only valid if natIpAllocateOption is set to MANUAL_ONLY. |
| region | string | `"europe-west1"` | Immutable. Region where the router and NAT reside. |
| resourceID | string | `""` | Immutable. Optional. The name of the resource. Used for creation and acquisition. When unset, the value of `metadata.name` is used as the default. |
| routerRef | object | `{"external":"","name":"","namespace":""}` | The Cloud Router in which this NAT will be configured. |
| routerRef.external | string | `""` | Allowed value: The `name` field of a `ComputeRouter` resource. |
| routerRef.name | string | `""` | Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names |
| routerRef.namespace | string | `""` | Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/ |
| rules | list | `[]` | A list of rules associated with this NAT. |
| sourceSubnetworkIpRangesToNat | string | `"ALL_SUBNETWORKS_ALL_IP_RANGES"` | How NAT should be configured per Subnetwork. If 'ALL_SUBNETWORKS_ALL_IP_RANGES', all of the IP ranges in every Subnetwork are allowed to Nat. If 'ALL_SUBNETWORKS_ALL_PRIMARY_IP_RANGES', all of the primary IP ranges in every Subnetwork are allowed to Nat. 'LIST_OF_SUBNETWORKS': A list of Subnetworks are allowed to Nat (specified in the field subnetwork below). Note that if this field contains ALL_SUBNETWORKS_ALL_IP_RANGES or ALL_SUBNETWORKS_ALL_PRIMARY_IP_RANGES, then there should not be any other RouterNat section in any Router for this network in this region. Possible values: ["ALL_SUBNETWORKS_ALL_IP_RANGES", "ALL_SUBNETWORKS_ALL_PRIMARY_IP_RANGES", "LIST_OF_SUBNETWORKS"]. |
| subnetwork | list | `[]` | One or more subnetwork NAT configurations. Only used if 'source_subnetwork_ip_ranges_to_nat' is set to 'LIST_OF_SUBNETWORKS'. |
| tcpEstablishedIdleTimeoutSec | int | `1200` | Timeout (in seconds) for TCP established connections. Defaults to 1200s if not set. |
| tcpTimeWaitTimeoutSec | int | `120` | Timeout (in seconds) for TCP connections that are in TIME_WAIT state. Defaults to 120s if not set. |
| tcpTransitoryIdleTimeoutSec | int | `30` | Timeout (in seconds) for TCP transitory connections. Defaults to 30s if not set. |
| udpIdleTimeoutSec | int | `30` | Timeout (in seconds) for UDP connections. Defaults to 30s if not set. |

## Installing the Chart

### With Helm

To install the chart with the release name `my-release`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/gcp-cloud-nat
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: gcp-cloud-nat
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.0"
    chart: gcp-cloud-nat
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
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/gcp-cloud-nat --config /charts/charts/gcp-cloud-nat/ct.yaml
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template gcp-cloud-nat . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```

