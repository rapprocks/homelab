variable "proxmox_host" {
	type = map
     default = {
       pm_api_url = "https://10.100.0.8:8006/api2/json"
       pm_api_token_id = "terraform-prov@pve!terraform"
       pm_api_token_secret = "139d34c4-d8c0-4fff-9a39-1a7dd498a6c9"
       pm_user = "terraform-prov@pve"
       target_node = "pve-1-prod"
     }
}

variable "vmid" {
	default     = 300
	description = "Starting ID for the CTs"
}


variable "hostnames" {
  description = "Containers to be created"
  type        = list(string)
  default     = ["prod-ct"]
}


variable "rootfs_size" {
	description = "Root filesystem size in GB"
	default = "2G"
}

variable "ips" {
    description = "IPs of the containers, respective to the hostname order"
    type        = list(string)
	default     = ["10.0.42.83"]
}

variable "user" {
	default     = "root"
	description = "Ansible user used to provision the container"
}

variable "ssh_keys" {
	type = map
     default = {
       pub = "~/.ssh/nixdesk.pub"
       priv = "~/.ssh/nixdesk"
     }
}
