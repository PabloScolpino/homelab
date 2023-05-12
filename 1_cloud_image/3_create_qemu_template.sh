#
#
#
# On the Hypervisor host
#
#
#
ciuser=quantum
cloud_image_file=focal-server-cloudimg-amd64.img
disk_name=main
nameserver_id=10.0.0.1
vmid=9000
vmname=cloud-template

echo "Input cipassword:"
read -s cipassword
echo "again for confirmation:"
read -s cipassword2

if [[ $cipassword != $cipassword2 ]]
then
  echo "Passwords do not match"
  exit 1
fi

# 1. Create template VM
qm create ${vmid} \
  --name ${vmname} \
  --bios ovmf \
  --memory 2048 \
  --cores 2 \
  --net0 virtio,bridge=vmbr0 \
  --ostype l26 \
  --numa true


# 2. Import Pristine image downloaded from canonicle
qm importdisk ${vmid} ${cloud_image_file} ${disk_name}


# 2.b These were other attempts that did not quite work

# 2.b.1 Personalized focal server image with virt-customize
# qm importdisk ${vmid} focal-server-cloudimg-amd64.img ${disk_name}

# 2.b.2 Pristine debian cloud-image
# qm importdisk ${vmid} debian-11-genericcloud-amd64-20220310-944.qcow2 ${disk_name}

# 3. Configure the VM
qm set ${vmid} --scsihw virtio-scsi-pci --scsi0 ${disk_name}:vm-${vmid}-disk-0
qm set ${vmid} --ide2 ${disk_name}:cloudinit
qm set ${vmid} --boot c --bootdisk scsi0
qm set ${vmid} --serial0 socket --vga serial0
qm set ${vmid} --agent enabled=1


# 4. Configure the cloud init settings on Proxmox
#    The successful attemp was done using the UI, but the same could/should
#    be archieved by using the cli
#
# qm set ${vmid} --ciuser "quantum"
# qm set ${vmid} --ipconfig0 "ip=dhcp"
qm set ${vmid} --ciuser ${ciuser}
qm set ${vmid} --cipassword ${cipassword}
qm set ${vmid} --sshkeys ./id_rsa.pub
qm set ${vmid} --citype nocloud
qm set ${vmid} --searchdomain ar.olumpos.net
qm set ${vmid} --nameserver ${nameserver_id}
qm set ${vmid} --ipconfig0 ip=dhcp

# NOTE: DO NOT SET IT AS TEMPLATE YET

# 5. configure the VM
#    followed the steps here: https://www.youtube.com/watch?v=h_PIjBHSDnw&t=663
# 5.1 boot the vm
# 5.2 install qemu-guest-agent
#    apt install qemu-guest-agent
# 5.3 install qemu-guest-agent


# 6. set vm as template
# qm template ${vmid}
