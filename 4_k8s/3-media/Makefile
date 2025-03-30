APP:=media
NS:=media
SERVICES:=deluge radar sonar jacket kavita bazar

include ../common.mk

install: ## Install the application
	$(MAKE) create_namespace
	$(MAKE) create_pv
	$(MAKE) create_pvc
	$(MAKE) create_backup
	$(MAKE) create_deployments

update: install ## Update the application
	# Stopping all services and bringing them up again to force an image pull

	$(MAKE) down
	@echo
	# Sleeping for 1 second
	sleep 1
	$(MAKE) up
