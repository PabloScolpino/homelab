NS:=backup
APP:=k8up-1743117928
CHART:=k8up-io/k8up
CHART_REPO:=k8up-io https://k8up-io.github.io/k8up

include ../common_ns.mk

install_crd: ## Install k8sup resources
	kubectl apply -f https://github.com/k8up-io/k8up/releases/download/v2.12.0/k8up-crd.yaml --server-side

common:
	$(MAKE) create_namespace
	# $(MAKE) create_pv
	# $(MAKE) create_pvc

install: ## Install the application
	$(MAKE) common
	$(MAKE) install_application

update: ## Update the application
	$(MAKE) common
	$(MAKE) update_application

upgrade: update
