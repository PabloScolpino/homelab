NS:=status
APP:=status
SERVICES:=smokeping

include ../common_ns.mk

install: ## Install the application
	$(MAKE) create_pv
	$(MAKE) create_namespace
	$(MAKE) create_pvc
	$(MAKE) create_deployment
	$(MAKE) create_ingress

update: install ## Update the application
	# Stopping all services and bringing them up again to force an image pull

	$(MAKE) down
	@echo
	# Sleeping for 1 second
	sleep 1
	$(MAKE) up

upgrade: update
