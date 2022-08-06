# https://github.com/bitnami/charts/tree/master/bitnami/grafana
resource "helm_release" "grafana" {
  depends_on = [kubernetes_namespace.namespaces]
  name       = "grafana"
  namespace  = "tools"
  chart      = "grafana"
  version    = "8.0.7"
  repository       = "https://charts.bitnami.com"

  set {
    name  = "admin.user"
    value = var.username_grafana
  }
  set {
    name  = "admin.password"
    value = var.password_grafana
  }
  set {
    name  = "ingress.enabled"
    value = "false"
  }
  set {
    name  = "persistence.enabled"
    value = "true"
  }
  set {
    name  = "persistence.existingClaim"
    value = var.tools_block_volume_name
  }
  set {
    name  = "persistence.subPath"
    value = "grafana-home/"
  }
  set {
    name  = "service.type"
    value = "ClusterIP"
  }
  set {
    name  = "dashboardsProvider.enabled"
    value = "true"
  }
  set {
    name  = "datasources.secretName"
    value =  kubernetes_secret_v1.datasource_secret.metadata[0].name
  }
  set {
    name  = "plugins"
    value =  "redis-datasource"
  }
  
  set {
    name  = "dashboardsConfigMaps[0].configMapName"
    value =  kubernetes_config_map_v1.configmap_grafana_dashboard_kubernetes_1.metadata[0].name
  }
  set {
    name  = "dashboardsConfigMaps[0].fileName"
    value =  "configmap_grafana_dashboard_kubernetes_1.json" 
  }  
  set {
    name  = "dashboardsConfigMaps[1].configMapName"
    value =  kubernetes_config_map_v1.configmap_grafana_dashboard_kubernetes_2.metadata[0].name
  }
  set {
    name  = "dashboardsConfigMaps[1].fileName"
    value =  "configmap_grafana_dashboard_kubernetes_2.json" 
  }
  
  set {
    name  = "dashboardsConfigMaps[2].configMapName"
    value =  kubernetes_config_map_v1.configmap_grafana_dashboard_redis_1.metadata[0].name
  }
  set {
    name  = "dashboardsConfigMaps[2].fileName"
    value =  "configmap_grafana_dashboard_redis_1.json" 
  }  
  set {
    name  = "dashboardsConfigMaps[3].configMapName"
    value =  kubernetes_config_map_v1.configmap_grafana_dashboard_redis_2.metadata[0].name
  }
  set {
    name  = "dashboardsConfigMaps[3].fileName"
    value =  "configmap_grafana_dashboard_redis_2.json" 
  }    
  set {
    name  = "dashboardsConfigMaps[4].configMapName"
    value =  kubernetes_config_map_v1.configmap_grafana_dashboard_mariadb_1.metadata[0].name
  }
  set {
    name  = "dashboardsConfigMaps[4].fileName"
    value =  "configmap_grafana_dashboard_mariadb_1.json" 
  }      
  set {
    name  = "dashboardsConfigMaps[5].configMapName"
    value =  kubernetes_config_map_v1.configmap_grafana_dashboard_mariadb_2.metadata[0].name
  }
  set {
    name  = "dashboardsConfigMaps[5].fileName"
    value =  "configmap_grafana_dashboard_mariadb_2.json" 
  }       
  set {
    name  = "dashboardsConfigMaps[6].configMapName"
    value =  kubernetes_config_map_v1.configmap_grafana_dashboard_mariadb_3.metadata[0].name
  }
  set {
    name  = "dashboardsConfigMaps[6].fileName"
    value =  "configmap_grafana_dashboard_mariadb_3.json" 
  }  
}


resource "kubernetes_secret_v1" "datasource_secret" {
  metadata {
    namespace = "tools"
    name = "datasource-secret"
  }

  data = {
    "datasources.yaml" = yamlencode({
      "datasources" : [
        {
        "name" : "prometheus",
        "type" : "prometheus", 
        "url" : "http://kube-prometheus-prometheus.networks.svc.cluster.local:9090",
        "access" : "proxy",
        "editable" : true,
        "httpMethod" : "POST"
        "orgId" : 1,
        "basicAuth" : false
        "jsonData" : {
          "timeInterval" : "5s"
          }
        },
        {
        "name" : "mariadb-master",
        "type" : "mysql", 
        "url" : "mariadb-primary.databases.svc.cluster.local:3306",
        "database" : "wordpress",
        "editable" : true,
        "user" : var.username_mariadb,
        "secureJsonData" : {
          "password" : var.password_mariadb
        }
        "orgId" : 1,
        "jsonData" : {
          "timeInterval" : "5s"
          }
        },
        {
        "name" : "redis",
        "type" : "redis-datasource", 
        "url" : "redis-master.databases.svc.cluster.local:6379",
        "access" : "proxy",
        "editable" : true,
        "isDefault" : true,
        "orgId" : 1,
        "secureJsonData" : {
          "password" : var.password_redis
        }
        "jsonData" : {
          "client" : "standalone",
          "poolSize" : "5",
          "timeout" : "10",
          "pingInterval" : "0",
          "pipelineWindow" : "0"
          }
        }
      ]
    })
  }
  type = "Opaque"
}

