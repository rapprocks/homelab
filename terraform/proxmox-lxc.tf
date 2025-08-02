terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.2-rc03"  # or latest
    }
  }

  required_version = ">= 1.3.0"
}

provider "proxmox" {
  pm_api_url          = var.proxmox_api_url
  pm_api_token_id     = var.proxmox_api_token_id
  pm_api_token_secret = var.proxmox_api_token_secret
  pm_tls_insecure     = true # Set to false in production
}

locals {
  # Default configuration for all LXC containers
  default_lxc_config = {
    target_node     = "pve-dev-1"
    ostemplate      = "local:vztmpl/nixos-image-lxc-proxmox-25.11pre-git-x86_64-linux.tar.xz"
    password        = var.lxc_password
    ostype          = "unmanaged"
    cmode           = "console"
    cores           = 1
    memory          = 512
    swap            = 512
    unprivileged    = true
    start           = true
    ssh_public_keys = file(var.ssh_public_key_path)
    features = {
      nesting = true
    }
    rootfs = {
      storage = "local-lvm"
      size    = "32G"
    }
    network = {
      name   = "eth0"
      bridge = "vmbr0"
      ip     = "dhcp"
      type   = "veth"
    }
  }

  # A map of your containers. Add new containers here.
  lxc_containers = {
    "test-lxc-1" = {
      # You can override defaults here, e.g., cores = 2
    }
     "test-lxc-2" = {
       cores  = 2
       memory = 1024
     }
  }

  # Create the final, merged configuration for each container
  final_lxc_configs = {
    for name, config in local.lxc_containers :
    name => merge(local.default_lxc_config, config)
  }
}

resource "proxmox_lxc" "lxc" {
  for_each = local.final_lxc_configs

  target_node     = each.value.target_node
  hostname        = each.key
  ostemplate      = each.value.ostemplate
  password        = each.value.password
  ostype          = each.value.ostype
  cmode           = each.value.cmode
  cores           = each.value.cores
  memory          = each.value.memory
  swap            = each.value.swap
  unprivileged    = each.value.unprivileged
  start           = each.value.start
  ssh_public_keys = each.value.ssh_public_keys

  features {
    nesting = each.value.features.nesting
  }

  rootfs {
    storage = each.value.rootfs.storage
    size    = each.value.rootfs.size
  }

  network {
    name   = each.value.network.name
    bridge = each.value.network.bridge
    ip     = each.value.network.ip
    type   = each.value.network.type
  }

  # Wait for network to be ready and get the IP address
  provisioner "local-exec" {
    command = "until ping -c 1 ${self.network[0].ip}; do sleep 1; done"
  }

  # Connection details for provisioners
  connection {
    type        = "ssh"
    user        = "admin"
    private_key = file(var.ssh_private_key_path)
    host        = self.network[0].ip
    port        = 33001
  }

  # Install git, clone the configuration repo, and apply the flake
  provisioner "remote-exec" {
    inline = [
      "sudo nix-env -iA nixos.git",
      "sudo git clone https://github.com/your-username/homelab.git /etc/nixos",
      "sudo nixos-rebuild switch --flake /etc/nixos#${each.key}"
    ]
  }
}