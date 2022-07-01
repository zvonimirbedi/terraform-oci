# Output the reserved public IP address
output "public-ip" {
  value = oci_core_public_ip.public_ip
}

# Outputs for compartment

output "compartment-name" {
  value = oci_identity_compartment.cluster_compartment.name
}

output "compartment-ocid" {
  value = oci_identity_compartment.cluster_compartment.id
}