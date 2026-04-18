{{/* Renders the HTTPRoute objects required by the chart */}}
{{- define "common.httproute" -}}
  {{- range $name, $route := .Values.httproutes }}
    {{- if $route.enabled -}}
      {{- $routeValues := $route -}}

      {{/* Set name override logic */}}
      {{- if and (not $routeValues.nameOverride) (ne $name "primary") -}}
        {{- $_ := set $routeValues "nameOverride" (printf "%s-%s" (include "common.names.fullname" $) $name) -}}
      {{- end -}}

      {{/* Create a localized context */}}
      {{- $routeCtx := dict "Values" $ "Chart" $.Chart "Release" $.Release "ObjectValues" (dict "route" $routeValues) -}}
      {{- include "common.classes.httproute" $routeCtx }}
    {{- end }}
  {{- end }}
{{- end }}
