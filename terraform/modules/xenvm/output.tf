output "network" {
  value = xenorchestra_vm.xenvm.network
  description = "The network configuration for the vm"
}

output "label" {
  value = xenorchestra_vm.xenvm.name_label
  description = "The vm label"
}