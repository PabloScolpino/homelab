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
	helm repo add k8up-io https://k8up-io.github.io/k8up
	helm repo update

	# Install k8sup resources
	kubectl apply -f https://github.com/k8up-io/k8up/releases/download/v2.12.0/k8up-crd.yaml --server-side

install: ## Install the application
	helm install k8up-io/k8up --generate-name \
		--namespace backup \
		--create-namespace

update: ## Update the application
	helm upgrade k8up-1743117928 k8up-io/k8up \
		--namespace backup \
		--set metrics.enabled=false

