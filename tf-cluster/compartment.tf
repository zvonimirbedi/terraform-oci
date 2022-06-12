resource "oci_identity_compartment" "tf-compartment" {
  # Required
  compartment_id = "ocid1.tenancy.oc1..aaaaaaaan3s7vpqdw76qzgifbvio2cqf76hsinebozowguckoc7vd2xu7qoa"
  description    = "Zvone Compartment for Terraform resources"
  name           = "zvone_compartment"
}
