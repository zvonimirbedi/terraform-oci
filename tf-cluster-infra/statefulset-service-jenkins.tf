resource "kubernetes_stateful_set_v1" "jenkins_stateful_set" {
  metadata {
    name = "jenkins"
    labels = {
      app = "jenkins"
    }
    namespace = "tools"
  }
  spec {
    service_name = "jenkins"
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
        service_account_name = kubernetes_service_account_v1.admin_service_account.metadata[0].name
        
        init_container {
          name              = "init-chown-data"
          image             = "busybox:latest"
          image_pull_policy = "IfNotPresent"
          command           = ["chown", "-R", "1000:1000", "/var/jenkins_home"]

          volume_mount {
            name       = "jenkins-home"
            mount_path = "/var/jenkins_home"
            sub_path   = ""
          }
        }

        container {
          image = "jenkins/jenkins:lts"
          name  = "jenkins"
          port {
            container_port = 8080
            name = "jenkins"
          } 


          volume_mount {
            name       = "jenkins-home"
            mount_path = "/var/jenkins_home"
            sub_path   = "jenkins-home/"
          }

        }
        
        volume {
          name = "jenkins-home"
          persistent_volume_claim {
            claim_name = "cluster-persistent-volume-claim"
          }
        }
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
    namespace = "tools"
  }
  spec {
    selector = {
      app = kubernetes_stateful_set_v1.jenkins_stateful_set.metadata[0].name
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