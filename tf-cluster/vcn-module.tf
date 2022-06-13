# Source from https://registry.terraform.io/modules/oracle-terraform-modules/vcn/oci/

module "vcn" {
  source  = "oracle-terraform-modules/vcn/oci"
  version = "3.1.0"
  # Required
  compartment_id = oci_identity_compartment.tf-compartment.id
  region = var.region
  vcn_name = "zvone_vcn"
  vcn_dns_label = "vcn"

  # Optional
  create_internet_gateway = true
  create_nat_gateway = true
  create_service_gateway = true
  vcn_cidrs     = ["10.0.0.0/16"]
}
