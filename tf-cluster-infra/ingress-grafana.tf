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
    ingress_class_name = kubernetes_ingress_class_v1.ingress_class.metadata.0.name

    rule {
      host = var.grafana_url
      http {
        path {
          backend {
            service {
              name = kubernetes_service_v1.grafana_service.metadata.0.name
              port {
                number = kubernetes_service_v1.grafana_service.spec[0].port[0].target_port
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
              name = kubernetes_service_v1.grafana_service.metadata.0.name
              port {
                number = kubernetes_service_v1.grafana_service.spec[0].port[0].target_port
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