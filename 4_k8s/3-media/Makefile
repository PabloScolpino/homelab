.PHONY: all help destroy_volumes create_volumes create_namespace create scale update up down
all: help

help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

K:=kubectl
APPLY:=$(K) apply -f
DEL:=$(K) delete -f

APP:=media
NS:=media
SERVICES:=deluge radar sonar jacket kavita bazar

create_namespace:
	@echo
	# Creating Namespace
	-$(K) create namespace $(NS)

create_volumes: ## Create persistent volume and persistent volume claim
	@echo
	# Creating PV
	$(APPLY) 1-persistent-volume.yml
	@echo
	# Creating PVC
	$(APPLY) 3-persistent-volume-claim.yml

create_backup: ## Create/Update the backup
	@echo
	# Creating the backup
	$(APPLY) 3-backup.yml

create_deployments: ## Create the services' deployments
	@echo
	# Update each service
	$(APPLY) 4-torrent.yml
	$(APPLY) 5-radar.yml
	$(APPLY) 6-sonar.yml
	$(APPLY) 7-bazar.yml
	$(APPLY) 8-jacket.yml
	$(APPLY) 9-kavita.yml

install: ## Install the application
	$(MAKE) create_namespace
	$(MAKE) create_volumes
	$(MAKE) create_backup
	$(MAKE) create_deployments

update: install ## Update the application
	# Stopping all services and bringing them up again to force an image pull

	$(MAKE) down
	@echo
	# Sleeping for 1 second
	sleep 1
	$(MAKE) up

up: ## Scale deployment to 1
	@echo
	# STARTING all services
	for service in $(SERVICES); do \
		$(K) scale --replicas=1 deployment.apps/$$service --namespace $(NS); \
	done

down: ## Scale deployment to 0
	@echo
	# STOPPING all services
	for service in $(SERVICES); do \
		$(K) scale --replicas=0 deployment.apps/$$service --namespace $(NS); \
	done
