# Output the reserved public IP address
output "public-ip" {
  value = oci_core_public_ip.public_ip.ip_address
}

output "public-ip-ocid" {
  value = oci_core_public_ip.public_ip.id
}

# Outputs for compartment

output "compartment-name" {
  value = oci_identity_compartment.tf-compartment.name
}

output "compartment-ocid" {
  value = oci_identity_compartment.tf-compartment.id
}