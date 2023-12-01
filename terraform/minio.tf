module "minio_server" {
  source = "./modules/xenvm"
  count  = 1

  vm_description = "Minio Host"
  vm_name        = "minio-${count.index}"
  cpus           = var.minio_host_resources.cpus
  max_memory     = var.minio_host_resources.memory_max
  disk_size      = var.minio_host_resources.disk_size
  sr_id          = data.xenorchestra_sr.cerulean_sata.id
  network_id     = data.xenorchestra_network.default_network.id
  template_id    = data.xenorchestra_template.vm_template_22043.id
  affinity_host  = data.xenorchestra_pool.pool.master

  cloud_config_file         = "resource/minio_cloudconfig.tftpl"
  cloud_network_config_file = "resource/networkconfig_static.tftpl"
  cloud_network_config_args = {
    ip_address      = element(var.minio_host_resources.ips, count.index),
    subnet_mask     = "255.255.255.0"
    gateway_address = "10.0.60.1"
    dns_server1     = "1.1.1.1"
  }

  additional_disk      = true
  additional_disk_size = var.minio_host_resources.additional_disk_size
  additional_disk_sr_id = data.xenorchestra_sr.cerulean_sata.id

  tags = [
    "minio"
  ]
}
