{{- /* The Gateway resource for the tenant */ -}}
{{- define "common.gateway" -}}
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: {{ .Values.gateway.name | default (printf "tenant-%s-gw" .Values.tenant) }}
  labels: {{ include "common.labels" . | nindent 4 }}
  annotations:
    cert-manager.io/cluster-issuer: {{ .Values.gateway.issuer | default "letsencrypt-production" }}
    {{- with .Values.gateway.annotations }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
spec:
  gatewayClassName: {{ .Values.gateway.className | default "merged-eg" }}
  listeners:
  - name: https
    port: 443
    protocol: HTTPS
    hostname: {{ printf "%s.%s" .Values.tenant .Values.dns.public_zone.name | quote }}
    tls:
      mode: Terminate
      certificateRefs:
      - name: {{ .Values.gateway.tlsName | default (printf "tenant-%s-tls" .Values.tenant) }}
    allowedRoutes:
      namespaces:
        {{- toYaml (.Values.gateway.allowedRoutes.namespaces | default (dict "from" "Same")) | nindent 10 }}
{{- end -}}
