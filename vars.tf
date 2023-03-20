variable "k3s_hosts" {
  default = {
    vm0 = {
      name: "k3s-0"
      hostname: "k3s-0"
      description: "K3S Host"
      mac: "00-39-39-06-37-99"
    }
    vm1 = {
      name: "k3s-1"
      hostname: "k3s-1"
      description: "K3S Host"
      mac: "00-39-39-E4-81-A2"
    }
    vm2 = {
      name: "k3s-2"
      hostname: "k3s-2"
      description: "K3S Host"
      mac: "00-39-39-FB-79-A3"
    }
  }
}

variable "arch_mirror_hosts" {
  default = {
    vm0 = {
      name: "arch-mirror-0"
      hostname: "arch-mirror-0"
      description: "Arch Mirror Host"
      mac: "00-39-39-DC-5A-99"
    }
  }
}

variable "k3s_resources" {
  default = {
    memory_max = 8 * 1024 * 1024 * 1024 # 8gb
    disk_size = 50 * 1024 * 1024 * 1024 # 50gb
  }
}

variable "arch_mirror_resources" {
  default = {
    memory_max = 1 * 1024 * 1024 * 1024 # 1 gb
    disk_size = 200 * 1024 * 1024 * 1024 # 200 gb
  }
}