# Source from https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_dhcp_options

resource "oci_core_dhcp_options" "cluster_dhcp_options" {

  # Required
  compartment_id = data.oci_identity_compartments.cluster_compartment.compartments[0].id
  vcn_id         = module.vcn.vcn_id
  #Options for type are either "DomainNameServer" or "SearchDomain"
  options {
    type        = "DomainNameServer"
    server_type = "VcnLocalPlusInternet"
  }

  # Optional
  display_name = "cluster_dhcp_options"
}
