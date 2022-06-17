variable "provider_kubernetes_config_path" {
  type        = string
  description = "Local file path to kubernetes config file"
}

variable "namespace_list" {
  type    = list(string)
  default = ["zvone-test-namespace-wrong-variables"]
}


