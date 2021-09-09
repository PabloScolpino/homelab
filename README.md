# Purpose

* Have all homelab services running as containers in our homelab
* have all configuration for the services as code
* updates are automatic and are triggered by git events
* inbound traffic from lan and wan.
* Reverse dns /proxy

# Platform

* one openwrt router
* one proxmox node
  * microk8s on VM
  * unbound / pihole on VM
* one freenas

## Setup

### FreeNAS install is manual

### Proxmox
Proxmox install is manual

#### Kubernetes cluster
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

# Tools

## [Kubectx](https://github.com/ahmetb/kubectx)

To swich between clusters easily

## [Lens](https://github.com/lensapp/lens)

Nice electron UI to inspect / monitor k8s clustes

## [Devspace](https://github.com/loft-sh/devspace)

Generate Helm charts and some other dev tasks are automated

# Services

## Definition

## Configuration

## Deployment

