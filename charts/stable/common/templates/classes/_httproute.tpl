{{/*
Generic HTTPRoute Class
*/}}

{{- define "common.classes.httproute" -}}
{{- $route := .Values.httproute }}

apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: {{ default (include "common.names.fullname" .) $route.name }}
  annotations:
    {{- include "common.annotations" . | nindent 4 }}
    {{- with $route.annotations }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
  labels:
    {{- include "common.labels" . | nindent 4 }}
    {{- with $route.labels }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
spec:
  parentRefs:
  - name: {{ required "httproute.gatewayName is required" $route.gatewayName }}
    sectionName: {{ default "https" $route.parentSection }}
  hostnames:
  {{- range required "httproute.hostnames is required" $route.hostnames }}
  - {{ . | quote }}
  {{- end }}
{{- if $route.rules }}
  rules:
{{ toYaml $route.rules | nindent 4 }}
{{- else }}
  rules:
  - matches:
    {{- if $route.matches }}
    {{- toYaml $route.matches | nindent 8 }}
    {{- else }}
    - path:
        type: {{ default "PathPrefix" $route.pathType }}
        value: {{ default "/" $route.path }}
    {{- end }}
    backendRefs:
    - name: {{ default (include "common.names.fullname" .) $route.serviceName }}
      {{- with $route.backendGroup }}
      group: {{ . }}
      {{- end }}
      {{- with $route.backendKind }}
      kind: {{ . }}
      {{- end }}
      port: {{ default (default 80 $.Values.service.port) $route.servicePort }}
      {{- with $route.weight }}
      weight: {{ . }}
      {{- end }}
  {{- end }}
{{- end }}
