module "cert_manager" {
  source        = "terraform-iaac/cert-manager/kubernetes"

  cluster_issuer_email                   = "zvonimirbedi@gmail.com"
  cluster_issuer_server                  = "https://acme-staging-v02.api.letsencrypt.org/directory" 
  namespace_name                         = "tools"
  create_namespace                       = false
  certificates = {   
    "${var.clusterissuer_jenkins}" = {
      dns_names = [var.jenkins_url, join(".", ["www", var.jenkins_url])]
      namespace = "tools"
    } 
    "${var.clusterissuer_grafana}" = {
      dns_names = [var.grafana_url, join(".", ["www", var.grafana_url])]
      namespace = "tools"
    } 
  }
}