# Services
Services orchestrated by ansible playbooks

## Inventory
The `inventory/hosts.ini` for ansible should be auto populated by terraform after creating the vm in the infrastructure section of the project. The playbook will reference the group defined in the inventory and run specific roles on them.

## Running playbooks

### Run site playbook
This runs the main playbook to setup the site, due to some of the global vars are encrypted by ansible vault, we will need to pass ask vault-pass to decrypt them during run time
```
ansible-playbook site.yml -i inventory/hosts.ini --ask-vault-pass 
```

### Reset VM
This resets the VM in to a near clean configuration, removing mostly everything the playbook will install

```
ansible-playbook reset.yml -i inventory/hosts.ini 
```

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
