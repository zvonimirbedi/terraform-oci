output "test-output-2" {
  value = data.oci_containerengine_clusters.clusters_list.clusters[0].id
}

output "test-output" {
  value = data.oci_containerengine_node_pools.cluster_node_pool_1.node_pools[0]
}