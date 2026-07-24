{{/*
Generic Gateway Class
*/}}
{{- define "common.classes.gateway" -}}
{{- $gateway := .Values.gateway }}
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: {{ default (printf "%s-gw" (include "common.names.fullname" .)) $gateway.name }}
  annotations:
    {{- include "common.annotations" . | nindent 4 }}
    {{- with $gateway.annotations }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
  labels:
    {{- include "common.labels" . | nindent 4 }}
    {{- with $gateway.labels }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
spec:
  gatewayClassName: {{ required "gateway.className is required" $gateway.className }}
  listeners:
  {{- if $gateway.listeners }}
  {{- range $gateway.listeners }}
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
    {{- toYaml . | nindent 8 }}
    {{- end }}
  {{- end }}
  {{- else }}
  - name: https
    hostname: {{ required "gateway.hostname is required" $gateway.hostname | quote }}
    port: {{ default 443 $gateway.port }}
    protocol: {{ default "HTTPS" $gateway.protocol }}
    tls:
      mode: {{ default "Terminate" $gateway.tlsMode }}
      certificateRefs:
      - name: {{ default (printf "%s-tls" (include "common.names.fullname" .)) $gateway.tlsName }}
    allowedRoutes:
      namespaces:
    {{- toYaml (default (dict "from" "Same") $gateway.allowedRoutesNamespaces) | nindent 8 }}
  {{- end }}
{{- end }}
