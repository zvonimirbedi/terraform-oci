resource "oci_core_volume_attachment" "volume_attachement_databases" {
  count = var.cluster_node_pool_1_count
  display_name = "cluster_databases_volume_attachment"
  attachment_type = "iscsi"
  instance_id     = oci_containerengine_node_pool.cluster_node_pool_1.nodes[count.index].id
  volume_id       = data.oci_core_volumes.cluster_databases_volume.volumes[0].id
  is_agent_auto_iscsi_login_enabled = false
  is_shareable = true
}

resource "oci_core_volume_attachment" "volume_attachement_tools" {
  count = var.cluster_node_pool_1_count
  display_name = "cluster_tools_volume_attachment"
  attachment_type = "iscsi"
  instance_id     = oci_containerengine_node_pool.cluster_node_pool_1.nodes[count.index].id
  volume_id       = data.oci_core_volumes.cluster_tools_volume.volumes[0].id
  is_agent_auto_iscsi_login_enabled = false
  is_shareable = true
}

resource "oci_core_volume_attachment" "volume_attachement_wordopress" {
  count = var.cluster_node_pool_1_count
  display_name = "cluster_wordopress_volume_attachment"
  attachment_type = "iscsi"
  instance_id     = oci_containerengine_node_pool.cluster_node_pool_1.nodes[count.index].id
  volume_id       = data.oci_core_volumes.cluster_wordpress_volume.volumes[0].id
  is_agent_auto_iscsi_login_enabled = false
  is_shareable = true
}
