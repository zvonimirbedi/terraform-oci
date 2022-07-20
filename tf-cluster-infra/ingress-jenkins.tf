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
    }
  }
  spec {
    ingress_class_name = "nginx"

    rule {
      host = var.jenkins_url
      http {
        path {
          backend {
            service {
              name = helm_release.jenkins.name
              port {
                number = "80"
              }
            }
          }
        }
      }
    }
    rule {
      host = "www.${var.jenkins_url}"
      http {
        path {
          backend {
            service {
              name = helm_release.jenkins.name
              port {
                number = "443"
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