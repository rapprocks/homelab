#
# This file holds the provider and each module
#

provider "proxmox" {
  pm_api_url          = var.proxmox_host["pm_api_url"]
  pm_user             = var.proxmox_host["pm_user"]
  pm_api_token_id     = var.proxmox_host["pm_api_token_id"]
  pm_api_token_secret = var.proxmox_host["pm_api_token_secret"]
  pm_tls_insecure     = true
  pm_log_enable       = true
  pm_debug            = true
}

module "lxc2-pve-1" {
  source = "./modules/containers/"

  hostname = "lxc2"
  memory   = 2048
}

module "lxc3-pve-1" {
  source   = "./modules/containers/"
  hostname = "lxc3"

}

module "lxc4-pve-1" {
  source   = "./modules/containers/"
  hostname = "lxc4"
}
