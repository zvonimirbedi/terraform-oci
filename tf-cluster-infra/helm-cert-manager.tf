# https://github.com/cert-manager/cert-manager/blob/master/deploy/charts/cert-manager/README.template.md
resource "helm_release" "cert_manager" {
  depends_on = [kubernetes_namespace.namespaces, helm_release.nginx_ingress_controller]
  provisioner "local-exec" {
    command = "kubectl delete Issuers,ClusterIssuers,Certificates,CertificateRequests,Orders,Challenges --all-namespaces --all"
    when    = destroy
  }
  name       = "cert-manager"
  namespace  = "networks"
  chart      = "cert-manager"
  version    = "0.7.6"
  repository = "https://charts.bitnami.com"

  set {
    name  = "installCRDs"
    value = "true"
  }
  set {
    name  = "metrics.enabled"
    value = "false"
  }
  set {
    name  = "webhook.replicaCount"
    value = "1"
  }
}

resource "kubernetes_secret" "namecheap_credentials" {
  depends_on = [kubernetes_namespace.namespaces]
  metadata {
    name = "namecheap-credentials"
    namespace  = "networks"
  }

  data = {
    apiUser = var.namecheap_username
    apiKey = var.namecheap_key
  }

  type = "Opaque" 
}

# https://github.com/Extrality/cert-manager-webhook-namecheap
resource "helm_release" "cert_manager_webhook_namecheap" {
  depends_on = [helm_release.cert_manager, kubernetes_secret.namecheap_credentials]
  name       = "cert-manager-webhook-namecheap"
  repository = "http://zvonimirbedi.github.io/cert-manager-webhook-namecheap/"
  chart      = "cert-manager-webhook-namecheap"
  version    = "0.1.2"
  namespace  = "networks"
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
    name      = "cert-manager-controller"
    namespace = "networks"
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