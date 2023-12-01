module "k3s_worker_cluster" {
  source = "./modules/xenvm"
  count  = var.k3s_worker_cluster_resources.size

  vm_description = "K3S Worker Host"
  vm_name        = "k3s-worker-${count.index}"
  cpus           = var.k3s_worker_cluster_resources.cpus
  max_memory     = var.k3s_worker_cluster_resources.memory_max
  disk_size      = var.k3s_worker_cluster_resources.disk_size
  sr_id          = element([
    data.xenorchestra_sr.aero_sata.id,
    data.xenorchestra_sr.arctic_sata.id,
    data.xenorchestra_sr.cerulean_sata.id
  ], count.index)
  network_id     = data.xenorchestra_network.default_network.id
  template_id    = data.xenorchestra_template.vm_template_22043.id
  affinity_host  = element([
    data.xenorchestra_host.aero.id,
    data.xenorchestra_host.arctic.id,
    data.xenorchestra_host.cerulean.id
  ], count.index)

  cloud_config_file         = "resource/k3s_worker_cloudconfig.tftpl"
  cloud_network_config_file = "resource/networkconfig_static.tftpl"
  cloud_network_config_args = {
    ip_address      = element(var.k3s_worker_cluster_resources.ips, count.index),
    subnet_mask     = "255.255.255.0"
    gateway_address = "10.0.60.1"
    dns_server1     = "1.1.1.1"
  }

  additional_disk      = true
  additional_disk_size = var.k3s_worker_cluster_resources.additional_disk_size
  additional_disk_sr_id = element([
    data.xenorchestra_sr.aero_nvme.id,
    data.xenorchestra_sr.arctic_nvme.id,
    data.xenorchestra_sr.cerulean_nvme.id
  ], count.index)

  tags = [
    "k3s",
    "longhorn",
    "worker",
    "k3s-worker-ha"
  ]
}
