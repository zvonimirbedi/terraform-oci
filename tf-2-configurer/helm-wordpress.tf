# https://github.com/bitnami/charts/tree/master/bitnami/wordpress
resource "helm_release" "wordpress" {
  depends_on = [kubernetes_namespace.namespaces]
  name       = "wordpress"
  namespace  = "tools"
  chart      = "wordpress"
  version    = "17.0.0"
  repository       = "https://charts.bitnami.com/bitnami"

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
    value = "astorx"
  }
  set {
    name  = "wordpressSkipInstall"
    value = "true"
  }
  set {
    name  = "wordpressExtraConfigContent"
    value = "define('FORCE_SSL_ADMIN'\\, false);"
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
    value = "astorx.com"
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
    value = kubernetes_persistent_volume_claim_v1.cluster_wordpress_persistent_volume_claim.metadata[0].name
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
    value = "jetpack\\, elementor\\, header-footer-elementor\\, ultimate-addons-for-gutenberg\\, hyperdb"
  }
  set {
    name  = "service.type"
    value = "ClusterIP"
  }
  set {
    name  = "livenessProbe.initialDelaySeconds"
    value = "60"
  }
  set {
    name  = "readinessProbe.initialDelaySeconds"
    value = "60"
  }
  set {
    name  = "startupProbe.initialDelaySeconds"
    value = "60"
  }
}
