### run all yaml issuers
kubectl apply -f ../kube-issuer/

### Backup and Restore Resources

#### Backup
kubectl get --all-namespaces -oyaml issuer,clusterissuer,cert | tee backup_else.yaml
kubectl get -n tools secret | grep -o '^clusterissuer.*Opaque' | grep -o '.* ' | xargs | xargs -I '{}' bash -c 'kubectl get -n tools -oyaml secrets {} | tee backup_secret.yaml'

#### Restore
kubectl apply -f <(awk '!/^ *(resourceVersion|uid): [^ ]+$/' backup_secret.yaml)
