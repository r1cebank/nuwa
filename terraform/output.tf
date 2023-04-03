output "k3s_master_instances" {
  value = {
    for k, v in module.k3s_master_cluster : module.k3s_master_cluster[k].label => module.k3s_master_cluster[k]
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

output "minio_server_instances" {
  value = {
    for k, v in module.minio_server : module.minio_server[k].label => module.minio_server[k]
  }
}

resource "local_file" "inventory" {
  filename = "../ansible/inventory/hosts.ini"
  content  = <<EOF
  [all]
  %{for i, v in module.k3s_master_cluster}
  ${replace(module.k3s_master_cluster[i].label, "-", "_")} ansible_host=${module.k3s_master_cluster[i].network[0].ipv4_addresses[0]}
  %{endfor}
  %{for i, v in module.k3s_worker_cluster}
  ${replace(module.k3s_worker_cluster[i].label, "-", "_")} ansible_host=${module.k3s_worker_cluster[i].network[0].ipv4_addresses[0]}
  %{endfor}
  %{for i, v in module.arch_mirror}
  ${replace(module.arch_mirror[i].label, "-", "_")} ansible_host=${module.arch_mirror[i].network[0].ipv4_addresses[0]}
  %{endfor}
  %{for i, v in module.minio_server}
  ${replace(module.minio_server[i].label, "-", "_")} ansible_host=${module.minio_server[i].network[0].ipv4_addresses[0]}
  %{endfor}
    %{for i, v in module.hashicorp_vault}
  ${replace(module.hashicorp_vault[i].label, "-", "_")} ansible_host=${module.hashicorp_vault[i].network[0].ipv4_addresses[0]}
  %{endfor}

  [minio_nodes]
  %{for i, v in module.minio_server}
  ${replace(module.minio_server[i].label, "-", "_")}
  %{endfor}

  [vault_nodes]
  %{for i, v in module.hashicorp_vault}
  ${replace(module.hashicorp_vault[i].label, "-", "_")}
  %{endfor}

  [k3s_nodes]
  %{for i, v in module.k3s_master_cluster}
  ${replace(module.k3s_master_cluster[i].label, "-", "_")}
  %{endfor}
  %{for i, v in module.k3s_worker_cluster}
  ${replace(module.k3s_worker_cluster[i].label, "-", "_")}
  %{endfor}

  [k3s_master]
  %{for i, v in module.k3s_master_cluster}
  ${replace(module.k3s_master_cluster[i].label, "-", "_")}
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
