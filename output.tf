output "k3s_instances" {
  value  = {
    for k, v in var.k3s_hosts : v.name => xenorchestra_vm.k3s_vm[k].network
  }
}

output "arch_mirror_instances" {
  value  = {
    for k, v in var.arch_mirror_hosts : v.name => xenorchestra_vm.arch_mirror_vm[k].network
  }
}
