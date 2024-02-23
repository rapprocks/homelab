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

variable "naming_convention" {
  description = "Containers to be created"
  type        = string
  default     = "pve-1"
}

variable "ssh_keys" {
  type = map(any)
  default = {
    pub  = "~/.ssh/nixdesk.pub"
    priv = "~/.ssh/nixdesk"
  }
}
