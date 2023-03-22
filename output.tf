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

resource "local_file" "inventory" {
 filename = "./inventory/hosts.ini"
 content = <<EOF
  [k3s-master]
  %{for i, v in module.k3s_master_cluster}
  ${module.k3s_master_cluster[i].network[0].ipv4_addresses[0]}
  %{endfor}
  [k3s-worker]
  %{for i, v in module.k3s_worker_cluster}
  ${module.k3s_worker_cluster[i].network[0].ipv4_addresses[0]}
  %{endfor}
  [arch-mirror]
  %{for i, v in module.arch_mirror}
  ${module.arch_mirror[i].network[0].ipv4_addresses[0]}
  %{endfor}
  EOF
}