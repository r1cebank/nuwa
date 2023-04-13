/* Doing this because bug in the xenorchestra
  provider prevent using random mac and outdated requirement */
variable "vm_macs" {
  default = [
    "00-39-39-78-98-DC",
    "00-39-39-E8-89-68",
    "00-39-39-38-8C-20",
    "00-39-39-31-D0-E1",
    "00-39-39-DB-22-2B",
    "00-39-39-00-90-4F",
    "00-39-39-91-EA-1C",
    "00-39-39-5D-DE-58",
    "00-39-39-16-5A-B1",
    "00-39-39-FA-24-46",
    "00-39-39-55-C0-1D",
    "00-39-39-36-F8-85",
    "00-39-39-0A-D1-77",
    "00-39-39-B4-4B-BB",
    "00-39-39-59-7D-22",
    "00-39-39-A1-04-A5",
    "00-39-39-CD-A1-CD",
    "00-39-39-4E-6E-B3",
    "00-39-39-D6-CF-65",
    "00-39-39-49-4B-EA",
    "00-39-39-91-66-F8",
    "00-39-39-40-3A-8D",
    "00-39-39-C2-2C-C2",
    "00-39-39-28-D7-A3",
    "00-39-39-95-44-15",
    "00-39-39-E8-19-78",
    "00-39-39-DB-43-3E",
    "00-39-39-71-06-A3",
    "00-39-39-E0-62-0D",
    "00-39-39-4F-C5-F1"
  ]
}

variable "k3s_master_cluster_resources" {
  default = {
    memory_max = 4 * 1024 * 1024 * 1024   # 4gb
    disk_size  = 100 * 1024 * 1024 * 1024 # 100gb
    size       = 3
    cpus       = 1
    ips = [
      "192.168.1.100",
      "192.168.1.101",
      "192.168.1.102"
    ]
    mac_pool = {
      start = 0
      end   = 3
    }
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
      "192.168.1.103",
      "192.168.1.104",
      "192.168.1.105"
    ]
    mac_pool = {
      start = 3
      end   = 6
    }
  }
}

variable "arch_mirror_resources" {
  default = {
    memory_max = 1 * 1024 * 1024 * 1024   # 1 gb
    disk_size  = 200 * 1024 * 1024 * 1024 # 200 gb
    size       = 1
    cpus       = 1
    ips = [
      "192.168.1.106"
    ]
    mac_pool = {
      start = 6
      end   = 7
    }
  }
}

variable "minio_host_resources" {
  default = {
    memory_max = 1 * 1024 * 1024 * 1024  # 1 gb
    disk_size  = 20 * 1024 * 1024 * 1024 # 20 gb
    size       = 1
    cpus       = 1
    ips = [
      "192.168.1.107"
    ]
    mac_pool = {
      start = 7
      end   = 8
    }
  }
}

variable "hashicorp_vault_resources" {
  default = {
    memory_max = 1 * 1024 * 1024 * 1024  # 1 gb
    disk_size  = 20 * 1024 * 1024 * 1024 # 20 gb
    size       = 1
    cpus       = 1
    ips = [
      "192.168.1.108"
    ]
    mac_pool = {
      start = 8
      end   = 9
    }
  }
}
