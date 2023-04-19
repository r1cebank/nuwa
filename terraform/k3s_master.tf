module "k3s_master_cluster" {
  source = "./modules/xenvm"
  count  = var.k3s_master_cluster_resources.size

  vm_description = "K3S Master Host"
  vm_name        = "k3s-master-${count.index}"
  cpus           = var.k3s_master_cluster_resources.cpus
  max_memory     = var.k3s_master_cluster_resources.memory_max
  disk_size      = var.k3s_master_cluster_resources.disk_size
  sr_id          = data.xenorchestra_sr.sr_nvme.id
  network_id     = data.xenorchestra_network.homelab_network.id
  template_id    = data.xenorchestra_template.vm_template_2204.id
  affinity_host  = data.xenorchestra_host.cerulean.id

  cloud_config_file         = "resource/k3s_cloudconfig.tftpl"
  cloud_network_config_file = "resource/networkconfig_static.tftpl"
  cloud_network_config_args = {
    ip_address      = element(var.k3s_master_cluster_resources.ips, count.index),
    subnet_mask     = "255.255.255.0"
    gateway_address = "10.0.60.1"
    dns_server1     = "1.1.1.1"
  }

  tags = [
    "k3s",
    "master"
  ]
}
