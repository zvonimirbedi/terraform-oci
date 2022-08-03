# https://github.com/bitnami/charts/tree/master/bitnami/mariadb/#installing-the-chart
resource "helm_release" "mariadb" {
  depends_on = [kubernetes_secret.namecheap_credentials]
  name       = "mariadb"
  namespace  = "databases"
  chart      = "mariadb"
  version    = "11.1.4"
  repository = "https://charts.bitnami.com"

  set {
    name  = "architecture"
    value = "replication"
  }
  set {
    name  = "auth.rootPassword"
    value = var.password_mariadb
  }
  set {
    name  = "auth.replicationUser"
    value = "replicator"
  }
  set {
    name  = "auth.replicationPassword"
    value = var.password_mariadb
  }
  set {
    name  = "auth.forcePassword"
    value = "true"
  }
  set {
    name  = "auth.database"
    value = var.databasename_mariadb
  }
  set {
    name  = "primary.persistence.enabled"
    value = "true"
  }
  set {
    name  = "primary.persistence.subPath"
    value = "mariadb-primary-home/"
  }
  set {
    name  = "primary.persistence.existingClaim"
    value = var.database_block_volume_name
  }
  set {
    name  = "secondary.persistence.enabled"
    value = "false"
  }
  set {
    name  = "secondary.replicaCount"
    value = "0"
  }
}
