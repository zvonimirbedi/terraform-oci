resource "kubernetes_cluster_role_v1" "admin_role" {
  metadata {
    name = "admin-role"
  }

  rule {
    api_groups = ["*"]
    resources  = ["*"]
    verbs      = ["*"]
  }
}

resource "kubernetes_service_account_v1" "admin_service_account" {
  metadata {
    name = "admin-service-account"
    namespace = "tools"
  }
  depends_on = [
    kubernetes_namespace.namespaces
  ]
}

resource "kubernetes_cluster_role_binding_v1" "admin_role_binding" {
  metadata {
    name = "admin_role_binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role_v1.admin_role.metadata.0.name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account_v1.admin_service_account.metadata.0.name
    namespace = "tools"
  }
}