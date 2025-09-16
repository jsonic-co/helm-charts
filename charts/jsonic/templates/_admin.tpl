{{/*
Admin base URL based on deployment mode and ingress configuration
*/}}
{{- define "jsonic.admin.baseUrl" -}}
  {{- if eq .Values.deploymentMode "aio" -}}
    {{- $baseUrl := (include "jsonic.ingressBaseUrl" .Values.aio.ingress) -}}
    {{- .Values.jsonic.frontend.enableSubpathBasedAccess | ternary (printf "%s/admin" $baseUrl) $baseUrl -}}
  {{- else if eq .Values.deploymentMode "distributed" -}}
    {{- include "jsonic.ingressBaseUrl" .Values.admin.ingress -}}
  {{- end -}}
{{- end -}}
