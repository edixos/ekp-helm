{{/* Expand the name of the chart. This is suffixed with -alertmanager, which means subtract 13 from longest 63 available */}}
{{- define "prometheus.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 50 | trimSuffix "-" -}}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
The components in this chart create additional resources that expand the longest created name strings.
The longest name that gets created adds and extra 37 characters, so truncation should be 63-35=26.
*/}}
{{- define "prometheus.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 26 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 26 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 26 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

 {{/* Create the name of prometheus service account to use */}}
{{- define "prometheus.serviceAccountName" -}}
{{- if .Values.prometheus.serviceAccount.create -}}
    {{ default (include "prometheus.fullname" .) .Values.prometheus.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.prometheus.serviceAccount.name }}
{{- end -}}
{{- end -}}

 {{/* Create chart name and version as used by the chart label. */}}
{{- define "prometheus.chartref" -}}
{{- replace "+" "_" .Chart.Version | printf "%s-%s" .Chart.Name -}}
{{- end }}

{{/* Generate basic labels */}}
{{- define "prometheus.labels" -}}
chart: {{ template "prometheus.chartref" . }}
release: {{ $.Release.Name | quote }}
{{- if .Values.commonLabels }}
{{ .Values.commonLabels | toYaml }}
{{- end }}
{{- end }}

{{- define "prometheus.version" }}
{{- if .Values.prometheus.image.tag }}
{{- printf "%v" .Values.prometheus.image.tag -}}
{{ else }}
{{- printf "v%v" .Chart.AppVersion -}}
{{ end }}
{{- end }}

{{- define "prometheus.roleKind" }}
{{- if .Values.rbac.scopeNamespaced }}Role{{ else }}ClusterRole{{ end }}
{{- end }}

{{- define "prometheus.roleBindingKind" }}
{{- if .Values.rbac.scopeNamespaced }}RoleBinding{{- else }}ClusterRoleBinding{{- end }}
{{- end }}

{{/* OIDC: target service name */}}
{{- define "prometheus.externalUrl" -}}
{{- if .Values.prometheus.externalUrl -}}
{{- print .Values.prometheus.externalUrl -}}
{{- else if and .Values.ingress.enabled .Values.ingress.host -}}
{{- printf "https://%s%s" .Values.ingress.host .Values.prometheus.routePrefix -}}
{{- else -}}
{{- printf "http://%s-prometheus.%s:%v" ( include "prometheus.fullname" . ) .Release.Namespace .Values.service.port -}}
{{- end -}}
{{- end -}}

{{/* Prometheus target port */}}
{{- define "prometheus.targetPort" -}}
{{- if .Values.oidc.enabled -}}
{{- .Values.oidc.port -}}
{{- else -}}
{{- .Values.service.targetPort -}}
{{- end -}}
{{- end -}}

{{/* OIDC client id */}}
{{- define "prometheus.clientApplicationId" -}}
{{- default ( include "prometheus.fullname" . ) .Values.oidc.applicationId -}}
{{- end -}}

{{/* OIDC redirection url*/}}
{{- define "prometheus.dex.redirectionUrl" -}}
{{- printf "%soauth/callback" ( include "prometheus.externalUrl" . ) -}}
{{- end -}}

{{/* OIDC upstream url*/}}
{{- define "prometheus.oidc.configmap.upstreamUrl" -}}
{{- default ( printf "http://127.0.0.1:%v" .Values.service.targetPort) .Values.oidc.configMap.upstreamUrl -}}
{{- end -}}

{{/* OIDC configmap name */}}
{{- define "prometheus.oidc.configmapName" -}}
{{- if .Values.oidc.configMap.name -}}
{{- print .Values.oidc.configMap.name -}}
{{- else -}}
{{- printf "%s-oidc" ( include "prometheus.fullname" . ) -}}
{{- end -}}
{{- end -}}

{{/* OIDC secret name */}}
{{- define "prometheus.oidc.secretName" -}}
{{- if .Values.oidc.secret.name -}}
{{- .Values.oidc.secret.name -}}
{{- else -}}
{{- printf "%s-oidc" ( include "prometheus.fullname" . ) -}}
{{- end -}}
{{- end -}}

{{/* Prometheus metics enabled for oidc proxy*/}}
{{- define "prometheus.oidc.metricsEnabled" -}}
{{- if and .Values.serviceMonitor.enabled (or .Values.oidc.serviceMonitor (and .Values.oidc.configMap.create .Values.oidc.configMap.enableMetric)) -}}
true
{{- else -}}
false
{{- end -}}
{{- end -}}

{{/* Ingress tls secret name */}}
{{- define "prometheus.ingress.tlsName" -}}
{{- if .Values.ingress.tls.secretName -}}
{{- printf "%s" .Values.ingress.tls.secretName -}}
{{- else -}}
{{- printf "%s-tls" ( include "prometheus.fullname" . ) -}}
{{- end -}}
{{- end -}}

{{/* Ingress annotations */}}
{{- define "prometheus.ingress.annotations" -}}
{{- if .Values.ingress.annotations -}}
{{ toYaml .Values.ingress.annotations }}
{{- end }}
{{- if and .Values.ingress.acme.enabled .Values.ingress.acme.annotations }}
{{- range .Values.ingress.acme.annotations }}
{{ fromYaml . | toYaml }}
{{- end }}
{{- end }}
{{- if .Values.ingress.extraAnnotations }}
{{ toYaml .Values.ingress.extraAnnotations }}
{{- end }}
{{- end -}}

{{/* PrometheusRule name */}}
{{- define "prometheus.rules.name" -}}
{{- printf "%s-rules" ( include "prometheus.fullname" . ) -}}
{{- end -}}

{{/* Prometheus rules labels */}}
{{- define "prometheus.rule.selectorLabels" -}}
{{- if .Values.rules.labels -}}
{{- toYaml .Values.rules.labels -}}
{{- end -}}
{{- printf "prometheus: %s" ( include "prometheus.fullname" . ) -}}
{{- end -}}

{{/* Ingress servicePortName */}}
{{- define "prometheus.ingress.servicePort" -}}
{{- if .Values.oidc.enabled -}}
{{ print .Values.oidc.port }}
{{- else }}
{{ print .Values.service.port }}
{{- end }}
{{- end -}}

{{/* prometheus image */}}
{{- define "prometheus.image" -}}
{{ printf "%s:%s" .Values.prometheus.image.repository ( include "prometheus.version" . ) }}
{{- end -}}
