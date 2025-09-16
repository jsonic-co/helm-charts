{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "jsonic.chart" -}}
  {{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a fully qualified name that includes the release name and chart name.
*/}}
{{- define "jsonic.fullname" -}}
  {{- if .Values.fullnameOverride -}}
    {{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
  {{- else -}}
    {{- $name := default .Chart.Name .Values.nameOverride -}}
    {{- $releaseName := regexReplaceAll "(-?[^a-z\\d\\-])+-?" (lower .Release.Name) "-" -}}
    {{- if contains $name $releaseName -}}
      {{- $releaseName | trunc 63 | trimSuffix "-" -}}
    {{- else -}}
      {{- printf "%s-%s" $releaseName $name | trunc 63 | trimSuffix "-" -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{/*
Checks if annotations include cert-manager requests
Usage: {{ include "jsonic.hasCertManagerRequest" ( dict "annotations" .Values.aio.ingress.annotations ) }}
*/}}
{{- define "jsonic.hasCertManagerRequest" -}}
  {{ if or (hasKey .annotations "cert-manager.io/cluster-issuer") (hasKey .annotations "cert-manager.io/issuer") (hasKey .annotations "kubernetes.io/tls-acme") }}
    {{- true -}}
  {{- end -}}
{{- end -}}

{{/*
Image name and tag for component resources. Chart app version is used as a default tag if not specified.
Usage: {{ include "jsonic.image" (dict "component" .Values.frontend "context" .) }}
*/}}
{{- define "jsonic.image" -}}
  {{- printf "%s:%s" .component.image.repository (default .context.Chart.AppVersion .component.image.tag) -}}
{{- end -}}

{{/*
Generate base URL from ingress resource
Usage: {{ include "jsonic.ingressBaseUrl" .Values.aio.ingress }}
*/}}
{{- define "jsonic.ingressBaseUrl" -}}
  {{- .enabled | ternary (urlJoin (dict "scheme" (.tls | ternary "https" "http") "host" .hostname "path" (.path | trimSuffix "/"))) "" -}}
{{- end -}}

{{/*
Return common labels for all resources.
*/}}
{{- define "jsonic.labels" -}}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/name: {{ include "jsonic.name" . }}
app.kubernetes.io/part-of: {{ template "jsonic.name" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
helm.sh/chart: {{ include "jsonic.chart" . }}
{{- if .Values.commonLabels}}
{{ toYaml .Values.commonLabels }}
{{- end -}}
{{- end -}}

{{/*
Allow the chart name to be overridden.
*/}}
{{- define "jsonic.name" -}}
  {{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Allow the release namespace to be overridden.
*/}}
{{- define "jsonic.namespace" -}}
  {{- default .Release.Namespace .Values.namespaceOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the appropriate resource configuration based on resources preset or custom resources
Usage: {{ include "jsonic.resources" (dict "preset" .Values.aio.resourcesPreset "resources" .Values.aio.resources) }}
*/}}
{{- define "jsonic.resources" -}}
  {{- $preset := .preset -}}
  {{- $resources := .resources -}}
  {{- if $resources -}}
    {{- toYaml $resources -}}
  {{- else if $preset -}}
    {{- include "jsonic.resourcesPreset" (dict "preset" $preset) -}}
  {{- end -}}
{{- end -}}

{{/*
Return predefined resource configurations based on preset name
Usage: {{ include "jsonic.resourcesPreset" (dict "preset" .Values.aio.resourcesPreset) }}
*/}}
{{- define "jsonic.resourcesPreset" -}}
{{- $preset := .preset -}}
{{- if eq $preset "nano" -}}
limits:
  cpu: 150m
  ephemeral-storage: 2Gi
  memory: 192Mi
requests:
  cpu: 100m
  ephemeral-storage: 50Mi
  memory: 128Mi
{{- else if eq $preset "micro" -}}
limits:
  cpu: 250m
  ephemeral-storage: 2Gi
  memory: 256Mi
requests:
  cpu: 125m
  ephemeral-storage: 50Mi
  memory: 192Mi
{{- else if eq $preset "small" -}}
limits:
  cpu: 500m
  ephemeral-storage: 2Gi
  memory: 512Mi
requests:
  cpu: 250m
  ephemeral-storage: 50Mi
  memory: 256Mi
{{- else if eq $preset "medium" -}}
limits:
  cpu: 1000m
  ephemeral-storage: 2Gi
  memory: 1Gi
requests:
  cpu: 500m
  ephemeral-storage: 50Mi
  memory: 512Mi
{{- else if eq $preset "large" -}}
limits:
  cpu: 2000m
  ephemeral-storage: 4Gi
  memory: 2Gi
requests:
  cpu: 1000m
  ephemeral-storage: 50Mi
  memory: 1Gi
{{- else if eq $preset "xlarge" -}}
limits:
  cpu: 4000m
  ephemeral-storage: 8Gi
  memory: 4Gi
requests:
  cpu: 2000m
  ephemeral-storage: 50Mi
  memory: 2Gi
{{- else if eq $preset "2xlarge" -}}
limits:
  cpu: 8000m
  ephemeral-storage: 16Gi
  memory: 8Gi
requests:
  cpu: 4000m
  ephemeral-storage: 50Mi
  memory: 4Gi
{{- else -}}
limits:
  cpu: 150m
  ephemeral-storage: 2Gi
  memory: 192Mi
requests:
  cpu: 100m
  ephemeral-storage: 50Mi
  memory: 128Mi
{{- end -}}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "jsonic.selectorLabels" -}}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/name: {{ include "jsonic.name" . }}
{{- end -}}

{{/*
Return the service account name to use.
*/}}
{{- define "jsonic.serviceAccountName" -}}
  {{- if .Values.serviceAccount.create -}}
    {{- default (include "jsonic.fullname" .) .Values.serviceAccount.name -}}
  {{- else -}}
    {{- default "default" .Values.serviceAccount.name -}}
  {{- end -}}
{{- end -}}
