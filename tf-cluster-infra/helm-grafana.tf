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
    name  = "datasources.secretName"
    value =  kubernetes_secret_v1.datasource_secret.metadata[0].name
  }
  set {
    name  = "dashboardsProvider.enabled"
    value = "true"
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
    name  = "service.type"
    value = "ClusterIP"
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
        "name" : "$${DS_PROMETHEUS}",
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
    "configmap_grafana_dashboard_kubernetes_1.json" = data.http.configmap_grafana_dashboard_kubernetes_1.response_body
  }
}

data "http" "configmap_grafana_dashboard_kubernetes_1" {
  url = "https://grafana.com/api/dashboards/6417/revisions/1/download"

  request_headers = {
    Accept = "application/json"
  }
}