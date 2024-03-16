resource "proxmox_vm_qemu" "unifi_vm" {
  clone   = var.template_name
  os_type = var.os_type
  scsihw  = var.scsihw
  qemu_os = var.qemu_os
  onboot  = var.onboot
  boot    = var.boot
  agent   = var.agent
  bios    = var.bios
  ciuser  = var.ciuser
  sshkeys = var.sshkeys

  target_node = "pve-2"
  vmid        = 120
  name        = "unifi.ar.olumpos.lan"
  desc        = "Unifi controller VM"

  cores  = 2
  memory = 3072

  disk {
    size    = "29900M"
    type    = "scsi"
    storage = "local-zfs"
    ssd     = 1
  }

  network {
    bridge    = "vmbr1"
    model     = "virtio"
    tag       = 20
  }

  nameserver   = "10.20.0.1"
  ipconfig0 = "ip=dhcp"
}

resource "proxmox_vm_qemu" "k8s" {
  clone        = var.template_name
  os_type      = var.os_type
  scsihw       = var.scsihw
  qemu_os      = var.qemu_os
  onboot       = var.onboot
  boot         = var.boot
  agent        = var.agent
  bios         = var.bios
  ciuser       = var.ciuser
  sshkeys      = var.sshkeys
  searchdomain = var.searchdomain

  target_node = "pve-2"
  vmid        = 150
  name        = "k8s.ar.olumpos.lan"
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
    bridge = "vmbr1"
    tag    = 30
  }
  nameserver   = "10.30.0.1"

  ipconfig0 = "ip=dhcp"
}

resource "proxmox_vm_qemu" "plex" {
  clone        = var.template_name
  os_type      = var.os_type
  scsihw       = var.scsihw
  qemu_os      = var.qemu_os
  onboot       = var.onboot
  boot         = var.boot
  agent        = var.agent
  bios         = var.bios
  ciuser       = var.ciuser
  sshkeys      = var.sshkeys
  searchdomain = var.searchdomain

  target_node = "pve-2"
  vmid        = 160
  name        = "plex.ar.olumpos.lan"
  desc        = "Plex VM"

  cpu    = "host,hidden=1"
  cores  = 6
  memory = 6144

  disk {
    size    = "29900M"
    type    = "scsi"
    storage = var.disk_storage
    ssd     = 1
  }

  network {
    model  = "virtio"
    bridge = "vmbr1"
    tag    = 30
  }

  network {
    model  = "virtio"
    bridge = "vmbr1"
    tag    = 40
  }

  nameserver   = "10.30.0.1"
  ipconfig0 = "ip=dhcp"
  ipconfig1 = "ip=dhcp"
}

resource "proxmox_vm_qemu" "minecraft" {
  clone        = var.template_name
  os_type      = var.os_type
  scsihw       = var.scsihw
  qemu_os      = var.qemu_os
  onboot       = var.onboot
  boot         = var.boot
  agent        = var.agent
  bios         = var.bios
  ciuser       = var.ciuser
  sshkeys      = var.sshkeys
  searchdomain = var.searchdomain

  target_node = "pve-2"
  vmid        = 161
  name        = "minecraft.ar.olumpos.lan"
  desc        = "Minecraft VM"

  cpu     = "host,hidden=1"
  cores   = 4
  balloon = 4096
  memory  = 8192

  disk {
    size    = "39116M"
    type    = "scsi"
    storage = var.disk_storage
    ssd     = 1
  }

  network {
    model  = "virtio"
    bridge = "vmbr1"
    tag    = 30
  }

  nameserver   = "10.30.0.1"
  ipconfig0 = "ip=dhcp"
}

resource "proxmox_vm_qemu" "deluge" {
  clone        = var.template_name
  os_type      = var.os_type
  scsihw       = var.scsihw
  qemu_os      = var.qemu_os
  onboot       = var.onboot
  boot         = var.boot
  agent        = var.agent
  bios         = var.bios
  ciuser       = var.ciuser
  sshkeys      = var.sshkeys
  searchdomain = var.searchdomain

  target_node = "pve-2"
  vmid        = 165
  name        = "deluge.ar.olumpos.lan"
  desc        = "Deluge VM"

  cpu    = "host,hidden=1"
  cores  = 2
  memory = 2048

  disk {
    size    = "29900M"
    type    = "scsi"
    storage = var.disk_storage
    ssd     = 1
  }

  network {
    model  = "virtio"
    bridge = "vmbr1"
    tag    = 30
  }

  nameserver   = "10.30.0.1"
  ipconfig0 = "ip=dhcp"
}

resource "proxmox_vm_qemu" "workstation" {
  clone        = var.template_name
  os_type      = var.os_type
  scsihw       = var.scsihw
  qemu_os      = var.qemu_os
  onboot       = var.onboot
  boot         = var.boot
  agent        = var.agent
  bios         = var.bios
  ciuser       = var.ciuser
  sshkeys      = var.sshkeys
  searchdomain = var.searchdomain

  target_node = "pve-2"
  vmid        = 180
  name        = "workstation.ar.olumpos.lan"
  desc        = "Workstation VM"

  cpu    = "host,hidden=1"
  cores  = 8
  memory = 16384

  disk {
    size    = "100G"
    type    = "scsi"
    storage = var.disk_storage
    ssd     = 1
  }

  network {
    model  = "virtio"
    bridge = "vmbr1"
    tag    = 40
  }

  nameserver   = "10.30.0.1"
  ipconfig0 = "ip=dhcp"
}
