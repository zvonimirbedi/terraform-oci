resource "oci_identity_compartment" "cluster_compartment" {
  # Required
  compartment_id = var.root_compartment_ocid
  description    = var.cluster_compartment_description
  name           = var.cluster_compartment_name
}
