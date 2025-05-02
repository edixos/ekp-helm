# gcp-vpc-network

![Version: 0.1.3](https://img.shields.io/badge/Version-0.1.3-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.3](https://img.shields.io/badge/AppVersion-0.1.3-informational?style=flat-square)

## Prerequisites

- Helm v3
- Config Connector installed (v1.6.0)

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| ilyasabdellaoui | <ilyas.abdellaoui21@gmail.com> | <https://github.com/ilyasabdellaoui> |

## Description

A Helm chart that Creates a Google VPC Network through Config Connector

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.cnrmNamespace | string | `nil` | Allows to deploy in another namespace than the release one |
| global.gcpProjectId | string | `"myprojectid"` | Google Project ID |
| global.abandon | bool | `false` | Keep the VPC even after the kcc resource deletion. |
| name | string | `"ekp-vpc"` | Name of the VPC Network. |
| displayName | string | `"EKP VPC"` | The display name for the VPC Network. Can be updated without creating a new resource. |
| description | string | `"EKP VPC Network for infrastructure."` | A text description of the VPC Network. Must be less than or equal to 256 UTF-8 bytes. |
| autoCreateSubnetworks | bool | `false` | Enable custom subnet creation. If false, the VPC Network will not create subnets. |
| deleteDefaultRoutesOnCreate | bool | `false` | Keep the default routes on creation by default. If true, the VPC Network will delete the default routes. |
| mtu | int | `1460` | Maximum Transmission Unit in bytes. |
| routingMode | string | `"REGIONAL"` | Routing mode for the VPC Network. |
| enableUlaInternalIpv6 | bool | `false` | Enable ULA internal ipv6 on this network. |
| internalIpv6Range | string | `""` | Internal IPv6 range for ULA internal ipv6. |
| networkFirewallPolicyEnforcementOrder | string | `"AFTER_CLASSIC_FIREWALL"` | The order that Firewall Rules and Firewall Policies are evaluated. Default value: "AFTER_CLASSIC_FIREWALL" Possible values: ["BEFORE_CLASSIC_FIREWALL", "AFTER_CLASSIC_FIREWALL"]. |
| resourceID | string | `""` | Optional resource ID. |
| annotations | object | `{}` | Add annotations to the VPC Network. |

## Installing the Chart

### With Helm

To install the chart with the release name `my-release`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/gcp-vpc-network
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: gcp-vpc-network
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.3"
    chart: gcp-vpc-network
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
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/gcp-vpc-network --config /charts/charts/gcp-vpc-network/ct.yaml
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template gcp-vpc-network . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```

