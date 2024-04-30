module "k3s_worker_cluster" {
  source = "./modules/proxmoxvm"
  count  = var.k3s_worker_cluster_resources.size

  vm_description = "K3S Worker Host"
  vm_name        = "k3s-worker-${count.index}"
  cpus           = var.k3s_worker_cluster_resources.cpus
  max_memory     = var.k3s_worker_cluster_resources.memory_max
  disk_size      = var.k3s_worker_cluster_resources.disk_size
  network_id     = "vmbr0"
  template_id    = "debian-12-cloudinit-template"
  affinity_host_name  = element(var.k3s_worker_cluster_resources.node_names, count.index)
  affinity_host = element(var.k3s_worker_cluster_resources.node_hosts, count.index)
  main_disk_storage = "ceph"

  cloud_init_storage = "local-lvm"
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
  additional_disk_storage = "local-lvm"

  # set other required values
  external_env = data.external.env.result
  tags = [
    "k3s",
    "longhorn",
    "worker",
    "k3s-worker-ha"
  ]
}
