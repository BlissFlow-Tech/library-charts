{{- range $name, $route := .Values.httproutes }}
  {{- if $route.enabled }}
---
    {{- $routeCtx := dict "Values" $ "ObjectValues" (dict "route" $route) -}}
    {{- include "common.classes.httproute" $routeCtx -}}
  {{- end }}
{{- end }}
