{{/* vim: set filetype=mustache: */}}

{{- define "postgresql.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "postgresql.fullname" -}}
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
{{- define "postgresql.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "postgresql.labels" -}}
app.kubernetes.io/name: {{ include "postgresql.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Values.labels -}}
{{- toYaml .Values.labels | nindent 0 }}
{{- end -}}
{{- end -}}

{{- define "postgresql.volumeClaimTemplateLabels" -}}
app.kubernetes.io/name: {{ include "postgresql.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Values.labels -}}
{{- toYaml .Values.labels | nindent 0 }}
{{- end -}}
{{- end -}}

{{- define "postgresql.matchLabels" -}}
app.kubernetes.io/name: {{ include "postgresql.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "postgresql.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "postgresql.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{- define "postgresql.annotations" -}}
prometheus.io/scrape: "true"
prometheus.io/port: "8080"
{{- if .Values.annotations -}}
{{- toYaml .Values.annotations | nindent 0 }}
{{- end -}}
{{- end -}}

{{- define "postgresql.superuserSecretName" -}}
{{- if .Values.superuser.secretName -}}
{{ .Values.superuser.secretName }}
{{- else -}}
{{ include "postgresql.fullname" . }}-superuser
{{- end -}}
{{- end -}}

{{- define "postgresql.replicationSecretName" -}}
{{- if .Values.replication.secretName -}}
{{ .Values.replication.secretName }}
{{- else -}}
{{ include "postgresql.fullname" . }}-replication
{{- end -}}
{{- end -}}

{{- define "postgresql.dataVolumeName" -}}
{{ include "postgresql.fullname" . }}-data
{{- end -}}
