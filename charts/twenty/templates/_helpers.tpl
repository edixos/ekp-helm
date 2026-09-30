{{/*
Expand the name of the chart.
*/}}
{{- define "twenty-wrapper.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "twenty-wrapper.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "twenty-wrapper.labels" -}}
helm.sh/chart: {{ include "twenty-wrapper.chart" . }}
{{ include "twenty-wrapper.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "twenty-wrapper.selectorLabels" -}}
app.kubernetes.io/name: {{ include "twenty-wrapper.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
