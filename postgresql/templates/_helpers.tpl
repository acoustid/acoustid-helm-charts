{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
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

{{/*
Common labels
*/}}
{{- define "postgresql.labels" -}}
helm.sh/chart: {{ include "postgresql.chart" . | quote }}
{{ include "postgresql.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "postgresql.selectorLabels" -}}
app.kubernetes.io/name: {{ include "postgresql.name" . | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
cluster-name: {{ include "postgresql.clusterName" . | quote }}
{{- end -}}

{{/*
Selector labels in JSON format
*/}}
{{- define "postgresql.patroniSelectorLabelsInJSON" -}}
{"app.kubernetes.io/name": {{ include "postgresql.name" . | quote}}, "cluster-name": {{ include "postgresql.clusterName" . | quote }}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "postgresql.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "postgresql.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{- define "postgresql.clusterName" -}}
{{- if .Values.clusterName -}}
{{ .Values.clusterName }}
{{- else -}}
{{ include "postgresql.fullname" . }}
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

{{- define "postgresql.backupSecretName" -}}
{{ include "postgresql.fullname" . }}-backup
{{- end -}}

{{- define "postgresql.backupPath" -}}
s3://{{ .Values.backup.bucket }}/{{ .Values.backup.prefix }}/{{ .Release.Name }}
{{- end -}}
