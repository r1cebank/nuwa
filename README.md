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

### NUT on Xcp-ng host

#### Enable epel library
```
yum --enablerepo=* install epel-release

yum --enablerepo=* install nut-client.x86_64
```

#### Set NUT client to netclient

```
nano /etc/ups/nut.conf
MODE=netclient
```

#### Set monitor address

```
nano /etc/ups/upsmon.conf
MONITOR ups@10.0.50.103 1 monuser secret slave
SHUTDOWNCMD "/etc/ups/xen-shutdown.sh"
```

#### Download the xen-shutdown.sh script
```
cd /etc/ups
wget https://raw.githubusercontent.com/r1cebank/nuwa/main/xen-shutdown.sh
chmod +x xen-shutdown.sh
```

#### Create nut-monitor service

```
mkdir /run/nut/
nano /etc/systemd/system/nut-monitor.service

[Unit]
Description=Network UPS Tools - XenServer Shutdown
After=local-fs.target network.target
 
[Service]
ExecStart=/usr/sbin/upsmon
PIDFile=/run/nut/upsmon.pid
Type=forking
 
[Install]
WantedBy=multi-user.target
```

#### Enable and start service

```
systemctl enable nut-monitor.service
systemctl daemon-reload
systemctl start nut-monitor
```