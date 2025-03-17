# bucket

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.16.0](https://img.shields.io/badge/AppVersion-1.16.0-informational?style=flat-square)

A Helm chart for Bucket

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| wiemaouadi | <wiem.aouadi3@gmail.com> | <https://github.com/wiemaouadi> |
| smileisak | <ikaboubi@gmail.com> | <https://github.com/smileisak> |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| accessControl | object | `{"createCloudIamPolicy":true,"iamPolicy":[{"member":"serviceAccount:sa-name@${gcpProjectId?}.iam.gserviceaccount.com","role":"roles/storage.admin"}],"publicAccessPrevention":"inherited","uniformBucketLevelAccess":false}` | Configure access control for the bucket |
| accessControl.createCloudIamPolicy | bool | `true` | Create iam policy member for the bucket through kcc, based on the `iamPolicy` list. |
| accessControl.iamPolicy[0].member | string | `"serviceAccount:sa-name@${gcpProjectId?}.iam.gserviceaccount.com"` | An identifier for the member, which usually has the following form: member-type:id. For example, user:my-user@example.com. For a full list of the values that member can have, see the [Policy Binding reference](https://cloud.google.com/iam/docs/reference/rest/v1/Policy#Binding). |
| accessControl.iamPolicy[0].role | string | `"roles/storage.admin"` | Name of the [role](https://cloud.google.com/storage/docs/access-control/iam-roles) to apply to the bucket |
| accessControl.publicAccessPrevention | string | `"inherited"` | The bucket's public access prevention status, which is either "inherited" or "enforced". If "inherited", the bucket uses public access prevention only if the bucket is subject to the public access prevention organization policy constraint. |
| accessControl.uniformBucketLevelAccess | bool | `false` | Activate [uniform bucket-level access](https://cloud.google.com/storage/docs/uniform-bucket-level-access) |
| annotations | object | `{}` | Add annotations to this chart resources |
| bucketName | string | `"myfirstbucket"` | Name of the bucket. Must be unique. |
| cors | list | See the `values.yaml` for more details | The bucket's [Cross-Origin Resource Sharing](https://en.wikipedia.org/wiki/Cross-origin_resource_sharing#:~:text=Cross%2Dorigin%20resource%20sharing%20(CORS,scripts%2C%20iframes%2C%20and%20videos.) (CORS) configuration. |
| defaultEventBasedHold | bool | `false` | Whether or not to automatically apply an [eventBasedHold](https://cloud.google.com/storage/docs/object-holds#hold-types) to new objects added to the bucket. |
| enableVersioning | bool | `false` | Activate bucket versioning |
| encryption.enabled | bool | `false` | Enables customer-supplied or customer-managed encryption. By default, Bucket are encrypted |
| encryption.kccControlled | bool | `false` | Specify if the KMS key was created through Kubernetes Config Connector on the same cluster or if it was create outside. |
| encryption.kmsKeyRefName | string | `"mykms"` | Name of the Cloud KMS key that will be used to encrypt objects inserted into this bucket |
| encryption.kmsKeyRefNamespace | string | `nil` | Namespace where the KMS key was created through KCC. Only use if kccControlled=true |
| global.abandon | bool | `true` | Activate abandon of the database (If true, the database will be keep after deleting k8s resources) |
| global.abandon | bool | `true` | Activate abandon of the database (If true, the database will be keep after deleting k8s resources) |
| global.cnrmNamespace | string | `nil` | Allows to deploy in another namespace than the release one |
| global.gcpProjectId | string | `"myprojectid"` | Google Project ID |
| lifecycleRule | list | See the `values.yaml` for more details | The bucket's lifecycle configuration. See [lifecycle management](https://cloud.google.com/storage/docs/lifecycle) for more information. |
| logging.enabled | bool | `false` | Enables logging for the bucket |
| logging.logBucket | string | `"access_log_gcs_irn70740_lab_adm"` | The destination bucket where the current bucket's logs should be placed. |
| logging.logObjectPrefix | string | `nil` | A prefix for log object names. The default prefix is the bucket name. |
| requestPays | bool | `false` | Charge the requester instead of the owner |
| retentionPolicy | object | `{"enabled":false,"isLocked":true,"retentionPeriod":8192}` | Bucket's retention policy configuration |
| retentionPolicy.enabled | bool | `false` | Enables the bucket's retention policy |
| retentionPolicy.isLocked | bool | `true` | Whether or not the retentionPolicy is locked. If true, the retentionPolicy cannot be removed and the retention period cannot be reduced. |
| retentionPolicy.retentionPeriod | int | `8192` | The period of time, in seconds, that objects in the bucket must be retained and cannot be deleted, overwritten, or made noncurrent. The value must be greater than 0 seconds and less than 3,155,760,000 seconds. |
| storageClass | string | `"STANDARD"` | Type of [storage class](https://cloud.google.com/storage/docs/storage-classes). Accepted values: [STANDARD, NEARLINE, COLDLINE, ARCHIVE] |
| website | object | `{"enabled":false,"mainPageSuffix":"index.html","notFoundPage":"404.html"}` | Website configuration of the bucket |
| website.enabled | bool | `false` | Enable website feature of the bucket |
| website.mainPageSuffix | string | `"index.html"` | Main page name |
| website.notFoundPage | string | `"404.html"` | Name of the page containing the 404 error page |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
