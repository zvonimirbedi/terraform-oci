resource "kubernetes_deployment" "jenkins_deployment" {
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
        service_account_name = kubernetes_service_account.jenkins_service_account.metadata[0].name
      }
    }
  }
}

resource "kubernetes_service" "jenkins_service" {
  metadata {
    name      = "jenkins-service"
    namespace = "jenkins"
  }
  spec {
    selector = {
      app = "jenkins"
    }
    port {
      port        = 8080
      target_port = 80
      node_port   = 31600
    }
    type = "NodePort"
  }
}