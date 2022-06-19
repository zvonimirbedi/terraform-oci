provider "kubernetes" {
  config_path = var.provider_kubernetes_config_path
}

/*
provider "docker" {
  registry_auth {
    address = var.docker_registry_address
    username = var.docker_registry_username
    password = var.docker_registry_password
  } 
}
*/