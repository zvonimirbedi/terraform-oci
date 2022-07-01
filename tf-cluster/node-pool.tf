# Source from https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/containerengine_node_pool

resource "oci_containerengine_node_pool" "cluster_node_pool_1" {
  # Required
  cluster_id         = oci_containerengine_cluster.zvone_cluster.id
  compartment_id     = data.oci_identity_compartments.cluster_compartment.compartments[0].id
  kubernetes_version = var.cluster_kubernetes_version
  name               = var.cluster_node_pool_1_name
  node_config_details {
    placement_configs {
      availability_domain = data.oci_core_volumes.cluster_fs_volume.volumes[0].availability_domain
      subnet_id           = oci_core_subnet.cluster_private_subnet.id
    } 
    size = var.cluster_node_pool_1_count
  }
  # https://docs.oracle.com/en-us/iaas/Content/Compute/References/computeshapes.htm#vmshapes__vm-standard
  # AMD processor
  node_shape = var.cluster_node_shape
  node_shape_config {
    memory_in_gbs = var.cluster_node_ram
    ocpus         = var.cluster_node_ocpus
  }

  # Using image Oracle-Linux-8.x-<date>
  # Find image OCID for your region
  # https://docs.oracle.com/en-us/iaas/images/
  node_source_details {
    image_id    = var.cluster_node_source_image
    source_type = "image"
  }

  # Optional
  initial_node_labels {
    key   = "name"
    value = var.cluster_name
  }

  # setup kube confing
  # enable agent
  provisioner "local-exec" {
    # generate kube config file for new cluster
    command = <<-EOT
          rm -r /home/botuser/.kube/config
          oci ce cluster create-kubeconfig --cluster-id ${oci_containerengine_cluster.zvone_cluster.id} --file $HOME/.kube/config --region ${var.region} --token-version 2.0.0  --kube-endpoint PUBLIC_ENDPOINT
          # yes | oci compute instance update --instance-id ${oci_containerengine_node_pool.cluster_node_pool_1.nodes[0].id} --agent-config "{\"is-agent-disabled\": false,\"plugins-config\": [{\"name\": \"Block Volume Management\", \"desiredState\": \"ENABLED\"}]}"
    EOT
  }
}
