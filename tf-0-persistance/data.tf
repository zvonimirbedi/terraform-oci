# Source from https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/identity_availability_domains

data "oci_identity_availability_domains" "ads" {
  compartment_id = oci_identity_compartment.cluster_compartment.compartment_id
}