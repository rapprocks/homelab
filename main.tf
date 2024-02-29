#
# This file holds the provider and each module
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
