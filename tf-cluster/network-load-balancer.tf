resource "oci_network_load_balancer_network_load_balancer" "cluster_nlb" {
  compartment_id = data.oci_identity_compartments.cluster_compartment.compartments[0].id
  display_name   = var.network_load_balancer_name
  subnet_id      = oci_core_subnet.cluster_public_subnet.id

  is_private                     = false
  is_preserve_source_destination = false
  reserved_ips {
        #Optional
        id = element([for node in data.oci_core_public_ips.cluster_public_ips.public_ips : node if node.display_name == var.public_ip_name], 0).id
  }
}

resource "oci_network_load_balancer_backend_set" "cluster_nlb_backend_set_80" {
  health_checker {
    protocol = "TCP"
    port     = var.cluster_health_port
  }
  name                     = "cluster-backend-set-80"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.cluster_nlb.id
  policy                   = "FIVE_TUPLE"

  is_preserve_source = false
}

resource "oci_network_load_balancer_backend" "cluster_nlb_backend_80" {
  count                    = var.cluster_node_pool_1_count
  backend_set_name         = oci_network_load_balancer_backend_set.cluster_nlb_backend_set_80.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.cluster_nlb.id
  port                     = var.cluster_node_http_port
  target_id                = [for node in oci_containerengine_node_pool.cluster_node_pool_1.nodes : node if node.state == "ACTIVE"][count.index].id
}

resource "oci_network_load_balancer_listener" "cluster_nlb_listener_port_80" {
  default_backend_set_name = oci_network_load_balancer_backend_set.cluster_nlb_backend_set_80.name
  name                     = "cluster-nlb-listener-port-80"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.cluster_nlb.id
  port                     = var.http_port
  protocol                 = "TCP"
}

resource "oci_network_load_balancer_backend_set" "cluster_nlb_backend_set_443" {
  health_checker {
    protocol = "TCP"
    port     = var.cluster_health_port
  }
  name                     = "cluster-backend-set-443"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.cluster_nlb.id
  policy                   = "FIVE_TUPLE"

  is_preserve_source = false
}

resource "oci_network_load_balancer_backend" "cluster_nlb_backend_443" {
  count                    = var.cluster_node_pool_1_count
  backend_set_name         = oci_network_load_balancer_backend_set.cluster_nlb_backend_set_443.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.cluster_nlb.id
  port                     = var.cluster_node_https_port
  target_id                = [for node in oci_containerengine_node_pool.cluster_node_pool_1.nodes : node if node.state == "ACTIVE"][count.index].id
}

resource "oci_network_load_balancer_listener" "cluster_nlb_listener_port_443" {
  default_backend_set_name = oci_network_load_balancer_backend_set.cluster_nlb_backend_set_443.name
  name                     = "cluster-nlb-listener-port-443"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.cluster_nlb.id
  port                     = var.https_port
  protocol                 = "TCP"
}