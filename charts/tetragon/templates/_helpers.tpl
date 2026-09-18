{{/*
Expand the name of the chart.
*/}}
{{- define "tetragon.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "tetragon.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := include "tetragon.name" . }}
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
{{- define "tetragon.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "tetragon.selectorLabels" -}}
app.kubernetes.io/name: {{ include "tetragon.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "tetragon.labels" -}}
helm.sh/chart: {{ include "tetragon.chart" . }}
{{ include "tetragon.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Annotations placed on the TracingPolicy resources. The CRDs they are instances
of are created by the Tetragon operator of the same release, so Argo CD must
neither dry-run them before the CRD exists nor apply them before the operator
is up.
*/}}
{{- define "tetragon.tracingPolicyAnnotations" -}}
{{- if (.Values.global).enableArgocdAnnotations -}}
annotations:
  argocd.argoproj.io/sync-options: SkipDryRunOnMissingResource=true
  argocd.argoproj.io/sync-wave: {{ (.Values.global).argocdSyncWave | default "1" | quote }}
{{- end -}}
{{- end -}}
