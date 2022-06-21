data "http" "cert_manager_manifest" {
  url = "https://github.com/cert-manager/cert-manager/releases/download/v1.8.0/cert-manager.yaml"
  request_headers = {
    Accept = "text/plain"
  }
}
data "kubectl_file_documents" "cert_manager_docs" {
    content = data.http.cert_manager_manifest.body
}

resource "kubectl_manifest" "cert_manager_manifest" {
    count     = length(data.kubectl_file_documents.cert_manager_docs.documents)
    yaml_body = element(data.kubectl_file_documents.cert_manager_docs.documents, count.index)

}