{{- /* The HTTPRoute resource for the application */ -}}
{{- define "common.httproute" -}}
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: {{ include "common.names.fullname" . }}
  labels: {{ include "common.labels" . | nindent 4 }}
spec:
  parentRefs:
  - name: {{ .Values.gateway.name | default (printf "tenant-%s-gw" .Values.tenant) }}
    sectionName: {{ .Values.route.parentSection | default "https" }}
  hostnames:
  - {{ printf "%s.%s" .Values.tenant .Values.dns.public_zone.name | quote }}
  rules:
  - matches:
    {{- if .Values.route.matches }}
      {{- toYaml .Values.route.matches | nindent 8 }}
    {{- else }}
    - path:
      type: PathPrefix
      value: {{ .Values.route.path | default "/" }}
    {{- end }}
    {{- with .Values.route.filters }}
    filters:
      {{- toYaml . | nindent 8 }}
    {{- end }}
    backendRefs:
    - group: ""
      kind: Service
      name: {{ include "common.names.fullname" . }}
      port: {{ .Values.service.mainPort | default .Values.service.port | default 80 }}
{{- end -}}
