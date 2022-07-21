# https://github.com/bitnami/charts/tree/master/bitnami/redis
resource "helm_release" "redis" {
  depends_on = [kubernetes_namespace.namespaces]
  name       = "redis"
  namespace  = "databases"
  chart            = "redis"
  repository       = "https://charts.bitnami.com"

  set {
    name  = "architecture"
    value = "replication"
  }
  set {
    name  = "auth.enabled"
    value = "true"
  }
  set {
    name  = "auth.password"
    value = "password"
  }
  set {
    name  = "master.count"
    value = "1"
  }
  set {
    name  = "master.persistence.enabled"
    value = "true"
  }
  set {
    name  = "master.persistence.subPath"
    value = "redis-master-home/"
  }
  set {
    name  = "master.persistence.existingClaim"
    value = var.database_block_volume_name
  }
  set {
    name  = "replica.persistence.enabled"
    value = "false"
  }
  set {
    name  = "replica.replicaCount"
    value = "0"
  }
}
