{{/*
Renders the Gateway objects required by the chart.
*/}}
{{- define "common.gateway" -}}
  {{- range $name, $gateway := .Values.gateways }}
    {{- if $gateway.enabled -}}
      {{- $gatewayValues := $gateway -}}

      {{/* Set the default nameOverride to the gateway name in the map */}}
      {{- if not $gatewayValues.nameOverride -}}
        {{- $_ := set $gatewayValues "nameOverride" $name -}}
      {{- end -}}

      {{- $_ := set $ "ObjectValues" (dict "gateway" $gatewayValues) -}}
      {{- include "common.classes.gateway" $ }}
    {{- end }}
  {{- end }}
{{- end }}
