resource "oci_dns_record" "dns_record_zvonimir_bedi_subdomain_wildcard" {
    #Required
    zone_name_or_id = oci_dns_zone.dns_zone_zvonimir_bedi.id
    domain = "*.zvonimirbedi.com"
    rtype ="A"
    rdata = oci_core_public_ip.public_ip.ip_address 

    #Optional
    compartment_id = oci_identity_compartment.cluster_compartment.id
    ttl = "300"
}