#
# This file holds the provider and each module
#

module "hass-pve-1" {
  source = "./modules/containers/"

  hostname = "hass"
  cores    = 2
  memory   = 1024
  swap     = 1024
  rootfs   = "3G"
  features = {
    fuse    = false
    nesting = true
  }
}

module "lxc2-pve-1" {
  source = "./modules/containers/"

  hostname = "lxc2"
  cores    = 2
  memory   = 1024
  swap     = 1024
  rootfs   = "3G"
  features = {
    fuse    = false
    nesting = true
  }
}
