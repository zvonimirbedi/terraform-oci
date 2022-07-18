variable "region" {
  type        = string
  description = "The region to provision the resources in"
  default = "eu-frankfurt-1"
}

variable "cluster_compartment_name" {
  type        = string
  description = "The public IP name"
  default = "Zvone Kubernetes Cluster"
}

variable "root_compartment_ocid" {
  type        = string
  description = "The compartment to provision the resources in"
}

variable "vcn_name" {
  type        = string
  description = "VCN Name description"
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

variable "cluster_name" {
  type        = string
  description = "Cluster Name description"
}

variable "cluster_node_pool_1_name" {
  type        = string
  description = "Cluster node Pool 1 Name description"
}

variable "cluster_node_shape" {
  type        = string
  description = "Cluster node Pool instance shape"
}

variable "cluster_kubernetes_version" {
  type        = string
  description = "Kubernetes version"
}

variable "cluster_node_source_image" {
  type        = string
  description = "Kubernetes cluster node source image ocid"
}

variable "cluster_node_pool_1_count" {
  type        = string
  description = "Number of Nodes in node pool 1"
}

variable "cluster_node_ocpus" {
  type        = string
  description = "Number of Node ocpu"
}

variable "cluster_node_ram" {
  type        = string
  description = "Number of Node RAM"
}

variable "http_port" {
  type        = string
  description = "Number of http port"
  default = "80"
}

variable "https_port" {
  type        = string
  description = "Number of https port"
  default = "443"
}

variable "cluster_health_port" {
  type        = string
  description = "Kubernetes cluster health port"
}

variable "cluster_node_http_port" {
  type        = string
  description = "Kubernetes cluster node http port"
}

variable "cluster_node_https_port" {
  type        = string
  description = "Kubernetes cluster node https port"
}

variable "tools_block_volume_name" {
  type        = string
  description = "Block volume name Tools"
}

variable "database_block_volume_name" {
  type        = string
  description = "Block volume name database"
}