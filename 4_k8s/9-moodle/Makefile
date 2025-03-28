.PHONY: all help
all: help

K:=kubectl
APPLY:=$(K) apply -f
DEL:=$(K) delete -f

APP:=kulturnetzd
NS:=kulturnetzd

help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


create_namespace:
	-$(K) create namespace $(NS)

destroy_volumes: ## Destroy persistent volume and persistent volume claim
	# $(DEL) 30-persistent-volume-claim.yml
	# $(DEL) 10-pv-ar.yml

create_volumes: ## Create persistent volume and persistent volume claim
	-$(APPLY) 1-persistent-volume.yml

	$(MAKE) create_namespace

	$(APPLY) 3-persistent-volume-claim.yml

install_chart: ## Install the helm chart
	helm repo add bitnami https://charts.bitnami.com/bitnami
	helm repo update

install: ## Install the application
	$(MAKE) create_volumes
	helm install $(APP) -f values.yml bitnami/moodle --namespace $(NS)

update: ## Update the application
	$(MAKE) create_volumes
	$(APPLY) 3-backup.yml

secret:
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
