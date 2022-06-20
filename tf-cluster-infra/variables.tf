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

variable "nginx_auth" {
  type        = string
  description = "Ingress Nginx Authentication username:password"
}