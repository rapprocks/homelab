provider "proxmox" {
  pm_api_url          = var.proxmox_host["pm_api_url"]
  pm_user             = "root@pam"
  pm_api_token_id     = var.proxmox_host["pm_api_token_id"]
  pm_api_token_secret = var.proxmox_host["pm_api_token_secret"]
  pm_tls_insecure     = true
}

resource "proxmox_vm_qemu" "earncloud-hz-1" {
  name        = var.hostname
  target_node = var.proxmox_host["target_node"]
  vmid        = 200
  full_clone  = true
  clone       = "debian12-cloudinit"

  bios = "ovmf"

  cores   = 2
  sockets = 1
  vcpus   = 2
  memory  = 2048
  balloon = 2048
  #boot     = "c"
  bootdisk = "virtio0"

  scsihw = "virtio-scsi-pci"

  onboot  = false
  agent   = 1
  cpu     = "kvm64"
  numa    = true
  hotplug = "network,disk,cpu,memory"

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }

  ipconfig0 = "ip=10.100.0.6/24,gw=10.100.0.1"

  disks {
    virtio {
      virtio0 {
        disk {
          storage = "vm_data"
          size    = 5
        }
      }
    }
  }

  efidisk {
    efitype = "4m"
    storage = "vm_data"
  }

  os_type = "cloud-init"

  #creates ssh connection to check when the CT is ready for ansible provisioning
  connection {
    host        = var.ipconfig0
    user        = var.user
    private_key = file(var.ssh_keys["vm-priv"])
    agent       = false
    timeout     = "3m"
  }

  provisioner "remote-exec" {
    # Leave this here so we know when to start with Ansible local-exec 
    inline = ["echo 'Cool, we are ready for provisioning'"]
  }

  provisioner "local-exec" {
    working_dir = "../../ansible/"
    command     = "ansible-playbook -u ${var.user} --key-file ${var.ssh_keys["priv"]} -i ${var.ipconfig0}, provision.yaml"
  }
}
