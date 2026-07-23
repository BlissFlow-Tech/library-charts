{{/*
Renders VerticalPodAutoscaler resources
*/}}
{{- define "common.vpa" -}}
{{- range $name, $vpa := $.Values.vpas }}
{{- if $vpa.enabled }}
{{- $values := deepCopy $vpa }}
{{- if not $values.nameOverride }}
{{- $_ := set $values "nameOverride" (printf "%s-%s" (include "common.names.fullname" $) $name) }}
{{- end }}
{{- $ctx := dict
    "Values" $.Values
    "Chart" $.Chart
    "Release" $.Release
    "Capabilities" $.Capabilities
    "Files" $.Files
    "Template" $.Template
    "VPA" $values
}}
---
{{ include "common.classes.vpa" $ctx }}
{{- end }}
{{- end }}
{{- end }}
