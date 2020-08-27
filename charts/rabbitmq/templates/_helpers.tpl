{{/*
Defines a JSON file containing definitions of all broker objects (queues, exchanges, bindings, 
users, virtual hosts, permissions and parameters) to load by the management plugin.
*/}}
{{- define "rabbitmq-ha.definitions" -}}
{
  "global_parameters": [
    {
        "name": "cluster_name",
        "value": {{ .Values.clusterName | quote }}
    }
  ],
  "users": [
    {
      "name": {{ .Values.rabbitmq.username | quote }},
      "password": {{ .Values.rabbitmq.password | quote }},
      "tags": "administrator"
    }
  ],
  "vhosts": [
    {
      "name": {{ .Values.rabbitmq.vhost | quote }}
    }
  ],
  "permissions": [
    {
      "user": {{ .Values.rabbitmq.username | quote }},
      "vhost": {{ .Values.rabbitmq.vhost | quote }},
      "configure": ".*",
      "read": ".*",
      "write": ".*"
    }
  ],
  "policies": [
    {
      "name": "ha-all",
      "pattern": ".*",
      "vhost": {{ .Values.rabbitmq.vhost | quote }},
      "definition": {
        "ha-mode": "all",
        "ha-sync-mode": "automatic",
        "ha-sync-batch-size": 1
      }
    }
  ]
}
{{- end -}}