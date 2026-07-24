{{/*
Renders the Gateway resource
*/}}
{{- define "common.gateway" -}}
{{- $gateway := default (dict) .Values.gateway }}
{{- if $gateway.enabled }}
---
{{ include "common.classes.gateway" . }}
{{- end }}
{{- end }}
