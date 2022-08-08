# https://github.com/bitnami/charts/tree/master/bitnami/wordpress
resource "helm_release" "wordpress" {
  depends_on = [kubernetes_namespace.namespaces, helm_release.mariadb]
  name       = "wordpress"
  namespace  = "tools"
  chart      = "wordpress"
  version    = "15.0.12"
  repository       = "https://charts.bitnami.com"

/*
  set {
    name  = "image.repository"
    value = "bitnami/wordpress-nginx"
  }
  set {
    name  = "image.tag"
    value = "6.0.1-debian-11-r3"
  }
  */
  set {
    name  = "wordpressUsername"
    value = var.username_wordpress
  }
  set {
    name  = "wordpressPassword"
    value = var.password_wordpress
  }
  set {
    name  = "wordpressEmail"
    value = "zvonimirbedi@gmail.com"
  }
  set {
    name  = "wordpressBlogName"
    value = "zvonimirbedi"
  }
  set {
    name  = "wordpressSkipInstall"
    value = "false"
  }
  set {
    name  = "allowEmptyPassword"
    value = "false"
  }
  set {
    name  = "multisite.enable"
    value = "true"
  }
  set {
    name  = "multisite.host"
    value = "zvonimirbedi.com"
  }
  set {
    name  = "multisite.networkType"
    value = "subdomain"
  }
  set {
    name  = "multisite.enableNipIoRedirect"
    value = "true"
  }
  set {
    name  = "persistence.enabled"
    value = "true"
  }
  set {
    name  = "persistence.existingClaim"
    value = var.wordpress_block_volume_name
  }  
  set {
    name  = "replicaCount"
    value = "1"
  }

  set {
    name  = "mariadb.enabled"
    value = "false"
  }

  set {
    name  = "externalDatabase.host"
    value = "mariadb-primary.databases.svc.cluster.local"
  }
  set {
    name  = "externalDatabase.port"
    value = "3306"
  }
  /*
  set {
    name  = "service.ports.http"
    value = "80"
  }
  set {
    name  = "service.ports.https"
    value = "443"
  }
  set {
    name  = "containerPorts.http"
    value = "80"
  }
  set {
    name  = "containerPorts.https"
    value = "443"
  }
  */
  set {
    name  = "externalDatabase.user"
    value = var.username_mariadb
  }
  set {
    name  = "externalDatabase.password"
    value = var.password_mariadb
  }
  set {
    name  = "externalDatabase.database"
    value = var.databasename_mariadb
  }
  set {
    name  = "wordpressPlugins"
    value = "jetpack\\, hyperdb"
  }
  set {
    name  = "service.type"
    value = "ClusterIP"
  }
  set {
    name  = "livenessProbe.initialDelaySeconds"
    value = "90"
  }
  set {
    name  = "readinessProbe.initialDelaySeconds"
    value = "90"
  }
  set {
    name  = "startupProbe.initialDelaySeconds"
    value = "90"
  }
}
