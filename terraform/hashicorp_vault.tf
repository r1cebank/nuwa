module "hashicorp_vault" {
  source = "./modules/proxmoxvm"
  count  = 1

  vm_description = "Hashicorp Vault Host"
  vm_name        = "hashicorp-vault-${count.index}"
  cpus           = var.hashicorp_vault_resources.cpus
  max_memory     = var.hashicorp_vault_resources.memory_max
  disk_size      = var.hashicorp_vault_resources.disk_size
  network_id     = "vmbr0"
  template_id    = "debian-12-cloudinit-template"
  affinity_host_name = var.hashicorp_vault_resources.node_names[0]
  affinity_host = var.hashicorp_vault_resources.node_hosts[0]
  cloud_init_storage = "local-lvm"
  main_disk_storage = "ceph"

  cloud_config_file         = "resource/hashicorp_vault_cloudconfig.tftpl"
  cloud_network_config_file = "resource/networkconfig_static.tftpl"
  cloud_network_config_args = {
    ip_address      = element(var.hashicorp_vault_resources.ips, count.index),
    subnet_mask     = "255.255.255.0"
    gateway_address = "10.0.60.1"
    dns_server1     = "1.1.1.1"
  }

  # set other required values
  external_env = data.external.env.result
  tags = [
    "vault"
  ]
}
