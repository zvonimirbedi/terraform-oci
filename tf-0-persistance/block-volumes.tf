resource "oci_core_volume" "cluster_databases_volume" {
  # count               = 1
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = oci_identity_compartment.cluster_compartment.id
  display_name        = var.databases_block_volume_name
  size_in_gbs         = var.databases_block_volume_size_gb
  vpus_per_gb         = 0
}

resource "oci_core_volume" "cluster_tools_volume" {
  # count               = 1
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = oci_identity_compartment.cluster_compartment.id
  display_name        = var.tools_block_volume_name
  size_in_gbs         = var.tools_block_volume_size_gb
  vpus_per_gb         = 0
}

resource "oci_core_volume" "cluster_wordpress_volume" {
  # count               = 1
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = oci_identity_compartment.cluster_compartment.id
  display_name        = var.wordpress_block_volume_name
  size_in_gbs         = var.wordpress_block_volume_size_gb
  vpus_per_gb         = 0
}
