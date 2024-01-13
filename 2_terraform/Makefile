.PHONY: all help build console db_create db_seed db_destroy db_reset down destroy guard pessimize shell test up ups e2e
all: help

help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

plan: ## verify what's supposedly going to happen
	terraform plan

refresh: ## Ingest changes from proxmox
	terraform refresh

apply: ## Apply the changes
	terraform apply
