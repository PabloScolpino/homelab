#
#
#
# On the Hypervisor host
#
#
#
disk_name=local-lvm

# 1. Create template VM
qm create 9000 \
  --bios ovmf \
  --memory 2048 \
  --cores 2 \
  --net0 virtio,bridge=vmbr0 \
  --ostype l26


# 2. Import Pristine image downloaded from canonicle
qm importdisk 9000 focal-server-cloudimg-amd64.img.orig ${disk_name}


# 2.b These were other attempts that did not quite work

# 2.b.1 Personalized focal server image with virt-customize
# qm importdisk 9000 focal-server-cloudimg-amd64.img ${disk_name}

# 2.b.2 Pristine debian cloud-image
# qm importdisk 9000 debian-11-genericcloud-amd64-20220310-944.qcow2 ${disk_name}

# 3. Configure the VM
qm set 9000 --scsihw virtio-scsi-pci --scsi0 ${disk_name}:vm-9000-disk-0
qm set 9000 --ide2 ${disk_name}:cloudinit
qm set 9000 --boot c --bootdisk scsi0
qm set 9000 --serial0 socket --vga serial0
qm set 9000 --agent enabled=1


# 4. Configure the cloud init settings on Proxmox
#    The successful attemp was done using the UI, but the same could/should
#    be archieved by using the cli
#
# qm set 9000 --ciuser "quantum"
# qm set 9000 --cipassword "quantum"
# qm set 9000 --ipconfig0 "ip=dhcp"

# NOTE: DO NOT SET IT AS TEMPLATE YET

# 5. configure the VM
#    followed the steps here: https://www.youtube.com/watch?v=h_PIjBHSDnw&t=663
# 5.1 boot the vm
# 5.2 install qemu-guest-agent
#    apt install qemu-guest-agent
# 5.3 install qemu-guest-agent


# 6. set vm as template
# qm template 9000
