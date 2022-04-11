resource "proxmox_vm_qemu" "unifi_vm" {
  target_node = var.target_node
  clone       = var.template_name
  os_type     = "cloud-init"

  onboot = true
  boot   = "c"
  agent  = 1
  bios    = "ovmf"

  ciuser       = var.ciuser
  sshkeys      = var.sshkeys
  nameserver   = var.nameserver
  searchdomain = var.searchdomain

  vmid        = 120
  name        = "unifi.ar.olumpos.local"
  desc        = "Unifi controller VM"

  cores   = 2
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

  ipconfig0    = "ip=10.0.0.20/24,gw=${var.gateway}"
}

resource "proxmox_vm_qemu" "k8s" {
  target_node = var.target_node
  clone       = var.template_name
  os_type     = "cloud-init"

  onboot = true
  boot   = "c"
  agent  = 1
  bios    = "ovmf"

  ciuser       = var.ciuser
  sshkeys      = var.sshkeys
  nameserver   = var.nameserver
  searchdomain = var.searchdomain

  vmid        = 150
  name        = "k8s.ar.olumpos.local"
  desc        = "Kubernetes cluster"

  cores   = 4
  balloon = 8192
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

  ipconfig0    = "ip=10.0.0.50/24,gw=${var.gateway}"
}

resource "proxmox_vm_qemu" "kulturnetzd" {
  target_node = var.target_node
  clone       = var.template_name
  os_type     = "cloud-init"

  onboot = true
  boot   = "c"
  agent  = 1
  bios    = "ovmf"

  ciuser       = var.ciuser
  sshkeys      = var.sshkeys
  nameserver   = var.nameserver
  searchdomain = var.searchdomain

  vmid        = 155
  name        = "kulturnetzd.ar.olumpos.local"
  desc        = "Kulturnetzd Moodle VM"

  cores   = 2
  balloon = 1024
  memory  = 4096

  disk {
    size    = "60620M"
    type    = "scsi"
    storage = var.disk_storage
    ssd     = 1
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  ipconfig0    = "ip=10.0.0.55/24,gw=${var.gateway}"
}

resource "proxmox_vm_qemu" "plex" {
  target_node = var.target_node
  clone       = var.template_name
  os_type     = "cloud-init"

  onboot = true
  boot   = "c"
  agent  = 1
  bios    = "ovmf"

  ciuser       = var.ciuser
  sshkeys      = var.sshkeys
  nameserver   = var.nameserver
  searchdomain = var.searchdomain

  vmid        = 160
  name        = "plex.ar.olumpos.local"
  desc        = "Plex VM"

  cores   = 4
  balloon = 2048
  memory  = 8192

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

  ipconfig0    = "ip=10.0.0.60/24,gw=${var.gateway}"
}
