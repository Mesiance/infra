# SSH
#===========================
variable "ssh_public_key" {
  description = "Main SSH key to put to created VMs"
  type = string
  sensitive = true
}

variable "ssh_private_key_path" {
  description = "Path to private key of ssh_public_key to connect to created vm"
  type = string
  sensitive = true
  default = "~/.ssh/id_rsa"
}

variable "ssh_new_port" {
  description = "SSH port to change on"
  type = string
  default = "22" # leave default if other not specified
}

variable "ssh_permit_root_login" {
  description = "Permit root login option for sshd_config"
  type = string
  default = "yes"
}

# Networking
#===========================
variable "network_subnet_cidr" {
  description = "Subnet cidr. For instance 192.168.0.0"
  type = string
  default = "192.168.0.0"
}

variable "network_subnet_mask" {
  description = "Subnet mask"
  type = number
  default = 24
}

variable "region" {
  description = "Location of network"
  type = string
  default = "am2"
}

# VMs
#===========================
variable "os_image" {
  description = "OS image to setup on VMs"
  type = string
  default = "Ubuntu-20.04-X64"
}

variable "cpu_count" {
  description = "Number of cpu. Default 1 cpu"
  type = number
  default = 1
}

variable "memory_count" {
  description = "Amount of memory in Mib. Default - 1024 Mib"
  type = number
  default = 1024
}

variable "disk_size" {
  description = "Size of disk in Gb. Default - 25 Gb"
  type = number
  default = 25
}

variable "publc_vm_network_bandwidth" {
  description = "Network bandwidth for the host with public network(master, ingress)"
  type = number
  default = 50
}