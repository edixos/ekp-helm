# descheduler

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.36.0](https://img.shields.io/badge/AppVersion-0.36.0-informational?style=flat-square)

**Homepage:** <https://sigs.k8s.io/descheduler>

## Prerequisites

- Helm v3

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://kubernetes-sigs.github.io/descheduler/ | descheduler(descheduler) | 0.36.0 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| smileisak | <ikaboubi@gmail.com> | <https://github.com/smileisak> |

## Description

A Helm chart for the Kubernetes descheduler, which evicts pods so the scheduler can place them on better-suited nodes

## Source Code

* <https://github.com/kubernetes-sigs/descheduler>

## Installing the Chart

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm repo update
helm install descheduler ekp-helm/descheduler --namespace kube-system
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| descheduler | object | `{}` | Values of the upstream descheduler chart. See https://github.com/kubernetes-sigs/descheduler/blob/master/charts/descheduler/values.yaml. |

## Develop

### Update Documentation

```bash
docker run --rm -it -v $(pwd):/helm --workdir /helm jnorwood/helm-docs:v1.14.2 helm-docs
```

### Run Pluto

```bash
helm template descheduler . -f tests/pluto/values.yaml --output-dir /tmp/pluto
pluto detect-files -d /tmp/pluto -o wide -t "k8s=v1.31.0"
```
