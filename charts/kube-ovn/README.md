# kube-ovn

![Version: 0.1.1](https://img.shields.io/badge/Version-0.1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.14.0](https://img.shields.io/badge/AppVersion-1.14.0-informational?style=flat-square) 





## Prerequisites

- Helm v3
- Config Connector installed (v1.6.0)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://kubeovn.github.io/kube-ovn/ | kube-ovn(kube-ovn) | 2.0.0 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| hamzatalbi | <hamzatalbi831@gmail.com> | <https://github.com/TalbiHamza> |

## Description

A Helm chart for Kubernetes



## Values

### CNI agent configuration

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| kube-ovn.agent | object | "{}" | Configuration for kube-ovn-cni, the agent responsible for handling CNI requests from the CRI. |
| kube-ovn.agent.annotations | object | `{}` | Annotations to be added to all top-level agent objects (resources under templates/agent) |
| kube-ovn.agent.labels | object | `{}` | Labels to be added to all top-level agent objects (resources under templates/agent) |
| kube-ovn.agent.metrics | object | "{}" | Agent metrics configuration. |
| kube-ovn.agent.metrics.port | int | `10665` | Configure the port on which the agent service will serve metrics. |
| kube-ovn.agent.mirroring | object | "{}" | Mirroring of the traffic for debug or analysis. https://kubeovn.github.io/docs/stable/en/guide/mirror/ |
| kube-ovn.agent.mirroring.enabled | bool | `false` | Enable mirroring of the traffic. |
| kube-ovn.agent.mirroring.interface | string | `"mirror0"` | Interface on which to send the mirrored traffic. |
| kube-ovn.agent.podAnnotations | object | `{}` | Annotations to be added to the agent pods (kube-ovn-cni) |
| kube-ovn.agent.podLabels | object | `{}` | Labels to be added to the agent pods (kube-ovn-cni) |
| kube-ovn.agent.resources | object | `{"limits":{"cpu":"1000m","memory":"1Gi"},"requests":{"cpu":"100m","memory":"100Mi"}}` | Agent daemon resource limits & requests. ref: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/ |

### CNI agent configuration.

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| kube-ovn.agent.dpdkTunnelInterface | string | `"br-phy"` | "" |
| kube-ovn.agent.interface | string | `""` | "" |

### API Network Attachment Definition configuration

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| kube-ovn.apiNad | object | "{}" | API NetworkAttachmentDefinition to give some pods (CoreDNS, NAT GW) in custom VPCs access to the K8S API. This requires Multus to be installed. |
| kube-ovn.apiNad.enabled | bool | `false` | Enable the creation of the API NAD. |
| kube-ovn.apiNad.name | string | `"ovn-kubernetes-api"` | Name of the NAD. |
| kube-ovn.apiNad.provider | string | `"{{ .Values.apiNad.name }}.{{ .Values.namespace }}.ovn"` | Name of the provider, must be in the form "nadName.nadNamespace.ovn". |
| kube-ovn.apiNad.subnet | object | "{}" | Subnet associated with the NAD, it will have full access to the API server. |
| kube-ovn.apiNad.subnet.cidrBlock | string | `"100.100.0.0/16,fd00:100:100::/112"` | CIDR block used by the API subnet. |
| kube-ovn.apiNad.subnet.name | string | `"ovn-kubernetes-api"` | Name of the subnet. |
| kube-ovn.apiNad.subnet.protocol | string | `"Dual"` | Protocol for the API subnet. |

### BGP speaker configuration

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| kube-ovn.bgpSpeaker | object | "{}" | Configuration for kube-ovn-speaker, the BGP speaker announcing routes to the external world. |
| kube-ovn.bgpSpeaker.annotations | object | `{}` | Annotations to be added to all top-level kube-ovn-speaker objects (resources under templates/speaker) |
| kube-ovn.bgpSpeaker.args | list | `[]` | Args passed to the kube-ovn-speaker pod. |
| kube-ovn.bgpSpeaker.enabled | bool | `false` | Enable the kube-ovn-speaker. |
| kube-ovn.bgpSpeaker.labels | object | `{}` | Labels to be added to all top-level kube-ovn-speaker objects (resources under templates/speaker) |
| kube-ovn.bgpSpeaker.nodeSelector | object | `{}` | Node selector to restrict the deployment of the speaker to specific nodes. |
| kube-ovn.bgpSpeaker.podAnnotations | object | `{}` | Annotations to be added to kube-ovn-speaker pods. |
| kube-ovn.bgpSpeaker.podLabels | object | `{}` | Labels to be added to kube-ovn-speaker pods. |
| kube-ovn.bgpSpeaker.resources | object | `{"limits":{},"requests":{"cpu":"500m","memory":"300Mi"}}` | kube-ovn-speaker resource limits & requests. ref: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/ |

### OVN-central daemon configuration

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| kube-ovn.central | object | "{}" | Configuration for ovn-central, the daemon containing the northbound/southbound DBs and northd. |
| kube-ovn.central.annotations | object | `{}` | Annotations to be added to all top-level ovn-central objects (resources under templates/central) |
| kube-ovn.central.labels | object | `{}` | Labels to be added to all top-level ovn-central objects (resources under templates/central) |
| kube-ovn.central.podAnnotations | object | `{}` | Annotations to be added to ovn-central pods. |
| kube-ovn.central.podLabels | object | `{}` | Labels to be added to ovn-central pods. |
| kube-ovn.central.resources | object | `{"limits":{"cpu":"3","memory":"4Gi"},"requests":{"cpu":"300m","memory":"200Mi"}}` | ovn-central resource limits & requests. ref: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/ |

### OVN-central daemon configuration.

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| kube-ovn.central.ovnLeaderProbeInterval | int | `5` | "" |
| kube-ovn.central.ovnNorthdNThreads | int | `1` | "" |
| kube-ovn.central.ovnNorthdProbeInterval | int | `5000` | "" |

### Global parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| kube-ovn.clusterDomain | string | `"cluster.local"` | Domain used by the cluster. |
| kube-ovn.fullnameOverride | string | `""` | Full name override. |
| kube-ovn.global | object | `{"images":{"kubeovn":{"repository":"kube-ovn","support_arm":true,"tag":"v1.14.0","thirdparty":true,"vpcRepository":"vpc-nat-gateway"}},"registry":{"address":"docker.io/kubeovn","imagePullSecrets":[]}}` | Global configuration. |
| kube-ovn.image | object | "{}" | Image configuration. |
| kube-ovn.image.pullPolicy | string | `"IfNotPresent"` | Pull policy for all images. |
| kube-ovn.masterNodes | list | `[]` | Comma-separated list of IPs for each master node. If not specified, fallback to auto-identifying masters based on "masterNodesLabels" |
| kube-ovn.masterNodesLabels | object | `{"kube-ovn/role":"master"}` | Label used to auto-identify masters. Any node that has any of these labels will be considered a master node. Note: This feature uses Helm "lookup" function, which is not compatible with tools such as ArgoCD. |
| kube-ovn.nameOverride | string | `""` | Name override. |
| kube-ovn.namespace | string | `"kube-system"` | Namespace in which the CNI is deployed. |

### CNI configuration

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| kube-ovn.cni | object | "{}" | CNI binary/configuration injected on the nodes. |
| kube-ovn.cni.binaryDirectory | string | `"/opt/cni/bin"` | Location on the node where the agent will inject the Kube-OVN binary. |
| kube-ovn.cni.configDirectory | string | `"/etc/cni/net.d"` | Location of the CNI configuration on the node. |
| kube-ovn.cni.configPriority | string | `"01"` | Priority of Kube-OVN within the CNI configuration directory on the node. Should be a string representing a double-digit integer. |
| kube-ovn.cni.localConfigFile | string | `"/kube-ovn/01-kube-ovn.conflist"` | Location of the CNI configuration inside the agent's pod. |
| kube-ovn.cni.mountToolingDirectory | bool | `false` | Whether to mount the node's tooling directory into the pod. |
| kube-ovn.cni.toolingDirectory | string | `"/usr/local/bin"` | Location on the node where the CNI will install Kube-OVN's tooling. |

### Kube-OVN controller configuration

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| kube-ovn.controller | object | "{}" | Configuration for kube-ovn-controller, the controller responsible for syncing K8s with OVN. |
| kube-ovn.controller.annotations | object | `{}` | Annotations to be added to all top-level kube-ovn-controller objects (resources under templates/controller) |
| kube-ovn.controller.labels | object | `{}` | Labels to be added to all top-level kube-ovn-controller objects (resources under templates/controller) |
| kube-ovn.controller.metrics | object | "{}" | Controller metrics configuration. |
| kube-ovn.controller.metrics.port | int | `10660` | Configure the port on which the controller service will serve metrics. |
| kube-ovn.controller.podAnnotations | object | `{}` | Annotations to be added to kube-ovn-controller pods. |
| kube-ovn.controller.podLabels | object | `{}` | Labels to be added to kube-ovn-controller pods. |
| kube-ovn.controller.resources | object | `{"limits":{"cpu":"1000m","memory":"1Gi"},"requests":{"cpu":"200m","memory":"200Mi"}}` | kube-ovn-controller resource limits & requests. ref: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/ |

### Extra objects

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| kube-ovn.extraObjects | list | `[]` | Array of extra K8s manifests to deploy. Note: Supports use of custom Helm templates (Go templating) |

### Opt-in/out Features

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| kube-ovn.features | object | `{"ENABLE_ANP":false,"ENABLE_BIND_LOCAL_IP":true,"ENABLE_OVN_LB_PREFER_LOCAL":false,"LS_CT_SKIP_DST_LPORT_IPS":true,"LS_DNAT_MOD_DL_DST":true,"OVSDB_CON_TIMEOUT":3,"OVSDB_INACTIVITY_TIMEOUT":10,"SET_VXLAN_TX_OFF":false,"enableExternalVpcs":true,"enableHardwareOffload":false,"enableKeepVmIps":true,"enableLiveMigrationOptimization":true,"enableLoadbalancer":true,"enableLoadbalancerService":false,"enableNatGateways":true,"enableNetworkPolicies":true,"enableOvnInterconnections":false,"enableOvnIpsec":false,"enableSecureServing":false,"enableTproxy":false,"enableU2OInterconnections":false}` | Features of Kube-OVN we wish to enable/disable. |
| kube-ovn.features.enableExternalVpcs | bool | `true` | Enable external VPCs |
| kube-ovn.features.enableHardwareOffload | bool | `false` | Enable hardware offloads |
| kube-ovn.features.enableKeepVmIps | bool | `true` | Enable persistent VM IPs |
| kube-ovn.features.enableLiveMigrationOptimization | bool | `true` | Enable optimized live migrations for VMs |
| kube-ovn.features.enableLoadbalancer | bool | `true` | Enable Kube-OVN loadbalancers |
| kube-ovn.features.enableLoadbalancerService | bool | `false` | Enable Kube-OVN loadbalancer services |
| kube-ovn.features.enableNatGateways | bool | `true` | Enable NAT gateways |
| kube-ovn.features.enableNetworkPolicies | bool | `true` | Enable Kube-OVN network policies |
| kube-ovn.features.enableOvnInterconnections | bool | `false` | Enable OVN interconnections |
| kube-ovn.features.enableOvnIpsec | bool | `false` | Enable IPSEC |
| kube-ovn.features.enableSecureServing | bool | `false` | Enable secure serving |
| kube-ovn.features.enableTproxy | bool | `false` | Enable TProxy |
| kube-ovn.features.enableU2OInterconnections | bool | `false` | Enable underlay to overlay interconnections |

### Kubelet configuration

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| kube-ovn.kubelet | object | "{}" | Kubelet configuration. |
| kube-ovn.kubelet.directory | string | `"/var/lib/kubelet"` | Directory in which the kubelet operates. |
| kube-ovn.logging.directory | string | `"/var/log"` | Directory in which to write the logs. |

### Logging configuration

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| kube-ovn.logging | object | "{}" | Logging configuration for all the daemons. |

### OVN monitoring daemon configuration

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| kube-ovn.monitor | object | "{}" | Configuration for kube-ovn-monitor, the agent monitoring and returning metrics for the northbound/southbound DBs and northd. |
| kube-ovn.monitor.annotations | object | `{}` | Annotations to be added to all top-level kube-ovn-monitor objects (resources under templates/monitor) |
| kube-ovn.monitor.labels | object | `{}` | Labels to be added to all top-level kube-ovn-monitor objects (resources under templates/monitor) |
| kube-ovn.monitor.metrics | object | "{}" | kube-ovn-monitor metrics configuration. |
| kube-ovn.monitor.metrics.port | int | `10661` | Configure the port on which the kube-ovn-monitor service will serve metrics. |
| kube-ovn.monitor.podAnnotations | object | `{}` | Annotations to be added to kube-ovn-monitor pods. |
| kube-ovn.monitor.podLabels | object | `{}` | Labels to be added to kube-ovn-monitor pods. |
| kube-ovn.monitor.resources | object | `{"limits":{"cpu":"200m","memory":"200Mi"},"requests":{"cpu":"200m","memory":"200Mi"}}` | kube-ovn-monitor resource limits & requests. ref: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/ |

### NAT gateways configuration

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| kube-ovn.natGw | object | "{}" | Configuration for the NAT gateways. |
| kube-ovn.natGw.bgpSpeaker | object | "{}" | Configuration of the BGP sidecar for when a NAT gateway is running in BGP mode. |
| kube-ovn.natGw.bgpSpeaker.apiNadProvider | string | `"{{ .Values.apiNad.name }}.{{ .Values.namespace }}.ovn"` | Network attachment definition used to reach the API server when running on BGP mode. By default, equals the value set at ".apiNad.provider", you will need to set ".apiNad.enabled" to true. See https://kubeovn.github.io/docs/stable/en/advance/with-bgp/ |
| kube-ovn.natGw.bgpSpeaker.image | object | "{}" | Image used by the NAT gateway sidecar. |
| kube-ovn.natGw.bgpSpeaker.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy. |
| kube-ovn.natGw.bgpSpeaker.image.repository | string | `"docker.io/kubeovn/kube-ovn"` | Image repository. |
| kube-ovn.natGw.bgpSpeaker.image.tag | string | `"v1.14.0"` | Image tag. |
| kube-ovn.natGw.namePrefix | string | `"vpc-nat-gw"` | Prefix appended to the name of the NAT gateways when generating the Pods. If this value is changed after NAT GWs have been provisioned, every NAT gateway will need to be manually destroyed and recreated. |

### Network parameters of the CNI

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| kube-ovn.networking | object | "{}" | General configuration of the network created by Kube-OVN. |
| kube-ovn.networking.defaultVpcName | string | `"ovn-cluster"` | Name of the default VPC once it is generated in the cluster. Pods in the default subnet live in this VPC. |
| kube-ovn.networking.enableCompact | bool | `false` | "" |
| kube-ovn.networking.enableEcmp | bool | `false` | "" |
| kube-ovn.networking.enableEipSnat | bool | `true` | Enable EIP and SNAT. |
| kube-ovn.networking.enableMetrics | bool | `true` | Enable listening on the metrics endpoint for the CNI daemons. |
| kube-ovn.networking.enableSsl | bool | `false` | Deploy the CNI with SSL encryption in between components. |
| kube-ovn.networking.exchangeLinkName | bool | `false` | "" |
| kube-ovn.networking.excludeIps | string | `""` | IPs to exclude from IPAM in the default subnet. |
| kube-ovn.networking.join | object | "{}" | Configuration of the "join" subnet, used by the nodes to contact (join) the pods in the default subnet. If .networking.stack is set to IPv4, only the .v4 key is used. If .networking.stack is set to IPv6, only the .v6 key is used. If .networking.stack is set to Dual, both keys are used. |
| kube-ovn.networking.join.cidr | object | "{}" | CIDR used by the join subnet. |
| kube-ovn.networking.join.cidr.v4 | string | `"100.64.0.0/16"` | IPv4 CIDR. |
| kube-ovn.networking.join.cidr.v6 | string | `"fd00:100:64::/112"` | IPv6 CIDR. |
| kube-ovn.networking.join.subnetName | string | `"join"` | Name of the join subnet once it gets generated in the cluster. |
| kube-ovn.networking.networkType | string | `"geneve"` | Network type can be "geneve" or "vlan". |
| kube-ovn.networking.nodeLocalDnsIp | string | `""` | Comma-separated string of NodeLocal DNS IP addresses. |
| kube-ovn.networking.podNicType | string | `"veth-pair"` | NIC type used on pods to connect them to the CNI. |
| kube-ovn.networking.pods | object | "{}" | Configuration for the default pod subnet. If .networking.stack is set to IPv4, only the .v4 key is used. If .networking.stack is set to IPv6, only the .v6 key is used. If .networking.stack is set to Dual, both keys are used. |
| kube-ovn.networking.pods.cidr | object | "{}" | CIDR used by the pods subnet. |
| kube-ovn.networking.pods.cidr.v4 | string | `"10.16.0.0/16"` | IPv4 CIDR. |
| kube-ovn.networking.pods.cidr.v6 | string | `"fd00:10:16::/112"` | IPv6 CIDR. |
| kube-ovn.networking.pods.enableGatewayChecks | bool | `true` | Enable default gateway checks |
| kube-ovn.networking.pods.enableLogicalGateways | bool | `false` | Enable logical gateways |
| kube-ovn.networking.pods.gateways | object | "{}" | Gateways used in the pod subnet. |
| kube-ovn.networking.pods.gateways.v4 | string | `"10.16.0.1"` | IPv4 gateway. |
| kube-ovn.networking.pods.gateways.v6 | string | `"fd00:10:16::1"` | IPv6 gateway. |
| kube-ovn.networking.pods.subnetName | string | `"ovn-default"` | Name of the pod subnet once it gets generated in the cluster. |
| kube-ovn.networking.services | object | "{}" | Configuration for the service subnet. If .networking.stack is set to IPv4, only the .v4 key is used. If .networking.stack is set to IPv6, only the .v6 key is used. If .networking.stack is set to Dual, both keys are used. |
| kube-ovn.networking.services.cidr | object | "{}" | CIDR used by the service subnet. |
| kube-ovn.networking.services.cidr.v4 | string | `"10.96.0.0/12"` | IPv4 CIDR. |
| kube-ovn.networking.services.cidr.v6 | string | `"fd00:10:96::/112"` | IPv6 CIDR. |
| kube-ovn.networking.stack | string | `"IPv4"` | Protocol(s) used by Kube-OVN to allocate IPs to pods and services. Can be either IPv4, IPv6 or Dual. |
| kube-ovn.networking.tunnelType | string | `"geneve"` | Tunnel type can be "geneve", "vxlan" or "stt". |
| kube-ovn.networking.vlan | object | `{"id":"100","interfaceName":"","name":"ovn-vlan","providerName":"provider"}` | Configuration if we're running on top of a VLAN. |

### OVS/OVN daemons configuration

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| kube-ovn.ovsOvn | object | "{}" | Configuration for ovs-ovn, the Open vSwitch/Open Virtual Network daemons. |
| kube-ovn.ovsOvn.annotations | object | `{}` | Annotations to be added to all top-level ovs-ovn objects (resources under templates/ovs-ovn) |
| kube-ovn.ovsOvn.disableModulesManagement | bool | `false` | Disable auto-loading of kernel modules by OVS. If this is disabled, you will have to enable the Open vSwitch kernel module yourself. |
| kube-ovn.ovsOvn.dpdkHybrid | object | "{}" | DPDK-hybrid support for OVS. ref: https://kubeovn.github.io/docs/v1.12.x/en/advance/dpdk/ |
| kube-ovn.ovsOvn.dpdkHybrid.enabled | bool | `false` | Enables DPDK-hybrid support on OVS. |
| kube-ovn.ovsOvn.dpdkHybrid.resources | object | `{"limits":{"cpu":"2","hugepages-2Mi":"1Gi","memory":"1000Mi"},"requests":{"cpu":"200m","memory":"200Mi"}}` | ovs-ovn resource limits & requests when DPDK-hybrid is enabled. ref: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/ |
| kube-ovn.ovsOvn.dpdkHybrid.tag | string | `"v1.14.0-dpdk"` | DPDK image tag. |
| kube-ovn.ovsOvn.labels | object | `{}` | Labels to be added to all top-level ovs-ovn objects (resources under templates/ovs-ovn) |
| kube-ovn.ovsOvn.ovnDirectory | string | `"/etc/origin/ovn"` | Directory on the node where Open Virtual Network (OVN) lives. |
| kube-ovn.ovsOvn.ovsDirectory | string | `"/etc/origin/openvswitch"` | Directory on the node where Open vSwitch (OVS) lives. |
| kube-ovn.ovsOvn.podAnnotations | object | `{}` | Annotations to be added to ovs-ovn pods. |
| kube-ovn.ovsOvn.podLabels | object | `{}` | Labels to be added to ovs-ovn pods. |
| kube-ovn.ovsOvn.resources | object | `{"limits":{"cpu":"2","memory":"1000Mi"},"requests":{"cpu":"200m","memory":"200Mi"}}` | ovs-ovn resource limits & requests. ref: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/ |

### Performance configuration

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| kube-ovn.performance | object | "{}" | Performance tuning parameters. |
| kube-ovn.performance.gcInterval | int | `360` | "" |
| kube-ovn.performance.inspectInterval | int | `20` | "" |
| kube-ovn.performance.ovsVsctlConcurrency | int | `100` | "" |

### Ping daemon configuration

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| kube-ovn.pinger | object | "{}" | Configuration for kube-ovn-pinger, the agent monitoring and returning metrics for OVS/external connectivity. |
| kube-ovn.pinger.annotations | object | `{}` | Annotations to be added to all top-level kube-ovn-pinger objects (resources under templates/pinger) |
| kube-ovn.pinger.labels | object | `{}` | Labels to be added to all top-level kube-ovn-pinger objects (resources under templates/pinger) |
| kube-ovn.pinger.metrics | object | "{}" | kube-ovn-pinger metrics configuration. |
| kube-ovn.pinger.metrics.port | int | `8080` | Configure the port on which the kube-ovn-monitor service will serve metrics. |
| kube-ovn.pinger.podAnnotations | object | `{}` | Annotations to be added to kube-ovn-pinger pods. |
| kube-ovn.pinger.podLabels | object | `{}` | Labels to be added to kube-ovn-pinger pods. |
| kube-ovn.pinger.resources | object | `{"limits":{"cpu":"200m","memory":"400Mi"},"requests":{"cpu":"100m","memory":"100Mi"}}` | kube-ovn-pinger resource limits & requests. ref: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/ |
| kube-ovn.pinger.targets | object | "{}" | Remote targets used by the pinger daemon to determine if the CNI works and has external connectivity. |
| kube-ovn.pinger.targets.externalAddresses | object | "{}" | Raw IPv4/6 on which to issue pings. |
| kube-ovn.pinger.targets.externalAddresses.v4 | string | `"1.1.1.1"` | IPv4 address. |
| kube-ovn.pinger.targets.externalAddresses.v6 | string | `"2606:4700:4700::1111"` | IPv6 address. |
| kube-ovn.pinger.targets.externalDomain | object | "{}" | Domains to resolve and to ping. Make sure the v6 domain resolves both A and AAAA records, while the v4 only resolves A records. |
| kube-ovn.pinger.targets.externalDomain.v4 | string | `"kube-ovn.io."` | Domain name resolving to an IPv4 only (A record) |
| kube-ovn.pinger.targets.externalDomain.v6 | string | `"google.com."` | Domain name resolving to an IPv6 and IPv4 only (A/AAAA record) |

### Validating webhook configuration

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| kube-ovn.validatingWebhook | object | "{}" | Configuration of the validating webhook used to verify custom resources before they are pushed to Kubernetes. Make sure cert-manager is installed for the generation of certificates for the webhook. See https://kubeovn.github.io/docs/stable/en/guide/webhook/ |
| kube-ovn.validatingWebhook.annotations | object | `{}` | Annotations to be added to all top-level kube-ovn-webhook objects (resources under templates/webhook) |
| kube-ovn.validatingWebhook.enabled | bool | `false` | Enable the deployment of the validating webhook. |
| kube-ovn.validatingWebhook.labels | object | `{}` | Labels to be added to all top-level kube-ovn-webhook objects (resources under templates/webhook) |
| kube-ovn.validatingWebhook.podAnnotations | object | `{}` | Annotations to be added to kube-ovn-webhook pods. |
| kube-ovn.validatingWebhook.podLabels | object | `{}` | Labels to be added to kube-ovn-webhook pods. |

### Other Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| prometheus.enabled | bool | `false` | Enables Prometheus Operator monitoring |
| prometheus.grafanaDashboard.enabled | bool | `true` | Add grafana dashboard as a configmap |
| prometheus.grafanaDashboard.label | object | `{"grafana_dashboard":"1"}` | label to apply to the config map. Used by Grafana sidecar to automatically install the dashboard |
| prometheus.rules.enabled | bool | `true` | Enables prometheus operator rules |
| prometheus.rules.labels | object | `{"prometheus":"prometheus-operator-prometheus"}` | Labels to affect to the Prometheus Rules |

## Installing the Chart

### With Helm

To install the chart with the release name `my-release`:

```bash
helm repo add ekp-helm https://edixos.github.io/ekp-helm
helm install ekp-helm/kube-ovn
```

### With ArgoCD

Add new application as:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: kube-ovn
spec:
  project: infra

  source:
    repoURL: "https://edixos.github.io/ekp-helm"
    targetRevision: "0.1.1"
    chart: kube-ovn
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
docker run --rm -it -w /charts -v $(pwd)/../../:/charts quay.io/helmpack/chart-testing:v3.12.0 ct lint --charts /charts/charts/kube-ovn --config /charts/charts/kube-ovn/ct.yaml
```

### Run pluto

In order to check if the api-version used in this chart are not deprecated, or worse, removed, we use pluto to check it:

```
docker run --rm -it -v $(pwd):/apps -v pluto:/pluto alpine/helm:3.17 template kube-ovn . -f tests/pluto/values.yaml --output-dir /pluto
docker run --rm -it -v pluto:/data us-docker.pkg.dev/fairwinds-ops/oss/pluto:v5 detect-files -d /data -o yaml --ignore-deprecations -t "k8s=v1.31.0,cert-manager=v1.17.0,istio=v1.24.0" -o wide
docker volume rm pluto
```

