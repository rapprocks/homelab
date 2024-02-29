provider "proxmox" {
  pm_api_url      = var.proxmox_host["pm_api_url"]
  pm_user         = "root@pam"
  pm_tls_insecure = true
}

resource "proxmox_lxc" "containers" {
  target_node  = var.proxmox_host["target_node"]
  hostname     = "${var.hostname}-${var.node_name}"
  memory       = var.memory
  swap         = var.swap
  cores        = var.cores
  ostemplate   = "docs:vztmpl/ubuntu-23.10-standard_23.10-1_amd64.tar.zst"
  unprivileged = var.priviliged
  features {
    fuse    = var.features["fuse"]
    nesting = var.features["nesting"]
  }
  rootfs {
    storage = "vm_data"
    size    = var.rootfs
  }
  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "dhcp"
  }

  password = "ad0nis33"
  start    = false

  ssh_public_keys = file(var.ssh_keys["pub"])
}
