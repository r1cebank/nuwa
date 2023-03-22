terraform {
  required_providers {
    xenorchestra = {
      source = "terra-farm/xenorchestra"
    }
  }
}

resource "xenorchestra_vm" "xenvm" {
  affinity_host = var.affinity_host
  memory_max = var.max_memory
  cpus = var.cpus
  name_label = "${var.vm_name}"
  name_description = var.vm_description
  template = var.template_id
  cloud_config = templatefile("${var.cloud_config_file}", {
        hostname = "${var.vm_name}"
  })

  network {
    network_id = var.network_id
    mac_address = var.mac_address
  }

  disk {
    sr_id = var.sr_id
    name_label = "${var.vm_name} root volume"
    size = var.disk_size
  }

  wait_for_ip = true

  tags = var.tags
}