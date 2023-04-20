# Services

We are using argocd to manage all the deployment of our apps or services on the k3s cluster.

### Checking linkerd status for pods
```
./linkerd --kubeconfig /etc/rancher/k3s/k3s.yaml viz edges pod -n NAMESPACE
```

### Get argocd admin init password

```
kubectl --kubeconfig ~/.kube/k3s.yaml get secret argocd-initial-admin-secret  --template={{.data.password}} -n argocd | base64 -d | pbcopy
```