# Output the "list" of all availability domains.
output "all-availability-domains-in-your-tenancy" {
  value = data.oci_identity_availability_domains.ads.availability_domains
}
# Outputs for compartment

output "compartment-name" {
  value = oci_identity_compartment.tf-compartment.name
}

output "compartment-OCID" {
  value = oci_identity_compartment.tf-compartment.id
}
# The "name" of the availability domain to be used for the compute instance.
output "name-of-first-availability-domain" {
  value = data.oci_identity_availability_domains.ads.availability_domains[0].name
}

# Outputs for the vcn module

output "vcn_id" {
  description = "OCID of the VCN that is created"
  value       = module.vcn.vcn_id
}
output "id-for-route-table-that-includes-the-internet-gateway" {
  description = "OCID of the internet-route table. This route table has an internet gateway to be used for public subnets"
  value       = module.vcn.ig_route_id
}
output "nat-gateway-id" {
  description = "OCID for NAT gateway"
  value       = module.vcn.nat_gateway_id
}
output "id-for-for-route-table-that-includes-the-nat-gateway" {
  description = "OCID of the nat-route table - This route table has a nat gateway to be used for private subnets. This route table also has a service gateway."
  value       = module.vcn.nat_route_id
}

# Outputs for private security list

output "private-security-list-name" {
  value = oci_core_security_list.zvone_private_security_list.display_name
}
output "private-security-list-OCID" {
  value = oci_core_security_list.zvone_private_security_list.id
}

# Outputs for public security list

output "public-security-list-name" {
  value = oci_core_security_list.zvone_public_security_list.display_name
}
output "public-security-list-OCID" {
  value = oci_core_security_list.zvone_public_security_list.id
}

# Outputs for private subnet

output "private-subnet-name" {
  value = oci_core_subnet.zvone_private_subnet.display_name
}
output "private-subnet-OCID" {
  value = oci_core_subnet.zvone_private_subnet.id
}

# Outputs for public subnet

output "public-subnet-name" {
  value = oci_core_subnet.zvone_public_subnet.display_name
}
output "public-subnet-OCID" {
  value = oci_core_subnet.zvone_public_subnet.id
}

# Outputs for k8s cluster

output "cluster-name" {
  value = oci_containerengine_cluster.zvone_cluster.name
}
output "cluster-OCID" {
  value = oci_containerengine_cluster.zvone_cluster.id
}
output "cluster-kubernetes-version" {
  value = oci_containerengine_cluster.zvone_cluster.kubernetes_version
}
output "cluster-state" {
  value = oci_containerengine_cluster.zvone_cluster.state
}

# Outputs for k8s node pool

output "node-pool-name" {
  value = oci_containerengine_node_pool.zvone_cluster_node_pool.name
}
output "node-pool-OCID" {
  value = oci_containerengine_node_pool.zvone_cluster_node_pool.id
}
output "node-pool-kubernetes-version" {
  value = oci_containerengine_node_pool.zvone_cluster_node_pool.kubernetes_version
}
output "node-size" {
  value = oci_containerengine_node_pool.zvone_cluster_node_pool.node_config_details[0].size
}
output "node-shape" {
  value = oci_containerengine_node_pool.zvone_cluster_node_pool.node_shape
}
