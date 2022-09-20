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
  name        = "unifi.ar.olumpos.lan"
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

resource "proxmox_vm_qemu" "observium" {
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

  vmid        = 110
  name        = "observium.ar.olumpos.lan"
  desc        = "Observium VM"

  cores   = 4
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

  ipconfig0    = "ip=10.0.0.10/24,gw=${var.gateway}"
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
    bridge = "vmbr0"
  }

  ipconfig0    = "ip=10.0.0.50/24,gw=${var.gateway}"
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
  name        = "plex.ar.olumpos.lan"
  desc        = "Plex VM"

  cpu     = "host,hidden=1"
  cores   = 6
  balloon = 2048
  memory  = 6144

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

resource "proxmox_vm_qemu" "minecraft" {
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
    bridge = "vmbr0"
  }

  ipconfig0    = "ip=10.0.0.61/24,gw=${var.gateway}"
}

resource "proxmox_vm_qemu" "workstation-pablo" {
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

  vmid        = 162
  name        = "work.ar.olumpos.lan"
  desc        = "Workstation"

  cpu     = "host,hidden=1"
  cores   = 4
  balloon = 4096
  memory  = 8192

  disk {
    size    = "99532M"
    type    = "scsi"
    storage = var.disk_storage
    ssd     = 1
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  ipconfig0    = "ip=10.0.0.62/24,gw=${var.gateway}"
}

resource "proxmox_vm_qemu" "workstation-fede" {
  target_node = var.target_node
  clone       = var.template_name
  os_type     = "cloud-init"

  onboot = true
  boot   = "c"
  agent  = 1
  bios    = "ovmf"

  ciuser       = "fede"
  sshkeys      = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC/Jkpw0NJxXC0sgPMxIVhjt9rSvkGeLskGBzuHX0OefZwQmM4cB9ZoL8fg7W5ZXwY9e9dbisD4YysRJMwJEZ0X+E2JYv68UZ3Q7WT9ASWgbLrhG/YQvBDE9vsfuvSBhtuDsRyoSLYgXITG3aQqm1+9TVk1KbDF0RJ/GWkeAnp8dftmJKrwAeZjd0les/r/e39EG53ikdZzTaJS+JAE5h415DUfYd9V0fkwDVcPxs+a04HWz09wN2H4qs8JpkXNSBSlONUQrAbOzrk2NvoLe9yNxFdg64SJnf5dxSwRoz3wbmFWxcHpFMyqgR8SGAYtxxEaAHH+Q3o3X86jO3m4NLNt fedex@azula"
  nameserver   = var.nameserver
  searchdomain = var.searchdomain

  vmid        = 163
  name        = "work-fede.ar.olumpos.lan"
  desc        = "Workstation for Fede"

  cpu     = "host,hidden=1"
  cores   = 4
  balloon = 4096
  memory  = 8192

  disk {
    size    = "99532M"
    type    = "scsi"
    storage = var.disk_storage
    ssd     = 1
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  ipconfig0    = "ip=10.0.0.63/24,gw=${var.gateway}"
}
