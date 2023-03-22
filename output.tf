output "k3s_worker_instances" {
  value = {
    for k, v in module.k3s_worker_cluster : module.k3s_worker_cluster[k].label => module.k3s_worker_cluster[k]
  }
}

output "k3s_master_instances" {
  value = {
    for k, v in module.k3s_master_cluster : module.k3s_master_cluster[k].label => module.k3s_master_cluster[k]
  }
}

output "arch_mirror_instances" {
  value = {
    for k, v in module.arch_mirror : module.arch_mirror[k].label => module.arch_mirror[k]
  }
}
