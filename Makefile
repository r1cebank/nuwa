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

.PHONY: vm-plan
vm-plan:
	terraform -chdir=terraform plan

.PHONY: vm-apply
vm-apply:
	terraform -chdir=terraform apply -parallelism=1

.PHONY: vm-destroy
vm-destroy:
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

.PHONY: essential-services
essential-services:
	ansible-playbook ansible/essential_services.yml --vault-password-file=./ansible/.vault/vault_pass.sh

.PHONY: k3s-install
k3s-install:
	ansible-playbook ansible/k3s_install.yml --vault-password-file=./ansible/.vault/vault_pass.sh

.PHONY: k3s-bootstrap
k3s-bootstrap:
	ansible-playbook ansible/k3s_bootstrap.yml --vault-password-file=./ansible/.vault/vault_pass.sh

.PHONY: k3s-apps
k3s-apps:
	ansible-playbook ansible/k3s_apps.yml --vault-password-file=./ansible/.vault/vault_pass.sh

.PHONY: arch-mirror
arch-mirror:
	ansible-playbook ansible/arch_mirror.yml --vault-password-file=./ansible/.vault/vault_pass.sh

.PHONY: k3s-uninstall
k3s-uninstall:
	ansible-playbook ansible/k3s_uninstall.yml

.PHONY: services-uninstall
services-uninstall:
	ansible-playbook ansible/reset_essential_services.yml
