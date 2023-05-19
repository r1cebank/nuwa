/* Doing this because bug in the xenorchestra
  provider prevent using random mac and outdated requirement */

variable "k3s_master_cluster_resources" {
  default = {
    memory_max = 16 * 1024 * 1024 * 1024   # 16gb
    disk_size  = 100 * 1024 * 1024 * 1024 # 100gb
    size       = 3
    cpus       = 1
    ips = [
      "10.0.60.100",
      "10.0.60.101",
      "10.0.60.102",
    ]
  }
}

variable "k3s_worker_cluster_resources" {
  default = {
    memory_max           = 32 * 1024 * 1024 * 1024  # 32gb
    disk_size            = 100 * 1024 * 1024 * 1024  # 100gb
    additional_disk_size = 500 * 1024 * 1024 * 1024 # 500gb
    size                 = 3
    cpus                 = 4
    ips = [
      "10.0.60.103",
      "10.0.60.104",
      "10.0.60.105",
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
      "10.0.60.106",
    ]
  }
}

variable "minio_host_resources" {
  default = {
    memory_max = 1 * 1024 * 1024 * 1024  # 1 gb
    disk_size  = 20 * 1024 * 1024 * 1024 # 20 gb
    additional_disk_size = 500 * 1024 * 1024 * 1024 # 500gb
    size       = 1
    cpus       = 1
    ips = [
      "10.0.60.107",
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
      "10.0.60.108",
    ]
  }
}
