# Transfer the modified image to the hypervisor
hypervisor_ip=10.0.0.3
hypervisor_user=quantum
scp ${hypervisor_user}@${hypervisor_ip}:~/workspace/homelab/cloud-image/*img ./
