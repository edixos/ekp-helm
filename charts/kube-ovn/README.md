# kube-ovn

![Version: 0.1.1](https://img.shields.io/badge/Version-0.1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.15.4](https://img.shields.io/badge/AppVersion-1.15.4-informational?style=flat-square)

## Prerequisites

- Helm v3
- Config Connector installed (v1.6.0)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://kubeovn.github.io/kube-ovn/ | kube-ovn(kube-ovn) | v1.15.4 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| hamzatalbi | <hamzatalbi831@gmail.com> | <https://github.com/TalbiHamza> |

## Description

A Helm chart for Kubernetes

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| kube-ovn.DISABLE_MODULES_MANAGEMENT | bool | `false` |  |
| kube-ovn.DPDK_CPU | string | `"1000m"` |  |
| kube-ovn.DPDK_IMAGE_TAG | string | `"v1.15.0-dpdk"` |  |
| kube-ovn.DPDK_MEMORY | string | `"2Gi"` |  |
| kube-ovn.HUGEPAGES | string | `"1Gi"` |  |
| kube-ovn.HUGEPAGE_SIZE_TYPE | string | `"hugepages-2Mi"` |  |
| kube-ovn.HYBRID_DPDK | bool | `false` |  |
| kube-ovn.MASTER_NODES | string | `""` |  |
| kube-ovn.MASTER_NODES_LABEL | string | `"kube-ovn/role=master"` |  |
| kube-ovn.OPENVSWITCH_DIR | string | `"/etc/origin/openvswitch"` |  |
| kube-ovn.OVN_DIR | string | `"/etc/origin/ovn"` |  |
| kube-ovn.OVN_IPSEC_KEY_DIR | string | `"/etc/origin/ovs_ipsec_keys"` |  |
| kube-ovn.cni_conf.CNI_BIN_DIR | string | `"/opt/cni/bin"` |  |
| kube-ovn.cni_conf.CNI_CONFIG_PRIORITY | string | `"01"` |  |
| kube-ovn.cni_conf.CNI_CONF_DIR | string | `"/etc/cni/net.d"` |  |
| kube-ovn.cni_conf.CNI_CONF_FILE | string | `"/kube-ovn/01-kube-ovn.conflist"` |  |
| kube-ovn.cni_conf.LOCAL_BIN_DIR | string | `"/usr/local/bin"` |  |
| kube-ovn.cni_conf.MOUNT_CNI_CONF_DIR | string | `"/etc/cni/net.d"` |  |
| kube-ovn.cni_conf.MOUNT_LOCAL_BIN_DIR | bool | `false` |  |
| kube-ovn.cni_conf.NON_PRIMARY_CNI | bool | `false` |  |
| kube-ovn.debug.ENABLE_MIRROR | bool | `false` |  |
| kube-ovn.debug.MIRROR_IFACE | string | `"mirror0"` |  |
| kube-ovn.dual_stack.JOIN_CIDR | string | `"100.64.0.0/16,fd00:100:64::/112"` |  |
| kube-ovn.dual_stack.PINGER_EXTERNAL_ADDRESS | string | `"1.1.1.1,2606:4700:4700::1111"` |  |
| kube-ovn.dual_stack.PINGER_EXTERNAL_DOMAIN | string | `"google.com."` |  |
| kube-ovn.dual_stack.POD_CIDR | string | `"10.16.0.0/16,fd00:10:16::/112"` |  |
| kube-ovn.dual_stack.POD_GATEWAY | string | `"10.16.0.1,fd00:10:16::1"` |  |
| kube-ovn.dual_stack.SVC_CIDR | string | `"10.96.0.0/12,fd00:10:96::/112"` |  |
| kube-ovn.fullnameOverride | string | `""` |  |
| kube-ovn.func.CHECK_GATEWAY | bool | `true` |  |
| kube-ovn.func.ENABLE_ANP | bool | `false` |  |
| kube-ovn.func.ENABLE_BIND_LOCAL_IP | bool | `true` |  |
| kube-ovn.func.ENABLE_DNS_NAME_RESOLVER | bool | `false` |  |
| kube-ovn.func.ENABLE_EXTERNAL_VPC | bool | `false` |  |
| kube-ovn.func.ENABLE_IC | bool | `false` |  |
| kube-ovn.func.ENABLE_KEEP_VM_IP | bool | `true` |  |
| kube-ovn.func.ENABLE_LB | bool | `true` |  |
| kube-ovn.func.ENABLE_LB_SVC | bool | `false` |  |
| kube-ovn.func.ENABLE_LIVE_MIGRATION_OPTIMIZE | bool | `true` |  |
| kube-ovn.func.ENABLE_NAT_GW | bool | `true` |  |
| kube-ovn.func.ENABLE_NP | bool | `true` |  |
| kube-ovn.func.ENABLE_OVN_IPSEC | bool | `false` |  |
| kube-ovn.func.ENABLE_OVN_LB_PREFER_LOCAL | bool | `false` |  |
| kube-ovn.func.ENABLE_TPROXY | bool | `false` |  |
| kube-ovn.func.HW_OFFLOAD | bool | `false` |  |
| kube-ovn.func.LOGICAL_GATEWAY | bool | `false` |  |
| kube-ovn.func.LS_CT_SKIP_DST_LPORT_IPS | bool | `true` |  |
| kube-ovn.func.LS_DNAT_MOD_DL_DST | bool | `true` |  |
| kube-ovn.func.NP_ENFORCEMENT | string | `"standard"` |  |
| kube-ovn.func.OVSDB_CON_TIMEOUT | int | `3` |  |
| kube-ovn.func.OVSDB_INACTIVITY_TIMEOUT | int | `10` |  |
| kube-ovn.func.SECURE_SERVING | bool | `false` |  |
| kube-ovn.func.SET_VXLAN_TX_OFF | bool | `false` |  |
| kube-ovn.func.U2O_INTERCONNECTION | bool | `false` |  |
| kube-ovn.global.images.kubeovn.repository | string | `"kube-ovn"` |  |
| kube-ovn.global.images.kubeovn.tag | string | `"v1.15.4"` |  |
| kube-ovn.global.images.natgateway.repository | string | `"vpc-nat-gateway"` |  |
| kube-ovn.global.images.natgateway.tag | string | `"v1.15.4"` |  |
| kube-ovn.global.registry.address | string | `"docker.io/kubeovn"` |  |
| kube-ovn.global.registry.imagePullSecrets | list | `[]` |  |
| kube-ovn.image.pullPolicy | string | `"IfNotPresent"` |  |
| kube-ovn.ipv4.JOIN_CIDR | string | `"100.64.0.0/16"` |  |
| kube-ovn.ipv4.PINGER_EXTERNAL_ADDRESS | string | `"1.1.1.1"` |  |
| kube-ovn.ipv4.PINGER_EXTERNAL_DOMAIN | string | `"kube-ovn.io."` |  |
| kube-ovn.ipv4.POD_CIDR | string | `"10.16.0.0/16"` |  |
| kube-ovn.ipv4.POD_GATEWAY | string | `"10.16.0.1"` |  |
| kube-ovn.ipv4.SVC_CIDR | string | `"10.96.0.0/12"` |  |
| kube-ovn.ipv6.JOIN_CIDR | string | `"fd00:100:64::/112"` |  |
| kube-ovn.ipv6.PINGER_EXTERNAL_ADDRESS | string | `"2606:4700:4700::1111"` |  |
| kube-ovn.ipv6.PINGER_EXTERNAL_DOMAIN | string | `"google.com."` |  |
| kube-ovn.ipv6.POD_CIDR | string | `"fd00:10:16::/112"` |  |
| kube-ovn.ipv6.POD_GATEWAY | string | `"fd00:10:16::1"` |  |
| kube-ovn.ipv6.SVC_CIDR | string | `"fd00:10:96::/112"` |  |
| kube-ovn.kube-ovn-cni.limits.cpu | string | `"1000m"` |  |
| kube-ovn.kube-ovn-cni.limits.ephemeral-storage | string | `"1Gi"` |  |
| kube-ovn.kube-ovn-cni.limits.memory | string | `"1Gi"` |  |
| kube-ovn.kube-ovn-cni.requests.cpu | string | `"100m"` |  |
| kube-ovn.kube-ovn-cni.requests.memory | string | `"100Mi"` |  |
| kube-ovn.kube-ovn-controller.limits.cpu | string | `"1000m"` |  |
| kube-ovn.kube-ovn-controller.limits.ephemeral-storage | string | `"1Gi"` |  |
| kube-ovn.kube-ovn-controller.limits.memory | string | `"1Gi"` |  |
| kube-ovn.kube-ovn-controller.requests.cpu | string | `"200m"` |  |
| kube-ovn.kube-ovn-controller.requests.memory | string | `"200Mi"` |  |
| kube-ovn.kube-ovn-monitor.limits.cpu | string | `"200m"` |  |
| kube-ovn.kube-ovn-monitor.limits.ephemeral-storage | string | `"1Gi"` |  |
| kube-ovn.kube-ovn-monitor.limits.memory | string | `"200Mi"` |  |
| kube-ovn.kube-ovn-monitor.requests.cpu | string | `"200m"` |  |
| kube-ovn.kube-ovn-monitor.requests.memory | string | `"200Mi"` |  |
| kube-ovn.kube-ovn-pinger.limits.cpu | string | `"200m"` |  |
| kube-ovn.kube-ovn-pinger.limits.ephemeral-storage | string | `"1Gi"` |  |
| kube-ovn.kube-ovn-pinger.limits.memory | string | `"400Mi"` |  |
| kube-ovn.kube-ovn-pinger.requests.cpu | string | `"100m"` |  |
| kube-ovn.kube-ovn-pinger.requests.memory | string | `"100Mi"` |  |
| kube-ovn.kubelet_conf.KUBELET_DIR | string | `"/var/lib/kubelet"` |  |
| kube-ovn.log_conf.LOG_DIR | string | `"/var/log"` |  |
| kube-ovn.nameOverride | string | `""` |  |
| kube-ovn.namespace | string | `"kube-system"` |  |
| kube-ovn.networking.DEFAULT_SUBNET | string | `"ovn-default"` |  |
| kube-ovn.networking.DEFAULT_VPC | string | `"ovn-cluster"` |  |
| kube-ovn.networking.DPDK_TUNNEL_IFACE | string | `"br-phy"` |  |
| kube-ovn.networking.ENABLE_COMPACT | bool | `false` |  |
| kube-ovn.networking.ENABLE_ECMP | bool | `false` |  |
| kube-ovn.networking.ENABLE_EIP_SNAT | bool | `true` |  |
| kube-ovn.networking.ENABLE_METRICS | bool | `true` |  |
| kube-ovn.networking.ENABLE_SSL | bool | `false` |  |
| kube-ovn.networking.EXCHANGE_LINK_NAME | bool | `false` |  |
| kube-ovn.networking.EXCLUDE_IPS | string | `""` |  |
| kube-ovn.networking.IFACE | string | `""` |  |
| kube-ovn.networking.NETWORK_TYPE | string | `"geneve"` |  |
| kube-ovn.networking.NET_STACK | string | `"ipv4"` |  |
| kube-ovn.networking.NODE_LOCAL_DNS_IP | string | `""` |  |
| kube-ovn.networking.NODE_SUBNET | string | `"join"` |  |
| kube-ovn.networking.OVN_LEADER_PROBE_INTERVAL | int | `5` |  |
| kube-ovn.networking.OVN_NORTHD_N_THREADS | int | `1` |  |
| kube-ovn.networking.OVN_NORTHD_PROBE_INTERVAL | int | `5000` |  |
| kube-ovn.networking.OVN_REMOTE_OPENFLOW_INTERVAL | int | `180` |  |
| kube-ovn.networking.OVN_REMOTE_PROBE_INTERVAL | int | `10000` |  |
| kube-ovn.networking.POD_NIC_TYPE | string | `"veth-pair"` |  |
| kube-ovn.networking.PROBE_INTERVAL | int | `180000` |  |
| kube-ovn.networking.SKIP_CONNTRACK_DST_CIDRS | string | `""` |  |
| kube-ovn.networking.TUNNEL_TYPE | string | `"geneve"` |  |
| kube-ovn.networking.vlan.PROVIDER_NAME | string | `"provider"` |  |
| kube-ovn.networking.vlan.VLAN_ID | string | `"100"` |  |
| kube-ovn.networking.vlan.VLAN_INTERFACE_NAME | string | `""` |  |
| kube-ovn.networking.vlan.VLAN_NAME | string | `"ovn-vlan"` |  |
| kube-ovn.ovn-central.limits.cpu | string | `"3"` |  |
| kube-ovn.ovn-central.limits.ephemeral-storage | string | `"1Gi"` |  |
| kube-ovn.ovn-central.limits.memory | string | `"4Gi"` |  |
| kube-ovn.ovn-central.requests.cpu | string | `"300m"` |  |
| kube-ovn.ovn-central.requests.memory | string | `"200Mi"` |  |
| kube-ovn.ovs-ovn.limits.cpu | string | `"2"` |  |
| kube-ovn.ovs-ovn.limits.ephemeral-storage | string | `"1Gi"` |  |
| kube-ovn.ovs-ovn.limits.memory | string | `"1000Mi"` |  |
| kube-ovn.ovs-ovn.requests.cpu | string | `"200m"` |  |
| kube-ovn.ovs-ovn.requests.memory | string | `"200Mi"` |  |
| kube-ovn.performance.GC_INTERVAL | int | `360` |  |
| kube-ovn.performance.INSPECT_INTERVAL | int | `20` |  |
| kube-ovn.performance.OVS_VSCTL_CONCURRENCY | int | `100` |  |
| prometheus.enabled | bool | `false` | Enables Prometheus Operator monitoring |
| prometheus.grafanaDashboard.enabled | bool | `false` | Add grafana dashboard as a configmap |
| prometheus.grafanaDashboard.label | object | `{"grafana_dashboard":"1"}` | label to apply to the config map. Used by Grafana sidecar to automatically install the dashboard |
| prometheus.rules.enabled | bool | `false` | Enables prometheus operator rules |
| prometheus.rules.labels | object | `{"prometheus":"prometheus-operator-prometheus"}` | Labels to affect to the Prometheus Rules |
| prometheus.serviceMonitor.annotations | object | `{}` | Map of annotations to apply to the ServiceMonitor |
| prometheus.serviceMonitor.bearerTokenFile | string | `"/var/run/secrets/kubernetes.io/serviceaccount/token"` | Path to bearer token file for authentication |
| prometheus.serviceMonitor.enabled | bool | `false` | Enables prometheus operator service monitor |
| prometheus.serviceMonitor.interval | string | `"15s"` | Scrape interval. If not set, defaults to 15s |
| prometheus.serviceMonitor.labels | object | `{"prometheus":"prometheus-operator-prometheus"}` | Map of labels to apply to the servicemonitor |
| prometheus.serviceMonitor.metricRelabelings | list | `[]` | metric relabel configs to apply to samples before ingestion. |
| prometheus.serviceMonitor.namespace | string | `"monitoring"` | Namespace where the ServiceMonitor will be created (default: monitoring) |
| prometheus.serviceMonitor.relabelings | list | `[]` | Relabel configs to apply to samples before ingestion. |
| prometheus.serviceMonitor.scheme | string | `""` | HTTP scheme to use for scraping. Can be used with `tlsConfig` for example if using istio mTLS. |
| prometheus.serviceMonitor.scrapeTimeout | string | `""` | Scrape timeout. If not set, Prometheus uses its default |
| prometheus.serviceMonitor.selectorLabels | object | `{}` | Override selector labels for the ServiceMonitor (default: app: kube-ovn-controller) |
| prometheus.serviceMonitor.targetNamespace | string | `"kube-system"` | Target namespace to monitor (where kube-ovn is installed, default: kube-system) |
| prometheus.serviceMonitor.tlsConfig | object | `{}` | TLS configuration to use when scraping the endpoint. For example if using istio mTLS. Of type: https://github.com/prometheus-operator/prometheus-operator/blob/master/Documentation/api.md#tlsconfig |

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

