qm create 9000 --memory 2048 --cores 2 --net0 virtio,bridge=vmbr0
qm importdisk 9000 focal-server-cloudimg-amd64.img local-lvm
qm set 9000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-9000-disk-0

qm set 9000 --ide2 local-lvm:cloudinit
qm set 9000 --boot c --bootdisk scsi0

qm set 9000 --serial0 socket --vga serial0

qm set 9000 --agent enabled=1

qm template 9000

# This did not work as is
# qm set 9000 --cicustom "user=nas-disks:snippets/cloud-init-user-basic.yml,network=nas-disks:snippets/cloud-init-network.yml"

# This WORKED
# qm set 9000 --ciuser "quantum"
# qm set 9000 --cipassword "quantum"
# qm set 9000 --ipconfig0 "ip=dhcp"

. clone.sh
