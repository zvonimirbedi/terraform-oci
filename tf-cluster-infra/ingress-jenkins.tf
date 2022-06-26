resource "kubernetes_ingress_v1" "ingress_nginx_jenkins" {
  metadata {
    name = "ingress-nginx-jenkins"
    namespace = "tools"
    annotations = {
      # type of authentication
      "nginx.ingress.kubernetes.io/auth-type" = "basic"
      "nginx.ingress.kubernetes.io/auth-secret" = kubernetes_secret_v1.secret_nginx.metadata.0.name
      "nginx.ingress.kubernetes.io/auth-realm" = "Authentication Required - zvonimirbedi"
      "nginx.ingress.kubernetes.io/rewrite-target" = "/"
      "cert-manager.io/cluster-issuer" = var.clusterissuer_jenkins
      "nginx.ingress.kubernetes.io/rewrite-target" = "/"
    }
  }
  spec {
    ingress_class_name = kubernetes_ingress_class_v1.ingress_class.metadata.0.name

    rule {
      host = var.jenkins_url
      http {
        path {
          backend {
            service {
              name = kubernetes_service_v1.jenkins_service.metadata.0.name
              port {
                number = kubernetes_service_v1.jenkins_service.spec[0].port[0].target_port
              }
            }
          }
        }
      }
    }
    rule {
      host = join(".", ["www", var.jenkins_url])
      http {
        path {
          backend {
            service {
              name = kubernetes_service_v1.jenkins_service.metadata.0.name
              port {
                number = kubernetes_service_v1.jenkins_service.spec[0].port[0].target_port
              }
            }
          }
        }
      }
    }
    tls {
      hosts = [var.jenkins_url, join(".", ["www", var.jenkins_url])]
      secret_name = var.clusterissuer_jenkins
    }
  }
}