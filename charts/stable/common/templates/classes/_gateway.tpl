{{- /* Generic Gateway Class - No Separator */ -}}
{{- define "common.classes.gateway" -}}
{{- $values := .ObjectValues.gateway -}}
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: {{ $values.nameOverride | default (printf "%s-gw" (include "common.names.fullname" .)) }}
  {{- with $values.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  gatewayClassName: {{ $values.className | required "gateway.className is required" | quote }}
  listeners:
    - name: {{ $values.listenerName | default "https" }}
      port: {{ $values.port | default 443 }}
      protocol: {{ $values.protocol | default "HTTPS" }}
      hostname: {{ $values.hostname | required "gateway.hostname is required" | quote }}
      tls:
        mode: {{ $values.tlsMode | default "Terminate" }}
        certificateRefs:
          - name: {{ $values.tlsName | default (printf "%s-tls" (include "common.names.fullname" .)) }}
      allowedRoutes:
        namespaces:
          {{- toYaml ($values.allowedRoutesNamespaces | default (dict "from" "Same")) | nindent 10 }}
{{- end -}}
