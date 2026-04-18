{{/* Generic HTTPRoute Class */}}
{{- define "common.classes.httproute" -}}
{{- $values := .ObjectValues.route -}}
---
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: {{ $values.nameOverride }}
  {{- with $values.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  parentRefs:
    - name: {{ $values.gatewayName | required "route.gatewayName is required" }}
      sectionName: {{ $values.parentSection | default "https" }}
  hostnames:
    {{- range ($values.hostnames | required "route.hostnames list is required") }}
    - {{ . | quote }}
    {{- end }}
  rules:
    - matches:
        {{- if $values.matches }}
        {{- toYaml $values.matches | nindent 8 }}
        {{- else }}
        - path:
            type: {{ $values.pathType | default "PathPrefix" }}
            value: {{ $values.path | default "/" }}
        {{- end }}
      backendRefs:
        - group: {{ $values.backendGroup | default "" | quote }}
          kind: {{ $values.backendKind | default "Service" | quote }}
          name: {{ $values.serviceName | default (include "common.names.fullname" .) }}
          port:
            port: {{ $values.servicePort | default $.Values.service.port | default 80 }}
{{- end -}}
