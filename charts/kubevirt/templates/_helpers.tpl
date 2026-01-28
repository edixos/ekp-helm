{{- define "call-nested" }}
{{- $dot := index . 0 }}
{{- $subchart := index . 1 | splitList "." }}
{{- $template := index . 2 }}
{{- $values := $dot.Values }}
{{- range $subchart }}
{{- $values = index $values . }}
{{- end }}
{{- include $template (dict
  "Chart" (dict "Name" (last $subchart))
  "Values" $values
  "Release" $dot.Release
  "Capabilities" $dot.Capabilities
) }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "kubevirt.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kubevirt.fullname" -}}
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
{{- define "kubevirt.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "kubevirt.labels" -}}
helm.sh/chart: {{ include "kubevirt.chart" . }}
{{ include "kubevirt.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- with .Values.commonLabels }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "kubevirt.selectorLabels" -}}
app.kubernetes.io/name: {{ include "kubevirt.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Operator selector labels
*/}}
{{- define "kubevirt.operatorSelectorLabels" -}}
kubevirt.io: virt-operator
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "kubevirt.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default "kubevirt-operator" .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the priority class to use
*/}}
{{- define "kubevirt.priorityClassName" -}}
{{- if .Values.priorityClass.create }}
{{- default "kubevirt-cluster-critical" .Values.priorityClass.name }}
{{- else }}
{{- .Values.priorityClass.name }}
{{- end }}
{{- end }}

{{/*
Namespace name
*/}}
{{- define "kubevirt.namespace" -}}
{{- if .Values.namespace.create }}
{{- .Values.namespace.name }}
{{- else }}
{{- .Release.Namespace }}
{{- end }}
{{- end }}

{{/*
Operator image
*/}}
{{- define "kubevirt.operatorImage" -}}
{{- $tag := .Values.operator.image.tag | default .Values.version -}}
{{- printf "%s:%s" .Values.operator.image.repository $tag }}
{{- end }}

{{/*
Common annotations
*/}}
{{- define "kubevirt.annotations" -}}
{{- with .Values.commonAnnotations }}
{{ toYaml . }}
{{- end }}
{{- end }}