resource "oci_core_volume_attachment" "volume_attachement_wordopress" {
  display_name = "cluster_wordopress_volume_attachment"
  attachment_type = "iscsi"
  instance_id     = oci_containerengine_node_pool.cluster_node_pool_1.nodes[0].id
  volume_id       = data.oci_core_volumes.cluster_wordpress_volume.volumes[0].id
  is_agent_auto_iscsi_login_enabled = false
  is_shareable = true
}