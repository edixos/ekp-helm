{{/*
Expand the name of the chart.
*/}}
{{- define "bucket.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "bucket.fullname" -}}
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
{{- define "bucket.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "bucket.labels" -}}
helm.sh/chart: {{ include "bucket.chart" . }}
{{ include "bucket.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "bucket.selectorLabels" -}}
app.kubernetes.io/name: {{ include "bucket.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Define Namespace
*/}}
{{- define "bucket.namespace" -}}
{{ default .Release.Namespace .Values.global.cnrmNamespace }}
{{- end -}}


{{- define "bucket.annotations" -}}
{{- if or .Values.global.abandon .Values.annotations .Values.global.gcpProjectId -}}
annotations:
  {{- if .Values.global.abandon }}
  cnrm.cloud.google.com/deletion-policy: abandon
  {{- end }}
  {{- if .Values.global.gcpProjectId }}
  cnrm.cloud.google.com/project-id: {{ .Values.global.gcpProjectId }}
  {{- end }}
  {{- if .Values.annotations }}
{{- .Values.annotations | toYaml | nindent 2 }}
  {{- end }}
{{- end }}
{{- end -}}

{{- define "iamPolicyMember.annotations" -}}
{{- if .Values.global.skipUnspecifiedFields -}}
annotation:
  cnrm.cloud.google.com/state-into-spec: absent
{{- end }}
{{- end -}}


{{/*
Create the name of the service account to use
*/}}
{{- define "bucket.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "bucket.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
