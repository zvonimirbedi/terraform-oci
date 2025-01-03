# Source from https://registry.terraform.io/modules/oracle-terraform-modules/vcn/oci/

module "vcn" {
  source  = "oracle-terraform-modules/vcn/oci"
  version = "3.1.0"
  # Required
  compartment_id = data.oci_identity_compartments.cluster_compartment.compartments[0].id
  region = var.region
  vcn_name = var.vcn_name
  vcn_dns_label = "vcn"

  # Optional
  internet_gateway_route_rules = null
  local_peering_gateways       = null
  nat_gateway_route_rules      = null
  create_internet_gateway = true
  create_nat_gateway = true
  create_service_gateway = true
  vcn_cidrs     = ["10.0.0.0/16"]
  nat_gateway_public_ip_id = element([for node in data.oci_core_public_ips.cluster_public_ips.public_ips : node if node.display_name == "Cluster NAT Gateway public IP"], 0).id
}