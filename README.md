# nuwa
My personal homelab setup config, using terraform and ansible

## Infrastructure

Single node XCP-NG host, 9 VM hosting K3s, repo mirror and longhorn

[Readme](infrastructure/README.md)

## Services

[Readme](argocd/README.md)


### Backup cluster

Longhorn volumes needs to be ignored in order to restore properly
```
velero --kubeconfig ~/.kube/k3s.yaml backup create lh-cluster --exclude-resources persistentvolumes,persistentvolumeclaims,backuptargets.longhorn.io,backupvolumes.longhorn.io,backups.longhorn.io,nodes.longhorn.io,volumes.longhorn.io,engines.longhorn.io,replicas.longhorn.io,backingimagedatasources.longhorn.io,backingimagemanagers.longhorn.io,backingimages.longhorn.io,sharemanagers.longhorn.io,instancemanagers.longhorn.io,engineimages.longhorn.io
```

### Restore cluster

Create the restore clean cluster

```
ansible-playbook restore.yml -i inventory/hosts.ini --ask-vault-pass
```

Create velero restore
```
velero --kubeconfig ~/.kube/k3s.yaml restore create --from-backup lh-cluster
```

Remove all instance-manager pods

https://longhorn.io/docs/1.3.0/advanced-resources/cluster-restore/restore-to-a-new-cluster-using-velero/#create-backup-for-the-old-cluster

This is necessary if nodes are configured unevenly (longhorn schedulable nodes/disabled nodes exist in cluster).
```
kubectl --kubeconfig ~/.kube/k3s.yaml get pods -n longhorn-system --no-headers=true | awk '/instance-manager/{print $1}' | xargs kubectl --kubeconfig ~/.kube/k3s.yaml delete -n longhorn-system pod
```

### Access Longhorn UI

```
kubectl --kubeconfig ~/.kube/k3s.yaml --namespace longhorn-system port-forward --address 0.0.0.0 service/longhorn-frontend 5080:80
```
