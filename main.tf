#
# This file holds the modules
#

module "earncloud" {
  source = "./modules/vms/"

  hostname  = "earncloud"
  cores     = "2"
  sockets   = "4"
  memory    = "2048"
  baloon    = "2048"
  disk_gb   = "50"
  ipconfig0 = "ip=10.100.0.6/24,gw=10.100.0.1"

}

#module "lxc1-pve-1" {
#source = "./modules/containers/"

#hostname = "lxc1"
#cores    = 2
#memory   = 1024
#swap     = 1024
#rootfs   = "8G"
#  features = {
#    fuse    = false
#    nesting = true
#  }
#}
