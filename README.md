# Purpose

* Have many services running as containers in our homelab
* Have some services running as VMs in our homelab
* Have all configuration for the Infrastructure, VMs, services as code
* Service updates are automatic and are triggered by git events
* Inbound traffic from lan and wan.
* Reverse dns /proxy

# Platform

* one openwrt router
  * wireguard
* one proxmox node
  * unbound / pihole on VM
  * unifi controller
  * microk8s on VM
  * ? FreeNAS ?
* one freenas
  * nfs server
  * cifs server

## Basic infrastructure setup

### OpenWRT
OpenWRT install is manual

### FreeNAS
FreeNAS install is manual

### Proxmox
Proxmox install is manual

## VM Template creation

The contents of `1_cloud_image` describe how to create a working Proxmox-cloud-init template

This template allows the automated creation of VMs based on Ubuntu 20 lts

## VM Provisioning

The creation of the VMs will use the template created in the previous step
This creation will be done using `2_terraform` files

## VM Configuration

Look at `3_ansible`

## Service deployments

Look at `4_k8s`

