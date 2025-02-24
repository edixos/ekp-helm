{{/*
Expand the name of the chart.
*/}}
{{- define "gcp-vpc-network.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "gcp-vpc-network.fullname" -}}
{{- if .Values.name }}
{{- .Values.name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "gcp-vpc-network.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "gcp-vpc-network.labels" -}}
helm.sh/chart: {{ include "gcp-vpc-network.chart" . }}
{{ include "gcp-vpc-network.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "gcp-vpc-network.selectorLabels" -}}
app.kubernetes.io/name: {{ include "gcp-vpc-network.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the vpc netwofk to use
*/}}
{{- define "gcp-vpc-network.vpcNetworkName" -}}
{{- if .Values.vpcNetworkName.create }}
{{- default (include "gcp-vpc-network.fullname" .) .Values.vpcNetworkName.name }}
{{- else }}
{{- default "default" .Values.vpcNetworkName.name }}
{{- end }}
{{- end }}

{{/*
Define Namespace
*/}}
{{- define "gcp-vpc-network.namespace" -}}
{{ default .Release.Namespace .Values.global.cnrmNamespace }}
{{- end -}}
