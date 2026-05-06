# kyverno-policies

![Version: 0.1.5](https://img.shields.io/badge/Version-0.1.5-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.18.0](https://img.shields.io/badge/AppVersion-v1.18.0-informational?style=flat-square)

## Prerequisites

- Helm v3
- Config Connector installed (v1.6.0)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://kyverno.github.io/kyverno/ | kyvernopolicies(kyverno-policies) | 3.8.0 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| wiemaouadi | <wiem.aouadi3@gmail.com> | <https://github.com/wiemaouadi> |
| smileisak | <ikaboubi@gmail.com> | <https://github.com/smileisak> |

## Description

A Helm chart for Kubernetes

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| kyvernopolicies.auditAnnotations | object | `{}` | Default audit annotations applied to all ValidatingPolicy policies (policyType: ValidatingPolicy only). Map of annotation key to CEL valueExpression. Audit annotations are recorded in the API server audit log. For more info https://kyverno.io/docs/policy-types/validating-policy/#using-auditannotations-to-add-custom-data |
| kyvernopolicies.auditAnnotationsByPolicy | object | `{}` | Define audit annotations for specific ValidatingPolicy policies (policyType: ValidatingPolicy only). Per-policy entries override defaults when they share the same key. |
| kyvernopolicies.autogenControllers | string | `""` | Customize the target Pod controllers for the auto-generated rules. (Eg. `none`, `Deployment`, `DaemonSet,Deployment,StatefulSet`) For more info https://kyverno.io/docs/policy-types/cluster-policy/autogen/. |
| kyvernopolicies.background | bool | `true` | Policies background mode |
| kyvernopolicies.customAnnotations | object | `{}` | Additional Annotations. |
| kyvernopolicies.customAnnotationsByPolicy | object | `{}` | Define custom annotations for specific policies. Per-policy entries override defaults when they share the same key. |
| kyvernopolicies.customLabels | object | `{}` | Additional labels. |
| kyvernopolicies.customPolicies | list | `[]` | Additional custom policies to include. |
| kyvernopolicies.failurePolicy | string | `"Fail"` | API server behavior if the webhook fails to respond ('Ignore', 'Fail') For more info: https://kyverno.io/docs/policy-types/cluster-policy/policy-settings/ |
| kyvernopolicies.includeOtherPolicies | list | `[]` | Additional policies to include from `other`. |
| kyvernopolicies.includeRestrictedPolicies | list | `[]` | Additional policies to include from `restricted`. |
| kyvernopolicies.kubeVersionOverride | string | `nil` | Kubernetes version override Override default value of kubeVersion set by release team taken from Chart.yaml with custom value. Ideally range of versions no more than two prior (ex., 1.28-1.31), must be enclosed in quotes. |
| kyvernopolicies.kyvernoVersion | string | `"autodetect"` | Kyverno version The default of "autodetect" will try to determine the currently installed version from the deployment |
| kyvernopolicies.nameOverride | string | `nil` | Name override. |
| kyvernopolicies.podSecurityPolicies | list | `[]` | Policies to include when `podSecurityStandard` is `custom`. |
| kyvernopolicies.podSecuritySeverity | string | `"medium"` | Pod Security Standard severity (`low`, `medium`, `high`). |
| kyvernopolicies.podSecuritySeverityByPolicy | object | `{}` | Define podSecuritySeverity overrides for specific policies. Override the global `podSecuritySeverity` with an individual severity for individual policies. An empty string per-policy entry suppresses the annotation entirely. |
| kyvernopolicies.podSecurityStandard | string | `"baseline"` | Pod Security Standard profile (`baseline`, `restricted`, `privileged`, `custom`). For more info https://kyverno.io/policies/pod-security. |
| kyvernopolicies.policyExclude | object | `{}` | Exclude resources from individual policies (policyType: ClusterPolicy only). Policies with multiple rules can have individual rules excluded by using the name of the rule as the key in the `policyExclude` map. NOTE: This setting only applies when policyType is set to ClusterPolicy. For ValidatingPolicy, use vpolExclude/vpolExcludeByPolicy instead. |
| kyvernopolicies.policyKind | string | `"ClusterPolicy"` | Policy kind (`ClusterPolicy`, `Policy`) Set to `Policy` if you need namespaced policies and not cluster policies |
| kyvernopolicies.policyPreconditions | object | `{}` | Add preconditions to individual policies. Policies with multiple rules can have individual rules excluded by using the name of the rule as the key in the `policyPreconditions` map. |
| kyvernopolicies.policyType | string | `"ClusterPolicy"` | Policy engine type (`ClusterPolicy`, `ValidatingPolicy`) Set to `ValidatingPolicy` to use CEL-based policies (requires Kyverno 1.17+) ClusterPolicy will be deprecated in Kyverno 1.17 Default: ClusterPolicy (for backward compatibility) |
| kyvernopolicies.skipBackgroundRequests | bool | `nil` | SkipBackgroundRequests bypasses admission requests that are sent by the background controller |
| kyvernopolicies.validationAllowExistingViolations | bool | `true` | Validate already existing resources. For more info https://kyverno.io/docs/policy-types/. |
| kyvernopolicies.validationFailureAction | string | `"Audit"` | Validation failure action (`Audit`, `Enforce`). For more info https://kyverno.io/docs/policy-types/cluster-policy/validate. |
| kyvernopolicies.validationFailureActionByPolicy | object | `{}` | Define validationFailureActionByPolicy for specific policies. Override the defined `validationFailureAction` with a individual validationFailureAction for individual Policies. |
| kyvernopolicies.validationFailureActionOverrides | object | `{"all":[]}` | Define validationFailureActionOverrides for specific policies. The overrides for `all` will apply to all policies. |
| kyvernopolicies.vpolExclude | object | `{}` | Default excludes applied to ALL ValidatingPolicy policies (policyType: ValidatingPolicy only). NOTE: This setting only applies when policyType is set to ValidatingPolicy. For ClusterPolicy, use policyExclude instead. Supports the following optional keys:   excludeResourceRules: list of Kubernetes NamedRuleWithOperations (native VAP excludes)   excludeNamespaces:    list of namespace names to exclude (generates CEL matchCondition)   excludeSubjects:      list of subjects to exclude (generates CEL matchCondition)   matchConditions:      list of CEL matchConditions for advanced filtering (passthrough of custom condition) Per-policy overrides via vpolExcludeByPolicy replace these defaults entirely for that policy. |
| kyvernopolicies.vpolExcludeByPolicy | object | `{}` | Per-policy excludes for individual ValidatingPolicy policies (policyType: ValidatingPolicy only). When set for a policy, it completely replaces the global vpolExclude defaults for that policy. NOTE: This setting only applies when policyType is set to ValidatingPolicy. For ClusterPolicy, use policyExclude instead. Each policy name maps to an object with the same keys as vpolExclude. |

## Installing the Chart

### With Helm

To install the chart with the release name `my-release`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/kyverno-policies
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: kyverno-policies
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.5"
    chart: kyverno-policies
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

## Develop

### Update documentation

Chart documentation is generated with [helm-docs](https://github.com/norwoodj/helm-docs) from `values.yaml` file.
After file modification, regenerate README.md with command:

```bash
docker run --rm -it -v $(pwd):/helm --workdir /helm jnorwood/helm-docs:v1.14.2 helm-docs
```

### Run linter

```bash
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/kyverno-policies --config /charts/charts/kyverno-policies/ct.yaml
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template kyverno-policies . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```

