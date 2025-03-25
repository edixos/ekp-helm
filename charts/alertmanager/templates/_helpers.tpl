{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "alertmanager.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "alertmanager.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "alertmanager.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "alertmanager.labels" -}}
{{- if .Values.istio.enabled -}}
version: {{ .Chart.AppVersion | quote | trim }}
{{- end -}}
app: {{ printf "%s-alertmanager" (include "alertmanager.name" . ) }}
app.kubernetes.io/name: {{ printf "%s-alertmanager" (include "alertmanager.name" . ) }}
clusterName: {{ include "alertmanager.clustername" . }}
helm.sh/chart: {{ include "alertmanager.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Values.commonLabels}}
{{ toYaml .Values.commonLabels }}
{{- end }}
{{- end -}}


{{/* Alertmanager name */}}
{{- define "alertmanager.clustername" -}}
{{- default (include "alertmanager.fullname" . ) .Values.clusterName -}}
{{- end -}}


{{/* Alertmanager image tag */}}
{{- define "alertmanager.image.tag" -}}
{{- if .Values.image.tag -}}
{{- .Values.image.tag -}}
{{- else -}}
{{- .Chart.AppVersion -}}
{{- end -}}
{{- end -}}

{{- define "call-nested" }}
{{- $dot := index . 0 }}
{{- $subchart := index . 1 | splitList "." }}
{{- $template := index . 2 }}
{{- $values := $dot.Values }}
{{- range $subchart }}
{{- $values = index $values . }}
{{- end }}
{{- include $template (dict "Chart" (dict "Name" (last $subchart)) "Values" $values "Release" $dot.Release "Capabilities" $dot.Capabilities) }}
{{- end }}

{{/* Create the name of alertmanager service account to use */}}
{{- define "alertmanager.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{ default (include "alertmanager.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
{{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}


{{/* OIDC: target service name */}}
{{- define "alertmanager.externalUrl" -}}
{{- if .Values.externalUrl -}}
{{- print .Values.externalUrl -}}
{{- else if and .Values.ingress.enabled .Values.ingress.host -}}
{{- printf "https://%s%s" .Values.ingress.host .Values.routePrefix -}}
{{- else -}}
{{- printf "http://%s-alertmanager.%s:%s" ( include "alertmanager.fullname" . ) .Release.Namespace (.Values.service.port | toString) -}}
{{- end -}}
{{- end -}}

{{/* OIDC client id */}}
{{- define "alertmanager.clientApplicationId" -}}
{{- default ( include "alertmanager.fullname" . ) .Values.oidc.applicationId -}}
{{- end -}}

{{/* OIDC redirection url*/}}
{{- define "alertmanager.dex.redirectionUrl" -}}
{{- printf "%soauth2/callback" ( include "alertmanager.externalUrl" . ) -}}
{{- end -}}

{{/* OIDC upstream url*/}}
{{- define "alertmanager.oidc.configMap.upstreamUrl" -}}
{{- if .Values.authorizations.enabled -}}
{{- printf "http://127.0.0.1:%v" .Values.authorizations.envoy.port }}
{{- else -}}
{{- default ( printf "http://127.0.0.1:%v" .Values.service.targetPort) .Values.oidc.configMap.upstreamUrl -}}
{{- end -}}
{{- end -}}

{{/* OIDC configmap name */}}
{{- define "alertmanager.oidc.configmapName" -}}
{{- if .Values.oidc.configMap.name -}}
{{- print .Values.oidc.configMap.name -}}
{{- else -}}
{{- printf "%s-oidc" ( include "alertmanager.fullname" . ) -}}
{{- end -}}
{{- end -}}

{{/* OIDC secret name */}}
{{- define "alertmanager.oidc.secretName" -}}
{{- if .Values.oidc.secret.name -}}
{{- print .Values.oidc.secret.name -}}
{{- else -}}
{{- printf "%s-oidc" ( include "alertmanager.fullname" . ) -}}
{{- end -}}
{{- end -}}

{{/* OIDC htpasswd file */}}
{{- define "alertmanager.oidc.htpasswdfile" -}}
{{- printf "/etc/karma/%s" .Values.karma.htpasswd.secretKey -}}
{{- end -}}

{{/* Envoy configmap name */}}
{{- define "alertmanager.envoy.configmapName" -}}
{{- if .Values.authorizations.envoy.configMap.name -}}
{{- print .Values.authorizations.envoy.configMap.name -}}
{{- else -}}
{{- printf "%s-envoy" ( include "alertmanager.fullname" . ) -}}
{{- end -}}
{{- end -}}


{{/* Prometheus metics enabled for oidc proxy*/}}
{{- define "alertmanager.oidc.metricsEnabled" -}}
{{- if and .Values.prometheus.serviceMonitor.enabled (or .Values.oidc.serviceMonitor (and .Values.oidc.configMap.create .Values.oidc.configMap.enableMetric)) -}}
true
{{- else -}}
false
{{- end -}}
{{- end -}}

{{/* Secret configuration */}}
{{- define "alertmanager.config.secretName" -}}
{{- if .Values.configSecret -}}
{{ print .Values.configSecret }}
{{- else -}}
{{- printf "alertmanager-%s" ( include "alertmanager.fullname" . ) -}}
{{- end -}}
{{- end -}}

{{/* Argcd Annotations */}}
{{- define "alertmanager.argocd.annotations" -}}
{{- if .Values.global.enableArgocdAnnotations -}}
{{- range .Values.global.argocdAnnotations -}}
{{ fromYaml . | toYaml }}
{{- end -}}
{{- end -}}
{{- end -}}

{{/* Ingress tls secret name */}}
{{- define "alertmanager.ingress.tlsName" -}}
{{- if .Values.ingress.tls.secretName -}}
{{- printf "%s" .Values.ingress.tls.secretName -}}
{{- else -}}
{{- printf "%s-tls" ( include "alertmanager.fullname" . ) -}}
{{- end -}}
{{- end -}}

{{/* Ingress annotations */}}
{{- define "alertmanager.ingress.annotations" -}}
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

{{/* Ingress servicePortName */}}
{{- define "alertmanager.ingress.servicePort" -}}
{{- if .Values.oidc.enabled -}}
{{ print .Values.oidc.port }}
{{- else }}
{{ print .Values.service.port }}
{{- end }}
{{- end -}}
