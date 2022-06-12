# Source from https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/containerengine_node_pool

resource "oci_containerengine_node_pool" "zvone_cluster_node_pool" {
  # Required
  cluster_id         = oci_containerengine_cluster.zvone_cluster.id
  compartment_id     = oci_identity_compartment.tf-compartment.id
  kubernetes_version = "v1.23.4"
  name               = "zvone_pool_1"
  node_config_details {
    placement_configs {
      availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
      subnet_id           = oci_core_subnet.zvone_private_subnet.id
    } 
    placement_configs{
      availability_domain = data.oci_identity_availability_domains.ads.availability_domains[1].name
      subnet_id = oci_core_subnet.zvone_private_subnet.id
    }
    placement_configs{
      availability_domain = data.oci_identity_availability_domains.ads.availability_domains[2].name
      subnet_id = oci_core_subnet.zvone_private_subnet.id
    }
    size = 1
  }
  # https://docs.oracle.com/en-us/iaas/Content/Compute/References/computeshapes.htm#vmshapes__vm-standard
  # AMD processor
  node_shape = "VM.Standard.E4.Flex"
  node_shape_config {
    memory_in_gbs = 2
    ocpus         = 1
  }

  # Using image Oracle-Linux-8.x-<date>
  # Find image OCID for your region
  # https://docs.oracle.com/en-us/iaas/images/
  node_source_details {
    image_id    = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaagnjarpaspryq7flekez4fxztbnko3y3i4k43gza4xsfl6m4xnn4q"
    source_type = "image"
  }

  # Optional
  initial_node_labels {
    key   = "name"
    value = "zvone_cluster"
  }
  timeouts {
    create = "80m"
    update = "80m"
    delete = "80m"
  }
}
