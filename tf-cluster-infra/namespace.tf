resource "kubernetes_namespace" "namespaces" {
  for_each = toset(var.namespace_list)
  metadata {
    name = each.value
  }
}