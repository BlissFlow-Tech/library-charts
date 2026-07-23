{{/*
Renders Gateway resources
*/}}
{{- define "common.gateway" -}}
{{- range $name, $gateway := $.Values.gateways }}
{{- if $gateway.enabled }}
{{- $gatewayValues := deepCopy $gateway }}
{{- if not $gatewayValues.nameOverride }}
{{- $_ := set $gatewayValues "nameOverride" $name }}
{{- end }}
{{- $ctx := dict
    "Values" $.Values
    "Chart" $.Chart
    "Release" $.Release
    "Capabilities" $.Capabilities
    "Files" $.Files
    "Template" $.Template
    "ObjectValues" (dict "gateway" $gatewayValues)
}}
---
{{ include "common.classes.gateway" $ctx }}
{{- end }}
{{- end }}
{{- end }}
