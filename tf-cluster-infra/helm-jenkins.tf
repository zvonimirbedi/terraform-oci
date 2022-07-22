# https://github.com/bitnami/charts/tree/master/bitnami/jenkins
resource "helm_release" "jenkins" {
  depends_on = [kubernetes_namespace.namespaces]
  name       = "jenkins"
  namespace  = "tools"
  chart            = "jenkins"
  repository       = "https://charts.bitnami.com"

  set {
    name  = "jenkinsUser"
    value = var.username_jenkins
  }
  set {
    name  = "jenkinsPassword"
    value = var.password_jenkins
  }
  set {
    name  = "jenkinsHome"
    value = "/bitnami/jenkins/home"
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
    name  = "service.type"
    value = "ClusterIP"
  }
}
