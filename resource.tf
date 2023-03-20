data "xenorchestra_pool" "pool" {
  name_label = "hachune-xenlab"
}

data "xenorchestra_template" "vm_template_2204" {
  name_label = "[cloud-init] Ubuntu Jammy Jellyfish 22.04.2"
}

data "xenorchestra_sr" "sr_sata" {
  name_label = "SATA SSD"
  pool_id = data.xenorchestra_pool.pool.id
}

data "xenorchestra_sr" "sr_nvme" {
  name_label = "NVME SSD"
  pool_id = data.xenorchestra_pool.pool.id
}

data "xenorchestra_network" "network" {
  name_label = "Pool-wide network associated with eth0"
  pool_id = data.xenorchestra_pool.pool.id
}