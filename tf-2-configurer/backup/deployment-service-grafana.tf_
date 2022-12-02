resource "kubernetes_deployment_v1" "grafana_deployment" {
  metadata {
    name = "grafana"
    labels = {
      app = "grafana"
    }
    namespace = "tools"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "grafana"
      }
    }
    template {
      metadata {
        labels = {
          app = "grafana"
        }
      }
      spec {
        container {
          image = "grafana/grafana"
          name  = "grafana"
          port {
            container_port = 3000
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

resource "kubernetes_service_v1" "grafana_service" {
  metadata {
    name      = "grafana-service"
    namespace = "tools"
  }
  spec {
    selector = {
      app = kubernetes_deployment_v1.grafana_deployment.metadata[0].name
    }
    port {
      port        = 3000
      target_port = 3000
      protocol    = "TCP"
    }
  }
  depends_on = [
    kubernetes_namespace.namespaces
  ]
}