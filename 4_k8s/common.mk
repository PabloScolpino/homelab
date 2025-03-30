.PHONY: all help
all: help

help:
	@awk 'BEGIN {FS = ":.*?## "; printf "\033[36m%-30s\033[0m %s\n", "Target", "Description"} /^[a-zA-Z0-9_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

K:=kubectl
APPLY:=$(K) apply -f
DEL:=$(K) delete -f

create_namespace: ## Create the namespace if missing
	@echo
	# Creating Namespace
	-$(K) create namespace $(NS)

create_pv: ## Create the persistent volumes
	@echo
	# Creating PV
	$(APPLY) 1-persistent-volume.yml

create_pvc: ## Create the persistent volumes claims
	@echo
	# Creating PVC
	$(APPLY) 3-persistent-volume-claim.yml

create_backup: ## Create the backup schedule
	@echo
	# Creating the backup
	$(APPLY) 3-backup.yml

create_secret_backup: ## Create the secret for backup
	-$(K) create secret generic backup \
		--from-literal=applicationKey="changeme" \
		--from-literal=keyID="changeme" \
		--from-literal=password="changeme" \
		--namespace=vehicle

	$(K) modify-secret backup --namespace vehicle

create_ingress: ## Create the ingress
	@echo
	# Creating the ingress route
	$(APPLY) 5-ingress.yml

install_chart:
	helm repo add $(CHART_REPO)
	helm repo update

check_helm_secrets: ## Check if helm secrets file secrets.yml exists
	@if [ ! -f secrets.yml ]; then \
		echo "Error: secrets.yml not found. Please create it from the template:"; \
		echo "cp secrets.yml.template secrets.yml"; \
		echo "Then edit secrets.yml with your actual secrets."; \
		exit 1; \
	fi

create_helm_secrets: ## Create the helm secrets file
	cp secrets.yml.template secrets.yml
	vi secrets.yml

install_application: install_chart
	@HELM_CMD="helm install $(APP) $(CHART) --namespace $(NS) -f values.yml";\
	if [ -f secrets.yml ]; then \
		$$HELM_CMD -f secrets.yml; \
	else \
		$$HELM_CMD; \
	fi
