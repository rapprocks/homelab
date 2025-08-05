#!/usr/bin/env bash

# --- Prompt for input ---
read -rp "Hostname: " HOSTNAME
read -rp "Number of CPU cores: " CORES
read -rp "Memory (MB) [used for both RAM and swap]: " MEMORY
read -rp "Start container after creation? (1 = yes, 0 = no): " START

# --- Validate inputs ---
if [[ -z "$HOSTNAME" || -z "$CORES" || -z "$MEMORY" || -z "$START" ]]; then
  echo "Error: All fields are required."
  exit 1
fi

# --- Proxmox host ---
PROXMOX_HOST="root@10.100.0.55"

# --- SSH into Proxmox and run pct create ---
ssh "$PROXMOX_HOST" bash -s <<EOF
set -e
NEXT_ID=\$(pvesh get /cluster/nextid)
pct create "\$NEXT_ID" \
  --arch amd64 \
  local:vztmpl/nixos-image-lxc-proxmox-25.11pre-git-x86_64-linux.tar.xz \
  --ostype unmanaged \
  --description nixos \
  --hostname "$HOSTNAME" \
  --net0 name=eth0,bridge=vmbr0,ip=dhcp,firewall=1 \
  --storage local-lvm \
  --memory "$MEMORY" \
  --swap "$MEMORY" \
  --cores "$CORES" \
  --rootfs local-lvm:32 \
  --unprivileged 1 \
  --features nesting=1 \
  --cmode console \
  --onboot 1 \
  --start "$START"
EOF