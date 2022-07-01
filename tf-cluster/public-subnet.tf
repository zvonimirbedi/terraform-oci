# Source from https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_subnet

resource "oci_core_subnet" "cluster_public_subnet" {

  # Required
  compartment_id = data.oci_identity_compartments.cluster_compartment.compartments[0].id
  vcn_id         = module.vcn.vcn_id
  cidr_block     = "10.0.0.0/24"

  # Optional
  route_table_id    = module.vcn.ig_route_id
  security_list_ids = [oci_core_security_list.cluster_public_security_list.id]
  display_name      = "cluster_public_subnet"
  prohibit_public_ip_on_vnic = false
}
