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

## VM Creation

The creation of the VMs will use the template created in the previous step
This creation will be done using `2_terraform` files

## VM configuration

Look at `3_ansible`


### Kubernetes cluster
Single node microk8s

1. [Microk8s getting started](https://microk8s.io/docs)
2. Enable microk8s modules
```
microk8s enable dns storage metallb
```
3. Get cluster config and setup remote admin
```
microk8s config > cluster.conf
```
4. Install traefik
full install, not through microk8s plugin
```
helm repo add traefik https://helm.traefik.io/traefik
helm repo update
kubectl create namespace traefik
helm install -f 1-traefik/values.yml traefik traefik/traefik -n traefik
kubectl apply -f 1-traefik/1-configuration.yml
```

5. check traefik dashboard
```
kubectl port-forward pod/traefik-[:alpha:]* -n traefik 9000:9000
open http://localhost:9000/dashboard/
```

# Tools

## [Kubectx](https://github.com/ahmetb/kubectx)

To swich between clusters easily

## [Lens](https://github.com/lensapp/lens)

Nice electron UI to inspect / monitor k8s clustes

## [Devspace](https://github.com/loft-sh/devspace)

Generate Helm charts and some other dev tasks are automated
