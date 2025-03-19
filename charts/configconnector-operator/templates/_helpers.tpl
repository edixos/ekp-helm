{{/*
Expand the name of the chart.
*/}}
{{- define "configconnector-operator.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "configconnector-operator.fullname" -}}
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

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "configconnector-operator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "configconnector-operator.labels" -}}
helm.sh/chart: {{ include "configconnector-operator.chart" . }}
{{ include "configconnector-operator.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "configconnector-operator.selectorLabels" -}}
cnrm.cloud.google.com/component: {{ include "configconnector-operator.fullname" . }}
cnrm.cloud.google.com/operator-system: "true"
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "configconnector-operator.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default ( include "configconnector-operator.fullname" . ) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "configconnector-operator.commonAnnotations" -}}
cnrm.cloud.google.com/operator-version: {{ .Chart.AppVersion }}
{{- with .Values.commonAnnotations }}
{{ . | toYaml }}
{{- end }}
{{- end }}