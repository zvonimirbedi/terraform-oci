resource "kubernetes_ingress_v1" "ingress_nginx_default_backend" {
  metadata {
    name = "ingress-nginx-default-backend"
    namespace = "tools"
    annotations = {
      # type of authentication
      "nginx.ingress.kubernetes.io/auth-type" = "basic"
      "nginx.ingress.kubernetes.io/auth-secret" = kubernetes_secret_v1.secret_nginx.metadata.0.name
      "nginx.ingress.kubernetes.io/auth-realm" = "Authentication Required - zvonimirbedi"
      "nginx.ingress.kubernetes.io/rewrite-target" = "/"
    }
  }
  spec {
    ingress_class_name = "nginx"

    default_backend {
      service {
        name = "wordpress"
        port {
          number = "8080"
        }
      }
    }
  }
}