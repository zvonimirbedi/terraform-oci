resource "kubernetes_deployment_v1" "jenkins_deployment" {
  metadata {
    name = "jenkins"
    labels = {
      app = "jenkins"
    }
    namespace = "jenkins"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "jenkins"
      }
    }
    template {
      metadata {
        labels = {
          app = "jenkins"
        }
      }
      spec {
        container {
          image = "jenkins/jenkins:lts"
          name  = "jenkins"
          port {
            container_port = 8080
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

resource "kubernetes_service_v1" "jenkins_service" {
  metadata {
    name      = "jenkins-service"
    namespace = "jenkins"
  }
  spec {
    selector = {
      app = kubernetes_deployment_v1.jenkins_deployment.metadata[0].name
    }
    port {
      port        = 8080
      target_port = 8080
      protocol    = "TCP"
    }
  }
  depends_on = [
    kubernetes_namespace.namespaces
  ]
}