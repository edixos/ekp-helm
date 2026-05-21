{{/* vim: set filetype=mustache: */}}

{{- define "kargo.fullname" -}}
{{- printf "%s-%s" .Release.Name (include "kargo.name" .) | trunc 63 | trimSuffix "-" -}}
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