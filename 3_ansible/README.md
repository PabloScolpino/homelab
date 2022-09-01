# Requirements

    # Install ansible
    ansible

    # install requirements
    ansible-galaxy install -r requirements.yml

# Development
## Validate inventory with

    ansible-inventory -i inventory --graph
    ansible-playbook ./dev_env_setup.yml -i ./inventory/all.yml --list-hosts

## Kubernetes cluster
[how to access the cluster](https://kubernetes.io/docs/tasks/access-application-cluster/access-cluster/)

# Homelab Infrastructure

    ansible-playbook ./infrastructure.yml -i ./inventory/all.yml --ask-become-pass

## Pi Remote Node
    ansible-playbook ./infrastructure.yml -i ./inventory/all.yml --limit pi --ask-become-pass

## Plex
    ansible-playbook ./infrastructure.yml -i ./inventory/all.yml --limit plex --ask-become-pass

## Development setup

    ansible-playbook ./dev_env_setup.yml -i ./inventory/all.yml --limit hermes

## Setup terminal on linux host

### prerequisites

    # RUN as root

    apt-get update
    apt-get install sudo
    usermod -aG sudo quantum

### On all machines

    ansible-playbook ./terminal.yml -i ./inventory/all.yml --ask-become-pass

### On a specific machine

    ansible-playbook ./terminal.yml -i ./inventory/all.yml --limit hermes
