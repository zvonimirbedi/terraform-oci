# terraform-oci
Terraform OCI repo

````
terraform init
terraform validate 
terraform plan -var-file="../variables.tfvars"
terraform apply -auto-approve -var-file="../variables.tfvars"
# apply with 'cherrypick' replace:
# terraform apply -auto-approve -var-file="../variables.tfvars" -replace=oci_core_volume.cluster_wordpress_volume
# terraform destroy -auto-approve -var-file="../variables.tfvars"
````

````
# cetmanager something 
kubectl apply --validate=false -f https://github.com/cert-manager/cert-manager/releases/download/v1.8.2/cert-manager.yaml
# force delete ns
kubectl get namespace "tools" -o json   | tr -d "\n" | sed "s/\"finalizers\": \[[^]]\+\]/\"finalizers\": []/"   | kubectl replace --raw /api/v1/namespaces/tools/finalize -f -
# or
kubectl delete apiservice v1beta1.webhook.cert-manager.io
````