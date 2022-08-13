# Source from https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/identity_availability_domains

data "oci_identity_compartments" "cluster_compartment" {
    #Required
    compartment_id = "ocid1.tenancy.oc1..aaaaaaaan3s7vpqdw76qzgifbvio2cqf76hsinebozowguckoc7vd2xu7qoa"
    name = var.cluster_compartment_name
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = data.oci_identity_compartments.cluster_compartment.compartments[0].id
}

data "oci_containerengine_clusters" "clusters_list" {
    #Required
    compartment_id = data.oci_identity_compartments.cluster_compartment.compartments[0].id

    #Optional
    name = var.cluster_name
    state = ["ACTIVE"]
}

data "oci_containerengine_node_pools" "cluster_node_pool_1" {
    #Required
    compartment_id = data.oci_identity_compartments.cluster_compartment.compartments[0].id

}