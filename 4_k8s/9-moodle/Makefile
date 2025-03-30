.PHONY: all help
all: help

help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

K:=kubectl
APPLY:=$(K) apply -f
DEL:=$(K) delete -f

APP:=kulturnetzd
NS:=kulturnetzd


create_namespace:
	@echo
	# Creating Namespace
	-$(K) create namespace $(NS)

create_volumes: ## Create persistent volume and persistent volume claim
	@echo
	# Creating PV - Using k3s local volume provisioner
	# $(APPLY) 1-persistent-volume.yml
	@echo
	# Creating PVC
	$(APPLY) 3-persistent-volume-claim.yml

create_backup: ## Create/Update the backup
	@echo
	# Creating the backup
	$(APPLY) 3-backup.yml

install: ## Install the application
	$(MAKE) create_namespace
	$(MAKE) create_volumes
	$(MAKE) create_backup
	@echo
	# Creating PVC
	helm install $(APP) -f values.yml bitnami/moodle --namespace $(NS)

update: ## Update the application
	$(MAKE) create_namespace
	$(MAKE) create_volumes
	$(MAKE) create_backup
	@echo
	# Creating PVC
	# helm install $(APP) -f values.yml bitnami/moodle --namespace $(NS)

upgrade: update

install_chart: ## Install the helm chart
	helm repo add bitnami https://charts.bitnami.com/bitnami
	helm repo update

create_secret: ## Create and edit application secrets
	# NOTE: only backup at the moment
	-$(K) create secret generic backup \
		--from-literal=applicationKey="changeme" \
		--from-literal=keyID="changeme" \
		--from-literal=password="changeme" \
		--namespace $(NS)

	$(K) modify-secret backup --namespace $(NS)

show_credentials: ## Show admin credentials
	$(K) view-secret kulturnetzd-moodle --namespace $(NS)
	@echo
	$(K) view-secret kulturnetzd-moodle moodle-password --namespace $(NS)
	@echo
	$(K) view-secret kulturnetzd-moodle smtp-password --namespace $(NS)
