# https://github.com/bitnami/charts/tree/master/bitnami/redis
resource "helm_release" "redis" {
  depends_on = [null_resource.trigger_cronjob_bucket_to_volume_tools]
  name       = "redis"
  namespace  = "databases"
  chart      = "redis"
  version    = "17.0.7"
  repository = "https://charts.bitnami.com"

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
    value = var.password_redis
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
    value = kubernetes_persistent_volume_claim_v1.cluster_databases_persistent_volume_claim.metadata[0].name
  }
  set {
    name  = "replica.persistence.enabled"
    value = "false"
  }
  set {
    name  = "replica.replicaCount"
    value = "0"
  }
  set {
    name  = "metrics.enabled"
    value = "true"
  }
}
