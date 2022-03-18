# Download image
# axel https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img

# sudo apt update -y && sudo apt install libguestfs-tools -y
# sudo virt-customize -a focal-server-cloudimg-amd64.img --install qemu-guest-agent

sudo virt-customize -a focal-server-cloudimg-amd64.img --root-password password:925OmicroN
