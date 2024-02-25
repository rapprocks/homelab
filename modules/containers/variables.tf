variable "proxmox_host" {
  type = map(any)
  default = {
    pm_api_url          = "https://10.100.0.8:8006/api2/json"
    pm_user             = "root@pam"
    target_node         = "pve-1-prod"
    pm_api_token_id     = "terraform-prov@pve!terraform"
    pm_api_token_secret = "139d34c4-d8c0-4fff-9a39-1a7dd498a6c9"
  }
}

variable "vmid" {
  default = 300
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
  default     = 1024
}
