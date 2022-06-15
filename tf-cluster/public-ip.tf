resource "oci_core_public_ip" "public_ip" {
  compartment_id = oci_identity_compartment.tf-compartment.id
  display_name   = "Zvone Cluster public ip"
  lifetime       = "RESERVED"
  private_ip_id  = ""
}