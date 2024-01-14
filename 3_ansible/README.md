# Requirements

    # Install ansible
    ansible

    # install requirements
    ansible-galaxy install -r requirements.yml

# Development

Check available commands with:

    make help

## Validate inventory with

    make validate


# Homelab Infrastructure

    make infrastructure

## Plex

    make plex

## K8s

    make k8s

### Kubernetes cluster

[how to access the cluster](https://kubernetes.io/docs/tasks/access-application-cluster/access-cluster/)

## Development setup

    ansible-playbook ./dev_env_setup.yml -i ./inventory/all.yml --limit hermes

## Setup terminal on linux host

    ansible-playbook ./infrastructure.yml -i ./inventory/all.yml --limit hermes
    ansible-playbook ./infrastructure.yml -i ./inventory/all.yml --limit work
