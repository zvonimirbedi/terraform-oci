resource "oci_core_volume" "cluster_wordpress_volume" {
  # count               = 1
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = oci_identity_compartment.cluster_compartment.id
  display_name        = var.wordpress_block_volume_name
  size_in_gbs         = var.wordpress_block_volume_size_gb
  vpus_per_gb         = 0
}
