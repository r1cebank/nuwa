output "default_ipv4_address" {
  value = proxmox_vm_qemu.vm.default_ipv4_address
  description = "The default ipv4 address configuration for the vm"
}

output "label" {
  value = proxmox_vm_qemu.vm.name
  description = "The vm label"
}