# https://github.com/bitnami/charts/tree/master/bitnami/nginx-ingress-controller
resource "helm_release" "nginx_ingress_controller" {
  //depends_on = [null_resource.trigger_cronjob_bucket_to_volume_tools]
  name       = "nginx-ingress-controller"
  namespace  = "tools"
  chart      = "nginx-ingress-controller"
  version    = "9.2.24"
  repository = "https://charts.bitnami.com/bitnami"

  set {
    name  = "service.type"
    value = "NodePort"
  }
  set {
    name  = "service.ports.http"
    value = "80"
  }
  set {
    name  = "service.targetPorts.http"
    value = "80"
  }
  set {
    name  = "service.nodePorts.http"
    value = "30080"
  }
  set {
    name  = "service.ports.https"
    value = "443"
  }
  set {
    name  = "service.targetPorts.https"
    value = "443"
  }
  set {
    name  = "service.nodePorts.https"
    value = "30443"
  }
  set {
    name  = "defaultBackend.enabled"
    value = "false"
  }
}

resource "kubernetes_cluster_role_binding_v1" "nginx_ingress_controller_role_binding" {
  depends_on = [helm_release.cert_manager]
  metadata {
    name = "nginx_ingress_controller_role_binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role_v1.admin_role.metadata.0.name
  }
  subject {
    kind      = "ServiceAccount"
    name      = "nginx-ingress-controller"
    namespace = "tools"
  }
}