resource "kubernetes_namespace" "namespace" {
  for_each = toset(["jenkins","zvone-namespace"])
  metadata {
    name = each.value
  }
}