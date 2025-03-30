NS:=homepage
APP:=homepage
CHART:=jameswynn/homepage
#
CHART_REPO:=jameswynn https://jameswynn.github.io/helm-charts

include ../common_ns.mk

common:
	$(MAKE) create_namespace
	$(MAKE) create_ingress

install: ## Install the application
	$(MAKE) common
	$(MAKE) install_application

update: ## Update the application
	$(MAKE) common
	$(MAKE) update_application

upgrade: update
