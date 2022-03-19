resource "proxmox_vm_qemu" "unifi_vm" {
  target_node = var.target_node

  os_type = "cloud-init"
  clone   = var.template_name
  onboot  = true
  # oncreate = false
  boot    = "c"
  agent   = 1

  count = 1

  vmid = 101
  name = "unifi.ar.olumpos.net"
  desc = "Unifi controller VM"
  bios    = "ovmf"
  sockets = 1
  cores = 2
  numa = true
  balloon = 512
  memory = 2048

  disk {
    size            = "30G"
    type            = "scsi"
    storage         = "local-lvm"
    ssd             = 1
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  # cicustom = "cloud_config.yml"
  cicustom = "user=local:snippets/user_data_vm-${count.index}.yml"

  # ipconfig0 = "ip=dhcp"

  # ipconfig0 = "ip=192.168.1.14/24,gw=192.168.1.1"
  # nameserver = "192.168.1.12"
  # ciuser = "quantum"
  # cipassword = "quantum"
  # ssh_user = "quantum"
  # sshkeys = var.sshkeys
}

# resource "proxmox_vm_qemu" "proxmox_docker_swarm" {
#   target_node = var.target_node
#
#   os_type = "cloud-init"
#   clone   = var.template_name
#   onboot  = true
#   boot    = "c"
#   agent   = 1
#
#   count = 1
#
#   bios    = "ovmf"
#   sockets = 1
#
#   network {
#     model  = "virtio"
#     bridge = "vmbr0"
#   }
#   #== Common Resources ==
#
#   #== Unifi Controller =================================================
#   # vmid = 101
#   # name = "unifi.ar.olumpos.net"
#   # desc = "Unifi controller VM"
#   # cores = 2
#   # balloon = 512
#   # memory = 2048
#   # disk {
#   #  size            = "30G"
#   #  type            = "scsi"
#   #  storage         = "local-lvm"
#   # }
#
#
#   #== Cluster Node =====================================================
#   vmid    = var.vm + count.index
#   name    = "cluster-${count.index + 1}.olumpos.net"
#   desc    = "Container cluster number ${count.index + 1}"
#   cores   = 8
#   balloon = 8192
#   memory  = 16384
#
#   disk {
#     size    = "100G"
#     type    = "scsi"
#     storage = "local-lvm"
#   }
#
#
#   #== Resources ==
#
#   # cicustom = "cloud_config.yml"
#   # ciuser = "quantum"
#
# }
