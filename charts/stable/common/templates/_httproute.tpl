{{/* Renders the HTTPRoute objects required by the chart */}}
{{- define "common.httproute" -}}
  {{- range $name, $route := .Values.httproutes }}
    {{- if $route.enabled -}}
      {{- $routeValues := $route -}}

      {{/* Set defaults */}}
      {{- if not $routeValues.nameOverride -}}
        {{- $_ := set $routeValues "nameOverride" (printf "%s-%s" (include "common.names.fullname" $) $name) -}}
      {{- end -}}

      {{/* Create a clean scope and call the class */}}
      {{- $ctx := dict "Values" $ "Chart" $.Chart "Release" $.Release "ObjectValues" (dict "route" $routeValues) -}}
      {{- include "common.classes.httproute" $ctx }}
    {{- end }}
  {{- end }}
{{- end }}
