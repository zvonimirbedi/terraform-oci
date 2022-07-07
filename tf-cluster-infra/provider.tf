provider "oci" {
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaan3s7vpqdw76qzgifbvio2cqf76hsinebozowguckoc7vd2xu7qoa"
  user_ocid = "ocid1.user.oc1..aaaaaaaaek2wrdojzwtfwd3c7oyg73jujjvzwhiin755faxuxcsn4l5sgd6a" 
  private_key_path = "/home/botuser/.oci/oci_api_key.pem"
  fingerprint = "ed:80:0a:1f:95:29:b1:58:da:bd:bd:23:5a:48:b6:38"
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