{{/*
Helpers for the wrapper chart only.

The `goldilocks-wrapper.` prefix is deliberate: Helm template names are global
across the parent and its subcharts, and the upstream chart already defines
`goldilocks.name`, `goldilocks.fullname` and `goldilocks.chart`. Reusing those
names here would silently override the subchart's own definitions.
*/}}

{{/*
Expand the name of the chart.
*/}}
{{- define "goldilocks-wrapper.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "goldilocks-wrapper.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "goldilocks-wrapper.selectorLabels" -}}
app.kubernetes.io/name: {{ include "goldilocks-wrapper.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "goldilocks-wrapper.labels" -}}
helm.sh/chart: {{ include "goldilocks-wrapper.chart" . }}
{{ include "goldilocks-wrapper.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
