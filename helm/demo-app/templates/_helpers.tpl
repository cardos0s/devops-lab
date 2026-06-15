{{/* Labels comuns aplicados a todos os recursos do chart. */}}
{{- define "demo-app.labels" -}}
app.kubernetes.io/name: demo-app
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
helm.sh/chart: demo-app-{{ .Chart.Version }}
{{- end -}}
