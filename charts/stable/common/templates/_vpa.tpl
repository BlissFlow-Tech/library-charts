{{/*
Renders the VerticalPodAutoscaler resource
*/}}
{{- define "common.vpa" -}}
{{- if .Values.vpa.enabled }}
---
{{ include "common.classes.vpa" . }}
{{- end }}
{{- end }}
