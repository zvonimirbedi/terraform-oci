resource "oci_dns_zone" "dns_zone_zvonimir_bedi" {
    #Required
    compartment_id = oci_identity_compartment.cluster_compartment.id
    name = "zvonimirbedi.com"
    zone_type = "PRIMARY"
}