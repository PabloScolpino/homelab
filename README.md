# 1. Purpose

* Have many services running as containers in our homelab
* Have some services running as VMs in our homelab
* Have all configuration for the Infrastructure, VMs, services as code
* Service updates are automatic and are triggered by git events
* Inbound traffic from lan and wan.
* Reverse dns /proxy

# 2. Hardware

* pfsense firewall (on pve-1)
    * wireguard
    * haproxy
* three proxmox nodes
    * pve-1
        * virtualized pfsense
    * pve-2
        * unify controller
        * single k8s cluster node
        * plex
        * minecraft
    * pve-3
        * virtualized Truenas

# 3. Basic infrastructure setup

## pFsense
pFsense install is manual

## Proxmox
Proxmox install is manual

## TrueNAS core
FreeNAS install is manual

# 4. Setup

## [4.1. VM template definition](1_cloud_image/)
## [4.2. Provisioning with terraform](2_terraform/)
## [4.3. Configuration with ansible](3_ansible/)
## [4.4. Container orchestration with k8s](4_k8s/)
