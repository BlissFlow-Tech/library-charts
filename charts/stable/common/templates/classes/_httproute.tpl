{{/*
Generic HTTPRoute Class
*/}}

{{- define "common.classes.httproute" -}}
{{- $values := .ObjectValues.route }}
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: {{ $values.nameOverride }}
  annotations:
  {{- include "common.annotations" $ | nindent 4 }}
  {{- with $values.annotations }}
    {{ toYaml . | nindent 4 }}
  {{- end }}
  labels:
  {{- include "common.labels" $ | nindent 4 }}
    {{- with $values.labels }}
  {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  parentRefs:
  - name: {{ required "route.gatewayName is required" $values.gatewayName }}
    sectionName: {{ default "https" $values.parentSection }}
  hostnames:
  {{- range required "route.hostnames is required" $values.hostnames }}
  - {{ . | quote }}
  {{- end }}
{{- if $values.rules }}
  rules:
{{ toYaml $values.rules | nindent 4 }}
{{- else }}
  rules:
  - matches:
{{- if $values.matches }}
{{ toYaml $values.matches | nindent 8 }}
{{- else }}
    - path:
        type: {{ default "PathPrefix" $values.pathType }}
        value: {{ default "/" $values.path }}
{{- end }}
    backendRefs:
    - name: {{ default (include "common.names.fullname" .) $values.serviceName }}
      {{- with $values.backendGroup }}
      group: {{ . }}
      {{- end }}
      {{- with $values.backendKind }}
      kind: {{ . }}
      {{- end }}
      port: {{ default (default 80 $.Values.service.port) $values.servicePort }}
      {{- with $values.weight }}
      weight: {{ . }}
      {{- end }}
{{- end }}
{{- end }}
