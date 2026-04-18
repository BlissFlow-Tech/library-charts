{{/*
Renders the HTTPRoute objects required by the chart.
*/}}
{{- define "common.httproute" -}}
  {{- range $name, $route := .Values.httproutes }}
    {{- if $route.enabled -}}
      {{- $routeValues := $route -}}

      {{/* Set the default nameOverride to the route name in the map */}}
      {{- if not $routeValues.nameOverride -}}
        {{- $_ := set $routeValues "nameOverride" $name -}}
      {{- end -}}

      {{- $_ := set $ "ObjectValues" (dict "route" $routeValues) -}}
      {{- include "common.classes.httproute" $ }}
    {{- end }}
  {{- end }}
{{- end }}
