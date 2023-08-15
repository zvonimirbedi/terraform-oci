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

variable "cluster_compartment_name" {
  type        = string
  description = "The public IP name"
  default = "Zvone Kubernetes Cluster"
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

variable "wordpress_url" {
  type        = string
  description = "DNS for Wordpress"
}

variable "grafana_url" {
  type        = string
  description = "DNS for Grafana"
}

variable "clusterissuer_astorx" {
  type        = string
  description = "Issuer cert-manager for DNS"
}



variable "username_jenkins" {
  type        = string
  description = "Username credentials"
}
variable "password_jenkins" {
  type        = string
  description = "Password credentials"
}
variable "username_grafana" {
  type        = string
  description = "Username credentials"
}
variable "password_grafana" {
  type        = string
  description = "Password credentials"
}
variable "username_mariadb" {
  type        = string
  description = "Username credentials"
}
variable "databasename_mariadb" {
  type        = string
  description = "Database name"
}
variable "password_mariadb" {
  type        = string
  description = "Password credentials"
}
variable "username_wordpress" {
  type        = string
  description = "Username credentials"
}
variable "password_wordpress" {
  type        = string
  description = "Password credentials"
}
variable "password_redis" {
  type        = string
  description = "Password credentials"
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

variable "provider_kubernetes_config_path" {
  type        = string
  description = "Local file path to kubernetes config file"
}

variable "cluster_name" {
  type        = string
  description = "Cluster Name description"
}

variable "cluster_node_pool_1_name" {
  type        = string
  description = "Cluster node Pool 1 Name description"
}

variable "namespace_list" {
  type    = list(string)
  default = ["terraform-namespace-wrong-variable"]
  description = "Namespaces to be crated automatically"
}


variable "STORAGE_TYPE" {
  type        = string
  description = "Rclone storage data"
}

variable "STORAGE_ACCESS_KEY_ID" {
  type        = string
  description = "Rclone storage data"
}

variable "STORAGE_SECRET_ACCESS_KEY" {
  type        = string
  description = "Rclone storage data"
}

variable "STORAGE_REGION" {
  type        = string
  description = "Rclone storage data"
}

variable "STORAGE_BUCKET_NAME" {
  type        = string
  description = "Rclone storage data"
}

variable "cronob_sync_timeout" {
  type        = string
  description = "Cronjob timeout in secunds"
}

