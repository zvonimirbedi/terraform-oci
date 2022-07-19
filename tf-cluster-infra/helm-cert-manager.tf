resource "kubernetes_secret" "namecheap_credentials" {
  depends_on = [
    kubernetes_namespace.namespaces
  ]
  metadata {
    name = "namecheap-credentials"
    namespace  = "tools"
  }

  data = {
    apiUser = var.namecheap_username
    apiKey = var.namecheap_key
  }

  type = "Opaque" 
}

resource "helm_release" "cert_manager" {
  depends_on = [kubernetes_secret.namecheap_credentials]
  provisioner "local-exec" {
    command = "kubectl delete Issuers,ClusterIssuers,Certificates,CertificateRequests,Orders,Challenges --all-namespaces --all"
    when    = destroy
  }
  name       = "cert-manager"
  namespace  = "tools"
  chart            = "cert-manager"
  repository       = "https://charts.jetstack.io"

  set {
    name  = "installCRDs"
    value = "true"
  }

  set {
    name  = "prometheus.enabled"
    value = "false"
  }
}

# https://github.com/Extrality/cert-manager-webhook-namecheap
resource "helm_release" "cert_manager_webhook_namecheap" {
  depends_on = [helm_release.cert_manager]
  name       = "cert-manager-webhook-namecheap"
  repository = "http://zvonimirbedi.github.io/cert-manager-webhook-namecheap/"
  chart      = "cert-manager-webhook-namecheap"
  version    = "0.1.2"
  namespace  = "tools"
}


resource "kubernetes_cluster_role_binding_v1" "cert_manager_role_binding" {
  depends_on = [helm_release.cert_manager]
  metadata {
    name = "cert_manager_role_binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role_v1.admin_role.metadata.0.name
  }
  subject {
    kind      = "ServiceAccount"
    name      = "cert-manager"
    namespace = "tools"
  }
}


resource "null_resource" "cert_secrets_and_isusers" {
  depends_on = [helm_release.cert_manager, helm_release.cert_manager_webhook_namecheap]
  # add certificates and issuers
  provisioner "local-exec" {
    # generate kube config file for new cluster
    interpreter = ["/bin/bash", "-c"]
    command     = <<-EOT
        kubectl --validate=false apply -f kube-issuer/
    EOT
  }
}