# https://github.com/bitnami/charts/tree/master/bitnami/grafana
resource "helm_release" "grafana" {
  depends_on = [kubernetes_namespace.namespaces]
  name       = "grafana"
  namespace  = "tools"
  chart      = "grafana"
  version    = "8.0.5"
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
}
