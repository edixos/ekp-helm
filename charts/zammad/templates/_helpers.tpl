{{/*
Expand the name of the chart.
*/}}
{{- define "zammad-wrapper.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "zammad-wrapper.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "zammad-wrapper.labels" -}}
helm.sh/chart: {{ include "zammad-wrapper.chart" . }}
{{ include "zammad-wrapper.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "zammad-wrapper.selectorLabels" -}}
app.kubernetes.io/name: {{ include "zammad-wrapper.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
