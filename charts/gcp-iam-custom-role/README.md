# gcp-iam-custom-role

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

A Helm chart for iam custom role

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| wiemaouadi | <wiem.aouadi3@gmail.com> | <https://github.com/wiemaouadi> |
| smileisak | <ikaboubi@gmail.com> | <https://github.com/smileisak> |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| customRoleName | string | `"velero"` | The name of the IAM Custom Role |
| description | string | `"The description of the custom role resource"` | A human-readable description for the role |
| global.cnrmNamespace | string | `""` | Allows to deploy in another namespace than the release one |
| global.gcpOrganisationId | string | `""` | Organisation ID where to deploy the custom role |
| global.gcpProjectId | string | `"myprojectid"` | Project ID where to deploy the custom role |
| global.skipUnspecifiedFields | bool | `false` | This skips populating unspecified fields into the Kubernetes resource spec |
| permissions | list | `[]` | custom role permissions |
| title | string | `"velero"` | A human-readable title for the role |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
