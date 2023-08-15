variable "private_key_path" {
  type        = string
  description = "Path to .oci/oci_api_key.pem file"
}

variable "fingerprint" {
  type        = string
  description = "API KEY fingerprint found in OCI Identity > Users > User Details > API Keys"
}

variable "region" {
  type        = string
  description = "The region to provision the resources in"
  default = "eu-frankfurt-1"
}

variable "public_ip_name" {
  type        = string
  description = "The public IP name"
  default = "Zvone Public IP test"
}

variable "root_compartment_ocid" {
  type        = string
  description = "The compartment to provision the resources in"
}

variable "cluster_compartment_name" {
  type        = string
  description = "The public IP name"
  default = "Zvone Kubernetes Cluster"
}

variable "cluster_compartment_description" {
  type        = string
  description = "The public IP name"
  default = "Zvone Compartment for Terraform resources"
}

variable "tools_block_volume_name" {
  type        = string
  description = "Block volume name "
}

variable "tools_block_volume_size_gb" {
  type        = string
  description = "Block volume size in GB"
}

variable "databases_block_volume_name" {
  type        = string
  description = "Block volume name"
}

variable "databases_block_volume_size_gb" {
  type        = string
  description = "Block volume size in GB"
}

variable "wordpress_block_volume_name" {
  type        = string
  description = "Block volume name "
}

variable "wordpress_block_volume_size_gb" {
  type        = string
  description = "Block volume size in GB"
}