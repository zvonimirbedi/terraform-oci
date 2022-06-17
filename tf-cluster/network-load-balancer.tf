resource "oci_network_load_balancer_network_load_balancer" "cluster_nlb" {
  compartment_id = var.compartment_ocid
  display_name   = var.network_load_balancer_name
  subnet_id      = oci_core_subnet.cluster_public_subnet.id

  is_private                     = false
  is_preserve_source_destination = false
  reserved_ips {
        #Optional
        id = var.public_ip_ocid
    }
}

resource "oci_network_load_balancer_backend_set" "cluster_nlb_backend_set" {
  health_checker {
    protocol = "TCP"
    port     = 10256
  }
  name                     = "zvone-cluster-backend-set"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.cluster_nlb.id
  policy                   = "FIVE_TUPLE"

  is_preserve_source = false
}

resource "oci_network_load_balancer_backend" "cluster_nlb_backend" {
  count                    = length([for node in oci_containerengine_node_pool.cluster_node_pool_1.nodes : node if node.state == "ACTIVE"])
  backend_set_name         = oci_network_load_balancer_backend_set.cluster_nlb_backend_set.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.cluster_nlb.id
  port                     = 31600
  target_id                = [for node in oci_containerengine_node_pool.cluster_node_pool_1.nodes : node if node.state == "ACTIVE"][count.index].id
}

resource "oci_network_load_balancer_listener" "cluster_nlb_listener" {
  default_backend_set_name = oci_network_load_balancer_backend_set.cluster_nlb_backend_set.name
  name                     = "zvone-cluster-nlb-listener"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.cluster_nlb.id
  port                     = "80"
  protocol                 = "TCP"
}