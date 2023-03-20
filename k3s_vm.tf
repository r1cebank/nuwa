resource "xenorchestra_vm" "k3s_vm" {
  for_each = var.k3s_hosts
  affinity_host = data.xenorchestra_pool.pool.master
  memory_max = var.k3s_resources.memory_max
  cpus = 4
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
    size = var.k3s_resources.disk_size
  }

  wait_for_ip = true

  tags = [
    "k3s"
  ]
}