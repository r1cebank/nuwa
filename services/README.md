# Services
Services orchestrated by ansible playbooks

## Inventory
The `inventory/hosts.ini` for ansible should be auto populated by terraform after creating the vm in the infrastructure section of the project. The playbook will reference the group defined in the inventory and run specific roles on them.

## Running playbooks

### Reset VM
This resets the VM in to a near clean configuration, removing mostly everything the playbook will install

```
ansible-playbook reset.yml -i inventory/hosts.ini 
```

### Run site playbook
This runs the main playbook to setup the site, due to some of the global vars are encrypted by ansible vault, we will need to pass ask vault-pass to decrypt them during run time
```
ansible-playbook site.yml -i inventory/hosts.ini --ask-vault-pass 
```