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
