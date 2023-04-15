terraform {
  required_providers {
    xenorchestra = {
      source = "terra-farm/xenorchestra"
    }
  }
}

resource "xenorchestra_vm" "xenvm" {
  affinity_host    = var.affinity_host
  memory_max       = var.max_memory
  cpus             = var.cpus
  name_label       = var.vm_name
  name_description = var.vm_description
  template         = var.template_id
  cloud_config = templatefile("${var.cloud_config_file}", {
    hostname = "${var.vm_name}"
  })

  cloud_network_config = templatefile("${var.cloud_network_config_file}", var.cloud_network_config_args)

  network {
    network_id  = var.network_id
  }

  disk {
    sr_id      = var.sr_id
    name_label = "${var.vm_name} root volume"
    size       = var.disk_size
  }

  dynamic "disk" {
    for_each = var.additional_disk == true ? toset([1]) : toset([])

    content {
      sr_id      = var.additional_disk_sr_id
      name_label = "${var.vm_name} additional volume"
      size       = var.additional_disk_size
    }
  }


  wait_for_ip = true

  tags = var.tags
}
