.EXPORT_ALL_VARIABLES:

GPG_EMAIL=siyuangao@pm.me
GPG_NAME=Siyuan Gao
ANSIBLE_CONFIG=ansible/ansible.cfg
OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

.PHONY: default
default: clean

.PHONY: prepare-terraform
prepare-terraform:
	$(shell ./terraform/prepare_terraform.sh)
	terraform -chdir=terraform init

.PHONY: prepare-vm
prepare-vm:
	terraform -chdir=terraform plan

.PHONY: apply-vm
apply-vm:
	terraform -chdir=terraform apply -parallelism=1

.PHONY: destroy-vm
destroy-vm:
	terraform -chdir=terraform destroy

.PHONY: prepare-ansible
prepare-ansible: ansible-credentials install-ansible-dependencies

.PHONY: install-ansible-dependencies
install-ansible-dependencies: ansible-galaxy role install -r ./ansible/requirements.yml

.PHONY: ansible-credentials
ansible-credentials:
	$(shell ./ansible/.vault/generate_vault_passphrase.sh)
	ansible-playbook ./ansible/generate_vault_credentials.yml

.PHONY: view-vault-credentials
view-vault-credentials:
	ansible-vault view --vault-password-file=./ansible/.vault/vault_pass.sh ./ansible/vars/vault.yml

.PHONY: gateway-setup
gateway-setup:
	ansible-playbook setup_picluster.yml --tags "gateway"

.PHONY: nodes-setup
nodes-setup:
	ansible-playbook setup_picluster.yml --tags "nodes"

.PHONY: essential-services
essential-services:
	ansible-playbook ansible/essential_services.yml --vault-password-file=./ansible/.vault/vault_pass.sh

.PHONY: configure-os-backup
configure-os-backup:
	ansible-playbook backup_configuration.yml

.PHONY: configure-monitoring-gateway
configure-monitoring-gateway:
	ansible-playbook deploy_monitoring_agent.yml

.PHONY: os-backup
os-backup:
	ansible -b -m shell -a 'systemctl start restic-backup' raspberrypi

.PHONY: k3s-install
k3s-install:
	ansible-playbook k3s_install.yml

.PHONY: k3s-bootstrap
k3s-bootstrap:
	ansible-playbook k3s_bootstrap.yml

.PHONY: k3s-reset
k3s-reset:
	ansible-playbook k3s_reset.yml

.PHONY: external-services-reset
external-services-reset:
	ansible-playbook reset_external_services.yml

.PHONY: shutdown-k3s-worker
shutdown-k3s-worker:
	ansible -b -m shell -a "shutdown -h 1 min" k3s_worker

.PHONY: shutdown-k3s-master
shutdown-k3s-master:
	ansible -b -m shell -a "shutdown -h 1 min" k3s_master

.PHONY: shutdown-gateway
shutdown-gateway:
	ansible -b -m shell -a "shutdown -h 1 min" gateway
