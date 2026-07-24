{{/*
Renders the HTTPRoute resource
*/}}
{{- define "common.httproute" -}}
{{- $route := default (dict) .Values.httproute }}
{{- if $route.enabled }}
---
{{ include "common.classes.httproute" . }}
{{- end }}
{{- end }}
