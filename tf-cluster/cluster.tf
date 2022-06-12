# Source from https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/containerengine_cluster

resource "oci_containerengine_cluster" "zvone_cluster" {
  # Required
  compartment_id     = oci_identity_compartment.tf-compartment.id
  kubernetes_version = "v1.23.4"
  name               = "zvone_cluster"
  vcn_id             = module.vcn.vcn_id
  endpoint_config {

    #Optional
    is_public_ip_enabled = true
    subnet_id            = oci_core_subnet.zvone_public_subnet.id
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
    service_lb_subnet_ids = [oci_core_subnet.zvone_public_subnet.id]
  }

  timeouts {
    create = "80m"
    update = "80m"
    delete = "80m"
  }
}
