#!/usr/bin/env bash

echo "Input password for terraform-prov:"
read -s password
echo "again for confirmation:"
read -s password2

if [[ $password != $password2 ]]
then
  echo "Passwords do not match"
  exit 1
fi

pveum role add TerraformProv -privs "\
Datastore.AllocateSpace \
Datastore.Audit \
Pool.Allocate \
Sys.Audit \
Sys.Console \
Sys.Modify \
VM.Allocate \
VM.Audit \
VM.Clone \
VM.Config.CDROM \
VM.Config.CPU \
VM.Config.Cloudinit \
VM.Config.Disk \
VM.Config.HWType \
VM.Config.Memory \
VM.Config.Network \
VM.Config.Options \
VM.Migrate \
VM.Monitor \
VM.PowerMgmt"

pveum user add terraform-prov@pve --password ${password}
pveum aclmod / -user terraform-prov@pve -role TerraformProv
