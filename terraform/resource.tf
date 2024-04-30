# data "xenorchestra_pool" "pool" {
#   name_label = "owo-xenlab"
# }

# data "xenorchestra_template" "vm_template_22043" {
#   name_label = "[cloud-init] Ubuntu Jammy Jellyfish 22.04.3"
# }

# data "xenorchestra_template" "vm_template_debian_12" {
#   name_label = "[cloud-init] Debian Bookworm 12"
# }

# data "xenorchestra_sr" "arctic_sata" {
#   name_label = "Arctic SATA"
#   pool_id    = data.xenorchestra_pool.pool.id
# }

# data "xenorchestra_sr" "arctic_nvme" {
#   name_label = "Arctic NVME"
#   pool_id    = data.xenorchestra_pool.pool.id
# }

# data "xenorchestra_sr" "aero_sata" {
#   name_label = "Aero SATA"
#   pool_id    = data.xenorchestra_pool.pool.id
# }

# data "xenorchestra_sr" "aero_nvme" {
#   name_label = "Aero NVME"
#   pool_id    = data.xenorchestra_pool.pool.id
# }

# data "xenorchestra_sr" "cerulean_sata" {
#   name_label = "Cerulean SATA"
#   pool_id    = data.xenorchestra_pool.pool.id
# }

# data "xenorchestra_sr" "cerulean_nvme" {
#   name_label = "Cerulean NVME"
#   pool_id    = data.xenorchestra_pool.pool.id
# }

# data "xenorchestra_network" "default_network" {
#   name_label = "Pool-wide network associated with eth0"
#   pool_id    = data.xenorchestra_pool.pool.id
# }

# data "xenorchestra_network" "homelab_untrusted_network" {
#   name_label = "Homelab Untrusted"
#   pool_id    = data.xenorchestra_pool.pool.id
# }

# data "xenorchestra_host" "cerulean" {
#   name_label = "cerulean"
# }

# data "xenorchestra_host" "aero" {
#   name_label = "aero"
# }

# data "xenorchestra_host" "arctic" {
#   name_label = "arctic"
# }
