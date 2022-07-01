resource "oci_core_volume" "cluster_fs_volume" {
  # count               = 1
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = oci_identity_compartment.cluster_compartment.id
  display_name        = var.block_volume_name
  size_in_gbs         = var.block_volume_size_gb
  vpus_per_gb         = 0
}
