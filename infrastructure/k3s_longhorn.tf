module "k3s_longhorn_cluster" {
  source = "./modules/xenvm"
  count = var.k3s_longhorn_cluster_resources.size

  vm_description = "K3S Longhorn Host"
  vm_name = "k3s-longhorn-${count.index}"
  cpus = var.k3s_longhorn_cluster_resources.cpus
  max_memory = var.k3s_longhorn_cluster_resources.memory_max
  disk_size = var.k3s_longhorn_cluster_resources.disk_size
  sr_id = data.xenorchestra_sr.sr_nvme.id
  network_id = data.xenorchestra_network.network.id
  template_id = data.xenorchestra_template.vm_template_2204.id
  affinity_host = data.xenorchestra_pool.pool.master
  
  cloud_config_file = "resource/k3s_longhorn_cloudconfig.tftpl"
  mac_address = element(slice(
    var.vm_macs,
    var.k3s_longhorn_cluster_resources.mac_pool.start,
    var.k3s_longhorn_cluster_resources.mac_pool.end
  ), count.index)
  
  tags = [
    "k3s",
    "longhorn"
  ]
}