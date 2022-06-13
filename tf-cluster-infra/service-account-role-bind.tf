resource "kubernetes_cluster_role" "jenkins_role" {
  metadata {
    name = "jenkin-role"
  }

  rule {
    api_groups = [""]
    resources  = ["*"]
    verbs      = ["*"]
  }
}

resource "kubernetes_service_account" "jenkins_service_account" {
  metadata {
    name = "jenkins-service-account"
    namespace = "jenkins"
  }
}

resource "kubernetes_cluster_role_binding" "jenkins_role_binding" {
  metadata {
    name = "jenkins_role_binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "jenkins-role"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "jenkins-service-account"
    namespace = "jenkins"
  }
}