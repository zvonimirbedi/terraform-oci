# Source from https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/containerengine_cluster

resource "oci_containerengine_cluster" "zvone_cluster" {
  # Required
  compartment_id     = data.oci_identity_compartments.cluster_compartment.compartments[0].id
  kubernetes_version = var.cluster_kubernetes_version
  name               = var.cluster_name
  vcn_id             = module.vcn.vcn_id
  endpoint_config {

    #Optional
    is_public_ip_enabled = true
    subnet_id            = oci_core_subnet.cluster_public_subnet.id
  }

  # Optional
  options {
    add_ons {
      is_kubernetes_dashboard_enabled = false
      is_tiller_enabled               = false
    }
    kubernetes_network_config {
      pods_cidr     = "10.244.0.0/16"
      services_cidr = "10.96.0.0/16"
    }
    service_lb_subnet_ids = [oci_core_subnet.cluster_public_subnet.id]
  }
}

# add delay on destroy because of errors on destroy finish
resource "time_sleep" "wait_30_seconds" {
  depends_on = [oci_containerengine_cluster.zvone_cluster]
  destroy_duration = "30s"
}
