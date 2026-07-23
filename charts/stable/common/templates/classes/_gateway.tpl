{{/*
Generic Gateway Class
*/}}

{{- define "common.classes.gateway" -}}
{{- $values := .ObjectValues.gateway }}
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: {{ default (printf "%s-gw" (include "common.names.fullname" .)) $values.nameOverride }}
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
  gatewayClassName: {{ required "gateway.className is required" $values.className }}
  listeners:
{{- if $values.listeners }}
{{- range $values.listeners }}
  - name: {{ default "https" .name }}
    hostname: {{ required "listener.hostname is required" .hostname | quote }}
    port: {{ default 443 .port }}
    protocol: {{ default "HTTPS" .protocol }}
    {{- if eq (default "HTTPS" .protocol) "HTTPS" }}
    tls:
      mode: {{ default "Terminate" .tlsMode }}
      certificateRefs:
      - name: {{ default (printf "%s-tls" (include "common.names.fullname" $)) .tlsName }}
      {{- end }}
    allowedRoutes:
      namespaces:
        {{- toYaml (default (dict "from" "Same") .allowedRoutesNamespaces) | nindent 8 }}
      {{- with .allowedRoutesKinds }}
      kinds:
        {{ toYaml . | nindent 10 }}
      {{- end }}
  {{- end }}
{{- else }}
  - name: https
    hostname: {{ required "gateway.hostname is required" $values.hostname | quote }}
    port: {{ default 443 $values.port }}
    protocol: {{ default "HTTPS" $values.protocol }}
    tls:
      mode: {{ default "Terminate" $values.tlsMode }}
      certificateRefs:
      - name: {{ default (printf "%s-tls" (include "common.names.fullname" .)) $values.tlsName }}
    allowedRoutes:
      namespaces:
      {{- toYaml (default (dict "from" "Same") $values.allowedRoutesNamespaces) | nindent 8 }}
    {{- end }}
{{- end }}
