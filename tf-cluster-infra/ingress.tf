resource "kubernetes_deployment_v1" "ingress_nginx_controller_deployment" {
  metadata {
    name = "ingress-nginx-controller"
    labels = {
      app = "ingress-nginx-controller"
    }
    namespace = "jenkins"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "ingress-nginx-controller"
      }
    }
    template {
      metadata {
        labels = {
          app = "ingress-nginx-controller"
          namespace = "jenkins"
        }
      }
      spec {
        container {
          image = "nginx/nginx-ingress:2.2.2"
          name  = "ingress-nginx-controller"
           args = [
            "--v=3",
            "--report-ingress-status", 
            "--enable-leader-election=false"
          ]
          port {
            container_port = 80
          }
        }
      service_account_name = kubernetes_service_account_v1.jenkins_service_account.metadata[0].name
      }
    }
  }
  depends_on = [
    kubernetes_namespace.namespaces
  ]
}

resource "kubernetes_service_v1" "ingress_service" {
  metadata {
    name = "ingress-service"
    namespace = "jenkins"
  }
  spec {
    selector = {
      app = kubernetes_deployment_v1.ingress_nginx_controller_deployment.metadata.0.name
    }
    port {
      port        = 80
      target_port = 80
      node_port   = 31600
      protocol    = "TCP"
    }
    type = "NodePort"
  }
}

resource "kubernetes_ingress_class_v1" "ingress_class" {
  metadata {
    name = "nginx"
  }

  spec {
    controller = "nginx.org/ingress-controller"
  }
}

resource "kubernetes_ingress_v1" "ingress_nginx" {
  metadata {
    name = "ingress-nginx"
    namespace = "jenkins"
  }
  spec {
    ingress_class_name = kubernetes_ingress_class_v1.ingress_class.metadata.0.name

    default_backend {
      service {
        name = kubernetes_service_v1.jenkins_service.metadata.0.name
        port {
          number = kubernetes_service_v1.jenkins_service.spec[0].port[0].target_port
        }
      }
    }

    rule {
      host = "jenkins.zvonimirbedi.com"
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
      host = "grafana.zvonimirbedi.com"
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
  }
}