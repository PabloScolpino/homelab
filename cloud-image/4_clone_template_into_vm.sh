vmid=101
vmname=unifi

qm clone 9000 ${vmid} --name ${vmname}

qm start ${vmid}
