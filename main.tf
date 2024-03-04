#
# This file holds the modules
#

module "lxc1-pve-1" {
  source = "./modules/containers/"

  hostname = "lxc1"
  cores    = 2
  memory   = 1024
  swap     = 1024
  rootfs   = "8G"
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
  rootfs   = "8G"
  features = {
    fuse    = false
    nesting = true
  }
}
