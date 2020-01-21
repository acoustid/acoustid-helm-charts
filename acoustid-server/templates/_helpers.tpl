{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "acoustid-server.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "acoustid-server.fullname" -}}
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
{{- define "acoustid-server.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "acoustid-server.matchLabels" -}}
app.kubernetes.io/name: {{ include "acoustid-server.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "acoustid-server.labels" -}}
{{ include "acoustid-server.matchLabels" . }}
{{ toYaml .Values.labels }}
{{- end -}}

{{- define "acoustid-server.sharedEnv" -}}
- name: ACOUSTID_CONFIG
  value: /etc/acoustid/acoustid.conf
- name: ACOUSTID_INDEX_HOST
  value: acoustid-index
- name: ACOUSTID_INDEX_PORT
  value: "6080"
- name: ACOUSTID_MB_OAUTH_CLIENT_ID_FILE
  value: /etc/secrets/acoustid/mb_oauth_client_id
- name: ACOUSTID_MB_OAUTH_CLIENT_SECRET_FILE
  value: /etc/secrets/acoustid/mb_oauth_client_secret
- name: ACOUSTID_GOOGLE_OAUTH_CLIENT_ID_FILE
  value: /etc/secrets/acoustid/google_oauth_client_id
- name: ACOUSTID_GOOGLE_OAUTH_CLIENT_SECRET_FILE
  value: /etc/secrets/acoustid/google_oauth_client_secret
- name: ACOUSTID_SECRET_FILE
  value: /etc/secrets/acoustid/app_secret
- name: ACOUSTID_CLUSTER_SECRET_FILE
  value: /etc/secrets/acoustid/cluster_secret
- name: ACOUSTID_SENTRY_WEB_DSN_FILE
  value: /etc/secrets/acoustid/sentry_web_dsn
- name: ACOUSTID_SENTRY_API_DSN_FILE
  value: /etc/secrets/acoustid/sentry_api_dsn
- name: ACOUSTID_SENTRY_SCRIPT_DSN_FILE
  value: /etc/secrets/acoustid/sentry_script_dsn
{{- end -}}

{{- define "acoustid-server.sharedVolumeMounts" -}}
- name: postgresql-user-acoustid
  mountPath: /etc/secrets/postgresql/acoustid
- name: acoustid-config
  mountPath: /etc/acoustid
- name: acoustid-secrets
  mountPath: /etc/secrets/acoustid
{{- end -}}

{{- define "acoustid-server.appSecretName" -}}
{{- if .Values.appSecretName -}}
{{- .Values.appSecretName -}}
{{- else -}}
{{- include "acoustid-server.fullname" . }}-secrets
{{- end -}}
{{- end -}}

{{- define "acoustid-server.sharedVolumes" -}}
- name: postgresql-user-acoustid
  secret:
    secretName: postgresql-user-acoustid
- name: acoustid-config
  configMap:
    name: {{ include "acoustid-server.fullname" . }}-config
- name: acoustid-secrets
  secret:
    secretName: {{ include "acoustid-server.appSecretName" . }}
{{- end -}}
