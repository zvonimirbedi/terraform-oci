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
    value = "false"
  }
  set {
    name  = "alertmanager.enabled"
    value = "false"
  }
  set {
    name  = "prometheus.enabled"
    value = "true"
  }
}
