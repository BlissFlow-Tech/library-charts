{{- range $name, $gateway := .Values.gateways }}
  {{- if $gateway.enabled -}}
    {{- /* If this is not the first enabled gateway in the loop,
       we need a separator to prevent YAML corruption.
    */ -}}
---
    {{- /* 1. Prepare the ObjectValues specifically for this gateway instance.
       2. Use 'merge' to allow the library to access global Values/Chart context.
    */ -}}
    {{- $gatewayValues := $gateway -}}

    {{- /* Handle name override logic similar to your Ingress pattern */ -}}
    {{- if and (not $gatewayValues.nameOverride) (ne $name "primary") -}}
      {{- $_ := set $gatewayValues "nameOverride" (printf "%s-%s" (include "common.names.fullname" $) $name) -}}
    {{- end -}}

    {{- /* Create the context and call the library class */ -}}
    {{- $gatewayCtx := dict "Values" $ "Chart" $.Chart "Release" $.Release "ObjectValues" (dict "gateway" $gatewayValues) -}}
    {{- include "common.classes.gateway" $gatewayCtx -}}
  {{- end }}
{{- end }}
