module "arch_mirror" {
  source = "./modules/xenvm"
  count = 1

  vm_description = "Arch Mirror Host"
  vm_name = "arch-mirror-${count.index}"
  cpus = var.arch_mirror_resources.cpus
  max_memory = var.arch_mirror_resources.memory_max
  disk_size = var.arch_mirror_resources.disk_size
  sr_id = data.xenorchestra_sr.sr_sata.id
  network_id = data.xenorchestra_network.network.id
  template_id = data.xenorchestra_template.vm_template_2204.id
  affinity_host = data.xenorchestra_pool.pool.master
  
  cloud_config_file = "resource/arch_mirror_cloudconfig.tftpl"
  mac_address = element(slice(var.vm_macs, var.arch_mirror_resources.mac_pool.start, var.arch_mirror_resources.mac_pool.end), count.index)

  tags = [
    "no-backup"
  ]
}