resource "oci_core_volume" "cluster_wordpress_volume" {
  # count               = 1
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = data.oci_identity_compartments.cluster_compartment.compartments[0].id
  display_name        = var.wordpress_block_volume_name
  size_in_gbs         = var.wordpress_block_volume_size_gb
  vpus_per_gb         = 0
}

resource "oci_core_volume_attachment" "volume_attachement_wordopress" {
  count = var.cluster_node_pool_1_count
  display_name = "cluster_wordopress_volume_attachment"
  attachment_type = "iscsi"
  instance_id     = oci_containerengine_node_pool.cluster_node_pool_1.nodes[count.index].id
  volume_id       = oci_core_volume.cluster_wordpress_volume.id
  is_agent_auto_iscsi_login_enabled = false
  is_shareable = true
}
