resource "oci_dns_record" "dns_record_zvonimir_bedi" {
    #Required
    zone_name_or_id = oci_dns_zone.dns_zone_zvonimir_bedi.id
    domain = "zvonimirbedi.com"
    rtype ="ALIAS"
    rdata = "d1ohxkw353dg1m.cloudfront.net."

    #Optional
    compartment_id = oci_identity_compartment.cluster_compartment.id
    ttl = "300"
}
resource "oci_dns_record" "dns_record_zvonimir_bedi_www" {
    #Required
    zone_name_or_id = oci_dns_zone.dns_zone_zvonimir_bedi.id
    domain = "www.zvonimirbedi.com"
    rtype ="ALIAS"
    rdata = "zvonimirbedi.com."

    #Optional
    compartment_id = oci_identity_compartment.cluster_compartment.id
    ttl = "300"
}

resource "oci_dns_record" "dns_record_zvonimir_bedi_google_verif" {
    #Required
    zone_name_or_id = oci_dns_zone.dns_zone_zvonimir_bedi.id
    domain = "zvonimirbedi.com"
    rtype ="TXT"
    rdata = "google-site-verification=7jJII_YeK8YLeKRmhucLMx5SEAWjb3fkHQesad9ieg4"

    #Optional
    compartment_id = oci_identity_compartment.cluster_compartment.id
    ttl = "300"
}


resource "oci_dns_record" "dns_record_zvonimir_bedi_subdomain_zvonimirbedi" {
    #Required
    zone_name_or_id = oci_dns_zone.dns_zone_zvonimir_bedi.id
    domain = "zvonimirbedi.zvonimirbedi.com"
    rtype ="A"
    rdata = "54.90.6.227"

    #Optional
    compartment_id = oci_identity_compartment.cluster_compartment.id
    ttl = "300"
}
resource "oci_dns_record" "dns_record_zvonimir_bedi_subdomain_www_zvonimirbedi" {
    #Required
    zone_name_or_id = oci_dns_zone.dns_zone_zvonimir_bedi.id
    domain = "www.zvonimirbedi.zvonimirbedi.com"
    rtype ="ALIAS"
    rdata = "zvonimirbedi.zvonimirbedi.com."

    #Optional
    compartment_id = oci_identity_compartment.cluster_compartment.id
    ttl = "300"
}

resource "oci_dns_record" "dns_record_zvonimir_bedi_subdomain_professorastor" {
    #Required
    zone_name_or_id = oci_dns_zone.dns_zone_zvonimir_bedi.id
    domain = "professorastor.zvonimirbedi.com"
    rtype ="ALIAS"
    rdata = "d1yg8yb2dya8ex.cloudfront.net."

    #Optional
    compartment_id = oci_identity_compartment.cluster_compartment.id
    ttl = "300"
}
resource "oci_dns_record" "dns_record_zvonimir_bedi_subdomain_www_professorastor" {
    #Required
    zone_name_or_id = oci_dns_zone.dns_zone_zvonimir_bedi.id
    domain = "www.professorastor.zvonimirbedi.com"
    rtype ="ALIAS"
    rdata = "professorastor.zvonimirbedi.com."

    #Optional
    compartment_id = oci_identity_compartment.cluster_compartment.id
    ttl = "300"
}

