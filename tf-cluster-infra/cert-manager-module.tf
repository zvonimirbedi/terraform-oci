module "cert_manager" {
  source        = "terraform-iaac/cert-manager/kubernetes"

  cluster_issuer_email                   = "zvonimirbedi@gmail.com"
  cluster_issuer_server                  = "https://acme-staging-v02.api.letsencrypt.org/directory" 
  namespace_name                         = "tools"
  create_namespace                       = false
}