resource "oci_core_public_ip" "public_ip" {
  compartment_id = oci_identity_compartment.cluster_compartment.id
  display_name   = var.public_ip_name
  lifetime       = "RESERVED"
  private_ip_id  = ""
}

resource "oci_core_public_ip" "nat_public_ip" {
  compartment_id = oci_identity_compartment.cluster_compartment.id
  display_name   = "Cluster NAT Gateway public IP"
  lifetime       = "RESERVED"
  private_ip_id  = ""
}