{{- define "h2o-knowledge-mgmt.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "h2o-knowledge-mgmt.fullname" -}}
{{- printf "%s-%s" .Release.Name (include "h2o-knowledge-mgmt.name" .) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "h2o-knowledge-mgmt.labels" -}}
app.kubernetes.io/name: {{ include "h2o-knowledge-mgmt.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
