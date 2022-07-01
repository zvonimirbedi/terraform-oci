provider "oci" {
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaan3s7vpqdw76qzgifbvio2cqf76hsinebozowguckoc7vd2xu7qoa"
  user_ocid = "ocid1.user.oc1..aaaaaaaaek2wrdojzwtfwd3c7oyg73jujjvzwhiin755faxuxcsn4l5sgd6a" 
  private_key_path = "/home/botuser/.oci/oci_api_key.pem"
  fingerprint = "0d:40:a6:14:0a:76:04:91:b0:af:54:63:c5:f2:c5:d9"
  region = var.region
}

provider "kubernetes" {
  config_path = var.provider_kubernetes_config_path
}

provider "helm" {
  kubernetes {
    config_path = var.provider_kubernetes_config_path
  }
}