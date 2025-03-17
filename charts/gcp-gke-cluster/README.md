# gcp-gke-cluster

![Version: 0.1.2](https://img.shields.io/badge/Version-0.1.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.2](https://img.shields.io/badge/AppVersion-0.1.2-informational?style=flat-square)

- [gke-cluster](#gcp-gke-cluster)
  - [Prerequisites](#prerequisites)
  - [Maintainers](#maintainers)
  - [Description](#description)
  - [Values](#values)
  - [GKE Immutable Fields](#gke-immutable-fields)
  - [Nodepool Immutable Fields](#nodepool-immutable-fields)
  - [Installing the Chart](#installing-the-chart)
    - [With Helm](#with-helm)
    - [With ArgoCD](#with-argocd)
  - [Develop](#develop)
    - [Update documentation](#update-documentation)
    - [Run linter](#run-linter)
    - [Run pluto](#run-pluto)

## Prerequisites

- Helm v3
- Config Connector installed (v1.6.0)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://edixos.github.io/ekp-helm | bigquery-dataset(gcp-bigquery-dataset) | 0.1.0 |
| https://edixos.github.io/ekp-helm | gcpSubnetwork(gcp-subnetwork) | 0.1.5 |
| https://edixos.github.io/ekp-helm | gcpVpcNetwork(gcp-vpc-network) | 0.1.3 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| ilyasabdellaoui | <ilyas.abdellaoui21@gmail.com> | <https://github.com/ilyasabdellaoui> |

## Description

A Helm chart to provision a GKE Cluster via Config Connector.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| addonsConfig | object | `{"cloudrunConfig":{"disabled":true,"loadBalancerType":null},"configConnectorConfig":{"enabled":false},"dnsCacheConfig":{"enabled":false},"gcePersistentDiskCsiDriverConfig":{"enabled":false},"gcpFilestoreCsiDriverConfig":{"enabled":false},"gcsFuseCsiDriverConfig":{"enabled":false},"gkeBackupAgentConfig":{"enabled":false},"horizontalPodAutoscaling":{"disabled":true},"httpLoadBalancing":{"disabled":false},"istioConfig":{"auth":"AUTH_MUTUAL_TLS","disabled":true},"kalmConfig":{"enabled":false},"networkPolicyConfig":{"disabled":true}}` | Configuration for addons and optional features |
| addonsConfig.cloudrunConfig | object | `{"disabled":true,"loadBalancerType":null}` | The status of the CloudRun addon |
| addonsConfig.cloudrunConfig.disabled | bool | `true` | Disables Anthos Cloud Run. |
| addonsConfig.cloudrunConfig.loadBalancerType | string | `nil` | Load balancer type of ingress service of Cloud Run (LOAD_BALANCER_TYPE_UNSPECIFIED, LOAD_BALANCER_TYPE_EXTERNAL or LOAD_BALANCER_TYPE_INTERNAL) |
| addonsConfig.configConnectorConfig | object | `{"enabled":false}` | Config Connector addon configuration |
| addonsConfig.configConnectorConfig.enabled | bool | `false` | Whether Config Connector addon is enabled |
| addonsConfig.dnsCacheConfig | object | `{"enabled":false}` | DNS cache configuration |
| addonsConfig.dnsCacheConfig.enabled | bool | `false` | The status of the NodeLocal DNSCache addon. It is disabled by default. |
| addonsConfig.gcePersistentDiskCsiDriverConfig | object | `{"enabled":false}` | Configuration for the Google Compute Engine ersistent Disk Container Storage Interface (CSI) Driver. |
| addonsConfig.gcePersistentDiskCsiDriverConfig.enabled | bool | `false` | Whether the GCE Persistent Disk CSI Driver is enabled. |
| addonsConfig.gcpFilestoreCsiDriverConfig | object | `{"enabled":false}` | Configuration for Filestore CSI driver addon, which allows the usage of filestore instance as volumes. |
| addonsConfig.gcpFilestoreCsiDriverConfig.enabled | bool | `false` | Whether the Filestore CSI Driver is enabled. |
| addonsConfig.gcsFuseCsiDriverConfig | object | `{"enabled":false}` | Configuration for the GCS Fuse CSI driver addon, which allows the usage of gcs bucket as volumes. |
| addonsConfig.gcsFuseCsiDriverConfig.enabled | bool | `false` | Whether the GCS Fuse CSI Driver is enabled. |
| addonsConfig.gkeBackupAgentConfig | object | `{"enabled":false}` | Configuration for the Backup for GKE Agent addon. |
| addonsConfig.gkeBackupAgentConfig.enabled | bool | `false` | Whether the Backup for GKE Agent addon is enabled. |
| addonsConfig.horizontalPodAutoscaling | object | `{"disabled":true}` | Configuration for the Horizontal Pod Autoscaling addon, which increases or decreases the number of replica pods a replication controller has based on the resource usage of the existing pods. It ensures that a Heapster pod is running in the cluster, which is also used by the Cloud Monitoring service |
| addonsConfig.horizontalPodAutoscaling.disabled | bool | `true` | Whether the Horizontal Pod Autoscaling addon is disabled. |
| addonsConfig.httpLoadBalancing | object | `{"disabled":false}` | Configuration for the HTTP (L7) load balancing controller addon, which makes it easy to set up HTTP load balancers for services in a cluster. |
| addonsConfig.httpLoadBalancing.disabled | bool | `false` | Whether the HTTP Load Balancing addon is disabled. |
| addonsConfig.istioConfig | object | `{"auth":"AUTH_MUTUAL_TLS","disabled":true}` | Configuration for the Istio addon. |
| addonsConfig.istioConfig.auth | string | `"AUTH_MUTUAL_TLS"` | Authentication type for Istio. Options: "AUTH_MUTUAL_TLS". |
| addonsConfig.istioConfig.disabled | bool | `true` | Whether the Istio addon is disabled. |
| addonsConfig.kalmConfig | object | `{"enabled":false}` | Configuration for the KALM addon, which manages the lifecycle of k8s. |
| addonsConfig.kalmConfig.enabled | bool | `false` | Whether the KALM addon is enabled. |
| addonsConfig.networkPolicyConfig | object | `{"disabled":true}` | Configuration for the Network Policy addon for the master. This must be enabled in order to enable network policy for the nodes. To enable this, you must also define a network_policy block, otherwise nothing will happen. It can only be disabled if the nodes already do not have network policies enabled. |
| addonsConfig.networkPolicyConfig.disabled | bool | `true` | Whether the Network Policy addon is disabled. |
| allowNetAdmin | bool | `false` | Enable NET_ADMIN for this cluster. |
| annotations | object | `{}` | Add annotations to the GKE Cluster. |
| authenticatorGroupsConfig | object | `{"securityGroup":null}` | Configuration for the Google Groups for GKE feature. |
| authenticatorGroupsConfig.securityGroup | string | `nil` | The name of the RBAC security group for use with Google security groups in Kubernetes RBAC. Group name must be in format gke-security-groups@yourdomain.com. |
| bigquery-dataset | object | `{"bigqueryDataset":{"access":[],"description":"<to_set>","friendlyName":"<to_set>","location":"<to_set>","name":"<to_set>"},"enabled":false,"gcpProjectId":"<to_set>"}` | Enables Bigquery Dataset for billing GKE resources |
| binaryAuthorization | object | `{"enabled":false,"evaluationMode":"EVALUATION_MODE_UNSPECIFIED"}` | Configuration for the Binary Authorization feature. |
| binaryAuthorization.enabled | bool | `false` | DEPRECATED. Deprecated in favor of evaluation_mode. Enable Binary Authorization for this cluster. |
| binaryAuthorization.evaluationMode | string | `"EVALUATION_MODE_UNSPECIFIED"` | Mode of operation for Binary Authorization policy evaluation. |
| clusterAutoscaling.autoProvisioningDefaults | object | `{"bootDiskKMSKeyRef":{"external":"","name":"","namespace":""},"diskSize":null,"imageType":null,"management":{"autoRepair":false,"autoUpgrade":false,"upgradeOptions":[{"autoUpgradeStartTime":null,"description":null}]},"minCpuPlatform":null,"oauthScodes":["https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/trace.append"],"serviceAccountRef":{"external":null,"name":null,"namespace":null},"shieldedInstanceConfig":{"enableIntegrityMonitoring":false,"enableSecureBoot":false},"upgradeSettings":{"blueGreenSettings":{"nodePoolSoakDuration":null,"standardRolloutPolicy":{"batchNodeCount":null,"batchPercentage":null,"batchSoakDuration":null}},"maxSurge":null,"maxUnavailable":null,"strategy":null}}` | Contains defaults for a node pool created by NAP. |
| clusterAutoscaling.autoProvisioningDefaults.bootDiskKMSKeyRef | object | `{"external":"","name":"","namespace":""}` | The Customer Managed Encryption Key used to encrypt the boot disk attached to each node in the node pool. |
| clusterAutoscaling.autoProvisioningDefaults.bootDiskKMSKeyRef.external | string | `""` | Allowed value: The `selfLink` field of a `KMSCryptoKey` resource. |
| clusterAutoscaling.autoProvisioningDefaults.bootDiskKMSKeyRef.name | string | `""` | Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names |
| clusterAutoscaling.autoProvisioningDefaults.bootDiskKMSKeyRef.namespace | string | `""` | Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/ |
| clusterAutoscaling.autoProvisioningDefaults.diskSize | string | `nil` | Size of the disk attached to each node, specified in GB. The smallest allowed disk size is 10GB. |
| clusterAutoscaling.autoProvisioningDefaults.imageType | string | `nil` | The default image type used by NAP once a new node pool is being created. |
| clusterAutoscaling.autoProvisioningDefaults.management | object | `{"autoRepair":false,"autoUpgrade":false,"upgradeOptions":[{"autoUpgradeStartTime":null,"description":null}]}` | NodeManagement configuration for this NodePool. |
| clusterAutoscaling.autoProvisioningDefaults.management.autoRepair | bool | `false` | Specifies whether the node auto-repair is enabled for the node pool. If enabled, the nodes in this node pool will be monitored and, if they fail health checks too many times, an automatic repair action will be triggered. |
| clusterAutoscaling.autoProvisioningDefaults.management.autoUpgrade | bool | `false` | Specifies whether node auto-upgrade is enabled for the node pool. If enabled, node auto-upgrade helps keep the nodes in your node pool up to date with the latest release version of Kubernetes. |
| clusterAutoscaling.autoProvisioningDefaults.management.upgradeOptions | list | `[{"autoUpgradeStartTime":null,"description":null}]` | Specifies the AutoUpgradeOptions for the node pool. |
| clusterAutoscaling.autoProvisioningDefaults.management.upgradeOptions[0] | object | `{"autoUpgradeStartTime":null,"description":null}` | This field is set when upgrades are about to commence with the approximate start time for the upgrades, in RFC3339 text format. |
| clusterAutoscaling.autoProvisioningDefaults.management.upgradeOptions[0].description | string | `nil` | This field is set when upgrades are about to commence with the description of the upgrade. |
| clusterAutoscaling.autoProvisioningDefaults.minCpuPlatform | string | `nil` | Minimum CPU platform to be used by this instance. The instance may be scheduled on the specified or newer CPU platform. Applicable values are the friendly names of CPU platforms, such as Intel Haswell. |
| clusterAutoscaling.autoProvisioningDefaults.oauthScodes | list | `["https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/trace.append"]` | List of scopes that are used by node pool autoprovisioning when creating node pools. |
| clusterAutoscaling.autoProvisioningDefaults.serviceAccountRef | object | `{"external":null,"name":null,"namespace":null}` | Reference to a service account used by NAP when creating node pools. |
| clusterAutoscaling.autoProvisioningDefaults.serviceAccountRef.external | string | `nil` | Allowed value: The `email` field of an `IAMServiceAccount` resource. |
| clusterAutoscaling.autoProvisioningDefaults.serviceAccountRef.name | string | `nil` | Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names |
| clusterAutoscaling.autoProvisioningDefaults.serviceAccountRef.namespace | string | `nil` | Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/ |
| clusterAutoscaling.autoProvisioningDefaults.shieldedInstanceConfig | object | `{"enableIntegrityMonitoring":false,"enableSecureBoot":false}` | Shielded Instance options. |
| clusterAutoscaling.autoProvisioningDefaults.shieldedInstanceConfig.enableIntegrityMonitoring | bool | `false` | Defines whether the instance has integrity monitoring enabled. |
| clusterAutoscaling.autoProvisioningDefaults.shieldedInstanceConfig.enableSecureBoot | bool | `false` | Defines whether the instance has Secure Boot enabled. |
| clusterAutoscaling.autoProvisioningDefaults.upgradeSettings | object | `{"blueGreenSettings":{"nodePoolSoakDuration":null,"standardRolloutPolicy":{"batchNodeCount":null,"batchPercentage":null,"batchSoakDuration":null}},"maxSurge":null,"maxUnavailable":null,"strategy":null}` | Specifies the upgrade settings for NAP created node pools. |
| clusterAutoscaling.autoProvisioningDefaults.upgradeSettings.blueGreenSettings | object | `{"nodePoolSoakDuration":null,"standardRolloutPolicy":{"batchNodeCount":null,"batchPercentage":null,"batchSoakDuration":null}}` | Settings for blue-green upgrade strategy. |
| clusterAutoscaling.autoProvisioningDefaults.upgradeSettings.blueGreenSettings.nodePoolSoakDuration | string | `nil` | Time needed after draining entire blue pool. After this period, blue pool will be cleaned up. A duration in seconds with up to nine fractional digits, ending with 's'. Example: "3.5s". |
| clusterAutoscaling.autoProvisioningDefaults.upgradeSettings.blueGreenSettings.standardRolloutPolicy | object | `{"batchNodeCount":null,"batchPercentage":null,"batchSoakDuration":null}` | Standard policy for the blue-green upgrade. |
| clusterAutoscaling.autoProvisioningDefaults.upgradeSettings.blueGreenSettings.standardRolloutPolicy.batchNodeCount | string | `nil` | Number of blue nodes to drain in a batch. |
| clusterAutoscaling.autoProvisioningDefaults.upgradeSettings.blueGreenSettings.standardRolloutPolicy.batchPercentage | string | `nil` | Percentage of the bool pool nodes to drain in a batch. The range of this field should be (0.0, 1.0]. |
| clusterAutoscaling.autoProvisioningDefaults.upgradeSettings.blueGreenSettings.standardRolloutPolicy.batchSoakDuration | string | `nil` | Soak time after each batch gets drained. A duration in seconds with up to nine fractional digits, ending with 's'. Example: "3.5s". |
| clusterAutoscaling.autoProvisioningDefaults.upgradeSettings.maxSurge | string | `nil` | The maximum number of nodes that can be created beyond the current size of the node pool during the upgrade process. |
| clusterAutoscaling.autoProvisioningDefaults.upgradeSettings.maxUnavailable | string | `nil` | The maximum number of nodes that can be simultaneously unavailable during the upgrade process. |
| clusterAutoscaling.autoProvisioningDefaults.upgradeSettings.strategy | string | `nil` | Update strategy of the node pool. |
| clusterAutoscaling.autoscalingProfile | string | `"BALANCED"` | Configuration options for the Autoscaling profile feature, which lets you choose whether the cluster autoscaler should optimize for resource utilization or resource availability when deciding to remove nodes from a cluster. Can be BALANCED or OPTIMIZE_UTILIZATION. Defaults to BALANCED. |
| clusterAutoscaling.enabled | bool | `false` | Per-cluster configuration of Node Auto-Provisioning with Cluster Autoscaler to automatically adjust the size of the cluster and create/delete node pools based on the current needs of the cluster's workload. See the guide to using Node Auto-Provisioning for more details. |
| clusterAutoscaling.resourceLimits | object | `{}` | Resource Limits for CPU and Memory Contains information about amount of some resource in the cluster. For memory, value should be in GB. @defaults -- See in the values.yaml file for more information |
| clusterIpv4Cidr | string | `nil` | Immutable. The IP address range of the Kubernetes pods in this cluster in CIDR notation (e.g. 10.96.0.0/14). Leave blank to have one automatically chosen or specify a /14 block in 10.0.0.0/8. This field will only work for routes-based clusters, where ip_allocation_policy is not defined. |
| clusterTelemetry | string | `nil` | Telemetry integration for the cluster. Allowed: UNSPECIFIED, DISABLED, ENABLED, SYSTEM_ONLY. For more information: documentation [here](https://cloud.google.com/kubernetes-engine/docs/reference/rest/v1beta1/projects.locations.clusters#type) |
| confidentialNodes | object | `{"enabled":false}` | Immutable. Configuration for the confidential nodes feature, which makes nodes run on confidential VMs. Warning: This configuration can't be changed (or added/removed) after cluster creation without deleting and recreating the entire cluster. |
| confidentialNodes.enabled | bool | `false` | Immutable. Whether Confidential Nodes feature is enabled for all nodes in this cluster. |
| costManagementConfig | object | `{"enabled":false}` | Cost management configuration for the cluster. |
| costManagementConfig.enabled | bool | `false` | Whether to enable GKE cost allocation. When you enable GKE cost allocation, the cluster name and namespace of your GKE workloads appear in the labels field of the billing export to BigQuery. Defaults to false. |
| databaseEncryption | object | `{"keyName":null,"state":null}` | Application-layer Secrets Encryption settings. The object format is {state = string, key_name = string}. Valid values of state are: "ENCRYPTED"; "DECRYPTED". key_name is the name of a CloudKMS key. |
| databaseEncryption.keyName | string | `nil` | Name of the CloudKMS key to use for Application-layer Secrets Encryption |
| databaseEncryption.state | string | `nil` | ENCRYPTED or DECRYPTED. If keyName is empty, encryption is managed by google and will always be encrypted |
| datapathProvider | string | `""` | Immutable. The desired datapath provider for this cluster. By default, uses the IPTables-based kube-proxy implementation. Possible values: - DATAPATH_PROVIDER_UNSPECIFIED: Default value. - LEGACY_DATAPATH: Use the IPTables implementation based on kube-proxy. - ADVANCED_DATAPATH: Use the eBPF based GKE Dataplane V2 with additional features. See the GKE Dataplane V2 documentation for more. |
| defaultMaxPodsPerNode | int | `0` | Immutable. The default maximum number of pods per node in this cluster. This doesn't work on "routes-based" clusters, clusters that don't have IP Aliasing enabled. |
| defaultSnatStatus | object | `{"disabled":false}` | Whether the cluster disables default in-node sNAT rules. In-node sNAT rules will be disabled when defaultSnatStatus is disabled. |
| defaultSnatStatus.disabled | bool | `false` | When disabled is set to false, default IP masquerade rules will be applied to the nodes to prevent sNAT on cluster internal traffic. |
| description | string | `"EKP GKE Cluster"` | A text description of the GKE Cluster. Must be less than or equal to 256 UTF-8 bytes. |
| enableAutopilot | bool | `false` | Immutable. Enable Autopilot for this cluster. |
| enableBinaryAuthorization | bool | `false` | DEPRECATED. Deprecated in favor of binary_authorization. Enable Binary Authorization for this cluster. If enabled, all container images will be validated by Google Binary Authorization. |
| enableFqdnNetworkPolicy | bool | `false` | Whether FQDN Network Policy is enabled on this cluster. |
| enableIntranodeVisibility | bool | `false` | Whether Intra-node visibility is enabled for this cluster. This makes same node pod to pod traffic visible for VPC network. |
| enableK8sBetaApis | object | `{"enabledApis":[]}` | Configuration for Kubernetes Beta APIs. |
| enableK8sBetaApis.enabledApis | list | `[]` | Enabled Kubernetes Beta APIs. |
| enableKubernetesAlpha | bool | `false` | Immutable. Whether to enable Kubernetes Alpha features for this cluster. Note that when this option is enabled, the cluster cannot be upgraded and will be automatically deleted after 30 days. |
| enableL4IlbSubsetting | bool | `false` | Whether L4ILB Subsetting is enabled for this cluster. |
| enableLegacyAbac | bool | `false` | Whether the ABAC authorizer is enabled for this cluster. When enabled, identities in the system, including service accounts, nodes, and controllers, will have statically granted permissions beyond those provided by the RBAC configuration or IAM. Defaults to false. |
| enableMultiNetworking | bool | `false` | Immutable. Whether multi-networking is enabled for this cluster. |
| enableShieldedNodes | bool | `true` | Enable Shielded Nodes features on all nodes in this cluster. Defaults to true. |
| enableTpu | bool | `false` | Immutable. Whether to enable Cloud TPU resources in this cluster. |
| gatewayApiConfig | object | `{"channel":"CHANNEL_STANDARD"}` | Configuration for GKE Gateway API controller. |
| gatewayApiConfig.channel | string | `"CHANNEL_STANDARD"` | The Gateway API release channel to use for Gateway API. |
| global.abandon | bool | `true` | If true, Keep the GKE Cluster even after the kcc resource deletion. |
| global.cnrmNamespace | string | `nil` | Allows to deploy in another namespace than the release one |
| global.gcpProjectId | string | `"myprojectid"` | Google Project ID |
| identityServiceConfig | object | `{"enabled":false}` | Configuration for Identity Service which allows customers to use external identity providers with the K8S API. |
| identityServiceConfig.enabled | bool | `false` | Whether to enable the Identity Service component. |
| initialNodeCount | int | `0` | Initial number of nodes in the default node pool. Must be set if no custom node pools are defined. |
| ipAllocationPolicy | object | `{"additionalPodRangesConfig":{"podRangeNames":[]},"clusterIpv4CidrBlock":null,"clusterSecondaryRangeName":null,"enabled":false,"podCidrOverprovisionConfig":{"disabled":false},"servicesIpv4CidrBlock":null,"servicesSecondaryRangeName":null,"stackType":null}` | Immutable. Configuration of cluster IP allocation for VPC-native clusters. Adding this block enables IP aliasing, making the cluster VPC-native instead of routes-based. |
| ipAllocationPolicy.additionalPodRangesConfig | object | `{"podRangeNames":[]}` | AdditionalPodRangesConfig is the configuration for additional pod secondary ranges supporting the ClusterUpdate message. |
| ipAllocationPolicy.additionalPodRangesConfig.podRangeNames | list | `[]` | Name for pod secondary ipv4 range which has the actual range defined ahead. |
| ipAllocationPolicy.clusterIpv4CidrBlock | string | `nil` | Immutable. The IP address range for the cluster pod IPs. Set to blank to have a range chosen with the default size. Set to /netmask (e.g. /14) to have a range chosen with a specific netmask. Set to a CIDR notation (e.g. 10.96.0.0/14) from the RFC-1918 private networks (e.g. 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) to pick a specific range to use. |
| ipAllocationPolicy.clusterSecondaryRangeName | string | `nil` | Immutable. The name of the existing secondary range in the cluster's subnetwork to use for pod IP addresses. Alternatively, cluster_ipv4_cidr_block can be used to automatically create a GKE-managed one. |
| ipAllocationPolicy.enabled | bool | `false` | Enables ipAllocationPolicy, allowing to specify pods and services secondary subnets name and CIDR |
| ipAllocationPolicy.podCidrOverprovisionConfig | object | `{"disabled":false}` | Immutable. Configuration for cluster level pod cidr overprovision. Default is disabled=false. |
| ipAllocationPolicy.podCidrOverprovisionConfig.disabled | bool | `false` | Whether pod cidr overprovision is disabled. |
| ipAllocationPolicy.servicesIpv4CidrBlock | string | `nil` | Immutable. The IP address range of the services IPs in this cluster. Set to blank to have a range chosen with the default size. Set to /netmask (e.g. /14) to have a range chosen with a specific netmask. Set to a CIDR notation (e.g. 10.96.0.0/14) from the RFC-1918 private networks (e.g. 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) to pick a specific range to use. |
| ipAllocationPolicy.servicesSecondaryRangeName | string | `nil` | Immutable. The name of the existing secondary range in the cluster's subnetwork to use for service ClusterIPs. Alternatively, services_ipv4_cidr_block can be used to automatically create a GKE-managed one. |
| ipAllocationPolicy.stackType | string | `nil` | Immutable. The IP Stack type of the cluster. Choose between IPV4 and IPV4_IPV6. Default type is IPV4 Only if not set. |
| location | string | `"europe-west1"` | Location (region or zone) for the GKE cluster. If a zone is specified, the cluster will be zonal. If a region is specified, it will be regional. |
| loggingConfig | object | `{"enableComponents":[]}` | Logging configuration for the cluster. |
| loggingConfig.enableComponents | list | `[]` | GKE components exposing logs. Valid values include SYSTEM_COMPONENTS, APISERVER, CONTROLLER_MANAGER, SCHEDULER, and WORKLOADS. |
| loggingService | string | `"logging.googleapis.com/kubernetes"` | The logging service that the cluster should write logs to. Available options include logging.googleapis.com(Legacy Stackdriver), logging.googleapis.com/kubernetes(Stackdriver Kubernetes Engine Logging), and none. Defaults to logging.googleapis.com/kubernetes. |
| maintenancePolicy | object | `{"dailyMaintenanceWindow":{"duration":null,"startTime":null},"maintenanceExclusion":[{"endTime":null,"exclusionName":null,"exclusionOptions":{"scope":null},"startTime":null}],"recurringWindow":{"endTime":null,"recurrence":null,"startTime":null}}` | The maintenance policy to use for the cluster. |
| maintenancePolicy.dailyMaintenanceWindow | object | `{"duration":null,"startTime":null}` | Time window specified for daily maintenance operations. Specify start_time in RFC3339 format "HH:MM”, where HH : [00-23] and MM : [00-59] GMT. |
| maintenancePolicy.dailyMaintenanceWindow.duration | string | `nil` | Duration of the maintenance window. |
| maintenancePolicy.dailyMaintenanceWindow.startTime | string | `nil` | Start time of the maintenance window in RFC3339 format "HH:MM". |
| maintenancePolicy.maintenanceExclusion | list | `[{"endTime":null,"exclusionName":null,"exclusionOptions":{"scope":null},"startTime":null}]` | Exceptions to maintenance window. Non-emergency maintenance should not occur in these windows. |
| maintenancePolicy.maintenanceExclusion[0] | object | `{"endTime":null,"exclusionName":null,"exclusionOptions":{"scope":null},"startTime":null}` | End time of the maintenance exclusion in RFC3339 format "HH:MM". |
| maintenancePolicy.maintenanceExclusion[0].exclusionName | string | `nil` | Name of the maintenance exclusion. |
| maintenancePolicy.maintenanceExclusion[0].exclusionOptions | object | `{"scope":null}` | Maintenance exclusion related options. |
| maintenancePolicy.maintenanceExclusion[0].exclusionOptions.scope | string | `nil` | The scope of automatic upgrades to restrict in the exclusion window. |
| maintenancePolicy.maintenanceExclusion[0].startTime | string | `nil` | Start time of the maintenance exclusion in RFC3339 format "HH:MM". |
| maintenancePolicy.recurringWindow | object | `{"endTime":null,"recurrence":null,"startTime":null}` | Time window for recurring maintenance operations. |
| maintenancePolicy.recurringWindow.endTime | string | `nil` | End time of the recurring maintenance window in RFC3339 format "HH:MM". |
| maintenancePolicy.recurringWindow.recurrence | string | `nil` | Recurrence of the maintenance window in RFC5545 format. |
| maintenancePolicy.recurringWindow.startTime | string | `nil` | Start time of the recurring maintenance window in RFC3339 format "HH:MM". |
| masterAuth | object | `{"clientCertificate":null,"clientCertificateConfig":{"issueClientCertificate":false},"clientKey":null,"clusterCaCertificate":null,"password":{"value":null,"valueFrom":{"secretKeyRef":{"key":null,"name":null}}},"username":null}` | DEPRECATED. Basic authentication was removed for GKE cluster versions >= 1.19. The authentication information for accessing the Kubernetes master. Some values in this block are only returned by the API if your service account has permission to get credentials for your GKE cluster. If you see an unexpected diff unsetting your client cert, ensure you have the container.clusters.getCredentials permission. |
| masterAuth.clientCertificate | string | `nil` | Base64 encoded public certificate used by clients to authenticate to the cluster endpoint. |
| masterAuth.clientCertificateConfig | object | `{"issueClientCertificate":false}` | Immutable. Whether client certificate authorization is enabled for this cluster. |
| masterAuth.clientCertificateConfig.issueClientCertificate | bool | `false` | Immutable. Whether client certificate authorization is enabled for this cluster. |
| masterAuth.clientKey | string | `nil` | Base64 encoded private key used by clients to authenticate to the cluster endpoint. |
| masterAuth.clusterCaCertificate | string | `nil` | Base64 encoded public certificate that is the root of trust for the cluster. |
| masterAuth.password | object | `{"value":null,"valueFrom":{"secretKeyRef":{"key":null,"name":null}}}` | The password to use for HTTP basic authentication when accessing the Kubernetes master endpoint. |
| masterAuth.password.value | string | `nil` | Value of the field. Cannot be used if 'valueFrom' is specified. |
| masterAuth.password.valueFrom | object | `{"secretKeyRef":{"key":null,"name":null}}` | Source for the field's value. Cannot be used if 'value' is specified. |
| masterAuth.password.valueFrom.secretKeyRef | object | `{"key":null,"name":null}` | Reference to a value with the given key in the given Secret in the resource's namespace. |
| masterAuth.password.valueFrom.secretKeyRef.key | string | `nil` | Key that identifies the value to be extracted. |
| masterAuth.password.valueFrom.secretKeyRef.name | string | `nil` | Name of the Secret to extract a value from. |
| masterAuth.username | string | `nil` | The username to use for HTTP basic authentication when accessing the Kubernetes master endpoint. If not present basic auth will be disabled. |
| masterAuthorizedNetworksConfig | object | `{"cidrBlocks":[{"cidrBlock":null,"displayName":null}],"gcpPublicCidrsAccessEnabled":false}` | The desired configuration options for master authorized networks. Omit the nested cidr_blocks attribute to disallow external access (except the cluster node IPs, which GKE automatically whitelists). |
| masterAuthorizedNetworksConfig.cidrBlocks | list | `[{"cidrBlock":null,"displayName":null}]` | External networks that can access the Kubernetes cluster master through HTTPS. |
| masterAuthorizedNetworksConfig.cidrBlocks[0] | object | `{"cidrBlock":null,"displayName":null}` | External network that can access Kubernetes master through HTTPS. Must be specified in CIDR notation. |
| masterAuthorizedNetworksConfig.cidrBlocks[0].displayName | string | `nil` | Field for users to identify CIDR blocks. |
| masterAuthorizedNetworksConfig.gcpPublicCidrsAccessEnabled | bool | `false` | Whether master is accessbile via Google Compute Engine Public IP addresses. |
| meshCertificates | object | `{"enableCertificates":false}` | If set, and enable_certificates=true, the GKE Workload Identity Certificates controller and node agent will be deployed in the cluster. |
| meshCertificates.enableCertificates | bool | `false` | When enabled the GKE Workload Identity Certificates controller and node agent will be deployed in the cluster. |
| minMasterVersion | string | `nil` | The minimum version of the master. GKE will auto-update the master to new versions, so this does not guarantee the current master version--use the read-only master_version field to obtain that. If unset, the cluster's version will be set by GKE to the version of the most recent official release (which is not necessarily the latest version). |
| monitoringConfig | object | `{"advancedDatapathObservabilityConfig":[{"enableMetrics":false,"relayMode":null}],"enableComponents":[],"managedPrometheus":{"enabled":false}}` | Monitoring configuration for the cluster. |
| monitoringConfig.advancedDatapathObservabilityConfig | list | `[{"enableMetrics":false,"relayMode":null}]` | Configuration of Advanced Datapath Observability features. |
| monitoringConfig.advancedDatapathObservabilityConfig[0] | object | `{"enableMetrics":false,"relayMode":null}` | Whether or not the advanced datapath metrics are enabled. |
| monitoringConfig.advancedDatapathObservabilityConfig[0].relayMode | string | `nil` | Mode used to make Relay available. |
| monitoringConfig.enableComponents | list | `[]` | GKE components exposing metrics. Valid values include SYSTEM_COMPONENTS, APISERVER, SCHEDULER, CONTROLLER_MANAGER, STORAGE, HPA, POD, DAEMONSET, DEPLOYMENT, STATEFULSET and WORKLOADS. |
| monitoringConfig.managedPrometheus | object | `{"enabled":false}` | Configuration for Google Cloud Managed Services for Prometheus. |
| monitoringConfig.managedPrometheus.enabled | bool | `false` | Whether or not the managed collection is enabled. |
| monitoringService | string | `"monitoring.googleapis.com/kubernetes"` | The monitoring service that the cluster should write metrics to. Automatically send metrics from pods in the cluster to the Google Cloud Monitoring API. VM metrics will be collected by Google Compute Engine regardless of this setting Available options include monitoring.googleapis.com(Legacy Stackdriver), monitoring.googleapis.com/kubernetes(Stackdriver Kubernetes Engine Monitoring), and none. Defaults to monitoring.googleapis.com/kubernetes. |
| name | string | `"ekp-gke-cluster"` | Name of the GKE Cluster. |
| networkPolicy | object | `{"enabled":false,"provider":null}` | Configuration options for the NetworkPolicy feature. |
| networkPolicy.enabled | bool | `false` | Whether network policy is enabled on the cluster. |
| networkPolicy.provider | string | `nil` | The selected network policy provider. Defaults to PROVIDER_UNSPECIFIED. |
| networkRef | object | `{"external":null,"name":null,"namespace":null}` | Reference to a Compute Network resource. |
| networkRef.external | string | `nil` | Allowed value: The `selfLink` field of a `ComputeNetwork` resource. |
| networkRef.name | string | `nil` | Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names |
| networkRef.namespace | string | `nil` | Namespace of the referent. More info: https://kubernetes.io/docs/concepts/over |
| networkingMode | string | `"VPC_NATIVE"` | Networking mode for the cluster. Determines whether alias IPs or routes will be used for pod IPs. Options: "VPC_NATIVE" (default) or "ROUTES". |
| nodeLocations | list | `[]` |  |
| nodePools[0].autoscaling.enabled | bool | `true` | Enables nodePool autoscaling |
| nodePools[0].autoscaling.maxNodeCount | int | 3 | Maximal node count. Default to 3 |
| nodePools[0].autoscaling.minNodeCount | int | 1 | Minimal node count. Default to 1 |
| nodePools[0].management | int | 1 | Number of nodes at initialization initialNodeCount: 1 |
| nodePools[0].management.autoRepair | bool | `true` | Enables node pool autorepair |
| nodePools[0].management.autoUpgrade | bool | `true` | Enables node pool auto upgrade |
| nodePools[0].maxPodsPerNode | int | 110 | Max number of Pods per nodes |
| nodePools[0].name | string | `"np1"` | Name of the node pool |
| nodePools[0].nodeConfig.bootDiskKMSCryptoKey.enabled | bool | `false` | Enables boot disk attached to each node in the node pool. Must provide a key |
| nodePools[0].nodeConfig.bootDiskKMSCryptoKey.external | string | `nil` | The Customer Managed Encryption Key used to encrypt the boot disk attached to each node in the node pool. This should be of the form projects/[KEY_PROJECT_ID]/locations/[LOCATION]/keyRings/[RING_NAME]/cryptoKeys/[KEY_NAME]. For more information about protecting resources with Cloud KMS Keys please see: https://cloud.google.com/compute/docs/disks/customer-managed-encryption |
| nodePools[0].nodeConfig.bootDiskKMSCryptoKey.kccManaged | bool | `false` | The KMS key was created by kubernetes Config Connector or not |
| nodePools[0].nodeConfig.bootDiskKMSCryptoKey.name | string | `nil` | Name of the KMS key config connector resource. Only when kccManaged=true |
| nodePools[0].nodeConfig.bootDiskKMSCryptoKey.namespace | string | `nil` | Namespace of the KMS key config connector resource. Only when kccManaged=true |
| nodePools[0].nodeConfig.diskSize | int | 100 | Size of the nodes' disk |
| nodePools[0].nodeConfig.diskType | string | pd-standard | Type of the nodes' disk |
| nodePools[0].nodeConfig.guestAccelerator | list | See the values.yaml file for an example. | A list of hardware accelerators to be attached to each node. See https://cloud.google.com/compute/docs/gpus for more information about support for GPUs. |
| nodePools[0].nodeConfig.imageType | string | `"COS_CONTAINERD"` | Type of Image used for the node pool instances |
| nodePools[0].nodeConfig.labels | object | `{}` | Map of kubernetes labels to apply to nodes in the nodePool |
| nodePools[0].nodeConfig.localSsdCount | intq | `nil` | The number of local SSD disks to be attached to the node. The limit for this value is dependent upon the maximum number of disks available on a machine per zone. See: https://cloud.google.com/compute/docs/disks/local-ssd for more information. |
| nodePools[0].nodeConfig.machineType | string | n1-standard-1 | Type of the machine used for nodes |
| nodePools[0].nodeConfig.metadata | object | `{}` | Map of metadata to apply to the nodes (key: string, value: string) |
| nodePools[0].nodeConfig.oauthScopes | list | `["https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/trace.append"]` | The set of Google API scopes to be made available on all of the node VMs under the "default" service account. |
| nodePools[0].nodeConfig.preemptible | bool | `false` | Configure the node pool with preemptible instances |
| nodePools[0].nodeConfig.serviceAccount.create | bool | `true` | Create the serviceAccount and IamPolicyMembers associated through Config Connector |
| nodePools[0].nodeConfig.serviceAccount.name | string | `"np1"` | Display name of the service Account used for the runner. If create=false, use the email of the Service Account |
| nodePools[0].nodeConfig.tags | list | `[]` | Network tags to apply to the node pool. |
| nodePools[0].nodeConfig.taints | list | See the values.yaml file for an example. | List of taints to apply to the node pool. Must contains the following : [{"effect": "<effect>", "key": "<key>", "value": "<value>"}] |
| notificationConfig | object | `{"pubsub":{"enabled":false,"filter":{"eventType":[]},"topicRef":{"external":null,"name":null,"namespace":null}}}` | The notification config for sending cluster upgrade notifications. |
| notificationConfig.pubsub | object | `{"enabled":false,"filter":{"eventType":[]},"topicRef":{"external":null,"name":null,"namespace":null}}` | Notification config for Cloud Pub/Sub. |
| notificationConfig.pubsub.enabled | bool | `false` | Whether or not the notification config is enabled. |
| notificationConfig.pubsub.filter | object | `{"eventType":[]}` | Allows filtering to one or more specific event types. If event types are present, those and only those event types will be transmitted to the cluster. Other types will be skipped. If no filter is specified, or no event types are present, all event types will be sent. |
| notificationConfig.pubsub.filter.eventType | list | `[]` | Can be used to filter what notifications are sent. Valid values include UPGRADE_AVAILABLE_EVENT, UPGRADE_EVENT and SECURITY_BULLETIN_EVENT. |
| notificationConfig.pubsub.topicRef | object | `{"external":null,"name":null,"namespace":null}` | The PubSubTopic to send the notification to. |
| notificationConfig.pubsub.topicRef.external | string | `nil` | Allowed value: string of the format `projects/{{project}}/topics/{{value}}`, where {{value}} is the `name` field of a `PubSubTopic` resource. |
| notificationConfig.pubsub.topicRef.name | string | `nil` | Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names |
| notificationConfig.pubsub.topicRef.namespace | string | `nil` | Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/ |
| podSecurityPolicyConfig | object | `{"enabled":false}` | Configuration for the PodSecurityPolicy feature. |
| podSecurityPolicyConfig.enabled | bool | `false` | Enable the PodSecurityPolicy controller for this cluster. If enabled, pods must be valid under a PodSecurityPolicy to be created. |
| privateClusterConfig | object | `{"enablePrivateEndpoint":false,"enablePrivateNodes":false,"enabled":true,"masterGlobalAccessConfig":{"enabled":false},"masterIpv4CidrBlock":null,"privateEndpointSubnetworkRef":{"external":null,"name":null,"namespace":null}}` | Configuration for private clusters, clusters with private nodes. |
| privateClusterConfig.enablePrivateEndpoint | bool | `false` | When true, the cluster's private endpoint is used as the cluster endpoint and access through the public endpoint is disabled. When false, either endpoint can be used. |
| privateClusterConfig.enablePrivateNodes | bool | `false` | Immutable. Enables the private cluster feature, creating a private endpoint on the cluster. In a private cluster, nodes only have RFC 1918 private addresses and communicate with the master's private endpoint via private networking. |
| privateClusterConfig.enabled | bool | `true` | Enables private cluster |
| privateClusterConfig.masterGlobalAccessConfig | object | `{"enabled":false}` | Controls cluster master global access settings. |
| privateClusterConfig.masterGlobalAccessConfig.enabled | bool | `false` | Whether the cluster master is accessible globally or not. |
| privateClusterConfig.masterIpv4CidrBlock | string | `nil` | Immutable. The IP range in CIDR notation to use for the hosted master network. This range will be used for assigning private IP addresses to the cluster master(s) and the ILB VIP. This range must not overlap with any other ranges in use within the cluster's network, and it must be a /28 subnet. See Private Cluster Limitations for more details. This field only applies to private clusters, when enable_private_nodes is true. |
| privateClusterConfig.privateEndpointSubnetworkRef | object | `{"external":null,"name":null,"namespace":null}` | Immutable. Subnetwork in cluster's network where master's endpoint will be provisioned. |
| privateClusterConfig.privateEndpointSubnetworkRef.external | string | `nil` | Allowed value: The `selfLink` field of a `ComputeSubnetwork` resource. |
| privateClusterConfig.privateEndpointSubnetworkRef.name | string | `nil` | Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names |
| privateClusterConfig.privateEndpointSubnetworkRef.namespace | string | `nil` | Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/ |
| privateIpv6GoogleAccess | string | `nil` | The desired state of IPv6 connectivity to Google Services. By default, no private IPv6 access to or from Google Services (all access will be via IPv4). |
| releaseChannel | object | `{"channel":null}` | Configuration options for the Release channel feature, which provide more control over automatic upgrades of your GKE clusters. Note that removing this field from your config will not unenroll it. Instead, use the "UNSPECIFIED" channel. |
| releaseChannel.channel | string | `nil` | The selected release channel. Accepted values are: * UNSPECIFIED: Not set. * RAPID: Weekly upgrade cadence; Early testers and developers who requires new features. * REGULAR: Multiple per month upgrade cadence; Production users who need features not yet offered in the Stable channel. * STABLE: Every few months upgrade cadence; Production users who need stability above all else, and for whom frequent upgrades are too risky. |
| removeDefaultNodePool | string | `"true"` | If set to true, the remove-default-node-pool directive removes the default node pool created during cluster creation. Also made as variable to import resources created using terraform. |
| resourceID | string | `nil` | Immutable. Optional. The name of the resource. Used for creation and acquisition. When unset, the value of `metadata.name` is used as the default. |
| resourceUsageExportConfig | object | `{"bigqueryDestination":{"datasetId":""},"enableNetworkEgressMetering":false,"enableResourceConsumptionMetering":false}` | Configuration for the ResourceUsageExportConfig feature. |
| resourceUsageExportConfig.bigqueryDestination | object | `{"datasetId":""}` | Parameters for using BigQuery as the destination of resource usage export. |
| resourceUsageExportConfig.bigqueryDestination.datasetId | string | `""` | The ID of a BigQuery Dataset. |
| resourceUsageExportConfig.enableNetworkEgressMetering | bool | `false` | Whether to enable network egress metering for this cluster. If enabled, a daemonset will be created in the cluster to meter network egress traffic. |
| resourceUsageExportConfig.enableResourceConsumptionMetering | bool | `false` | Whether to enable resource consumption metering on this cluster. When enabled, a table will be created in the resource export BigQuery dataset to store resource consumption data. The resulting table can be joined with the resource usage table or with BigQuery billing export. Defaults to true. |
| serviceExternalIpsConfig | object | `{"enabled":false}` | If set, and enabled=true, services with external ips field will not be blocked. |
| serviceExternalIpsConfig.enabled | bool | `false` | When enabled, services with exterenal ips specified will be allowed. |
| subnetworkRef | object | `{"external":null,"name":null,"namespace":null}` | Reference to a ComputeSubnetwork resource. |
| subnetworkRef.external | string | `nil` | Allowed value: The `selfLink` field of a `ComputeSubnetwork` resource. |
| subnetworkRef.name | string | `nil` | Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names |
| subnetworkRef.namespace | string | `nil` | Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/ |
| tags.networking | bool | `false` | Whether we want to create networking features like VPC, Subnetwork, etc. |
| verticalPodAutoscaling | object | `{"enabled":false}` | Vertical Pod Autoscaling automatically adjusts the resources of pods controlled by it. |
| verticalPodAutoscaling.enabled | bool | `false` | Enables vertical pod autoscaling. |
| workloadIdentityConfig | object | `{"identityNamespace":null,"workloadPool":null}` | Configuration for the use of Kubernetes Service Accounts in GCP IAM policies. |
| workloadIdentityConfig.identityNamespace | string | `nil` | DEPRECATED. This field will be removed in a future major release as it has been deprecated in the API. Use `workloadPool` instead; `workloadPool` field will supersede this field. Enables workload identity. |
| workloadIdentityConfig.workloadPool | string | `nil` | The workload pool to attach all Kubernetes service accounts to. |

## GKE Immutable Fields

| Key  |  **Required** |  Type | Description  |
|-----|------|---------|-------------|
| clusterAutoscaling.autoProvisioningDefaults.bootDiskKMSKeyRef |  | object | The Customer Managed Encryption Key used to encrypt the boot disk attached to each node in the node pool. |
| clusterIpv4Cidr |  | string | The IP address range of the Kubernetes pods in this cluster in CIDR notation (e.g. 10.96.0.0/14). Leave blank to have one automatically chosen or specify a /14 block in 10.0.0.0/8. |
| confidentialNodes  |  | object | Configuration for the confidential nodes feature, which makes nodes run on confidential VMs. Warning: This configuration can't be changed (or added/removed) after cluster creation without deleting and recreating the entire cluster. |
| confidentialNodes.enabled | X | boolean | Whether Confidential Nodes feature is enabled for all nodes in this cluster. |
| datapathProvider |  | string | The desired datapath provider for this cluster. By default, uses the IPTables-based kube-proxy implementation. |
| defaultMaxPodsPerNode |  | integer | The default maximum number of pods per node in this cluster. This doesn't work on "routes-based" clusters, clusters that don't have IP Aliasing enabled. |
| description |  | string | Description of the cluster. |
| dnsConfig |  | object |  Description of the cluster. |
| enableAutopilot |  | boolean | Enable Autopilot for this cluster. |
| enableKubernetesAlpha |  | boolean | Whether to enable Kubernetes Alpha features for this cluster. Note that when this option is enabled, the cluster cannot be upgraded and will be automatically deleted after 30 days. |
| enableTpu |  | boolean | Whether to enable Cloud TPU resources in this cluster. |
| initialNodeCount |  | integer | The number of nodes to create in this cluster's default node pool. In regional or multi-zonal clusters, this is the number of nodes per zone. Must be set if node_pool is not set. If you're using google_container_node_pool objects with no default node pool, you'll need to set this to a value of at least 1, alongside setting remove_default_node_pool to true. |
| ipAllocationPolicy |  | object | Configuration of cluster IP allocation for VPC-native clusters. Adding this block enables IP aliasing, making the cluster VPC-native instead of routes-based. |
| ipAllocationPolicy.clusterIpv4CidrBlock |  | string | The IP address range for the cluster pod IPs. Set to blank to have a range chosen with the default size. |
| ipAllocationPolicy.clusterSecondaryRangeName |  | string | The name of the existing secondary range in the cluster's subnetwork to use for pod IP addresses. Alternatively, cluster_ipv4_cidr_block can be used to automatically create a GKE-managed one. |
| ipAllocationPolicy.servicesIpv4CidrBlock |  | string | The IP address range of the services IPs in this cluster. Set to blank to have a range chosen with the default size. |
| ipAllocationPolicy.servicesSecondaryRangeName |  | string | The name of the existing secondary range in the cluster's subnetwork to use for service ClusterIPs. Alternatively, services_ipv4_cidr_block can be used to automatically create a GKE-managed one. |
| location | X | string | The location (region or zone) in which the cluster master will be created, as well as the default node location. |
| masterAuth.clientCertificateConfig |  | object | Whether client certificate authorization is enabled for this cluster. |
| masterAuth.clientCertificateConfig.issueClientCertificate | X | boolean | Whether client certificate authorization is enabled for this cluster. |
| networkingMode |  | string | Determines whether alias IPs or routes will be used for pod IPs in the cluster. |
| privateClusterConfig.enablePrivateNodes |  | boolean | Enables the private cluster feature, creating a private endpoint on the cluster. In a private cluster, nodes only have RFC 1918 private addresses and communicate with the master's private endpoint via private networking. |
| privateClusterConfig.masterIpv4CidrBlock |  | string | The IP range in CIDR notation to use for the hosted master network. This range will be used for assigning private IP addresses to the cluster master(s) and the ILB VIP. |
| privateClusterConfig.privateEndpointSubnetworkRef |  | object | Subnetwork in cluster's network where master's endpoint will be provisioned. |
| resourceID |  | string | The name of the resource. Used for creation and acquisition. When unset, the value of `metadata.name` is used as the default. |

## Nodepool Immutable Fields

| Key  |  **Required** |  Type | Description  |
|-----|------|---------|-------------|
| clusterRef | X | object | Cluster Target |
| initialNodeCount | | integer | The initial number of nodes for the pool. In regional or multi-zonal clusters, this is the number of nodes per zone. Changing this will force recreation of the resource. |
| location | X | string | The location (region or zone) of the cluster. |
| maxPodsPerNode | | integer | The maximum number of pods per node in this node pool. Note that this does not work on node pools which are "route-based" - that is, node pools belonging to clusters that do not have IP Aliasing enabled. |
| namePrefix | | string | Creates a unique name for the node pool beginning with the specified prefix. Conflicts with name. |
| networkConfig.createPodRange | | boolean | Whether to create a new range for pod IPs in this node pool. Defaults are provided for pod_range and pod_ipv4_cidr_block if they are not specified. |
| networkConfig.podIpv4CidrBlock | | string | The IP address range for pod IPs in this node pool. Only applicable if create_pod_range is true. Set to blank to have a range chosen with the default size. Set to /netmask (e.g. /14) to have a range chosen with a specific netmask. Set to a CIDR notation (e.g. 10.96.0.0/14) to pick a specific range to use. |
| networkConfig.podRange | | string | The ID of the secondary range for pod IPs. If create_pod_range is true, this ID is used for the new range. If create_pod_range is false, uses an existing secondary range with this ID. |
| nodeConfig | | object | The configuration of the nodepool. |
| nodeConfig.diskSizeGb |  | integer | Size of the disk attached to each node, specified in GB. The smallest allowed disk size is 10GB. |
| nodeConfig.diskType | | string | Type of the disk attached to each node. Such as pd-standard, pd-balanced or pd-ssd. |
| nodeConfig.ephemeralStorageConfig | | object | Parameters for the ephemeral storage filesystem. |
| nodeConfig.ephemeralStorageConfig.localSsdCount  | X | integer | Number of local SSDs to use to back ephemeral storage. Uses NVMe interfaces. Each local SSD is 375 GB in size. |
| nodeConfig.gcfsConfig       | | object | GCFS configuration for this node. |
| nodeConfig.gcfsConfig.enabled    | X | boolean | Whether or not GCFS is enabled. |
| nodeConfig.guestAccelerator | | list | List of the type and count of accelerator cards attached to the instance. |
| nodeConfig.guestAccelerator[].count | | integer | The number of the accelerator cards exposed to an instance. |
| nodeConfig.guestAccelerator[].gpuPartitionSize    | | string | Size of partitions to create on the GPU. Valid values are described in the NVIDIA mig user guide (https://docs.nvidia.com/datacenter/tesla/mig-user-guide/#partitioning). |
| nodeConfig.guestAccelerator[].gpuSharingConfig    | | object | Configuration for GPU sharing. |
| nodeConfig.guestAccelerator[].gpuSharingConfig.gpuSharingStrategy    | X | string | The type of GPU sharing strategy to enable on the GPU node. Possible values are described in the API package |
| nodeConfig.guestAccelerator[].gpuSharingConfig.maxSharedClientsPerGpu   | X | integer | The maximum number of containers that can share a GPU. |
| nodeConfig.guestAccelerator[].type     | X | string | The accelerator type resource name. |
| nodeConfig.gvnic     | | object | Enable or disable gvnic in the node pool. |
| nodeConfig.gvnic.enabled     | X | boolean | Whether or not gvnic is enabled. |
| nodeConfig.kubeletConfig.cpuManagerPolicy    | X | string | Control the CPU management policy on the node. |
| nodeConfig.linuxNodeConfig.sysctls    | X | map (key: string, value: string) | The Linux kernel parameters to be applied to the nodes and all pods running on the nodes. |
| nodeConfig.localSsdCount  | | integer | The number of local SSD disks to be attached to the node. |
| nodeConfig.machineType | | string | The name of a Google Compute Engine machine type. |
| nodeConfig.metadata | | map (key: string, value: string) | The metadata key/value pairs assigned to instances in the cluster. |
| nodeConfig.minCpuPlatform | | string | Minimum CPU platform to be used by this instance. The instance may be scheduled on the specified or newer CPU platform. |
| nodeConfig.nodeGroupRef   | | object | Setting this field will assign instances of this pool to run on the specified node group. This is useful for running workloads on sole tenant nodes. |
| nodeConfig.oauthScopes | | list (string)| The set of Google API scopes to be made available on all of the node VMs. |
| nodeConfig.preemptible | | boolean | Whether the nodes are created as preemptible VM instances. |
| nodeConfig.reservationAffinity   | | object | The reservation affinity configuration for the node pool. |
| nodeConfig.reservationAffinity.consumeReservationType     | X |string | Corresponds to the type of reservation consumption. |
| nodeConfig.reservationAffinity.key     | | string | The label key of a reservation resource. |
| nodeConfig.reservationAffinity.values     | | list (string) | The label values of the reservation resource. |
| nodeConfig.sandboxConfig     | | object | Sandbox configuration for this node. |
| nodeConfig.sandboxConfig.sandboxType   | X | string | Type of the sandbox to use for the node (e.g. 'gvisor'). |
| nodeConfig.shieldedInstanceConfig    | | object | Shielded Instance options. |
| nodeConfig.shieldedInstanceConfig.enableIntegrityMonitoring      | | boolean | Defines whether the instance has integrity monitoring enabled. |
| nodeConfig.shieldedInstanceConfig.enableSecureBoot      | | boolean | Defines whether the instance has Secure Boot enabled. |
| nodeConfig.spot    | | boolean | Whether the nodes are created as spot VM instances. |
| nodeConfig.taint | | list (object) | List of Kubernetes taints to be applied to each node. |
| nodeConfig.taint[].effect | X | string | Effect for taint. |
| nodeConfig.taint[].key | X | string | Key for taint. |
| nodeConfig.taint[].value | X | string | Value for taint. |
| placementPolicy | | object | Specifies the node placement policy. |
| placementPolicy.type | X | string | Type defines the type of placement policy. |
| upgradeSettings.blueGreenSettings.standardRolloutPolicy | X | object | Standard rollout policy is the default policy for blue-green. |

## Installing the Chart

### With Helm

To install the chart with the release name `my-release`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/gcp-gke-cluster
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: gcp-gke-cluster
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.2"
    chart: gcp-gke-cluster
    path: ''

    helm:

      values: |
        name: mygke

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
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/gcp-gke-cluster --config /charts/charts/gcp-gke-cluster/ct.yaml
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template gcp-gke-cluster . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```

