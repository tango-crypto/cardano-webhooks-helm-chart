{{/*
Common labels
*/}}
{{- define "cardano-webhooks-helm-chart.labels" -}}
helm.sh/chart: {{ include "cardano-webhooks-helm-chart.chart" . }}
{{ include "cardano-webhooks-helm-chart.selectorLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "cardano-webhooks-helm-chart.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cardano-webhooks-helm-chart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Chart name
*/}}
{{- define "cardano-webhooks-helm-chart.name" -}}
{{ .Chart.Name }}
{{- end -}}

{{/*
Chart version
*/}}
{{- define "cardano-webhooks-helm-chart.chart" -}}
{{ .Chart.Name }}-{{ .Chart.Version }}
{{- end -}}

{{/*
Full name
*/}}
{{- define "cardano-webhooks-helm-chart.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end -}}
