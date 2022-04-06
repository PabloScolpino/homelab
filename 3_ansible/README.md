# Requirements

    # Install ansible
    ansible

    # install requirements
    ansible-galaxy install -r requirements.yml

# Validate inventory with

    ansible-inventory -i inventory --graph
    ansible-playbook ./dev_env_setup.yml -i ./inventory/all.yml --list-hosts

# Homelab Infrastructure

    ansible-playbook ./infrastructure.yml -i ./inventory/all.yml --ask-become-pass

### Kubernetes cluster
[how to access the cluster](https://kubernetes.io/docs/tasks/access-application-cluster/access-cluster/)

#### Old notes

1.  Get cluster config and setup remote admin
```
microk8s config > cluster.conf
```
2.  Install traefik
full install, not through microk8s plugin
```
helm repo add traefik https://helm.traefik.io/traefik
helm repo update
kubectl create namespace traefik
helm install -f 1-traefik/values.yml traefik traefik/traefik -n traefik
kubectl apply -f 1-traefik/1-configuration.yml
```
3. check traefik dashboard
```
kubectl port-forward pod/traefik-[:alpha:]* -n traefik 9000:9000
open http://localhost:9000/dashboard/
```

# Pi Remote Node
    ansible-playbook ./pi.yml -i ./inventory/all.yml --limit pi --ask-become-pass

# Dev machine setup

## setup all machines

    ansible-playbook ./dev_env_setup.yml -i ./inventory/all.yml --ask-become-pass

## a specific machine

    ansible-playbook ./dev_env_setup.yml -i ./inventory/all.yml --limit hermes

# Setup terminal on linux host

## prerequisites

    # RUN as root

    apt-get update
    apt-get install sudo
    usermod -aG sudo quantum

## setup all machines

    ansible-playbook ./terminal.yml -i ./inventory/all.yml --ask-become-pass

## a specific machine

    ansible-playbook ./terminal.yml -i ./inventory/all.yml --limit hermes
