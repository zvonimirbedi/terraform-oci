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

variable "tools_block_volume_name" {
  type        = string
  description = "Block volume name tools"
}

variable "tools_block_volume_size_gb" {
  type        = string
  description = "Block volume size in GB for tools"
}

variable "database_block_volume_name" {
  type        = string
  description = "Block volume name database"
}

variable "database_block_volume_size_gb" {
  type        = string
  description = "Block volume size in GB for database"
}

variable "provider_kubernetes_config_path" {
  type        = string
  description = "Local file path to kubernetes config file"
}

variable "namespace_list" {
  type    = list(string)
  default = ["zvone-test-namespace-wrong-variables"]
  description = "Namespaces to be crated automatically"
}

variable "docker_registry_address" {
  type        = string
  description = "Docker registry url address"
}

variable "docker_registry_username" {
  type        = string
  description = "Docker registry username"
}

variable "docker_registry_password" {
  type        = string
  description = "Docker registry password"
}

variable "namecheap_username" {
  type        = string
  description = "Namecheap username"
}

variable "namecheap_key" {
  type        = string
  description = "Namecheap key"
}

variable "nginx_auth" {
  type        = string
  description = "Ingress Nginx Authentication username:password"
}

variable "jenkins_url" {
  type        = string
  description = "DNS for Jenkins"
}

variable "grafana_url" {
  type        = string
  description = "DNS for Grafana"
}

variable "clusterissuer_zvonimirbedi" {
  type        = string
  description = "Issuer cert-manager for zvonimirbedi.com"
}