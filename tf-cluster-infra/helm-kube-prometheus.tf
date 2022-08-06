# https://github.com/bitnami/charts/tree/master/bitnami/kube-prometheus
resource "helm_release" "kube-prometheus" {
  depends_on = [kubernetes_namespace.namespaces]
  name       = "kube-prometheus"
  namespace  = "networks"
  chart      = "kube-prometheus"
  version    = "8.0.12"
  repository = "https://charts.bitnami.com"

  set {
    name  = "blackboxExporter.enabled"
    value = "false"
  }
  set {
    name  = "exporters.kube-state-metrics.enabled"
    value = "true"
  }
  set {
    name  = "exporters.node-exporter.enabled"
    value = "true"
  }
  set {
    name  = "operator.enabled"
    value = "true"
  }
  set {
    name  = "alertmanager.enabled"
    value = "false"
  }
  set {
    name  = "prometheus.enabled"
    value = "true"
  }
  set {
    name  = "prometheus.additionalScrapeConfigs.enabled"
    value = "true"
  }
  set {
    name  = "prometheus.additionalScrapeConfigs.type"
    value = "internal"
  }
  set {
    name  = "prometheus.additionalScrapeConfigs.internal.jobList"
    value = yamlencode([
              {
                "job_name" : "mariadb_master_metrics",
                "static_configs" : [
                  {
                    "targets" : ["mariadb-primary.databases.svc.cluster.local:9104"]
                  }
                ]
              },
              {
                "job_name" : "mariadb_slave_metrics",
                "static_configs" : [
                  {
                    "targets" : ["mariadb-secondary.databases.svc.cluster.local:9104"]
                  }
                ]
              },
              {
                "job_name" : "redis_metrics",
                "static_configs" : [
                  {
                    "targets" : ["redis-metrics.databases.svc.cluster.local:9121"]
                  }
                ]
              }
          ])
  }
}