# https://github.com/bitnami/charts/tree/master/bitnami/mariadb/#installing-the-chart
resource "helm_release" "jenkins" {
  depends_on = [kubernetes_secret.namecheap_credentials]
  name       = "jenkins"
  namespace  = "tools"
  chart            = "jenkins"
  repository       = "https://charts.bitnami.com"

  set {
    name  = "jenkinsUser"
    value = "root"
  }
  set {
    name  = "jenkinsPassword"
    value = "password"
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
    name  = "persistence.subPath"
    value = "jenkins-home/"
  }
  set {
    name  = "service.type"
    value = "ClusterIP"
  }
}
