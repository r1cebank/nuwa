module "minio_server" {
  source = "./modules/proxmoxvm"
  count  = 1

  vm_description = "Minio Host"
  vm_name        = "minio-${count.index}"
  cpus           = var.minio_host_resources.cpus
  max_memory     = var.minio_host_resources.memory_max
  disk_size      = var.minio_host_resources.disk_size
  network_id     = "vmbr0"
  template_id    = "debian-12-cloudinit-template"
  affinity_host_name = var.minio_host_resources.node_names[0]
  affinity_host = var.minio_host_resources.node_hosts[0]
  main_disk_storage = "ceph"

  cloud_init_storage = "local-lvm"
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
  additional_disk_storage = "local-lvm"

  # set other required values
  external_env = data.external.env.result
  tags = [
    "minio"
  ]
}
