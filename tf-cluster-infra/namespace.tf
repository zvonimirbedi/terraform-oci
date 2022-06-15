resource "kubernetes_namespace" "namespaces" {
  for_each = toset(["jenkins","zvone-namespace"])
  metadata {
    name = each.value
  }
}