resource "kubernetes_ingress_v1" "ingress_nginx_grafana" {
  metadata {
    name = "ingress-nginx-grafana"
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

    rule {
      host = var.grafana_url
      http {
        path {
          backend {
            service {
              name = helm_release.grafana.name
              port {
                number = "3000"
              }
            }
          }
        }
      }
    }
    rule {
      host = "www.${var.grafana_url}"
      http {
        path {
          backend {
            service {
              name = helm_release.grafana.name
              port {
                number = "3000"
              }
            }
          }
        }
      }
    }
    tls {
      secret_name = var.clusterissuer_zvonimirbedi
    }
  }
}