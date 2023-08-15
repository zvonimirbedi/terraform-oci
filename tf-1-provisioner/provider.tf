provider "oci" {
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaan3s7vpqdw76qzgifbvio2cqf76hsinebozowguckoc7vd2xu7qoa"
  user_ocid = "ocid1.user.oc1..aaaaaaaaek2wrdojzwtfwd3c7oyg73jujjvzwhiin755faxuxcsn4l5sgd6a" 
  private_key_path = var.private_key_path
  fingerprint = var.fingerprint
  region = var.region
}