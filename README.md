# terraform-oci
Terraform OCI repo

* terraform init
* terraform validate 
* terraform plan -var-file="../variables.tfvars"
* terraform apply -auto-approve -var-file="../variables.tfvars"
* terraform destroy -auto-approve -var-file="../variables.tfvars"


kubectl apply --validate=false -f https://github.com/cert-manager/cert-manager/releases/download/v1.8.2/cert-manager.yaml

kubectl apply -f ../kube-issuer/issuer-grafana.yaml 