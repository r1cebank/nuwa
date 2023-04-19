module "arch_mirror" {
  source = "./modules/xenvm"
  count  = 1

  vm_description = "Arch Mirror Host"
  vm_name        = "arch-mirror-${count.index}"
  cpus           = var.arch_mirror_resources.cpus
  max_memory     = var.arch_mirror_resources.memory_max
  disk_size      = var.arch_mirror_resources.disk_size
  sr_id          = data.xenorchestra_sr.sr_sata.id
  network_id     = data.xenorchestra_network.homelab_network.id
  template_id    = data.xenorchestra_template.vm_template_2204.id
  affinity_host  = data.xenorchestra_host.cerulean.id

  cloud_config_file         = "resource/arch_mirror_cloudconfig.tftpl"
  cloud_network_config_file = "resource/networkconfig_static.tftpl"
  cloud_network_config_args = {
    ip_address      = element(var.arch_mirror_resources.ips, count.index),
    subnet_mask     = "255.255.255.0"
    gateway_address = "10.0.60.1"
    dns_server1     = "1.1.1.1"
  }

  tags = [
    "no-backup"
  ]
}
