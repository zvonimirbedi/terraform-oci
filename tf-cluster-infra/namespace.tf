resource "kubernetes_namespace" "namespaces" {
  for_each = toset(var.namespace_list)
  metadata {
    name = each.value
  }
}

# add delay on destroy because of errors on destroy finish
resource "time_sleep" "wait_30_seconds" {
  depends_on = [kubernetes_namespace.namespaces]
  destroy_duration = "30s"
}
