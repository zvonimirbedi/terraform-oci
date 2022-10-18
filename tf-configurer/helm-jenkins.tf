# https://github.com/bitnami/charts/tree/master/bitnami/jenkins
resource "helm_release" "jenkins" {
  //depends_on = [null_resource.trigger_cronjob_bucket_to_volume_tools]
  name       = "jenkins"
  namespace  = "tools"
  chart      = "jenkins"
  version    = "10.2.4"
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
    value = kubernetes_persistent_volume_claim_v1.cluster_tools_persistent_volume_claim.metadata[0].name
  }
  set {
    name  = "service.type"
    value = "ClusterIP"
  }  
  set {
    name  = "livenessProbe.initialDelaySeconds"
    value = "200"
  }
  set {
    name  = "readinessProbe.initialDelaySeconds"
    value = "60"
  }
  set {
    name  = "startupProbe.initialDelaySeconds"
    value = "200"
  }
}
