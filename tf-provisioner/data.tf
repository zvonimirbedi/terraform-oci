# Source from https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/identity_availability_domains

data "oci_identity_compartments" "cluster_compartment" {
    #Required
    compartment_id = var.root_compartment_ocid
    name = var.cluster_compartment_name
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = data.oci_identity_compartments.cluster_compartment.compartments[0].id
}

data "oci_core_public_ips" "cluster_public_ips" {
    #Required
    compartment_id = data.oci_identity_compartments.cluster_compartment.compartments[0].id
    scope = "REGION"
    lifetime = "RESERVED"
}

data "oci_core_volumes" "cluster_databases_volume" {
    compartment_id = data.oci_identity_compartments.cluster_compartment.compartments[0].id
    display_name        = var.databases_block_volume_name
    state = "AVAILABLE"
}

data "oci_core_volumes" "cluster_tools_volume" {
    compartment_id = data.oci_identity_compartments.cluster_compartment.compartments[0].id
    display_name        = var.tools_block_volume_name
    state = "AVAILABLE"
}

data "oci_core_volumes" "cluster_wordpress_volume" {
    compartment_id = data.oci_identity_compartments.cluster_compartment.compartments[0].id
    display_name        = var.wordpress_block_volume_name
    state = "AVAILABLE"
}