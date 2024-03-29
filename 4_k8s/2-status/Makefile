.PHONY: all help destroy_volumes create_volumes create_namespace create scale update
all: help

help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

K:=kubectl
APPLY:=$(K) apply -f
DEL:=$(K) delete -f

destroy_volumes: ## Destroy persistent volume and persistent volume claim
	$(DEL) 2-status/30-persistent-volume-claim.yml
	$(DEL) 2-status/10-pv-ar.yml

create_volumes: ## Create persistent volume and persistent volume claim
	$(APPLY) 2-status/10-pv-ar.yml
	$(MAKE) create_namespace
	$(APPLY) 2-status/30-persistent-volume-claim.yml

create_namespace:
	$(APPLY) 2-status/20-namespace.yml

create: ## create status deployment
	$(MAKE) destroy_volumes
	$(MAKE) create_volumes
	$(MAKE) create_namespace
	$(APPLY) 2-status/40-deployment.yml
	$(APPLY) 2-status/51-smokeping-status-ar.yml

up: ## Scale status deployment to 1
	$(K) scale --replicas=1 deployment.apps/smokeping -n status

down: ## Scale status deployment to 0
	$(K) scale --replicas=0 deployment.apps/smokeping -n status

update: ## Update status deployment
	$(APPLY) 2-status/20-namespace.yml
	$(APPLY) 2-status/40-deployment.yml
	$(APPLY) 2-status/51-smokeping-status-ar.yml
