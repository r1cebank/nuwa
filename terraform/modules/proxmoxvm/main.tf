terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
    }
  }
}

resource "null_resource" "cloud_init_user_data_file" {
  connection {
    user     = "root"
    password = var.external_env.PROXMOX_HOST_PASSWORD
    host     = var.affinity_host
    port     = 22
  }
  provisioner "file" {
    content = templatefile("${var.cloud_config_file}", {
      hostname = "${var.vm_name}"
    })
    destination = "/var/lib/vz/snippets/user_data_vm-${var.vm_name}.yml"
  }
}

resource "null_resource" "cloud_init_network_data_file" {
  connection {
    user     = "root"
    password = var.external_env.PROXMOX_HOST_PASSWORD
    host     = var.affinity_host
    port     = 22
  }
  provisioner "file" {
    content     = templatefile("${var.cloud_network_config_file}", var.cloud_network_config_args)
    destination = "/var/lib/vz/snippets/network_data_vm-${var.vm_name}.yml"
  }
}

resource "proxmox_vm_qemu" "vm" {
  name = var.vm_name
  desc = var.vm_description
  clone = var.template_id
  full_clone = true
  # Activate QEMU agent for this VM
  agent                   = 1
  os_type                 = "cloud-init"
  target_node             = var.affinity_host_name
  cores                   = var.cpus
  sockets                 = 1
  vcpus                   = 0
  cpu                     = "host"
  memory                  = var.max_memory
  vm_state                = "running"
  ciuser                  = "root"
  cloudinit_cdrom_storage = var.cloud_init_storage
  cicustom                = "user=local:snippets/user_data_vm-${var.vm_name}.yml,network=local:snippets/network_data_vm-${var.vm_name}.yml"
  scsihw                  = "virtio-scsi-single"

  # Setup the network interface
  network {
    model  = "virtio"
    bridge = var.network_id
  }
  # Setup the disk
  disks {
    scsi {
      scsi0 {
        disk {
          size    = var.disk_size
          storage = var.main_disk_storage
          emulatessd = true
          iothread = false
          discard = true
          backup = true
          replicate = true
        }
      }
      dynamic "scsi1" {
        for_each = var.additional_disk == true ? toset([1]) : toset([])
        content {
          disk {
            size    = var.additional_disk_size
            storage = var.additional_disk_storage
          }
        }
      }
    }
  }

  tags = join(",", var.tags)

  depends_on = [
    null_resource.cloud_init_user_data_file,
    null_resource.cloud_init_network_data_file,
  ]

  lifecycle {
    replace_triggered_by = [
      null_resource.cloud_init_user_data_file,
      null_resource.cloud_init_network_data_file,
    ]
  }
}
