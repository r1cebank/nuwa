variable "max_memory" {
  description = "The maximum byte of memory the vm can has"
}

variable "cpus" {
  description = "Amount of cpu to allocate to the vm"
}

variable "vm_name" {
  description = "The vm name"
}

variable "vm_description" {
  description = "The vm description"
}

variable "external_env" {
  description = "external env passed in"
}

variable "disk_size" {
  description = "The disk size in bytes"
}

variable "main_disk_storage" {
  description = "The main disk storage"
}


variable "template_id" {
  description = "The template id to use to create the vm"
}

variable "affinity_host_name" {
  description = "The affinity host name"
}

variable "affinity_host" {
  description = "The affinity host network location"
}

variable "network_id" {
  description = "The network id"
}

variable "cloud_init_storage" {
  description = "The storage for cloud-init"
}

variable "additional_disk" {
  description = "If add additional disk to the vm"
  default     = false
}

variable "additional_disk_size" {
  description = "Size for the additional disk"
  default     = 0
}

variable "additional_disk_storage" {
  description = "The storage name for additional disk"
  default = ""
}


variable "cloud_config_file" {
  description = "The cloud config file path for the vm"
}

variable "cloud_network_config_file" {
  description = "The cloud network config file path for the vm"
}

variable "cloud_network_config_args" {
  description = "The cloud network config arguments for the vm"
  default     = {}
}

variable "tags" {
  description = "The tags to set on the vm"
  default     = []
}
