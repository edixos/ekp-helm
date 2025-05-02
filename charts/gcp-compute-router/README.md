# gcp-compute-router

![Version: 0.1.1](https://img.shields.io/badge/Version-0.1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.1](https://img.shields.io/badge/AppVersion-0.1.1-informational?style=flat-square)

## Prerequisites

- Helm v3
- Config Connector installed (v1.6.0)

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| ilyasabdellaoui | <ilyas.abdellaoui21@gmail.com> | <https://github.com/ilyasabdellaoui> |

## Description

A Helm chart to provision a Google Compute Router via Config Connector

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.cnrmNamespace | string | `nil` | Allows to deploy in another namespace than the release one |
| global.gcpProjectId | string | `"myprojectid"` | Google Project ID |
| global.abandon | bool | `true` | If true, Keep the Compute Router even after the kcc resource deletion. |
| annotations | object | `{}` | Add annotations to the Compute Router. |
| name | string | `"ekp-router"` | Name of the Compute Router. |
| description | string | `"Compute Router for managing BGP routing"` | A text description of the Compute Router. Must be less than or equal to 256 UTF-8 bytes. |
| region | string | `"europe-west1"` | Immutable. Region where the router resides. |
| resourceID | string | `nil` | Immutable. Optional. The name of the resource. Used for creation and acquisition. When unset, the value of `metadata.name` is used as the default. |
| encryptedInterconnectRouter | string | `nil` | Immutable. Indicates if a router is dedicated for use with encrypted VLAN attachments (interconnectAttachments). |
| networkRef | object | `{"external":"","name":"","namespace":""}` | A reference to the network to which this router belongs. |
| networkRef.external | string | `""` | Allowed value: The `selfLink` field of a `ComputeNetwork` resource. |
| networkRef.name | string | `""` | Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names |
| networkRef.namespace | string | `""` | Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/ |
| bgp | object | `{"advertiseMode":"DEFAULT","advertisedGroups":[],"advertisedIpRanges":[{"description":null,"range":null}],"asn":null,"keepaliveInterval":20}` | BGP information specific to this router. |
| bgp.asn | string | `nil` | Local BGP Autonomous System Number (ASN). Must be an RFC6996 private ASN, either 16-bit or 32-bit. The value will be fixed for this router resource. All VPN tunnels that link to this router will have the same local ASN. |
| bgp.advertiseMode | string | `"DEFAULT"` | User-specified flag to indicate which mode to use for advertisement. Default value: "DEFAULT" Possible values: ["DEFAULT", "CUSTOM"]. |
| bgp.advertisedGroups | list | `[]` | User-specified list of prefix groups to advertise in custom mode. This field can only be populated if advertiseMode is CUSTOM and is advertised to all peers of the router. These groups will be advertised in addition to any specified prefixes. Leave this field blank to advertise no custom groups. This enum field has the one valid value: ALL_SUBNETS. |
| bgp.advertisedIpRanges | list | `[{"description":null,"range":null}]` | User-specified list of individual IP ranges to advertise in custom mode. This field can only be populated if advertiseMode is CUSTOM and is advertised to all peers of the router. These IP ranges will be advertised in addition to any specified groups. Leave this field blank to advertise no custom IP ranges. |
| bgp.advertisedIpRanges[0] | object | `{"description":null,"range":null}` | User-specified description for the IP range. |
| bgp.advertisedIpRanges[0].range | string | `nil` | The IP range to advertise. The value must be a CIDR-formatted string. |
| bgp.keepaliveInterval | int | `20` | The interval in seconds between BGP keepalive messages that are sent to the peer. Hold time is three times the interval at which keepalive messages are sent, and the hold time is the maximum number of seconds allowed to elapse between successive keepalive messages that BGP receives from a peer. BGP will use the smaller of either the local hold time value or the peer's hold time value as the hold time for the BGP connection between the two peers. If set, this value must be between 20 and 60. The default is 20. |

## Installing the Chart

### With Helm

To install the chart with the release name `my-release`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/gcp-compute-router
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: gcp-compute-router
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.1"
    chart: gcp-compute-router
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
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/gcp-compute-router --config /charts/charts/gcp-compute-router/ct.yaml
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template gcp-compute-router . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```

