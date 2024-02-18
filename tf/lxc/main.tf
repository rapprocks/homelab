provider "proxmox" {
    pm_api_url = var.proxmox_host["pm_api_url"]
    pm_user = var.proxmox_host["pm_user"]
    pm_api_token_id = var.proxmox_host["pm_api_token_id"]
    pm_api_token_secret = var.proxmox_host["pm_api_token_secret"]
    pm_tls_insecure = true
}

resource "proxmox_lxc" "advanced_features" {
  target_node  = var.proxmox_host["target_node"]
  hostname     = "lxc-test"
  ostemplate   = "docs:vztmpl/ubuntu-23.10-standard_23.10-1_amd64.tar.zst"
  unprivileged = true
  
  ssh_public_keys = file(var.ssh_keys["pub"])

  rootfs {
    storage = "vm_data"
    size    = "8G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "dhcp"
    ip6    = "dhcp"
  }
}
