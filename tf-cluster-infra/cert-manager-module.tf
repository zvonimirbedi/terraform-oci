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
resource "null_resource" "cert_secrets_and_isusers" {
  depends_on = [module.cert_manager]
  # add certificates and issuers
  provisioner "local-exec" {
    # generate kube config file for new cluster
    interpreter = ["/bin/bash", "-c"]
    command = <<-EOT
        kubectl --validate=false apply -f <(awk '!/^ *(resourceVersion|uid): [^ ]+$/' ../data/backup_secret.yaml)
        # kubectl --validate=false apply -f <(awk '!/^ *(resourceVersion|uid): [^ ]+$/' ../data/backup_else.yaml)
        kubectl apply -f kube-issuer/
    EOT
  }
}