# AWS 
resource "oci_dns_record" "dns_record_zvonimir_bedi_subdomain_1" {
    #Required
    zone_name_or_id = oci_dns_zone.dns_zone_zvonimir_bedi.id
    domain = "_8a3cd9b35b07721454cad40c5b897d76.www.professorastor.zvonimirbedi.com"
    rtype ="ALIAS"
    rdata = "_b0b463bf7c21a963600a6195f4b54d45.vtqfhvjlcp.acm-validations.aws."

    #Optional
    compartment_id = oci_identity_compartment.cluster_compartment.id
    ttl = "300"
}
resource "oci_dns_record" "dns_record_zvonimir_bedi_subdomain_2" {
    #Required
    zone_name_or_id = oci_dns_zone.dns_zone_zvonimir_bedi.id
    domain = "_a2cf0d0f967c9cc263d2c2e5d694349b.www.zvonimirbedi.com"
    rtype ="ALIAS"
    rdata = "_aa51bd2b59491caa15dfb6f08503a121.zdxcnfdgtt.acm-validations.aws."

    #Optional
    compartment_id = oci_identity_compartment.cluster_compartment.id
    ttl = "300"
}
resource "oci_dns_record" "dns_record_zvonimir_bedi_subdomain_3" {
    #Required
    zone_name_or_id = oci_dns_zone.dns_zone_zvonimir_bedi.id
    domain = "_a8c37fc6a1fe946f453df87ace443797.professorastor.zvonimirbedi.com"
    rtype ="ALIAS"
    rdata = "_46b6afc4fe287036a313da6ca9859177.vtqfhvjlcp.acm-validations.aws."

    #Optional
    compartment_id = oci_identity_compartment.cluster_compartment.id
    ttl = "300"
}
resource "oci_dns_record" "dns_record_zvonimir_bedi_subdomain_4" {
    #Required
    zone_name_or_id = oci_dns_zone.dns_zone_zvonimir_bedi.id
    domain = "_cc042b97ea4dfe606cda8471674603c4.zvonimirbedi.com"
    rtype ="ALIAS"
    rdata = "_30c4b37b214e015e60f2318573ebfa48.zdxcnfdgtt.acm-validations.aws."

    #Optional
    compartment_id = oci_identity_compartment.cluster_compartment.id
    ttl = "300"
}
resource "oci_dns_record" "dns_record_zvonimir_bedi_subdomain_5" {
    #Required
    zone_name_or_id = oci_dns_zone.dns_zone_zvonimir_bedi.id
    domain = "cp3slujgag4do7kpwleyzc53uonnz34z._domainkey.zvonimirbedi.com"
    rtype ="ALIAS"
    rdata = "cp3slujgag4do7kpwleyzc53uonnz34z.dkim.amazonses.com."

    #Optional
    compartment_id = oci_identity_compartment.cluster_compartment.id
    ttl = "300"
}
resource "oci_dns_record" "dns_record_zvonimir_bedi_subdomain_6" {
    #Required
    zone_name_or_id = oci_dns_zone.dns_zone_zvonimir_bedi.id
    domain = "hyumzuxfuyjwftapkezfoq3gbk3wpvsk._domainkey.zvonimirbedi.com"
    rtype ="ALIAS"
    rdata = "hyumzuxfuyjwftapkezfoq3gbk3wpvsk.dkim.amazonses.com."

    #Optional
    compartment_id = oci_identity_compartment.cluster_compartment.id
    ttl = "300"
}
resource "oci_dns_record" "dns_record_zvonimir_bedi_subdomain_7" {
    #Required
    zone_name_or_id = oci_dns_zone.dns_zone_zvonimir_bedi.id
    domain = "hxs32zacgz4yds7urnbzdv6ixqonaoyod._domainkey.zvonimirbedi.com"
    rtype ="ALIAS"
    rdata = "xs32zacgz4yds7urnbzdv6ixqonaoyod.dkim.amazonses.com."

    #Optional
    compartment_id = oci_identity_compartment.cluster_compartment.id
    ttl = "300"
}
resource "oci_dns_record" "dns_record_zvonimir_bedi_subdomain_8" {
    #Required
    zone_name_or_id = oci_dns_zone.dns_zone_zvonimir_bedi.id
    domain = "_amazonses.zvonimirbedi.com"
    rtype ="TXT"
    rdata = "YAZOgMiC17IJGd03twZDEyeSb1ez6u1BY0R7NRRF8fM="

    #Optional
    compartment_id = oci_identity_compartment.cluster_compartment.id
    ttl = "300"
}