NS:=vehicle
APP:=lubelogger
CHART:=anza-labs/lubelogger
# https://artifacthub.io/packages/helm/anza-labs/lubelogger
CHART_REPO:=anza-labs https://anza-labs.github.io/charts

include ../common_ns.mk

common:
	$(MAKE) create_namespace
	$(MAKE) create_pv
	$(MAKE) create_pvc
	$(MAKE) create_backup
	$(MAKE) create_ingress

install: check_helm_secrets ## Install the application
	$(MAKE) common
	$(MAKE) install_application

update: ## Update the application
	$(MAKE) common
	$(MAKE) update_application

upgrade: update
