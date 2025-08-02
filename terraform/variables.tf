variable "proxmox_api_url" {
  type        = string
  description = "The URL for the Proxmox API."
  sensitive   = true
}

variable "proxmox_api_token_id" {
  type        = string
  description = "The Proxmox API token ID."
  sensitive   = true
}

variable "proxmox_api_token_secret" {
  type        = string
  description = "The Proxmox API token secret."
  sensitive   = true
}

variable "lxc_password" {
  type        = string
  description = "The default password for the LXC containers."
  sensitive   = true
}

variable "ssh_public_key_path" {
  type        = string
  description = "Path to the SSH public key."
  default     = "~/.ssh/rapprocks.pub"
}

variable "ssh_private_key_path" {
  type        = string
  description = "Path to the SSH private key for provisioning."
  default     = "~/.ssh/rapprocks"
}