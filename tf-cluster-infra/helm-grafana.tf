# https://github.com/bitnami/charts/tree/master/bitnami/grafana
resource "helm_release" "grafana" {
  depends_on = [kubernetes_namespace.namespaces]
  name       = "grafana"
  namespace  = "tools"
  chart            = "grafana"
  repository       = "https://charts.bitnami.com"

  set {
    name  = "admin.user"
    value = "root"
  }
  set {
    name  = "admin.password"
    value = "password"
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
}
