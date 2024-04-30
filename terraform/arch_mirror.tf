module "arch_mirror" {
  source = "./modules/proxmoxvm"
  count  = 1

  vm_description = "Arch Mirror Host"
  vm_name        = "arch-mirror-${count.index}"
  cpus           = var.arch_mirror_resources.cpus
  max_memory     = var.arch_mirror_resources.memory_max
  disk_size      = var.arch_mirror_resources.disk_size
  network_id     = "vmbr0"
  template_id    = "debian-12-cloudinit-template"
  affinity_host_name  = var.arch_mirror_resources.node_names[0]
  affinity_host = var.arch_mirror_resources.node_hosts[0]
  cloud_init_storage = "local-lvm"
  main_disk_storage = "local-lvm"

  cloud_config_file         = "resource/arch_mirror_cloudconfig.tftpl"
  cloud_network_config_file = "resource/networkconfig_static.tftpl"

  # pass in the IP address from the list of IPs
  cloud_network_config_args = {
    ip_address      = element(var.arch_mirror_resources.ips, count.index),
    subnet_mask     = "255.255.255.0"
    gateway_address = "10.0.60.1"
    dns_server1     = "1.1.1.1"
  }


  # set other required values
  external_env = data.external.env.result
  tags = [
    "no-backup"
  ]
}
