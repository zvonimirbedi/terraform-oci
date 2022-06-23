resource "kubernetes_secret_v1" "secret_nginx" {
  metadata {
    name = "secret-nginx-basic-auth"
    namespace = "tools"
  }

  data = {
    auth = var.nginx_auth
  }

  type = "Opaque"
  depends_on = [
    kubernetes_namespace.namespaces
  ]
}