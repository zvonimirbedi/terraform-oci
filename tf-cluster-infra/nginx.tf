resource "kubernetes_deployment_v1" "ingress_nginx_controller_deployment" {
  metadata {
    name = "ingress-nginx-controller"
    labels = {
      app = "ingress-nginx-controller"
    }
    namespace = "tools"
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
          namespace = "tools"
        }
      }
      spec {
        container {
          image = "k8s.gcr.io/ingress-nginx/controller:v1.2.0@sha256:d8196e3bc1e72547c5dec66d6556c0ff92a23f6d0919b206be170bc90d5f9185"
          name  = "ingress-nginx-controller"
           args = []
          
          env {
            name = "POD_NAME"
            value_from {
              field_ref {
                field_path = "metadata.name"
              }
            }
          }
          env {
            name = "POD_NAMESPACE"
            value_from {
              field_ref {
                field_path = "metadata.namespace"
              }
            }
          }
          port {
            container_port = 80
          }
        }
      service_account_name = kubernetes_service_account_v1.admin_service_account.metadata[0].name
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
    namespace = "tools"
  }
  spec {
    external_traffic_policy = "Local"
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
    controller = "k8s.io/ingress-nginx"
  }
}