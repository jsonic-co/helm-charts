{{/*
Frontend base URL based on deployment mode and ingress configuration
*/}}
{{- define "jsonic.frontend.baseUrl" -}}
  {{- if .Values.jsonic.frontend.baseUrl -}}
    {{- .Values.jsonic.frontend.baseUrl -}}
  {{- else -}}
    {{- if eq .Values.deploymentMode "aio" -}}
      {{- include "jsonic.ingressBaseUrl" .Values.aio.ingress -}}
    {{- else if eq .Values.deploymentMode "distributed" -}}
      {{- include "jsonic.ingressBaseUrl" .Values.frontend.ingress -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{/*
Frontend admin URL based on deployment mode and ingress configuration
*/}}
{{- define "jsonic.frontend.adminUrl" -}}
  {{- if .Values.jsonic.frontend.adminUrl -}}
    {{- .Values.jsonic.frontend.adminUrl -}}
  {{- else -}}
    {{- include "jsonic.admin.baseUrl" . -}}
  {{- end -}}
{{- end -}}

{{/*
Frontend backend API URL based on deployment mode and ingress configuration
*/}}
{{- define "jsonic.frontend.backendApiUrl" -}}
  {{- if .Values.jsonic.frontend.backendApiUrl -}}
    {{- .Values.jsonic.frontend.backendApiUrl -}}
  {{- else -}}
    {{- $url := (include "jsonic.backend.baseUrl" .) -}}
    {{- if ne $url "" -}}
      {{- printf "%s/v1" $url -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{/*
Frontend backend GraphQL URL based on deployment mode and ingress configuration
*/}}
{{- define "jsonic.frontend.backendGqlUrl" -}}
  {{- if .Values.jsonic.frontend.backendGqlUrl -}}
    {{- .Values.jsonic.frontend.backendGqlUrl -}}
  {{- else -}}
    {{- $url := (include "jsonic.backend.baseUrl" .) -}}
    {{- if ne $url "" -}}
      {{- printf "%s/graphql" $url -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{/*
Frontend backend WebSocket URL based on deployment mode and ingress configuration
*/}}
{{- define "jsonic.frontend.backendWsUrl" -}}
  {{- if .Values.jsonic.frontend.backendWsUrl -}}
    {{- .Values.jsonic.frontend.backendWsUrl -}}
  {{- else -}}
    {{- include "jsonic.frontend.backendGqlUrl" . | replace "http://" "ws://" | replace "https://" "wss://" -}}
  {{- end -}}
{{- end -}}

{{/*
Frontend backend WebSocket URL based on deployment mode and ingress configuration
*/}}
{{- define "jsonic.frontend.shortcodeBaseUrl" -}}
  {{- if .Values.jsonic.frontend.shortcodeBaseUrl -}}
    {{- .Values.jsonic.frontend.shortcodeBaseUrl -}}
  {{- else -}}
    {{- include "jsonic.frontend.baseUrl" . -}}
  {{- end -}}
{{- end -}}
