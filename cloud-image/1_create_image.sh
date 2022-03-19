#
#
#
#
# RUN THIS IN A LINUX BOX
#
#   NOT in the Hypervisor
#
#
#
#

# Download image
# axel https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img

# Install tools to customize image
# sudo apt update -y && sudo apt install libguestfs-tools -y

# Instal quemu guest tools
# sudo virt-customize -a focal-server-cloudimg-amd64.img --install qemu-guest-agent
sudo virt-customize -a focal-server-cloudimg-amd64.img --root-password password:925OmicroN
