{{/*
Default init container that waits for the database to be ready.
*/}}
{{- define "jsonic.defaultInitContainers.waitForDatabase" -}}
- name: wait-for-db
  image: postgres:16-alpine
  command:
    - /bin/sh
  args:
    - -c
    - until pg_isready -d $DATABASE_URL; do sleep 3; done
  envFrom:
    - secretRef:
        name: {{ include "jsonic.secretName" . }}
{{- end -}}

{{/*
Default init container that waits for the database migrations to be complete.
*/}}
{{- define "jsonic.defaultInitContainers.waitForMigrations" -}}
- name: wait-for-migrations
  image: {{ include "jsonic.backend.image" . }}
  imagePullPolicy: {{ include "jsonic.backend.imagePullPolicy" . }}
  command:
    - /bin/sh
  args:
    - -c
    - until ./node_modules/.bin/prisma migrate status; do sleep 2; done
  envFrom:
    - secretRef:
        name: {{ include "jsonic.secretName" . }}
{{- end -}}
