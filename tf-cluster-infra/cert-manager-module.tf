module "cert_manager" {
  source        = "terraform-iaac/cert-manager/kubernetes"

  cluster_issuer_email                   = "zvonimirbedi@gmail.com"
  cluster_issuer_server                  = "https://acme-staging-v02.api.letsencrypt.org/directory" 
  namespace_name                         = "tools"
  create_namespace                       = false
  certificates = {   
    "clusterissuer-jenkins-zvonimirbedi-com" = {
      secret_labels = {"cert_manager" = "true"}
      dns_names = ["jenkins.zvonimirbedi.com", "www.jenkins.zvonimirbedi.com"]
      namespace = "tools"
    } 
    "clusterissuer-grafana-zvonimirbedi-com" = {
      secret_labels = {"cert_manager" = "true"}
      dns_names = ["grafana.zvonimirbedi.com", "www.grafana.zvonimirbedi.com"]
      namespace = "tools"
    } 
  }
}