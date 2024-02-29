variable "proxmox_host" {
  type = map(any)
  default = {
    pm_api_url  = "https://10.100.0.8:8006/api2/json"
    pm_user     = "root@pam"
    target_node = "pve-1-prod"
  }
}

variable "vmid" {
  default = 300
}

variable "network" {
  type = map(any)
  default = {
    gateway = "10.100.0.1"
    ipv4    = "10.100.0.30"
  }
}

variable "node_name" {
  description = "Node name config for containers"
  type        = string
  default     = "pve-1"
}

variable "hostname" {
  description = "Hostname of the container. Will be added before node_name variable"
  type        = string
  default     = "lxc"
}

variable "memory" {
  description = "Amount of memory for specified container"
  default     = 512
}

variable "swap" {
  description = "Amount of swap memory"
  default     = 512
}

variable "cores" {
  description = "The amount of cpu cores that the container should have"
  default     = 1
}

variable "features" {
  type = map(any)
  default = {
    fuse    = false
    nesting = false
  }
}

variable "priviliged" {
  description = "Unpriviliged or not unpriviliged"
  default     = false
}

variable "rootfs" {
  description = "Root filesystem in GB"
  default     = "2G"
}

variable "ips" {
  description = "IPs of the containers, respective of the hostname order"
  default     = ["10.100.0.29"]
}

variable "ansible_user" {
  default     = "root"
  description = "Ansible user used to provision the container"
}

variable "ssh_keys" {
  type = map(any)
  default = {
    pub  = "~/dev/personal/homelab/modules/containers/lxc-key.pub"
    priv = "~/dev/personal/homelab/modules/containers/lxc-key"
  }
}
