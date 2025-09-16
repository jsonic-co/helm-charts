{{/*
Generate backend base URL based on deployment mode and ingress configuration
*/}}
{{- define "jsonic.backend.baseUrl" -}}
  {{- if eq .Values.deploymentMode "aio" -}}
    {{- $baseUrl := (include "jsonic.ingressBaseUrl" .Values.aio.ingress) -}}
    {{- .Values.jsonic.frontend.enableSubpathBasedAccess | ternary (printf "%s/backend" $baseUrl) $baseUrl -}}
  {{- else if eq .Values.deploymentMode "distributed" -}}
    {{- include "jsonic.ingressBaseUrl" .Values.backend.ingress -}}
  {{- end -}}
{{- end -}}

{{/*
Generate auth callback URL based on deployment mode and ingress configuration
Usage: {{ include "jsonic.backend.authCallbackUrl" (dict "provider" "github" "context" .) }}
*/}}
{{- define "jsonic.backend.authCallbackUrl" -}}
  {{- $baseUrl := (include "jsonic.backend.baseUrl" .context) -}}
  {{- if ne $baseUrl "" -}}
    {{- printf "%s/v1/auth/%s/callback" $baseUrl .provider -}}
  {{- end -}}
{{- end -}}

{{/*
Generate GitHub auth callback URL based on on deployment mode and ingress configuration
*/}}
{{- define "jsonic.backend.githubCallbackUrl" -}}
  {{- if .Values.jsonic.backend.auth.github.callbackUrl -}}
    {{- .Values.jsonic.backend.auth.github.callbackUrl -}}
  {{- else -}}
    {{- include "jsonic.backend.authCallbackUrl" (dict "provider" "github" "context" .) -}}
  {{- end -}}
{{- end }}

{{/*
Generate Google auth callback URL based on deployment mode and ingress configuration
*/}}
{{- define "jsonic.backend.googleCallbackUrl" -}}
  {{- if .Values.jsonic.backend.auth.google.callbackUrl -}}
    {{- .Values.jsonic.backend.auth.google.callbackUrl -}}
  {{- else -}}
    {{- include "jsonic.backend.authCallbackUrl" (dict "provider" "google" "context" .) -}}
  {{- end -}}
{{- end }}

{{/*
Backend image based on deployment mode
*/}}
{{- define "jsonic.backend.image" -}}
  {{- include "jsonic.image" (dict "component" ((eq .Values.deploymentMode "aio") | ternary .Values.aio .Values.backend) "context" .) -}}
{{- end -}}

{{/*
Backend image pull policy based on deployment mode
*/}}
{{- define "jsonic.backend.imagePullPolicy" -}}
  {{- (eq .Values.deploymentMode "aio") | ternary .Values.aio.image.pullPolicy .Values.backend.image.pullPolicy -}}
{{- end -}}

{{/*
Generate Microsoft auth callback URL based on deployment mode and ingress configuration
*/}}
{{- define "jsonic.backend.microsoftCallbackUrl" -}}
  {{- if .Values.jsonic.backend.auth.microsoft.callbackUrl -}}
    {{- .Values.jsonic.backend.auth.microsoft.callbackUrl -}}
  {{- else -}}
    {{- include "jsonic.backend.authCallbackUrl" (dict "provider" "microsoft" "context" .) -}}
  {{- end -}}
{{- end }}

{{/*
Generate OIDC auth callback URL based on deployment mode and ingress configuration
*/}}
{{- define "jsonic.backend.oidcCallbackUrl" -}}
  {{- if .Values.jsonic.backend.auth.oidc.callbackUrl -}}
    {{- .Values.jsonic.backend.auth.oidc.callbackUrl -}}
  {{- else -}}
    {{- include "jsonic.backend.authCallbackUrl" (dict "provider" "oidc" "context" .) -}}
  {{- end -}}
{{- end }}

{{/*
Generate SAML auth callback URL based on deployment mode and ingress configuration
*/}}
{{- define "jsonic.backend.samlCallbackUrl" -}}
  {{- if .Values.jsonic.backend.auth.saml.callbackUrl -}}
    {{- .Values.jsonic.backend.auth.saml.callbackUrl -}}
  {{- else -}}
    {{- include "jsonic.backend.authCallbackUrl" (dict "provider" "saml" "context" .) -}}
  {{- end -}}
{{- end }}

{{/*
Generate readiness probe HTTP GET path
*/}}
{{- define "jsonic.backend.readinessProbePath" -}}
  {{- if eq .Values.deploymentMode "aio" -}}
    /backend/ping
  {{- else -}}
    /ping
  {{- end -}}
{{- end -}}

{{/*
Generate the redirect URL for the backend based on deployment mode and ingress configuration
*/}}
{{- define "jsonic.backend.redirectUrl" -}}
  {{- if .Values.jsonic.backend.redirectUrl -}}
    {{- .Values.jsonic.backend.redirectUrl -}}
  {{- else -}}
    {{- include "jsonic.frontend.baseUrl" . -}}
  {{- end -}}
{{- end -}}

{{/*
Generate whitelisted origins for the backend based on ingress configuration
*/}}
{{- define "jsonic.backend.whitelistedOrigins" -}}
  {{- if .Values.jsonic.backend.whitelistedOrigins -}}
    {{- .Values.jsonic.backend.whitelistedOrigins | join "," -}}
  {{- else -}}
    {{- $origins := list -}}
    {{- $frontendBaseUrl := urlParse (include "jsonic.frontend.baseUrl" .) -}}
    {{- if ne $frontendBaseUrl.host "" -}}
      {{- $origins = append $origins (printf "%s://%s" $frontendBaseUrl.scheme $frontendBaseUrl.host) -}}
      {{- $origins = append $origins (printf "app://%s" $frontendBaseUrl.host) -}}
    {{- end -}}
    {{- $backendBaseUrl := urlParse (include "jsonic.backend.baseUrl" .) -}}
    {{- if ne $backendBaseUrl.host "" -}}
      {{- $backendOrigin := (printf "%s://%s" $backendBaseUrl.scheme $backendBaseUrl.host) -}}
      {{- if not (has $backendOrigin $origins) -}}
        {{- $origins = append $origins $backendOrigin -}}
      {{- end -}}
    {{- end -}}
    {{- $adminBaseUrl := urlParse (include "jsonic.admin.baseUrl" .) -}}
    {{- if ne $adminBaseUrl.host "" -}}
      {{- $adminOrigin := (printf "%s://%s" $adminBaseUrl.scheme $adminBaseUrl.host) -}}
      {{- if not (has $adminOrigin $origins) -}}
        {{- $origins = append $origins $adminOrigin -}}
      {{- end -}}
    {{- end -}}
    {{- $origins | join "," -}}
  {{- end -}}
{{- end }}
