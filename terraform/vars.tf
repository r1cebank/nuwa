/* Doing this because bug in the xenorchestra
  provider prevent using random mac and outdated requirement */

variable "k3s_master_cluster_resources" {
  default = {
    memory_max = 16 * 1024   # 16gb
    disk_size  = 200 # 200gb
    size       = 3
    cpus       = 4
    ips = [
      "10.0.60.100",
      "10.0.60.101",
      "10.0.60.102",
    ]
    node_names = [
      "aero",
      "arctic",
      "cerulean"
    ]
    node_hosts = [
      "aero.miku.cx",
      "arctic.miku.cx",
      "cerulean.miku.cx"
    ]
  }
}

variable "k3s_worker_cluster_resources" {
  default = {
    memory_max           = 32 * 1024 # 32gb
    disk_size            = 200 # 200gb
    additional_disk_size = 1024 # 1tb
    size                 = 3
    cpus                 = 8
    ips = [
      "10.0.60.103",
      "10.0.60.104",
      "10.0.60.105",
    ]
    node_names = [
      "aero",
      "arctic",
      "cerulean"
    ]
    node_hosts = [
      "aero.miku.cx",
      "arctic.miku.cx",
      "cerulean.miku.cx"
    ]
  }
}

variable "arch_mirror_resources" {
  default = {
    memory_max = 1 * 1024 # 1 gb
    disk_size  = 200 # 200 gb
    size       = 1
    cpus       = 1
    ips = [
      "10.0.60.106",
    ]
    node_names = [
      "aero"
    ]
    node_hosts = [
      "aero.miku.cx"
    ]
  }
}

variable "minio_host_resources" {
  default = {
    memory_max = 1 * 1024 # 1 gb
    disk_size  = 32 # 32 gb
    additional_disk_size = 500 # 500gb
    size       = 1
    cpus       = 1
    ips = [
      "10.0.60.107",
    ]
    node_names = [
      "arctic"
    ]
    node_hosts = [
      "arctic.miku.cx"
    ]
  }
}

variable "hashicorp_vault_resources" {
  default = {
    memory_max = 1 * 1024 # 1 gb
    disk_size  = 32 # 32 gb
    size       = 1
    cpus       = 1
    ips = [
      "10.0.60.108",
    ]
    node_names = [
      "cerulean"
    ]
    node_hosts = [
      "cerulean.miku.cx"
    ]
  }
}
