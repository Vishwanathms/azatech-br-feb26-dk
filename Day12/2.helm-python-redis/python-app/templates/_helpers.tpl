{{- define "python-app.name" -}}
{{ .Chart.Name }}
{{- end -}}

{{- define "python-app.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end -}}

{{- define "myapp.fullname" -}}
{{ printf "%s-%s" .Release.Name .Chart.Name | trunc 63 }}
{{- end -}}
