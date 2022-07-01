# Source from https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_security_list

resource "oci_core_security_list" "cluster_private_security_list" {

  # Required
  compartment_id = data.oci_identity_compartments.cluster_compartment.compartments[0].id
  vcn_id         = module.vcn.vcn_id

  # Optional
  display_name = var.private_security_list

  egress_security_rules {
    stateless        = false
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"
  }
  
  ingress_security_rules {
    stateless   = false
    source      = "10.0.0.0/16"
    source_type = "CIDR_BLOCK"
    protocol    = "all"
  }
  ingress_security_rules {
    stateless   = false
    source      = "10.0.0.0/24"
    source_type = "CIDR_BLOCK"
    protocol    = "6"
    tcp_options {
      min = var.cluster_health_port
      max = var.cluster_health_port
    }
  }
  ingress_security_rules {
    stateless   = false
    source      = "10.0.0.0/24"
    source_type = "CIDR_BLOCK"
    protocol    = "6"
    tcp_options {
      min = var.cluster_node_http_port
      max = var.cluster_node_http_port
    }
  }
  ingress_security_rules {
    stateless   = false
    source      = "10.0.0.0/24"
    source_type = "CIDR_BLOCK"
    protocol    = "6"
    tcp_options {
      min = var.cluster_node_https_port
      max = var.cluster_node_https_port
    }
  }
}
