/* Doing this because bug in the xenorchestra
  provider prevent using random mac and outdated requirement */

variable "k3s_master_cluster_resources" {
  default = {
    memory_max = 4 * 1024 * 1024 * 1024   # 4gb
    disk_size  = 100 * 1024 * 1024 * 1024 # 100gb
    size       = 3
    cpus       = 1
    ips = [
      "10.0.70.100",
      "10.0.70.101",
      "10.0.70.102",
    ]
  }
}

variable "k3s_worker_cluster_resources" {
  default = {
    memory_max           = 12 * 1024 * 1024 * 1024  # 12gb
    disk_size            = 100 * 1024 * 1024 * 1024  # 100gb
    additional_disk_size = 500 * 1024 * 1024 * 1024 # 500gb
    size                 = 3
    cpus                 = 4
    ips = [
      "10.0.70.103",
      "10.0.70.104",
      "10.0.70.105",
    ]
  }
}

variable "arch_mirror_resources" {
  default = {
    memory_max = 1 * 1024 * 1024 * 1024   # 1 gb
    disk_size  = 200 * 1024 * 1024 * 1024 # 200 gb
    size       = 1
    cpus       = 1
    ips = [
      "10.0.70.106",
    ]
  }
}

variable "minio_host_resources" {
  default = {
    memory_max = 1 * 1024 * 1024 * 1024  # 1 gb
    disk_size  = 20 * 1024 * 1024 * 1024 # 20 gb
    size       = 1
    cpus       = 1
    ips = [
      "10.0.70.107",
    ]
  }
}

variable "hashicorp_vault_resources" {
  default = {
    memory_max = 1 * 1024 * 1024 * 1024  # 1 gb
    disk_size  = 20 * 1024 * 1024 * 1024 # 20 gb
    size       = 1
    cpus       = 1
    ips = [
      "10.0.70.108",
    ]
  }
}
