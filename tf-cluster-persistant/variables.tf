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

variable "compartment_name" {
  type        = string
  description = "The public IP name"
  default = "Zvone Kubernetes Cluster"
}

variable "compartment_description" {
  type        = string
  description = "The public IP name"
  default = "Zvone Compartment for Terraform resources"
}
