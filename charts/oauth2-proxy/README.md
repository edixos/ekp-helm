# oauth2-proxy

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 7.15.5](https://img.shields.io/badge/AppVersion-7.15.5-informational?style=flat-square)

**Homepage:** <https://oauth2-proxy.github.io/oauth2-proxy/>

## Prerequisites

- Helm v3
- An OIDC provider
- External Secrets Operator, if the client credentials are delivered through `externalSecrets`

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://oauth2-proxy.github.io/manifests | oauth2-proxy(oauth2-proxy) | 10.7.1 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| smileisak | <ikaboubi@gmail.com> | <https://github.com/smileisak> |

## Description

A Helm chart for oauth2-proxy, with its OAuth client credentials delivered by External Secrets

## Source Code

* <https://github.com/oauth2-proxy/oauth2-proxy>

## Installing the Chart

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm repo update
helm install oauth2-proxy ekp-helm/oauth2-proxy --namespace oauth2-proxy
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| externalSecrets | list | `[]` | ExternalSecrets rendered in the release namespace, typically the one that writes `oauth2-proxy.config.existingSecret`. Each item: { name, namespace?, spec }. |
| oauth2-proxy | object | `{}` | Values of the upstream oauth2-proxy chart. See https://github.com/oauth2-proxy/manifests/blob/main/helm/oauth2-proxy/values.yaml. |

## Develop

### Update Documentation

```bash
docker run --rm -it -v $(pwd):/helm --workdir /helm jnorwood/helm-docs:v1.14.2 helm-docs
```

### Run Pluto

```bash
helm template oauth2-proxy . -f tests/pluto/values.yaml --output-dir /tmp/pluto
pluto detect-files -d /tmp/pluto -o wide -t "k8s=v1.31.0"
```