resource "kubernetes_config_map_v1" "configmap_grafana_dashboard_kubernetes_1" {
  depends_on = [kubernetes_namespace.namespaces]
  metadata {
    namespace = "tools"
    name = "configmap-grafana-dashboard-kubernetes-1"
  }
  data = {
    "configmap_grafana_dashboard_kubernetes_1.json" = replace(data.http.configmap_grafana_dashboard_kubernetes_1.response_body, "$${DS_PROMETHEUS}","prometheus")
  }
}

data "http" "configmap_grafana_dashboard_kubernetes_1" {
  url = "https://grafana.com/api/dashboards/15760/revisions/1/download"

  request_headers = {
    Accept = "application/json"
  }
}

resource "kubernetes_config_map_v1" "configmap_grafana_dashboard_kubernetes_2" {
  depends_on = [kubernetes_namespace.namespaces]
  metadata {
    namespace = "tools"
    name = "configmap-grafana-dashboard-kubernetes-2"
  }
  data = {
    "configmap_grafana_dashboard_kubernetes_2.json" = replace(data.http.configmap_grafana_dashboard_kubernetes_2.response_body, "$${DS_PROMETHEUS}","prometheus")
  }
}

data "http" "configmap_grafana_dashboard_kubernetes_2" {
  url = "https://grafana.com/api/dashboards/15479/revisions/1/download"

  request_headers = {
    Accept = "application/json"
  }
}

resource "kubernetes_config_map_v1" "configmap_grafana_dashboard_redis_1" {
  depends_on = [kubernetes_namespace.namespaces]
  metadata {
    namespace = "tools"
    name = "configmap-grafana-dashboard-redis-1"
  }
  data = {
    "configmap_grafana_dashboard_redis_1.json" = replace(data.http.configmap_grafana_dashboard_redis_1.response_body, "$${DS_REDIS}","redis")
  }
}

data "http" "configmap_grafana_dashboard_redis_1" {
  url = "https://grafana.com/api/dashboards/12776/revisions/1/download"

  request_headers = {
    Accept = "application/json"
  }
}

resource "kubernetes_config_map_v1" "configmap_grafana_dashboard_redis_2" {
  depends_on = [kubernetes_namespace.namespaces]
  metadata {
    namespace = "tools"
    name = "configmap-grafana-dashboard-redis-2"
  }
  data = {
    "configmap_grafana_dashboard_redis_2.json" = replace(data.http.configmap_grafana_dashboard_redis_2.response_body, "$${DS_PROMETHEUS}","prometheus")
  }
}

data "http" "configmap_grafana_dashboard_redis_2" {
  url = "https://grafana.com/api/dashboards/11835/revisions/1/download"

  request_headers = {
    Accept = "application/json"
  }
}

resource "kubernetes_config_map_v1" "configmap_grafana_dashboard_mariadb_1" {
  depends_on = [kubernetes_namespace.namespaces]
  metadata {
    namespace = "tools"
    name = "configmap-grafana-dashboard-mariadb-1"
  }
  data = {
    "configmap_grafana_dashboard_mariadb_1.json" = replace(data.http.configmap_grafana_dashboard_mariadb_1.response_body, "$${DS_PROMETHEUS}","prometheus")
  }
}

data "http" "configmap_grafana_dashboard_mariadb_1" {
  url = "https://grafana.com/api/dashboards/7362/revisions/1/download"

  request_headers = {
    Accept = "application/json"
  }
}

resource "kubernetes_config_map_v1" "configmap_grafana_dashboard_mariadb_2" {
  depends_on = [kubernetes_namespace.namespaces]
  metadata {
    namespace = "tools"
    name = "configmap-grafana-dashboard-mariadb-2"
  }
  data = {
    "configmap_grafana_dashboard_mariadb_2.json" = replace(data.http.configmap_grafana_dashboard_mariadb_2.response_body, "$${DS_MYMYSQL}","mariadb-master")
  }
}

data "http" "configmap_grafana_dashboard_mariadb_2" {
  url = "https://grafana.com/api/dashboards/11679/revisions/1/download"

  request_headers = {
    Accept = "application/json"
  }
}
resource "kubernetes_config_map_v1" "configmap_grafana_dashboard_mariadb_3" {
  depends_on = [kubernetes_namespace.namespaces]
  metadata {
    namespace = "tools"
    name = "configmap-grafana-dashboard-mariadb-3"
  }
  data = {
    "configmap_grafana_dashboard_mariadb_3.json" = replace(data.http.configmap_grafana_dashboard_mariadb_3.response_body, "$${DS_MYMYSQL}","mariadb-master")
  }
}
# https://github.com/meob/my2Collector
data "http" "configmap_grafana_dashboard_mariadb_3" {
  url = "https://grafana.com/api/dashboards/7371/revisions/1/download"

  request_headers = {
    Accept = "application/json"
  }
}