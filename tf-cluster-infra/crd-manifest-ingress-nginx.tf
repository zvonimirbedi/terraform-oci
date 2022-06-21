terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
    }
  }
}

data "http" "ingress_nginx_manifest_org_virtualservers" {
  url = "https://raw.githubusercontent.com/nginxinc/kubernetes-ingress/main/deployments/common/crds/k8s.nginx.org_virtualservers.yaml"
  request_headers = {
    Accept = "text/plain"
  }
}

resource "kubectl_manifest" "org_virtualservers" {
  yaml_body = data.http.ingress_nginx_manifest_org_virtualservers.body
}

data "http" "ingress_nginx_manifest_org_virtualserverroutes" {
  url = "https://raw.githubusercontent.com/nginxinc/kubernetes-ingress/main/deployments/common/crds/k8s.nginx.org_virtualserverroutes.yaml"
  request_headers = {
    Accept = "text/plain"
  }
}

resource "kubectl_manifest" "org_virtualserverroutes" {
  yaml_body = data.http.ingress_nginx_manifest_org_virtualserverroutes.body
}

data "http" "ingress_nginx_manifest_org_policies" {
  url = "https://raw.githubusercontent.com/nginxinc/kubernetes-ingress/main/deployments/common/crds/k8s.nginx.org_policies.yaml"
  request_headers = {
    Accept = "text/plain"
  }
}

resource "kubectl_manifest" "org_policies" {
  yaml_body = data.http.ingress_nginx_manifest_org_policies.body
}

data "http" "ingress_nginx_manifest_org_transportservers" {
  url = "https://raw.githubusercontent.com/nginxinc/kubernetes-ingress/main/deployments/common/crds/k8s.nginx.org_transportservers.yaml"
  request_headers = {
    Accept = "text/plain"
  }
}

resource "kubectl_manifest" "org_transportservers" {
  yaml_body = data.http.ingress_nginx_manifest_org_transportservers.body
}

data "http" "ingress_nginx_manifest_org_globalconfigurations" {
  url = "https://raw.githubusercontent.com/nginxinc/kubernetes-ingress/main/deployments/common/crds/k8s.nginx.org_globalconfigurations.yaml"
  request_headers = {
    Accept = "text/plain"
  }
}

resource "kubectl_manifest" "org_globalconfigurations" {
  yaml_body = data.http.ingress_nginx_manifest_org_globalconfigurations.body
}

data "http" "ingress_nginx_manifest_com_dosprotectedresources" {
  url = "https://raw.githubusercontent.com/nginxinc/kubernetes-ingress/main/deployments/common/crds/appprotectdos.f5.com_dosprotectedresources.yaml"
  request_headers = {
    Accept = "text/plain"
  }
}

resource "kubectl_manifest" "com_dosprotectedresources" {
  yaml_body = data.http.ingress_nginx_manifest_com_dosprotectedresources.body
}

data "http" "ingress_nginx_manifest_com_apdospolicy" {
  url = "https://raw.githubusercontent.com/nginxinc/kubernetes-ingress/main/deployments/common/crds/appprotectdos.f5.com_apdospolicy.yaml"
  request_headers = {
    Accept = "text/plain"
  }
}

resource "kubectl_manifest" "com_apdospolicy" {
  yaml_body = data.http.ingress_nginx_manifest_com_apdospolicy.body
}

data "http" "ingress_nginx_manifest_com_apdoslogconfs" {
  url = "https://raw.githubusercontent.com/nginxinc/kubernetes-ingress/main/deployments/common/crds/appprotectdos.f5.com_apdoslogconfs.yaml"
  request_headers = {
    Accept = "text/plain"
  }
}

resource "kubectl_manifest" "com_apdoslogconfs" {
  yaml_body = data.http.ingress_nginx_manifest_com_apdoslogconfs.body
}

data "http" "ingress_nginx_manifest_com_apusersigs" {
  url = "https://raw.githubusercontent.com/nginxinc/kubernetes-ingress/main/deployments/common/crds/appprotect.f5.com_apusersigs.yaml"
  request_headers = {
    Accept = "text/plain"
  }
}

resource "kubectl_manifest" "com_apusersigs" {
  yaml_body = data.http.ingress_nginx_manifest_com_apusersigs.body
}

data "http" "ingress_nginx_manifest_com_appolicies" {
  url = "https://raw.githubusercontent.com/nginxinc/kubernetes-ingress/main/deployments/common/crds/appprotect.f5.com_appolicies.yaml"
  request_headers = {
    Accept = "text/plain"
  }
}

resource "kubectl_manifest" "com_appolicies" {
  yaml_body = data.http.ingress_nginx_manifest_com_appolicies.body
}

data "http" "ingress_nginx_manifest_com_aplogconfs" {
  url = "https://raw.githubusercontent.com/nginxinc/kubernetes-ingress/main/deployments/common/crds/appprotect.f5.com_aplogconfs.yaml"
  request_headers = {
    Accept = "text/plain"
  }
}

resource "kubectl_manifest" "com_aplogconfs" {
  yaml_body = data.http.ingress_nginx_manifest_com_aplogconfs.body
}
