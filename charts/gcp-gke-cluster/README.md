# gcp-gke-cluster

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

## Prerequisites

- Helm v3
- Config Connector installed (v1.6.0)

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| ilyasabdellaoui | <ilyas.abdellaoui21@gmail.com> | <https://github.com/ilyasabdellaoui> |

## Description

A Helm chart to provision a GKE Cluster via Config Connector.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| addonsConfig | object | `{"cloudrunConfig":{"disabled":true,"loadBalancerType":""},"configConnectorConfig":{"enabled":true},"dnsCacheConfig":{"enabled":false},"gcePersistentDiskCsiDriverConfig":{"enabled":true},"gcpFilestoreCsiDriverConfig":{"enabled":false},"gcsFuseCsiDriverConfig":{"enabled":false},"gkeBackupAgentConfig":{"enabled":false},"horizontalPodAutoscaling":{"disabled":false},"httpLoadBalancing":{"disabled":false},"istioConfig":{"auth":"AUTH_MUTUAL_TLS","disabled":true},"kalmConfig":{"enabled":false},"networkPolicyConfig":{"disabled":true}}` | Configuration for addons and optional features |
| addonsConfig.cloudrunConfig | object | `{"disabled":true,"loadBalancerType":""}` | The status of the CloudRun addon |
| addonsConfig.cloudrunConfig.disabled | bool | `true` | Whether Cloud Run addon is enabled |
| addonsConfig.cloudrunConfig.loadBalancerType | string | `""` | Type of load balancer |
| addonsConfig.configConnectorConfig | object | `{"enabled":true}` | Config Connector addon configuration |
| addonsConfig.configConnectorConfig.enabled | bool | `true` | Whether Config Connector addon is enabled |
| addonsConfig.dnsCacheConfig | object | `{"enabled":false}` | DNS cache configuration |
| addonsConfig.dnsCacheConfig.enabled | bool | `false` | Whether NodeLocal DNSCache addon is enabled |
| addonsConfig.gcePersistentDiskCsiDriverConfig | object | `{"enabled":true}` | Configuration for the Google Compute Engine ersistent Disk Container Storage Interface (CSI) Driver. |
| addonsConfig.gcePersistentDiskCsiDriverConfig.enabled | bool | `true` | Whether the GCE Persistent Disk CSI Driver is enabled. |
| addonsConfig.gcpFilestoreCsiDriverConfig | object | `{"enabled":false}` | Configuration for Filestore CSI driver addon, which allows the usage of filestore instance as volumes. |
| addonsConfig.gcpFilestoreCsiDriverConfig.enabled | bool | `false` | Whether the Filestore CSI Driver is enabled. |
| addonsConfig.gcsFuseCsiDriverConfig | object | `{"enabled":false}` | Configuration for the GCS Fuse CSI driver addon, which allows the usage of gcs bucket as volumes. |
| addonsConfig.gcsFuseCsiDriverConfig.enabled | bool | `false` | Whether the GCS Fuse CSI Driver is enabled. |
| addonsConfig.gkeBackupAgentConfig | object | `{"enabled":false}` | Configuration for the Backup for GKE Agent addon. |
| addonsConfig.gkeBackupAgentConfig.enabled | bool | `false` | Whether the Backup for GKE Agent addon is enabled. |
| addonsConfig.horizontalPodAutoscaling | object | `{"disabled":false}` | Configuration for the Horizontal Pod Autoscaling addon, which increases or decreases the number of replica pods a replication controller has based on the resource usage of the existing pods. It ensures that a Heapster pod is running in the cluster, which is also used by the Cloud Monitoring service |
| addonsConfig.horizontalPodAutoscaling.disabled | bool | `false` | Whether the Horizontal Pod Autoscaling addon is disabled. |
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
| annotations | object | `{}` | Add annotations to the VPC Network. |
| authenticatorGroupsConfig | object | `{"securityGroup":"gke-security-groups@edixos.com"}` | Configuration for the Google Groups for GKE feature. |
| authenticatorGroupsConfig.securityGroup | string | `"gke-security-groups@edixos.com"` | The name of the RBAC security group for use with Google security groups in Kubernetes RBAC. Group name must be in format gke-security-groups@yourdomain.com. |
| binaryAuthorization | object | `{"enabled":false,"evaluationMode":""}` | Configuration for the Binary Authorization feature. |
| binaryAuthorization.enabled | bool | `false` | DEPRECATED. Deprecated in favor of evaluation_mode. Enable Binary Authorization for this cluster. |
| binaryAuthorization.evaluationMode | string | `""` | Mode of operation for Binary Authorization policy evaluation. |
| clusterAutoscaling | object | `{"autoProvisioningDefaults":{"bootDiskKMSKeyRef":{"external":"","name":"","namespace":""},"diskSize":10,"imageType":"","management":{"autoRepair":false,"autoUpgrade":false,"upgradeOptions":{"autoUpgradeStartTime":"","description":""}},"minCpuPlatform":"","oauthScopes":[],"serviceAccountRef":{"external":"","name":"","namespace":""},"shieldedInstanceConfig":{"enableIntegrityMonitoring":false,"enableSecureBoot":false},"upgradeSettings":{"blueGreenSettings":{"nodePoolSoakDuration":"","standardRolloutPolicy":{"batchNodeCount":0,"batchPercentage":0,"batchSoakDuration":""}},"maxSurge":0,"maxUnavailable":0,"strategy":""}},"autoscalingProfile":"BALANCED","enabled":false,"resourceLimits":[{"maximum":0,"minimum":0,"resourceType":""}]}` | Per-cluster configuration of Node Auto-Provisioning with Cluster Autoscaler to automatically adjust the size of the cluster and create/delete node pools based on the current needs of the cluster's workload. See the guide to using Node Auto-Provisioning for more details. |
| clusterAutoscaling.autoProvisioningDefaults | object | `{"bootDiskKMSKeyRef":{"external":"","name":"","namespace":""},"diskSize":10,"imageType":"","management":{"autoRepair":false,"autoUpgrade":false,"upgradeOptions":{"autoUpgradeStartTime":"","description":""}},"minCpuPlatform":"","oauthScopes":[],"serviceAccountRef":{"external":"","name":"","namespace":""},"shieldedInstanceConfig":{"enableIntegrityMonitoring":false,"enableSecureBoot":false},"upgradeSettings":{"blueGreenSettings":{"nodePoolSoakDuration":"","standardRolloutPolicy":{"batchNodeCount":0,"batchPercentage":0,"batchSoakDuration":""}},"maxSurge":0,"maxUnavailable":0,"strategy":""}}` | Contains defaults for a node pool created by NAP. |
| clusterAutoscaling.autoProvisioningDefaults.bootDiskKMSKeyRef | object | `{"external":"","name":"","namespace":""}` | The Customer Managed Encryption Key used to encrypt the boot disk attached to each node in the node pool. |
| clusterAutoscaling.autoProvisioningDefaults.bootDiskKMSKeyRef.external | string | `""` | Allowed value: The `selfLink` field of a `KMSCryptoKey` resource. |
| clusterAutoscaling.autoProvisioningDefaults.bootDiskKMSKeyRef.name | string | `""` | Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names |
| clusterAutoscaling.autoProvisioningDefaults.bootDiskKMSKeyRef.namespace | string | `""` | Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/ |
| clusterAutoscaling.autoProvisioningDefaults.diskSize | int | `10` | Size of the disk attached to each node, specified in GB. The smallest allowed disk size is 10GB. |
| clusterAutoscaling.autoProvisioningDefaults.imageType | string | `""` | The default image type used by NAP once a new node pool is being created. |
| clusterAutoscaling.autoProvisioningDefaults.management | object | `{"autoRepair":false,"autoUpgrade":false,"upgradeOptions":{"autoUpgradeStartTime":"","description":""}}` | NodeManagement configuration for this NodePool. |
| clusterAutoscaling.autoProvisioningDefaults.management.autoRepair | bool | `false` | Specifies whether the node auto-repair is enabled for the node pool. If enabled, the nodes in this node pool will be monitored and, if they fail health checks too many times, an automatic repair action will be triggered. |
| clusterAutoscaling.autoProvisioningDefaults.management.autoUpgrade | bool | `false` | Specifies whether node auto-upgrade is enabled for the node pool. If enabled, node auto-upgrade helps keep the nodes in your node pool up to date with the latest release version of Kubernetes. |
| clusterAutoscaling.autoProvisioningDefaults.management.upgradeOptions | object | `{"autoUpgradeStartTime":"","description":""}` | Specifies the AutoUpgradeOptions for the node pool. |
| clusterAutoscaling.autoProvisioningDefaults.management.upgradeOptions.autoUpgradeStartTime | string | `""` | This field is set when upgrades are about to commence with the approximate start time for the upgrades, in RFC3339 text format. |
| clusterAutoscaling.autoProvisioningDefaults.management.upgradeOptions.description | string | `""` | This field is set when upgrades are about to commence with the description of the upgrade. |
| clusterAutoscaling.autoProvisioningDefaults.minCpuPlatform | string | `""` | Minimum CPU platform to be used by this instance. The instance may be scheduled on the specified or newer CPU platform. Applicable values are the friendly names of CPU platforms, such as Intel Haswell. |
| clusterAutoscaling.autoProvisioningDefaults.oauthScopes | list | `[]` | Scopes that are used by NAP when creating node pools. |
| clusterAutoscaling.autoProvisioningDefaults.serviceAccountRef | object | `{"external":"","name":"","namespace":""}` | Reference to a service account used by NAP when creating node pools. |
| clusterAutoscaling.autoProvisioningDefaults.serviceAccountRef.external | string | `""` | Allowed value: The `email` field of an `IAMServiceAccount` resource. |
| clusterAutoscaling.autoProvisioningDefaults.serviceAccountRef.name | string | `""` | Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names |
| clusterAutoscaling.autoProvisioningDefaults.serviceAccountRef.namespace | string | `""` | Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/ |
| clusterAutoscaling.autoProvisioningDefaults.shieldedInstanceConfig | object | `{"enableIntegrityMonitoring":false,"enableSecureBoot":false}` | Shielded Instance options. |
| clusterAutoscaling.autoProvisioningDefaults.shieldedInstanceConfig.enableIntegrityMonitoring | bool | `false` | Defines whether the instance has integrity monitoring enabled. |
| clusterAutoscaling.autoProvisioningDefaults.shieldedInstanceConfig.enableSecureBoot | bool | `false` | Defines whether the instance has Secure Boot enabled. |
| clusterAutoscaling.autoProvisioningDefaults.upgradeSettings | object | `{"blueGreenSettings":{"nodePoolSoakDuration":"","standardRolloutPolicy":{"batchNodeCount":0,"batchPercentage":0,"batchSoakDuration":""}},"maxSurge":0,"maxUnavailable":0,"strategy":""}` | Specifies the upgrade settings for NAP created node pools. |
| clusterAutoscaling.autoProvisioningDefaults.upgradeSettings.blueGreenSettings | object | `{"nodePoolSoakDuration":"","standardRolloutPolicy":{"batchNodeCount":0,"batchPercentage":0,"batchSoakDuration":""}}` | Settings for blue-green upgrade strategy. |
| clusterAutoscaling.autoProvisioningDefaults.upgradeSettings.blueGreenSettings.nodePoolSoakDuration | string | `""` | Time needed after draining entire blue pool. After this period, blue pool will be cleaned up. A duration in seconds with up to nine fractional digits, ending with 's'. Example: "3.5s". |
| clusterAutoscaling.autoProvisioningDefaults.upgradeSettings.blueGreenSettings.standardRolloutPolicy | object | `{"batchNodeCount":0,"batchPercentage":0,"batchSoakDuration":""}` | Standard policy for the blue-green upgrade. |
| clusterAutoscaling.autoProvisioningDefaults.upgradeSettings.blueGreenSettings.standardRolloutPolicy.batchNodeCount | int | `0` | Number of blue nodes to drain in a batch. |
| clusterAutoscaling.autoProvisioningDefaults.upgradeSettings.blueGreenSettings.standardRolloutPolicy.batchPercentage | float | `0` | Percentage of the bool pool nodes to drain in a batch. The range of this field should be (0.0, 1.0]. |
| clusterAutoscaling.autoProvisioningDefaults.upgradeSettings.blueGreenSettings.standardRolloutPolicy.batchSoakDuration | string | `""` | Soak time after each batch gets drained. A duration in seconds with up to nine fractional digits, ending with 's'. Example: "3.5s". |
| clusterAutoscaling.autoProvisioningDefaults.upgradeSettings.maxSurge | int | `0` | The maximum number of nodes that can be created beyond the current size of the node pool during the upgrade process. |
| clusterAutoscaling.autoProvisioningDefaults.upgradeSettings.maxUnavailable | int | `0` | The maximum number of nodes that can be simultaneously unavailable during the upgrade process. |
| clusterAutoscaling.autoProvisioningDefaults.upgradeSettings.strategy | string | `""` | Update strategy of the node pool. |
| clusterAutoscaling.autoscalingProfile | string | `"BALANCED"` | Configuration options for the Autoscaling profile feature, which lets you choose whether the cluster autoscaler should optimize for resource utilization or resource availability when deciding to remove nodes from a cluster. Can be BALANCED or OPTIMIZE_UTILIZATION. Defaults to BALANCED. |
| clusterAutoscaling.enabled | bool | `false` | Whether node auto-provisioning is enabled. Resource limits for cpu and memory must be defined to enable node auto-provisioning. |
| clusterAutoscaling.resourceLimits | list | `[{"maximum":0,"minimum":0,"resourceType":""}]` | Global constraints for machine resources in the cluster. Configuring the cpu and memory types is required if node auto-provisioning is enabled. These limits will apply to node pool autoscaling in addition to node auto-provisioning. |
| clusterAutoscaling.resourceLimits[0] | object | `{"maximum":0,"minimum":0,"resourceType":""}` | The type of the resource. For example, cpu and memory. See the guide to using Node Auto-Provisioning for a list of types. |
| clusterAutoscaling.resourceLimits[0].maximum | int | `0` | Maximum amount of the resource in the cluster. |
| clusterAutoscaling.resourceLimits[0].minimum | int | `0` | Minimum amount of the resource in the cluster. |
| clusterIpv4Cidr | string | `""` | Immutable. The IP address range of the Kubernetes pods in this cluster in CIDR notation (e.g. 10.96.0.0/14). Leave blank to have one automatically chosen or specify a /14 block in 10.0.0.0/8. This field will only work for routes-based clusters, where ip_allocation_policy is not defined. |
| clusterTelemetry | object | `{"type":""}` | Telemetry integration for the cluster. |
| clusterTelemetry.type | string | `""` | Type of the integration. |
| confidentialNodes | object | `{"enabled":false}` | Immutable. Configuration for the confidential nodes feature, which makes nodes run on confidential VMs. Warning: This configuration can't be changed (or added/removed) after cluster creation without deleting and recreating the entire cluster. |
| confidentialNodes.enabled | bool | `false` | Immutable. Whether Confidential Nodes feature is enabled for all nodes in this cluster. |
| costManagementConfig | object | `{"enabled":false}` | Cost management configuration for the cluster. |
| costManagementConfig.enabled | bool | `false` | Whether to enable GKE cost allocation. When you enable GKE cost allocation, the cluster name and namespace of your GKE workloads appear in the labels field of the billing export to BigQuery. Defaults to false. |
| databaseEncryption | object | `{"keyName":"","state":""}` | Application-layer Secrets Encryption settings. The object format is {state = string, key_name = string}. Valid values of state are: "ENCRYPTED"; "DECRYPTED". key_name is the name of a CloudKMS key. |
| databaseEncryption.keyName | string | `""` | The key to use to encrypt/decrypt secrets. |
| databaseEncryption.state | string | `""` | ENCRYPTED or DECRYPTED. |
| datapathProvider | string | `""` | Immutable. The desired datapath provider for this cluster. By default, uses the IPTables-based kube-proxy implementation. |
| defaultMaxPodsPerNode | int | `0` | Immutable. The default maximum number of pods per node in this cluster. This doesn't work on "routes-based" clusters, clusters that don't have IP Aliasing enabled. |
| defaultSnatStatus | object | `{"disabled":false}` | Whether the cluster disables default in-node sNAT rules. In-node sNAT rules will be disabled when defaultSnatStatus is disabled. |
| defaultSnatStatus.disabled | bool | `false` | When disabled is set to false, default IP masquerade rules will be applied to the nodes to prevent sNAT on cluster internal traffic. |
| description | string | `"EKP GKE Cluster"` | A text description of the GKE Cluster. Must be less than or equal to 256 UTF-8 bytes. |
| dnsConfig | object | `{"clusterDns":"","clusterDnsDomain":"","clusterDnsScope":""}` | Immutable. Configuration for Cloud DNS for Kubernetes Engine. |
| dnsConfig.clusterDns | string | `""` | Which in-cluster DNS provider should be used. |
| dnsConfig.clusterDnsDomain | string | `""` | The suffix used for all cluster service records. |
| dnsConfig.clusterDnsScope | string | `""` | The scope of access to cluster DNS records. |
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
| gatewayApiConfig | object | `{"channel":""}` | Configuration for GKE Gateway API controller. |
| gatewayApiConfig.channel | string | `""` | The Gateway API release channel to use for Gateway API. |
| global.abandon | bool | `false` | If true, Keep the GKE Cluster even after the kcc resource deletion. |
| global.cnrmNamespace | string | `nil` | Allows to deploy in another namespace than the release one |
| global.gcpProjectId | string | `"myprojectid"` | Google Project ID |
| identityServiceConfig | object | `{"enabled":false}` | Configuration for Identity Service which allows customers to use external identity providers with the K8S API. |
| identityServiceConfig.enabled | bool | `false` | Whether to enable the Identity Service component. |
| initialNodeCount | int | `1` | Initial number of nodes in the default node pool. Must be set if no custom node pools are defined. |
| ipAllocationPolicy | object | `{"additionalPodRangesConfig":{"podRangeNames":[]},"clusterIpv4CidrBlock":"","clusterSecondaryRangeName":"","podCidrOverprovisionConfig":{"disabled":false},"servicesIpv4CidrBlock":"","servicesSecondaryRangeName":"","stackType":""}` | Immutable. Configuration of cluster IP allocation for VPC-native clusters. Adding this block enables IP aliasing, making the cluster VPC-native instead of routes-based. |
| ipAllocationPolicy.additionalPodRangesConfig | object | `{"podRangeNames":[]}` | AdditionalPodRangesConfig is the configuration for additional pod secondary ranges supporting the ClusterUpdate message. |
| ipAllocationPolicy.additionalPodRangesConfig.podRangeNames | list | `[]` | Name for pod secondary ipv4 range which has the actual range defined ahead. |
| ipAllocationPolicy.clusterIpv4CidrBlock | string | `""` | Immutable. The IP address range for the cluster pod IPs. Set to blank to have a range chosen with the default size. Set to /netmask (e.g. /14) to have a range chosen with a specific netmask. Set to a CIDR notation (e.g. 10.96.0.0/14) from the RFC-1918 private networks (e.g. 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) to pick a specific range to use. |
| ipAllocationPolicy.clusterSecondaryRangeName | string | `""` | Immutable. The name of the existing secondary range in the cluster's subnetwork to use for pod IP addresses. Alternatively, cluster_ipv4_cidr_block can be used to automatically create a GKE-managed one. |
| ipAllocationPolicy.podCidrOverprovisionConfig | object | `{"disabled":false}` | Immutable. Configuration for cluster level pod cidr overprovision. Default is disabled=false. |
| ipAllocationPolicy.podCidrOverprovisionConfig.disabled | bool | `false` | Whether pod cidr overprovision is disabled. |
| ipAllocationPolicy.servicesIpv4CidrBlock | string | `""` | Immutable. The IP address range of the services IPs in this cluster. Set to blank to have a range chosen with the default size. Set to /netmask (e.g. /14) to have a range chosen with a specific netmask. Set to a CIDR notation (e.g. 10.96.0.0/14) from the RFC-1918 private networks (e.g. 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) to pick a specific range to use. |
| ipAllocationPolicy.servicesSecondaryRangeName | string | `""` | Immutable. The name of the existing secondary range in the cluster's subnetwork to use for service ClusterIPs. Alternatively, services_ipv4_cidr_block can be used to automatically create a GKE-managed one. |
| ipAllocationPolicy.stackType | string | `""` | Immutable. The IP Stack type of the cluster. Choose between IPV4 and IPV4_IPV6. Default type is IPV4 Only if not set. |
| location | string | `"europe-west1-a"` | Location (region or zone) for the GKE cluster. If a zone is specified, the cluster will be zonal. If a region is specified, it will be regional. |
| loggingConfig | object | `{"enableComponents":[]}` | Logging configuration for the cluster. |
| loggingConfig.enableComponents | list | `[]` | GKE components exposing logs. Valid values include SYSTEM_COMPONENTS, APISERVER, CONTROLLER_MANAGER, SCHEDULER, and WORKLOADS. |
| loggingService | string | `"logging.googleapis.com/kubernetes"` | The logging service that the cluster should write logs to. Available options include logging.googleapis.com(Legacy Stackdriver), logging.googleapis.com/kubernetes(Stackdriver Kubernetes Engine Logging), and none. Defaults to logging.googleapis.com/kubernetes. |
| maintenancePolicy | object | `{"dailyMaintenanceWindow":{"duration":"","startTime":""},"maintenanceExclusion":[{"endTime":"","exclusionName":"","exclusionOptions":{"scope":""},"startTime":""}],"recurringWindow":{"endTime":"","recurrence":"","startTime":""}}` | The maintenance policy to use for the cluster. |
| maintenancePolicy.dailyMaintenanceWindow | object | `{"duration":"","startTime":""}` | Time window specified for daily maintenance operations. Specify start_time in RFC3339 format "HH:MM”, where HH : [00-23] and MM : [00-59] GMT. |
| maintenancePolicy.dailyMaintenanceWindow.duration | string | `""` | Duration of the maintenance window. |
| maintenancePolicy.dailyMaintenanceWindow.startTime | string | `""` | Start time of the maintenance window in RFC3339 format "HH:MM". |
| maintenancePolicy.maintenanceExclusion | list | `[{"endTime":"","exclusionName":"","exclusionOptions":{"scope":""},"startTime":""}]` | Exceptions to maintenance window. Non-emergency maintenance should not occur in these windows. |
| maintenancePolicy.maintenanceExclusion[0] | object | `{"endTime":"","exclusionName":"","exclusionOptions":{"scope":""},"startTime":""}` | End time of the maintenance exclusion in RFC3339 format "HH:MM". |
| maintenancePolicy.maintenanceExclusion[0].exclusionName | string | `""` | Name of the maintenance exclusion. |
| maintenancePolicy.maintenanceExclusion[0].exclusionOptions | object | `{"scope":""}` | Maintenance exclusion related options. |
| maintenancePolicy.maintenanceExclusion[0].exclusionOptions.scope | string | `""` | The scope of automatic upgrades to restrict in the exclusion window. |
| maintenancePolicy.maintenanceExclusion[0].startTime | string | `""` | Start time of the maintenance exclusion in RFC3339 format "HH:MM". |
| maintenancePolicy.recurringWindow | object | `{"endTime":"","recurrence":"","startTime":""}` | Time window for recurring maintenance operations. |
| maintenancePolicy.recurringWindow.endTime | string | `""` | End time of the recurring maintenance window in RFC3339 format "HH:MM". |
| maintenancePolicy.recurringWindow.recurrence | string | `""` | Recurrence of the maintenance window in RFC5545 format. |
| maintenancePolicy.recurringWindow.startTime | string | `""` | Start time of the recurring maintenance window in RFC3339 format "HH:MM". |
| masterAuth | object | `{"clientCertificate":"","clientCertificateConfig":{"issueClientCertificate":false},"clientKey":"","clusterCaCertificate":"","password":{"value":"","valueFrom":{"secretKeyRef":{"key":"","name":""}}},"username":""}` | DEPRECATED. Basic authentication was removed for GKE cluster versions >= 1.19. The authentication information for accessing the Kubernetes master. Some values in this block are only returned by the API if your service account has permission to get credentials for your GKE cluster. If you see an unexpected diff unsetting your client cert, ensure you have the container.clusters.getCredentials permission. |
| masterAuth.clientCertificate | string | `""` | Base64 encoded public certificate used by clients to authenticate to the cluster endpoint. |
| masterAuth.clientCertificateConfig | object | `{"issueClientCertificate":false}` | Immutable. Whether client certificate authorization is enabled for this cluster. |
| masterAuth.clientCertificateConfig.issueClientCertificate | bool | `false` | Immutable. Whether client certificate authorization is enabled for this cluster. |
| masterAuth.clientKey | string | `""` | Base64 encoded private key used by clients to authenticate to the cluster endpoint. |
| masterAuth.clusterCaCertificate | string | `""` | Base64 encoded public certificate that is the root of trust for the cluster. |
| masterAuth.password | object | `{"value":"","valueFrom":{"secretKeyRef":{"key":"","name":""}}}` | The password to use for HTTP basic authentication when accessing the Kubernetes master endpoint. |
| masterAuth.password.value | string | `""` | Value of the field. Cannot be used if 'valueFrom' is specified. |
| masterAuth.password.valueFrom | object | `{"secretKeyRef":{"key":"","name":""}}` | Source for the field's value. Cannot be used if 'value' is specified. |
| masterAuth.password.valueFrom.secretKeyRef | object | `{"key":"","name":""}` | Reference to a value with the given key in the given Secret in the resource's namespace. |
| masterAuth.password.valueFrom.secretKeyRef.key | string | `""` | Key that identifies the value to be extracted. |
| masterAuth.password.valueFrom.secretKeyRef.name | string | `""` | Name of the Secret to extract a value from. |
| masterAuth.username | string | `""` | The username to use for HTTP basic authentication when accessing the Kubernetes master endpoint. If not present basic auth will be disabled. |
| masterAuthorizedNetworksConfig | object | `{"cidrBlocks":[{"cidrBlock":"","displayName":""}],"gcpPublicCidrsAccessEnabled":false}` | The desired configuration options for master authorized networks. Omit the nested cidr_blocks attribute to disallow external access (except the cluster node IPs, which GKE automatically whitelists). |
| masterAuthorizedNetworksConfig.cidrBlocks | list | `[{"cidrBlock":"","displayName":""}]` | External networks that can access the Kubernetes cluster master through HTTPS. |
| masterAuthorizedNetworksConfig.cidrBlocks[0] | object | `{"cidrBlock":"","displayName":""}` | External network that can access Kubernetes master through HTTPS. Must be specified in CIDR notation. |
| masterAuthorizedNetworksConfig.cidrBlocks[0].displayName | string | `""` | Field for users to identify CIDR blocks. |
| masterAuthorizedNetworksConfig.gcpPublicCidrsAccessEnabled | bool | `false` | Whether master is accessbile via Google Compute Engine Public IP addresses. |
| meshCertificates | object | `{"enableCertificates":false}` | If set, and enable_certificates=true, the GKE Workload Identity Certificates controller and node agent will be deployed in the cluster. |
| meshCertificates.enableCertificates | bool | `false` | When enabled the GKE Workload Identity Certificates controller and node agent will be deployed in the cluster. |
| minMasterVersion | string | `""` | The minimum version of the master. GKE will auto-update the master to new versions, so this does not guarantee the current master version--use the read-only master_version field to obtain that. If unset, the cluster's version will be set by GKE to the version of the most recent official release (which is not necessarily the latest version). |
| monitoringConfig | object | `{"advancedDatapathObservabilityConfig":[{"enableMetrics":false,"relayMode":""}],"enableComponents":[],"managedPrometheus":{"enabled":false}}` | Monitoring configuration for the cluster. |
| monitoringConfig.advancedDatapathObservabilityConfig | list | `[{"enableMetrics":false,"relayMode":""}]` | Configuration of Advanced Datapath Observability features. |
| monitoringConfig.advancedDatapathObservabilityConfig[0] | object | `{"enableMetrics":false,"relayMode":""}` | Whether or not the advanced datapath metrics are enabled. |
| monitoringConfig.advancedDatapathObservabilityConfig[0].relayMode | string | `""` | Mode used to make Relay available. |
| monitoringConfig.enableComponents | list | `[]` | GKE components exposing metrics. Valid values include SYSTEM_COMPONENTS, APISERVER, SCHEDULER, CONTROLLER_MANAGER, STORAGE, HPA, POD, DAEMONSET, DEPLOYMENT, STATEFULSET and WORKLOADS. |
| monitoringConfig.managedPrometheus | object | `{"enabled":false}` | Configuration for Google Cloud Managed Services for Prometheus. |
| monitoringConfig.managedPrometheus.enabled | bool | `false` | Whether or not the managed collection is enabled. |
| monitoringService | string | `"monitoring.googleapis.com/kubernetes"` | The monitoring service that the cluster should write metrics to. Automatically send metrics from pods in the cluster to the Google Cloud Monitoring API. VM metrics will be collected by Google Compute Engine regardless of this setting Available options include monitoring.googleapis.com(Legacy Stackdriver), monitoring.googleapis.com/kubernetes(Stackdriver Kubernetes Engine Monitoring), and none. Defaults to monitoring.googleapis.com/kubernetes. |
| name | string | `"ekp-gke-cluster"` | Name of the GKE Cluster. |
| networkPolicy | object | `{"enabled":false,"provider":""}` | Configuration options for the NetworkPolicy feature. |
| networkPolicy.enabled | bool | `false` | Whether network policy is enabled on the cluster. |
| networkPolicy.provider | string | `""` | The selected network policy provider. Defaults to PROVIDER_UNSPECIFIED. |
| networkRef | object | `{"external":"","name":"","namespace":""}` | Reference to a Compute Network resource. |
| networkRef.external | string | `""` | Allowed value: The `selfLink` field of a `ComputeNetwork` resource. |
| networkRef.name | string | `""` | Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names |
| networkRef.namespace | string | `""` | Namespace of the referent. More info: https://kubernetes.io/docs/concepts/over |
| networkingMode | string | `"VPC_NATIVE"` | Networking mode for the cluster. Determines whether alias IPs or routes will be used for pod IPs. Options: "VPC_NATIVE" (default) or "ROUTES". |
| nodeConfig | object | `{"advancedMachineFeatures":{"threadsPerCore":0},"bootDiskKMSCryptoKeyRef":{"external":"","name":"","namespace":""},"confidentialNodes":{"enabled":false},"diskSizeGb":10,"diskType":"","ephemeralStorageConfig":{"localSsdCount":0},"ephemeralStorageLocalSsdConfig":{"localSsdCount":0},"fastSocket":{"enabled":false},"gcfsConfig":{"enabled":false},"guestAccelerator":[{"count":0,"gpuDriverInstallationConfig":{"gpuDriverVersion":""},"gpuPartitionSize":"","gpuSharingConfig":{"gpuSharingStrategy":"","maxSharedClientsPerGpu":0},"type":""}],"gvnic":{"enabled":false},"hostMaintenancePolicy":{"maintenanceInterval":""},"imageType":"","kubeletConfig":{"cpuCfsQuota":false,"cpuCfsQuotaPeriod":"","cpuManagerPolicy":"","podPidsLimit":0},"labels":{},"linuxNodeConfig":{"cgroupMode":"","sysctls":{}},"localNvmeSsdBlockConfig":{"localSsdCount":0},"localSsdCount":0,"loggingVariant":"","machineType":"","metadata":{},"minCpuPlatform":"","nodeGroupRef":{"external":"","name":"","namespace":""},"oauthScopes":[],"preemptible":false,"reservationAffinity":{"consumeReservationType":"","key":"","values":[]},"resourceLabels":{},"sandboxConfig":{"sandboxType":""},"serviceAccountRef":{"external":"","name":"","namespace":""},"shieldedInstanceConfig":{"enableIntegrityMonitoring":false,"enableSecureBoot":false},"soleTenantConfig":{"nodeAffinity":[{"key":"","operator":"","values":[]}]},"spot":false,"tags":[],"taint":[{"effect":"","key":"","value":""}],"workloadMetadataConfig":{"mode":"","nodeMetadata":""}}` | Immutable. The configuration of the nodepool. |
| nodeConfig.advancedMachineFeatures | object | `{"threadsPerCore":0}` | Immutable. Specifies options for controlling advanced machine features. |
| nodeConfig.advancedMachineFeatures.threadsPerCore | int | `0` | Immutable. The number of threads per physical core. To disable simultaneous multithreading (SMT) set this to 1. If unset, the maximum number of threads supported per core by the underlying processor is assumed. |
| nodeConfig.bootDiskKMSCryptoKeyRef | object | `{"external":"","name":"","namespace":""}` | Reference to a KMS CryptoKey resource for encrypting the boot disk. |
| nodeConfig.bootDiskKMSCryptoKeyRef.external | string | `""` | Allowed value: The `selfLink` field of a `KMSCryptoKey` resource. |
| nodeConfig.bootDiskKMSCryptoKeyRef.name | string | `""` | Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names |
| nodeConfig.bootDiskKMSCryptoKeyRef.namespace | string | `""` | Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/ |
| nodeConfig.confidentialNodes | object | `{"enabled":false}` | Immutable. Configuration for the confidential nodes feature, which makes nodes run on confidential VMs. Warning: This configuration can't be changed (or added/removed) after pool creation without deleting and recreating the entire pool. |
| nodeConfig.confidentialNodes.enabled | bool | `false` | Immutable. Whether Confidential Nodes feature is enabled for all nodes in this pool. |
| nodeConfig.diskSizeGb | int | `10` | Immutable. Size of the disk attached to each node, specified in GB. The smallest allowed disk size is 10GB. |
| nodeConfig.diskType | string | `""` | Immutable. Type of the disk attached to each node. Such as pd-standard, pd-balanced or pd-ssd. |
| nodeConfig.ephemeralStorageConfig | object | `{"localSsdCount":0}` | Immutable. Parameters for the ephemeral storage filesystem. If unspecified, ephemeral storage is backed by the boot disk. |
| nodeConfig.ephemeralStorageConfig.localSsdCount | int | `0` | Immutable. Number of local SSDs to use to back ephemeral storage. Uses NVMe interfaces. Each local SSD must be 375 or 3000 GB in size, and all local SSDs must share the same size. |
| nodeConfig.ephemeralStorageLocalSsdConfig | object | `{"localSsdCount":0}` | Immutable. Parameters for the ephemeral storage filesystem. If unspecified, ephemeral storage is backed by the boot disk. |
| nodeConfig.ephemeralStorageLocalSsdConfig.localSsdCount | int | `0` | Immutable. Number of local SSDs to use to back ephemeral storage. Uses NVMe interfaces. Each local SSD must be 375 or 3000 GB in size, and all local SSDs must share the same size. |
| nodeConfig.fastSocket | object | `{"enabled":false}` | Enable or disable NCCL Fast Socket in the node pool. |
| nodeConfig.fastSocket.enabled | bool | `false` | Whether or not NCCL Fast Socket is enabled. |
| nodeConfig.gcfsConfig | object | `{"enabled":false}` | Immutable. GCFS configuration for this node. |
| nodeConfig.gcfsConfig.enabled | bool | `false` | Immutable. Whether or not GCFS is enabled. |
| nodeConfig.guestAccelerator | list | `[{"count":0,"gpuDriverInstallationConfig":{"gpuDriverVersion":""},"gpuPartitionSize":"","gpuSharingConfig":{"gpuSharingStrategy":"","maxSharedClientsPerGpu":0},"type":""}]` | Immutable. List of the type and count of accelerator cards attached to the instance. |
| nodeConfig.guestAccelerator[0] | object | `{"count":0,"gpuDriverInstallationConfig":{"gpuDriverVersion":""},"gpuPartitionSize":"","gpuSharingConfig":{"gpuSharingStrategy":"","maxSharedClientsPerGpu":0},"type":""}` | Immutable. The number of the accelerator cards exposed to an instance. |
| nodeConfig.guestAccelerator[0].gpuDriverInstallationConfig | object | `{"gpuDriverVersion":""}` | Immutable. Configuration for auto installation of GPU driver. |
| nodeConfig.guestAccelerator[0].gpuDriverInstallationConfig.gpuDriverVersion | string | `""` | Immutable. Mode for how the GPU driver is installed. |
| nodeConfig.guestAccelerator[0].gpuPartitionSize | string | `""` | Immutable. Size of partitions to create on the GPU. Valid values are described in the NVIDIA mig user guide (https://docs.nvidia.com/datacenter/tesla/mig-user-guide/#partitioning). |
| nodeConfig.guestAccelerator[0].gpuSharingConfig | object | `{"gpuSharingStrategy":"","maxSharedClientsPerGpu":0}` | Immutable. Configuration for GPU sharing. |
| nodeConfig.guestAccelerator[0].gpuSharingConfig.gpuSharingStrategy | string | `""` | Immutable. The type of GPU sharing strategy to enable on the GPU node. Possible values are described in the API package (https://pkg.go.dev/google.golang.org/api/container/v1#GPUSharingConfig). |
| nodeConfig.guestAccelerator[0].gpuSharingConfig.maxSharedClientsPerGpu | int | `0` | Immutable. The maximum number of containers that can share a GPU. |
| nodeConfig.guestAccelerator[0].type | string | `""` | Immutable. The accelerator type resource name. |
| nodeConfig.gvnic | object | `{"enabled":false}` | Immutable. Enable or disable gvnic in the node pool. |
| nodeConfig.gvnic.enabled | bool | `false` | Immutable. Whether or not gvnic is enabled. |
| nodeConfig.hostMaintenancePolicy | object | `{"maintenanceInterval":""}` | Immutable. The maintenance policy for the hosts on which the GKE VMs run on. |
| nodeConfig.hostMaintenancePolicy.maintenanceInterval | string | `""` | Immutable. The maintenance interval for the hosts. |
| nodeConfig.imageType | string | `""` | The image type to use for this node. Note that for a given image type, the latest version of it will be used. |
| nodeConfig.kubeletConfig | object | `{"cpuCfsQuota":false,"cpuCfsQuotaPeriod":"","cpuManagerPolicy":"","podPidsLimit":0}` | Node kubelet configs. |
| nodeConfig.kubeletConfig.cpuCfsQuota | bool | `false` | Enable CPU CFS quota enforcement for containers that specify CPU limits. |
| nodeConfig.kubeletConfig.cpuCfsQuotaPeriod | string | `""` | Set the CPU CFS quota period value 'cpu.cfs_period_us'. |
| nodeConfig.kubeletConfig.cpuManagerPolicy | string | `""` | Control the CPU management policy on the node. |
| nodeConfig.kubeletConfig.podPidsLimit | int | `0` | Controls the maximum number of processes allowed to run in a pod. |
| nodeConfig.labels | object | `{}` | Immutable. The map of Kubernetes labels (key/value pairs) to be applied to each node. These will added in addition to any default label(s) that Kubernetes may apply to the node. |
| nodeConfig.linuxNodeConfig | object | `{"cgroupMode":"","sysctls":{}}` | Parameters that can be configured on Linux nodes. |
| nodeConfig.linuxNodeConfig.cgroupMode | string | `""` | cgroupMode specifies the cgroup mode to be used on the node. |
| nodeConfig.linuxNodeConfig.sysctls | object | `{}` | The Linux kernel parameters to be applied to the nodes and all pods running on the nodes. |
| nodeConfig.localNvmeSsdBlockConfig | object | `{"localSsdCount":0}` | Immutable. Parameters for raw-block local NVMe SSDs. |
| nodeConfig.localNvmeSsdBlockConfig.localSsdCount | int | `0` | Immutable. Number of raw-block local NVMe SSD disks to be attached to the node. Each local SSD is 375 GB in size. |
| nodeConfig.localSsdCount | int | `0` | Immutable. The number of local SSD disks to be attached to the node. |
| nodeConfig.loggingVariant | string | `""` | Type of logging agent that is used as the default value for node pools in the cluster. Valid values include DEFAULT and MAX_THROUGHPUT. |
| nodeConfig.machineType | string | `""` | Immutable. The name of a Google Compute Engine machine type. |
| nodeConfig.metadata | object | `{}` | Immutable. The metadata key/value pairs assigned to instances in the cluster. |
| nodeConfig.minCpuPlatform | string | `""` | Immutable. Minimum CPU platform to be used by this instance. The instance may be scheduled on the specified or newer CPU platform. |
| nodeConfig.nodeGroupRef | object | `{"external":"","name":"","namespace":""}` | Immutable. Setting this field will assign instances of this pool to run on the specified node group. This is useful for running workloads on sole tenant nodes. |
| nodeConfig.nodeGroupRef.external | string | `""` | Allowed value: The `name` field of a `ComputeNodeGroup` resource. |
| nodeConfig.nodeGroupRef.name | string | `""` | Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names |
| nodeConfig.nodeGroupRef.namespace | string | `""` | Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/ |
| nodeConfig.oauthScopes | list | `[]` | Immutable. The set of Google API scopes to be made available on all of the node VMs. |
| nodeConfig.preemptible | bool | `false` | Immutable. Whether the nodes are created as preemptible VM instances. |
| nodeConfig.reservationAffinity | object | `{"consumeReservationType":"","key":"","values":[]}` | Immutable. The reservation affinity configuration for the node pool. |
| nodeConfig.reservationAffinity.consumeReservationType | string | `""` | Immutable. Corresponds to the type of reservation consumption. |
| nodeConfig.reservationAffinity.key | string | `""` | Immutable. The label key of a reservation resource. |
| nodeConfig.reservationAffinity.values | list | `[]` | Immutable. The label values of the reservation resource. |
| nodeConfig.resourceLabels | object | `{}` | The GCE resource labels (a map of key/value pairs) to be applied to the node pool. |
| nodeConfig.sandboxConfig | object | `{"sandboxType":""}` | Immutable. Sandbox configuration for this node. |
| nodeConfig.sandboxConfig.sandboxType | string | `""` | Type of the sandbox to use for the node (e.g. 'gvisor'). |
| nodeConfig.serviceAccountRef | object | `{"external":"","name":"","namespace":""}` | Reference to a service account used by the node pool. |
| nodeConfig.serviceAccountRef.external | string | `""` | Allowed value: The `email` field of an `IAMServiceAccount` resource. |
| nodeConfig.serviceAccountRef.name | string | `""` | Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names |
| nodeConfig.serviceAccountRef.namespace | string | `""` | Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/ |
| nodeConfig.shieldedInstanceConfig | object | `{"enableIntegrityMonitoring":false,"enableSecureBoot":false}` | Immutable. Shielded Instance options. |
| nodeConfig.shieldedInstanceConfig.enableIntegrityMonitoring | bool | `false` | Immutable. Defines whether the instance has integrity monitoring enabled. |
| nodeConfig.shieldedInstanceConfig.enableSecureBoot | bool | `false` | Immutable. Defines whether the instance has Secure Boot enabled. |
| nodeConfig.soleTenantConfig | object | `{"nodeAffinity":[{"key":"","operator":"","values":[]}]}` | Immutable. Node affinity options for sole tenant node pools. |
| nodeConfig.soleTenantConfig.nodeAffinity | list | `[{"key":"","operator":"","values":[]}]` | Immutable. Node affinity configuration for sole tenant node pools. |
| nodeConfig.soleTenantConfig.nodeAffinity[0] | object | `{"key":"","operator":"","values":[]}` | Immutable. The key for the node affinity configuration. |
| nodeConfig.soleTenantConfig.nodeAffinity[0].operator | string | `""` | Immutable. The operator for the node affinity configuration. |
| nodeConfig.soleTenantConfig.nodeAffinity[0].values | list | `[]` | Immutable. The values for the node affinity configuration. |
| nodeConfig.spot | bool | `false` | Immutable. Whether the nodes are created as spot VM instances. |
| nodeConfig.tags | list | `[]` | The list of instance tags applied to all nodes. |
| nodeConfig.taint | list | `[{"effect":"","key":"","value":""}]` | List of Kubernetes taints to be applied to each node. |
| nodeConfig.taint[0] | object | `{"effect":"","key":"","value":""}` | Effect for taint. |
| nodeConfig.taint[0].key | string | `""` | Key for taint. |
| nodeConfig.taint[0].value | string | `""` | Value for taint. |
| nodeConfig.workloadMetadataConfig | object | `{"mode":"","nodeMetadata":""}` | Immutable. The workload metadata configuration for this node. |
| nodeConfig.workloadMetadataConfig.mode | string | `""` | Mode is the configuration for how to expose metadata to workloads running on the node. |
| nodeConfig.workloadMetadataConfig.nodeMetadata | string | `""` | DEPRECATED. Deprecated in favor of mode. NodeMetadata is the configuration for how to expose metadata to the workloads running on the node. |
| nodeLocations | list | `[]` | The list of zones in which the cluster's nodes are located. Nodes must be in the region of their regional cluster or in the same region as their cluster's zone for zonal clusters. If this is specified for a zonal cluster, omit the cluster's zone. |
| nodePoolAutoConfig | object | `{"networkTags":{"tags":[]}}` | Node pool configs that apply to all auto-provisioned node pools in autopilot clusters and node auto-provisioning enabled clusters. |
| nodePoolAutoConfig.networkTags | object | `{"tags":[]}` | Collection of Compute Engine network tags that can be applied to a node's underlying VM instance. |
| nodePoolAutoConfig.networkTags.tags | list | `[]` | List of network tags applied to auto-provisioned node pools. |
| nodePoolDefaults | object | `{"nodeConfigDefaults":{"gcfsConfig":{"enabled":false},"loggingVariant":""}}` | The default node pool settings for the entire cluster. |
| nodePoolDefaults.nodeConfigDefaults | object | `{"gcfsConfig":{"enabled":false},"loggingVariant":""}` | Subset of NodeConfig message that has defaults. |
| nodePoolDefaults.nodeConfigDefaults.gcfsConfig | object | `{"enabled":false}` | GCFS configuration for this node. |
| nodePoolDefaults.nodeConfigDefaults.gcfsConfig.enabled | bool | `false` | Whether or not GCFS is enabled. |
| nodePoolDefaults.nodeConfigDefaults.loggingVariant | string | `""` | Type of logging agent that is used as the default value for node pools in the cluster. Valid values include DEFAULT and MAX_THROUGHPUT. |
| nodeVersion | string | `""` | The Kubernetes version to use for the nodes in the cluster. |
| notificationConfig | object | `{"pubsub":{"enabled":false,"filter":{"eventType":[]},"topicRef":{"external":"","name":"","namespace":""}}}` | The notification config for sending cluster upgrade notifications. |
| notificationConfig.pubsub | object | `{"enabled":false,"filter":{"eventType":[]},"topicRef":{"external":"","name":"","namespace":""}}` | Notification config for Cloud Pub/Sub. |
| notificationConfig.pubsub.enabled | bool | `false` | Whether or not the notification config is enabled. |
| notificationConfig.pubsub.filter | object | `{"eventType":[]}` | Allows filtering to one or more specific event types. If event types are present, those and only those event types will be transmitted to the cluster. Other types will be skipped. If no filter is specified, or no event types are present, all event types will be sent. |
| notificationConfig.pubsub.filter.eventType | list | `[]` | Can be used to filter what notifications are sent. Valid values include UPGRADE_AVAILABLE_EVENT, UPGRADE_EVENT and SECURITY_BULLETIN_EVENT. |
| notificationConfig.pubsub.topicRef | object | `{"external":"","name":"","namespace":""}` | The PubSubTopic to send the notification to. |
| notificationConfig.pubsub.topicRef.external | string | `""` | Allowed value: string of the format `projects/{{project}}/topics/{{value}}`, where {{value}} is the `name` field of a `PubSubTopic` resource. |
| notificationConfig.pubsub.topicRef.name | string | `""` | Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names |
| notificationConfig.pubsub.topicRef.namespace | string | `""` | Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/ |
| podSecurityPolicyConfig | object | `{"enabled":false}` | Configuration for the PodSecurityPolicy feature. |
| podSecurityPolicyConfig.enabled | bool | `false` | Enable the PodSecurityPolicy controller for this cluster. If enabled, pods must be valid under a PodSecurityPolicy to be created. |
| privateClusterConfig | object | `{"enablePrivateEndpoint":false,"enablePrivateNodes":false,"masterGlobalAccessConfig":{"enabled":false},"masterIpv4CidrBlock":"","peeringName":"","privateEndpoint":"","privateEndpointSubnetworkRef":{"external":"","name":"","namespace":""},"publicEndpoint":""}` | Configuration for private clusters, clusters with private nodes. |
| privateClusterConfig.enablePrivateEndpoint | bool | `false` | When true, the cluster's private endpoint is used as the cluster endpoint and access through the public endpoint is disabled. When false, either endpoint can be used. |
| privateClusterConfig.enablePrivateNodes | bool | `false` | Immutable. Enables the private cluster feature, creating a private endpoint on the cluster. In a private cluster, nodes only have RFC 1918 private addresses and communicate with the master's private endpoint via private networking. |
| privateClusterConfig.masterGlobalAccessConfig | object | `{"enabled":false}` | Controls cluster master global access settings. |
| privateClusterConfig.masterGlobalAccessConfig.enabled | bool | `false` | Whether the cluster master is accessible globally or not. |
| privateClusterConfig.masterIpv4CidrBlock | string | `""` | Immutable. The IP range in CIDR notation to use for the hosted master network. This range will be used for assigning private IP addresses to the cluster master(s) and the ILB VIP. This range must not overlap with any other ranges in use within the cluster's network, and it must be a /28 subnet. See Private Cluster Limitations for more details. This field only applies to private clusters, when enable_private_nodes is true. |
| privateClusterConfig.peeringName | string | `""` | The name of the peering between this cluster and the Google owned VPC. |
| privateClusterConfig.privateEndpoint | string | `""` | The internal IP address of this cluster's master endpoint. |
| privateClusterConfig.privateEndpointSubnetworkRef | object | `{"external":"","name":"","namespace":""}` | Immutable. Subnetwork in cluster's network where master's endpoint will be provisioned. |
| privateClusterConfig.privateEndpointSubnetworkRef.external | string | `""` | Allowed value: The `selfLink` field of a `ComputeSubnetwork` resource. |
| privateClusterConfig.privateEndpointSubnetworkRef.name | string | `""` | Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names |
| privateClusterConfig.privateEndpointSubnetworkRef.namespace | string | `""` | Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/ |
| privateClusterConfig.publicEndpoint | string | `""` | The external IP address of this cluster's master endpoint. |
| privateIpv6GoogleAccess | string | `""` | The desired state of IPv6 connectivity to Google Services. By default, no private IPv6 access to or from Google Services (all access will be via IPv4). |
| protectConfig | object | `{"workloadConfig":{"auditMode":""},"workloadVulnerabilityMode":""}` | Enable/Disable Protect API features for the cluster. |
| protectConfig.workloadConfig | object | `{"auditMode":""}` | WorkloadConfig defines which actions are enabled for a cluster's workload configurations. |
| protectConfig.workloadConfig.auditMode | string | `""` | Sets which mode of auditing should be used for the cluster's workloads. Accepted values are DISABLED, BASIC. |
| protectConfig.workloadVulnerabilityMode | string | `""` | Sets which mode to use for Protect workload vulnerability scanning feature. Accepted values are DISABLED, BASIC. |
| releaseChannel | object | `{"channel":""}` | Configuration options for the Release channel feature, which provide more control over automatic upgrades of your GKE clusters. Note that removing this field from your config will not unenroll it. Instead, use the "UNSPECIFIED" channel. |
| releaseChannel.channel | string | `""` | The selected release channel. Accepted values are: * UNSPECIFIED: Not set. * RAPID: Weekly upgrade cadence; Early testers and developers who requires new features. * REGULAR: Multiple per month upgrade cadence; Production users who need features not yet offered in the Stable channel. * STABLE: Every few months upgrade cadence; Production users who need stability above all else, and for whom frequent upgrades are too risky. |
| resourceID | string | `""` | Immutable. Optional. The name of the resource. Used for creation and acquisition. When unset, the value of `metadata.name` is used as the default. |
| resourceUsageExportConfig | object | `{"bigqueryDestination":{"datasetId":""},"enableNetworkEgressMetering":false,"enableResourceConsumptionMetering":true}` | Configuration for the ResourceUsageExportConfig feature. |
| resourceUsageExportConfig.bigqueryDestination | object | `{"datasetId":""}` | Parameters for using BigQuery as the destination of resource usage export. |
| resourceUsageExportConfig.bigqueryDestination.datasetId | string | `""` | The ID of a BigQuery Dataset. |
| resourceUsageExportConfig.enableNetworkEgressMetering | bool | `false` | Whether to enable network egress metering for this cluster. If enabled, a daemonset will be created in the cluster to meter network egress traffic. |
| resourceUsageExportConfig.enableResourceConsumptionMetering | bool | `true` | Whether to enable resource consumption metering on this cluster. When enabled, a table will be created in the resource export BigQuery dataset to store resource consumption data. The resulting table can be joined with the resource usage table or with BigQuery billing export. Defaults to true. |
| securityPostureConfig | object | `{"mode":"","vulnerabilityMode":""}` | Defines the config needed to enable/disable features for the Security Posture API. |
| securityPostureConfig.mode | string | `""` | Sets the mode of the Kubernetes security posture API's off-cluster features. Available options include DISABLED and BASIC. |
| securityPostureConfig.vulnerabilityMode | string | `""` | Sets the mode of the Kubernetes security posture API's workload vulnerability scanning. Available options include VULNERABILITY_DISABLED and VULNERABILITY_BASIC. |
| serviceExternalIpsConfig | object | `{"enabled":false}` | If set, and enabled=true, services with external ips field will not be blocked. |
| serviceExternalIpsConfig.enabled | bool | `false` | When enabled, services with exterenal ips specified will be allowed. |
| subnetworkRef | object | `{"external":"","name":"","namespace":""}` | Reference to a ComputeSubnetwork resource. |
| subnetworkRef.external | string | `""` | Allowed value: The `selfLink` field of a `ComputeSubnetwork` resource. |
| subnetworkRef.name | string | `""` | Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names |
| subnetworkRef.namespace | string | `""` | Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/ |
| verticalPodAutoscaling | object | `{"enabled":false}` | Vertical Pod Autoscaling automatically adjusts the resources of pods controlled by it. |
| verticalPodAutoscaling.enabled | bool | `false` | Enables vertical pod autoscaling. |
| workloadIdentityConfig | object | `{"identityNamespace":"","workloadPool":""}` | Configuration for the use of Kubernetes Service Accounts in GCP IAM policies. |
| workloadIdentityConfig.identityNamespace | string | `""` | DEPRECATED. This field will be removed in a future major release as it has been deprecated in the API. Use `workloadPool` instead; `workloadPool` field will supersede this field. Enables workload identity. |
| workloadIdentityConfig.workloadPool | string | `""` | The workload pool to attach all Kubernetes service accounts to. |

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
    targetRevision: "0.1.0"
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

