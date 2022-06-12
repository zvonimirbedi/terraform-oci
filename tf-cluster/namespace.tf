provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "namespace" {
  for_each = {for namespace in ["jenkins","zvone-namespace"] : namespace => namespace}
  metadata {
    name = each.value
  }
  depends_on = [oci_containerengine_node_pool.zvone_cluster_node_pool]
}