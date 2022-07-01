# Source from https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_subnet

resource "oci_core_subnet" "cluster_private_subnet" {

  # Required
  compartment_id = data.oci_identity_compartments.cluster_compartment.compartments[0].id
  vcn_id         = module.vcn.vcn_id
  cidr_block     = "10.0.1.0/24"

  # Optional
  # Caution: For the route table id, use module.vcn.nat_route_id.
  # Do not use module.vcn.nat_gateway_id, because it is the OCID for the gateway and not the route table.
  route_table_id    = module.vcn.nat_route_id
  security_list_ids = [oci_core_security_list.cluster_private_security_list.id]
  display_name      = "cluster_private_subnet"
  prohibit_public_ip_on_vnic = true
}
