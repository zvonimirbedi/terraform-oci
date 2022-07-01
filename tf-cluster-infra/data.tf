# Source from https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/identity_availability_domains

data "oci_identity_compartments" "cluster_compartment" {
    #Required
    compartment_id = "ocid1.tenancy.oc1..aaaaaaaan3s7vpqdw76qzgifbvio2cqf76hsinebozowguckoc7vd2xu7qoa"
    name = var.cluster_compartment_name
}

data "oci_core_public_ips" "public_ip" {
    #Required
    compartment_id = data.oci_identity_compartments.cluster_compartment.compartments[0].id
    scope = "REGION"
    lifetime = "RESERVED"
}

data "oci_core_volumes" "cluster_fs_volume" {
    #Required
    compartment_id = data.oci_identity_compartments.cluster_compartment.compartments[0].id
    display_name = var.block_volume_name
    state = "Available"
}