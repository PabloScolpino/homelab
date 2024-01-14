.PHONY: all help build console db_create db_seed db_destroy db_reset down destroy guard pessimize shell test up ups e2e
all: help

help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

install: requirements.yml ## Install ansible python dependencies
	ansible-galaxy install -r requirements.yml

validate: ## Validate inventory
	ansible-inventory -i inventory --graph
	ansible-playbook ./dev_env_setup.yml -i ./inventory/all.yml --list-hosts

infrastructure: ## Run on all hosts
	ansible-playbook ./infrastructure.yml -i ./inventory/all.yml

unifi: ## Deploy unifi controller
	ansible-playbook ./infrastructure.yml -i ./inventory/all.yml --limit unifi

plex: ## Deploy plex server
	ansible-playbook ./infrastructure.yml -i ./inventory/all.yml --limit plex

k8s: ## Deploy k8s cluster
	ansible-playbook ./infrastructure.yml -i ./inventory/all.yml --limit k8s
