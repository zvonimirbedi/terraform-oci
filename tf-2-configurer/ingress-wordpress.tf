resource "kubernetes_ingress_v1" "ingress_nginx_wordpress" {
  metadata {
    name = "ingress-nginx-wordpress"
    namespace = "tools"
    annotations = {
      # type of authentication  
      # "nginx.ingress.kubernetes.io/rewrite-target" = "/"    
      "nginx.ingress.kubernetes.io/proxy-body-size" = "300m"  
    }
  }
  spec {
    ingress_class_name = "nginx"

    rule {
      host = var.wordpress_url
      http {
        path {
          backend {
            service {
              name = helm_release.wordpress.name
              port {
                number = "80"
              }
            }
          }
        }
      }
    }
    rule {
      host = "www.${var.wordpress_url}"
      http {
        path {
          backend {
            service {
              name = helm_release.wordpress.name
              port {
                number = "80"
              }
            }
          }
        }
      }
    }
    rule {
      host = "*.${var.wordpress_url}"
      http {
        path {
          backend {
            service {
              name = helm_release.wordpress.name
              port {
                number = "80"
              }
            }
          }
        }
      }
    }
    tls {
      secret_name = var.clusterissuer_astorx
    }
  }
}