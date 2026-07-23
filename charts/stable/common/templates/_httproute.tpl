{{/*
Renders HTTPRoute resources
*/}}
{{- define "common.httproute" -}}
{{- range $name, $route := $.Values.httproutes }}
{{- if $route.enabled }}
{{- $routeValues := deepCopy $route }}
{{- if not $routeValues.nameOverride }}
{{- $_ := set $routeValues "nameOverride" (printf "%s-%s" (include "common.names.fullname" $) $name) }}
{{- end }}
{{- $ctx := dict
    "Values" $.Values
    "Chart" $.Chart
    "Release" $.Release
    "Capabilities" $.Capabilities
    "Files" $.Files
    "Template" $.Template
    "ObjectValues" (dict "route" $routeValues)
}}
---
{{ include "common.classes.httproute" $ctx }}
{{- end }}
{{- end }}
{{- end }}
