resource "xenorchestra_vm" "arch_mirror_vm" {
  for_each = var.arch_mirror_hosts
  affinity_host = data.xenorchestra_pool.pool.master
  memory_max = var.arch_mirror_resources.memory_max
  cpus = 1
  name_label = each.value.name
  name_description = each.value.description
  template = data.xenorchestra_template.vm_template_2204.id
  cloud_config = templatefile("resource/k3s_cloudconfig.tftpl", {
        hostname = each.value.hostname
  })

  network {
    network_id = data.xenorchestra_network.network.id
    mac_address = each.value.mac
  }

  disk {
    sr_id = data.xenorchestra_sr.sr_sata.id
    name_label = "${each.value.name} root volume"
    size = var.arch_mirror_resources.disk_size
  }

  wait_for_ip = true

  tags = [
    "k3s"
  ]
}