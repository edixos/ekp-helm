{{/*
Expand the name of the chart.
*/}}
{{- define "gcp-iam-policy-members.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "gcp-iam-policy-members.fullname" -}}
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
{{- define "gcp-iam-policy-members.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "gcp-iam-policy-members.labels" -}}
helm.sh/chart: {{ include "gcp-iam-policy-members.chart" . }}
{{ include "gcp-iam-policy-members.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "gcp-iam-policy-members.selectorLabels" -}}
app.kubernetes.io/name: {{ include "gcp-iam-policy-members.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "gcp-iam-policy-members.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "gcp-iam-policy-members.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Define Namespace
*/}}
{{- define "gcp-iam-policy-members.namespace" -}}
{{- $globalValues := default dict .Values.global -}}
{{- $cnrmNamespace := default .Values.cnrmNamespace $globalValues.cnrmNamespace -}}
{{- default .Release.Namespace $cnrmNamespace -}}
{{- end -}}
