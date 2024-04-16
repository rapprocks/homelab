provider "proxmox" {
  pm_api_url          = var.proxmox_host["pm_api_url"]
  pm_user             = "root@pam"
  pm_tls_insecure     = true
  pm_api_token_id     = "root@pam!root"
  pm_api_token_secret = "3e6e88da-ce06-4aac-b7d5-d012e5074d2f"

}

resource "proxmox_vm_qemu" "cloudinit-test" {
  name        = "earn-cloud"
  desc        = "testing cloud init tf"
  target_node = var.proxmox_host["target_node"]

  clone      = "debian12-cloudinit"
  full_clone = true

  bios = "ovmf"

  cores   = 2
  sockets = 1
  memory  = 2048

  os_type = "cloud-init"

  disks {
    scsi {
      scsi0 {
        disk {
          size    = 20
          storage = "vm_data"
        }
      }
    }
  }

  cloudinit_cdrom_storage = "vm_data"

  boot     = "order=scsi0"
  bootdisk = "scsi0"

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  ipconfig0 = "ip=10.100.0.7/24,gw=10.100.0.1"

}
