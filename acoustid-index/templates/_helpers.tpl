{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "acoustid-index.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "acoustid-index.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "acoustid-index.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "acoustid-index.matchLabels" -}}
app.kubernetes.io/name: {{ include "acoustid-index.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "acoustid-index.labels" -}}
{{ include "acoustid-index.matchLabels" . }}
{{ toYaml .Values.labels }}
{{- end -}}

{{- define "acoustid-index.annotations" -}}
{{- if .Values.annotations }}
{{ toYaml .Values.annotations }}
{{- end }}
{{- end -}}

{{- define "acoustid-index.metricsAnnotations" -}}
{{- if .Values.metrics.enabled }}
{{- if .Values.metrics.annotations }}
{{ toYaml .Values.metrics.annotations }}
{{- end }}
{{- end }}
{{- end -}}
