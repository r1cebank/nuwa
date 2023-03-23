output "k3s_master_instances" {
  value = {
    for k, v in module.k3s_master_cluster : module.k3s_master_cluster[k].label => module.k3s_master_cluster[k]
  }
}

output "k3s_longhorn_instances" {
  value = {
    for k, v in module.k3s_longhorn_cluster : module.k3s_longhorn_cluster[k].label => module.k3s_longhorn_cluster[k]
  }
}

output "k3s_worker_instances" {
  value = {
    for k, v in module.k3s_worker_cluster : module.k3s_worker_cluster[k].label => module.k3s_worker_cluster[k]
  }
}

output "arch_mirror_instances" {
  value = {
    for k, v in module.arch_mirror : module.arch_mirror[k].label => module.arch_mirror[k]
  }
}

resource "local_file" "inventory" {
  filename = "../services/inventory/hosts.ini"
  content  = <<EOF
  [all]
  %{for i, v in module.k3s_master_cluster}
  ${replace(module.k3s_master_cluster[i].label, "-", "_")} ansible_host=${module.k3s_master_cluster[i].network[0].ipv4_addresses[0]}
  %{endfor}
  %{for i, v in module.k3s_longhorn_cluster}
  ${replace(module.k3s_longhorn_cluster[i].label, "-", "_")} ansible_host=${module.k3s_longhorn_cluster[i].network[0].ipv4_addresses[0]}
  %{endfor}
  %{for i, v in module.k3s_worker_cluster}
  ${replace(module.k3s_worker_cluster[i].label, "-", "_")} ansible_host=${module.k3s_worker_cluster[i].network[0].ipv4_addresses[0]}
  %{endfor}
  %{for i, v in module.arch_mirror}
  ${replace(module.arch_mirror[i].label, "-", "_")} ansible_host=${module.arch_mirror[i].network[0].ipv4_addresses[0]}
  %{endfor}

  [k3s_nodes]
  %{for i, v in module.k3s_master_cluster}
  ${replace(module.k3s_master_cluster[i].label, "-", "_")}
  %{endfor}
  %{for i, v in module.k3s_longhorn_cluster}
  ${replace(module.k3s_longhorn_cluster[i].label, "-", "_")}
  %{endfor}
  %{for i, v in module.k3s_worker_cluster}
  ${replace(module.k3s_worker_cluster[i].label, "-", "_")}
  %{endfor}

  [k3s_master]
  %{for i, v in module.k3s_master_cluster}
  ${replace(module.k3s_master_cluster[i].label, "-", "_")}
  %{endfor}
  [k3s_longhorn]
  %{for i, v in module.k3s_longhorn_cluster}
  ${replace(module.k3s_longhorn_cluster[i].label, "-", "_")}
  %{endfor}
  [k3s_worker]
  %{for i, v in module.k3s_worker_cluster}
  ${replace(module.k3s_worker_cluster[i].label, "-", "_")}
  %{endfor}
  [arch_mirror]
  %{for i, v in module.arch_mirror}
  ${replace(module.arch_mirror[i].label, "-", "_")}
  %{endfor}
  EOF
}
