APP:=kulturnetzd
NS:=kulturnetzd
CHART:=bitnami/moodle
# 
CHART_REPO:= bitnami https://charts.bitnami.com/bitnami

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

show_credentials: ## Show admin credentials
	$(K) view-secret kulturnetzd-moodle --namespace $(NS)
	@echo
	$(K) view-secret kulturnetzd-moodle moodle-password --namespace $(NS)
	@echo
	$(K) view-secret kulturnetzd-moodle smtp-password --namespace $(NS)

print_credentials: ## Show admin credentials
	echo Username: admin
	echo Password: $(kubectl get secret --namespace kulturnetzd kulturnetzd-moodle -o jsonpath="{.data.moodle-password}" | base64 --decode)
