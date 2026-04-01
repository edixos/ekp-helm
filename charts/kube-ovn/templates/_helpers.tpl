{{- define "kube-ovn.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "call-nested" }}
{{- $dot := index . 0 }}
{{- $subchart := index . 1 | splitList "." }}
{{- $template := index . 2 }}
{{- $values := $dot.Values }}
{{- range $subchart }}
{{- $values = index $values . }}
{{- end }}
{{- /* If the nested chart values include a `valuesFrom` config, try to load and merge it. */ -}}
{{- with $values.valuesFrom }}
  {{- with .configMapKeyRef }}
    {{- $cmName := .name }}
    {{- if $cmName }}
      {{- $cmKey := .key | default "" }}
      {{- $cmNs := .namespace | default $dot.Release.Namespace }}
      {{- $optional := .optional | default false }}
      {{- $cm := lookup "v1" "ConfigMap" $cmNs $cmName }}
      {{- if $cm }}
        {{- if $cm.data }}
          {{- if $cmKey }}
            {{- $raw := index $cm.data $cmKey | default "" }}
            {{- if $raw }}
              {{- $parsed := fromYaml $raw }}
              {{- if kindIs "map" $parsed }}
                {{- $values = merge $values $parsed }}
              {{- else }}
                {{- $_ := set $values $cmKey $raw }}
              {{- end }}
            {{- end }}
          {{- else }}
            {{- range $k, $v := $cm.data }}
              {{- $parsed := fromYaml $v }}
              {{- if kindIs "map" $parsed }}
                {{- $values = merge $values $parsed }}
              {{- else }}
                {{- $_ := set $values $k $v }}
              {{- end }}
            {{- end }}
          {{- end }}
        {{- end }}
      {{- else }}
        {{- if not $optional }}
          {{- fail (printf "configMap %s/%s not found" $cmNs $cmName) }}
        {{- end }}
      {{- end }}
    {{- end }}
  {{- end }}
{{- end }}
{{- include $template (dict
  "Chart" (dict "Name" (last $subchart))
  "Values" $values
  "Release" $dot.Release
  "Capabilities" $dot.Capabilities
) }}
{{- end }}
