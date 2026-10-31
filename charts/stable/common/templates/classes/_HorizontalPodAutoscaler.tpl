{{- define "common.classes.hpa" -}}
{{- if .Values.autoscaling.enabled -}}
{{- $hpaName := include "common.names.fullname" . -}}
{{- $targetName := include "common.names.fullname" . }}
---
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: {{ $hpaName }}
  labels: {{- include "common.labels" $ | nindent 4 }}
  annotations: {{- include "common.annotations" $ | nindent 4 }}
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: {{ include "common.names.controllerType" . }}
    name: {{ .Values.autoscaling.target | default $targetName }}
  minReplicas: {{ .Values.autoscaling.minReplicas | default 1 }}
  maxReplicas: {{ .Values.autoscaling.maxReplicas | default 3 }}
  metrics:
    {{- $container := .Values.autoscaling.targetContainer }}
    {{- $metricType := ternary "ContainerResource" "Resource" (not (empty $container)) }}
    {{- range (list
      (list "cpu" "Utilization" .Values.autoscaling.targetCPUUtilizationPercentage)
      (list "memory" "Utilization" .Values.autoscaling.targetMemoryUtilizationPercentage)
      (list "cpu" "AverageValue" .Values.autoscaling.targetCPUAverageValue)
      (list "memory" "AverageValue" .Values.autoscaling.targetMemoryAverageValue)) }}
    {{- if index . 2 }}
    - type: {{ $metricType }}
      {{ $metricType | untitle }}:
        name: {{ index . 0 }}
        {{- with $container }}
        container: {{ . }}
        {{- end }}
        target:
          type: {{ index . 1 }}
          {{- if eq (index . 1) "Utilization" }}
          averageUtilization: {{ index . 2 }}
          {{- else }}
          averageValue: {{ index . 2 }}
          {{- end }}
    {{- end }}
    {{- end }}
    {{- range .Values.autoscaling.externalMetrics }}
    - type: External
      external:
        metric:
          name: {{ required "external metric name is required" .name }}
          {{- if .selector }}
          selector:
            matchLabels:
              {{- toYaml .selector | nindent 14 }}
          {{- end }}
        target:
          type: {{ .target.type }}
          {{- if eq .target.type "Value" }}
          value: {{ .target.value }}
          {{- else if eq .target.type "AverageValue" }}
          averageValue: {{ .target.averageValue }}
          {{- end }}
    {{- end }}
  {{- with .Values.autoscaling.behavior }}
  behavior:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end }}
{{- end }}
