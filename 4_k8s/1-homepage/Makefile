.PHONY: all help
all: help

K:=kubectl
APPLY:=$(K) apply -f
DEL:=$(K) delete -f

help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

create_namespace:
	$(APPLY) 2-namespace.yml

destroy_volumes: ## Destroy persistent volume and persistent volume claim
	$(DEL) 30-persistent-volume-claim.yml
	$(DEL) 10-pv-ar.yml

create_volumes: ## Create persistent volume and persistent volume claim
	$(APPLY) 1-persistent-volume.yml
	$(MAKE) create_namespace
	$(APPLY) 3-persistent-volume-claim.yml

create_ingress:
	$(APPLY) 5-ingress.yml

install_chart: ## Install the helm chart
	helm repo add jameswynn https://jameswynn.github.io/helm-charts
	helm repo update

install: ## Install the application
	helm install homepage jameswynn/homepage --namespace homepage --create-namespace
	$(APPLY) 5-ingress.yml
	# helm install lubelogger anza-labs/lubelogger --namespace vehicle --create-namespace --version 0.5.12 -f values.yml

update: ## Update the application
	helm upgrade homepage jameswynn/homepage --namespace homepage -f values.yml
