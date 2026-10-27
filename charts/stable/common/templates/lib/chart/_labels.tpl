{{/* Common labels shared across objects */}}
{{- define "common.labels" -}}
helm.sh/chart: {{ include "common.names.chart" . }}
{{ include "common.labels.selectorLabels" . }}
  {{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
  {{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
  {{- with .Values.global.labels }}
    {{- range $k, $v := . }}
      {{- $name := $k }}
      {{- $value := tpl $v $ }}
{{ $name }}: {{ quote $value }}
    {{- end }}
  {{- end }}
{{- end -}}

{{/* Selector labels shared across objects */}}
{{- define "common.labels.selectorLabels" -}}
app.kubernetes.io/name: {{ include "common.names.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/* Pod labels of a controller, selector labels take precedence */}}
{{- define "common.labels.podLabels" -}}
{{- toYaml (merge (include "common.labels.selectorLabels" .context | fromYaml) (dict "app.kubernetes.io/controller" .controller) (.labels | default dict)) }}
{{- end -}}
