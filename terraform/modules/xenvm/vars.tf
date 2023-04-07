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

variable "disk_size" {
  description = "The disk size in bytes"
}

variable "template_id" {
  description = "The template id to use to create the vm"
}

variable "affinity_host" {
  description = "The affinity host"
}

variable "network_id" {
  description = "The network id"
}

variable "sr_id" {
  description = "The storage repository id"
}

variable "additional_disk" {
  description = "If add additional disk to the vm"
  default     = false
}

variable "additional_disk_size" {
  description = "Size for the additional disk"
  default     = 0
}

variable "additional_disk_sr_id" {
  description = "The storage repository id for additional disk"
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

variable "mac_address" {
  description = "The mac address for the vm"
}
