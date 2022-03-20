resource "proxmox_vm_qemu" "unifi_vm" {
  target_node = var.target_node
  name        = "unifi.ar.olumpos.net"
  desc        = "Unifi controller VM"

  os_type = "cloud-init"
  clone   = var.template_name
  count   = 1
  vmid    = 100 + var.unifi_id

  onboot  = true
  boot    = "c"
  agent   = 1

  bios    = "ovmf"
  sockets = 1
  cores   = 2
  numa    = true
  balloon = 512
  memory  = 2048

  disk {
    size    = "29900M"
    type    = "scsi"
    storage = "local-lvm"
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
  ipconfig0    = "ip=192.168.1.${ var.unifi_id }/24,gw=${var.gateway}"
  nameserver   = var.nameserver
  searchdomain = var.searchdomain
}

resource "proxmox_vm_qemu" "k8-node" {
  target_node = var.target_node
  name        = "k8-${count.index + 1}.ar.olumpos.net"
  desc        = "Container cluster number ${count.index + 1}"

  os_type = "cloud-init"
  clone   = var.template_name
  count   = 1
  vmid    = 100 + var.k8_node_id + count.index

  onboot  = true
  boot    = "c"
  agent   = 1

  bios    = "ovmf"
  sockets = 1
  cores   = 4
  numa    = true
  balloon = 4096
  memory  = 16384

  disk {
    size    = "203980M"
    type    = "scsi"
    storage = "local-lvm"
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
  ipconfig0    = "ip=192.168.1.${var.k8_node_id + count.index}/24,gw=${var.gateway}"
  nameserver   = var.nameserver
  searchdomain = var.searchdomain
}
