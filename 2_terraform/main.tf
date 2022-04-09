resource "proxmox_vm_qemu" "pihole_vm" {
  target_node = var.target_node
  name        = "pihole.ar.olumpos.local"
  desc        = "Pi-Hole VM"

  os_type = "cloud-init"
  clone   = var.template_name
  count   = 1
  vmid    = 100 + var.pihole_id

  onboot = true
  boot   = "c"
  agent  = 1

  bios    = "ovmf"
  sockets = 1
  cores   = 2
  numa    = true
  balloon = 768
  memory  = 3072

  disk {
    size    = "29900M"
    type    = "scsi"
    storage = var.disk_storage
    ssd     = 1
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  lifecycle {
    # prevent_destroy = true
    ignore_changes = [
      # network, vmid, clone, full_clone, qemu_os
    ]
  }

  ciuser       = var.ciuser
  sshkeys      = var.sshkeys
  ipconfig0    = "ip=10.0.0.${var.pihole_id}/24,gw=${var.gateway}"
  nameserver   = var.nameserver
  searchdomain = var.searchdomain
}

resource "proxmox_vm_qemu" "unifi_vm" {
  target_node = var.target_node
  name        = "unifi.ar.olumpos.local"
  desc        = "Unifi controller VM"

  os_type = "cloud-init"
  clone   = var.template_name
  count   = 1
  vmid    = 100 + var.unifi_id

  onboot = true
  boot   = "c"
  agent  = 1

  bios    = "ovmf"
  sockets = 1
  cores   = 2
  numa    = true
  balloon = 512
  memory  = 3072

  disk {
    size    = "29900M"
    type    = "scsi"
    storage = var.disk_storage
    ssd     = 1
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  lifecycle {
    # prevent_destroy = true
    ignore_changes = [
      # network, vmid, clone, full_clone, qemu_os
    ]
  }

  ciuser       = var.ciuser
  sshkeys      = var.sshkeys
  ipconfig0    = "ip=10.0.0.${var.unifi_id}/24,gw=${var.gateway}"
  nameserver   = var.nameserver
  searchdomain = var.searchdomain
}

resource "proxmox_vm_qemu" "k8s-node" {
  target_node = var.target_node
  name        = "k8s-${count.index + 1}.ar.olumpos.local"
  desc        = "Container cluster number ${count.index + 1}"

  os_type = "cloud-init"
  clone   = var.template_name
  count   = 1
  vmid    = 100 + var.k8s_node_id + count.index

  onboot = true
  boot   = "c"
  agent  = 1

  bios    = "ovmf"
  sockets = 1
  cores   = 4
  numa    = true
  balloon = 4096
  memory  = 16384

  disk {
    size    = "203980M"
    type    = "scsi"
    storage = var.disk_storage
    ssd     = 1
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  ciuser       = var.ciuser
  sshkeys      = var.sshkeys
  ipconfig0    = "ip=10.0.0.${var.k8s_node_id + count.index}/24,gw=${var.gateway}"
  nameserver   = var.nameserver
  searchdomain = var.searchdomain
}
