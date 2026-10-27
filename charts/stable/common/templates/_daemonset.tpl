{{/*
This template serves as the blueprint for the DaemonSet objects that are created
within the common library.
*/}}
{{- define "common.daemonset" }}
---
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: {{ include "common.names.fullname" . }}
  {{- with (merge (.Values.controller.labels | default dict) (include "common.labels" $ | fromYaml)) }}
  labels: {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with (merge (.Values.controller.annotations | default dict) (include "common.annotations" $ | fromYaml)) }}
  annotations: {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  revisionHistoryLimit: {{ .Values.controller.revisionHistoryLimit }}
  selector:
    matchLabels:
      {{- include "common.labels.selectorLabels" . | nindent 6 }}
  template:
    metadata:
    {{- with include ("common.podAnnotations") . }}
      annotations:
        {{- . | nindent 8 }}
    {{- end }}
      labels:
        {{- include "common.labels.podLabels" (dict "context" . "controller" "main" "labels" .Values.podLabels) | nindent 8 }}
    spec:
      {{- include "common.controller.pod" . | nindent 6 }}
{{- end }}
