# VM cloning

    terraform init
    cp variables.tf.sample variables.tf
    vi main.tf variables.tf
    # make sure the resources described and the variables match what you want
    terraform plan
    # verify what's supposedly going to happen
    terraform apply


# Importing existing VM into infrastructure definition

    terraform import proxmox_vm_qemu.unifi_vm.unifi_vm pve/qemu/120
