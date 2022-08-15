# https://github.com/bitnami/charts/tree/master/bitnami/mariadb/#installing-the-chart
resource "helm_release" "mariadb" {
  depends_on = [kubernetes_namespace.namespaces, null_resource.trigger_cronjob_bucket_to_volume_databases]
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
    value = kubernetes_persistent_volume_claim_v1.cluster_databases_persistent_volume_claim.metadata[0].name
  }
  set {
    name  = "secondary.persistence.enabled"
    value = "false"
  }
  set {
    name  = "secondary.replicaCount"
    value = "0"
  }
  set {
    name  = "metrics.enabled"
    value = "true"
  }
  set {
    name  = "initdbScriptsConfigMap"
    value = kubernetes_config_map_v1.configmap_mariadb_init_script.metadata[0].name
  }
}


resource "kubernetes_config_map_v1" "configmap_mariadb_init_script" {
  depends_on = [kubernetes_namespace.namespaces]
  metadata {
    namespace = "databases"
    name = "configmap-mariadb-init-script"
  }
  data = {
    "my2_80.sql" = data.http.configmap_mariadb_init_script.response_body
  }
}
# https://github.com/meob/my2Collector
data "http" "configmap_mariadb_init_script" {
  url = "https://raw.githubusercontent.com/meob/my2Collector/master/my2_80.sql"

  request_headers = {
    Accept = "application/json"
  }
}