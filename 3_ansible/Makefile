.PHONY: all help build console db_create db_seed db_destroy db_reset down destroy guard pessimize shell test up ups e2e
all: help

help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

validate: ## Validate inventory
	ansible-inventory -i inventory --graph
	ansible-playbook ./dev_env_setup.yml -i ./inventory/all.yml --list-hosts


unifi: ## Deploy unificontroller
	ansible-playbook ./infrastructure.yml -i ./inventory/all.yml --limit unifi

plex:
	ansible-playbook ./infrastructure.yml -i ./inventory/all.yml --limit plex
