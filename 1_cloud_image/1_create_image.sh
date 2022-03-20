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

# 1. Download image
# axel https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img

# 2. These steps were tried but this is not the accepted solution
# 2.1 Install tools to customize image
# sudo apt update -y && sudo apt install libguestfs-tools -y
# 2.2 Instal quemu guest tools
# sudo virt-customize -a focal-server-cloudimg-amd64.img --install qemu-guest-agent
