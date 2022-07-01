### Backup and Restore Resources

#### Restore
kubectl apply -f <(awk '!/^ *(resourceVersion|uid): [^ ]+$/' ../backup_secret.yaml)
kubectl apply -f <(awk '!/^ *(resourceVersion|uid): [^ ]+$/' ../backup_else.yaml)

### run all yaml issuers
kubectl apply -f kube-issuer/
# kubectl delete -f ../kube-issuer/

#### Backup
kubectl get --all-namespaces -oyaml issuer,clusterissuer,cert | tee ../backup_else.yaml
kubectl get -n tools secret | grep -o '^clusterissuer.*Opaque' | grep -o '.* ' | xargs | xargs -I '{}' bash -c 'kubectl get -n tools -oyaml secrets {} | tee ../backup_secret.yaml'

