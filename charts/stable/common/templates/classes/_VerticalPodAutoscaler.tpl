{{/*
Generic VerticalPodAutoscaler Class
*/}}

{{- define "common.classes.vpa" -}}
{{- $vpa := .Values.vpa }}
{{- $targetRef := default (dict) $vpa.targetRef }}

apiVersion: autoscaling.k8s.io/v1
kind: VerticalPodAutoscaler
metadata:
  name: {{ default (include "common.names.fullname" .) $vpa.name }}
  annotations:
    {{- include "common.annotations" . | nindent 4 }}
    {{- with $vpa.annotations }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
  labels:
    {{- include "common.labels" . | nindent 4 }}
    {{- with $vpa.labels }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
spec:
  targetRef:
    apiVersion: {{ default "apps/v1" $targetRef.apiVersion }}
    kind: {{ default "Deployment" $targetRef.kind }}
    name: {{ default (include "common.names.fullname" .) $targetRef.name }}
  {{- with $vpa.updatePolicy }}
  updatePolicy:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with $vpa.resourcePolicy }}
  resourcePolicy:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end }}
