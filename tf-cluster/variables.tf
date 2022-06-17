variable "region" {
  type        = string
  description = "The region to provision the resources in"
  default = "eu-frankfurt-1"
}

variable "compartment_ocid" {
  type        = string
  description = "The compartment to provision the resources in"
}

variable "public_ip_ocid" {
  type        = string
  description = "Reserved public IP ocid"
}

variable "cluster_name" {
  type        = string
  description = "Cluster Name description"
}

variable "vcn_name" {
  type        = string
  description = "VCN Name description"
}

variable "cluster_node_pool_1_name" {
  type        = string
  description = "Cluster node Pool 1 Name description"
}

variable "private_security_list" {
  type        = string
  description = "Cluster Private secirity List"
}

variable "public_security_list" {
  type        = string
  description = "Cluster Public secirity List"
}

variable "network_load_balancer_name" {
  type        = string
  description = "Cluster Network Load balancer Name"
}

