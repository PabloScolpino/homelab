include $(dir $(lastword $(MAKEFILE_LIST)))common.mk

################################################################################
### K8s Actions
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
	$(APPLY) 2-persistent-volume-claim.yml

delete_volumes: ## Show volumes
	@echo
	# Deleting PV
	$(DELETE) 1-persistent-volume.yml

	@echo
	# Deleting PVC
	$(DELETE) 2-persistent-volume-claim.yml

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

create_deployment: ## Create the deployment
	@echo
	# Creating the deployment
	$(APPLY) 4-deployment.yml

create_deployments: ## Create the services' deployments
	for service in $(SERVICES); do \
		echo ""; \
		echo "Creating deployment for $$service"; \
		$(APPLY) 4-$$service.yml --namespace $(NS); \
	done

create_ingress: ## Create the ingress
	@echo
	# Creating the ingress route
	$(APPLY) 5-ingress.yml

up: ## Scale deployment to 1
	@echo
	# STARTING all services
	for service in $(SERVICES); do \
		$(K) scale --replicas=1 deployment.apps/$$service --namespace $(NS); \
	done

down: ## Scale deployment to 0
	@echo
	# STOPPING all services
	for service in $(SERVICES); do \
		$(K) scale --replicas=0 deployment.apps/$$service --namespace $(NS); \
	done

################################################################################
### Helm Actions
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
	@HELM_CMD="helm install $(APP) $(CHART) --namespace $(NS)";\
	if [ -f values.yml ]; then \
		HELM_CMD="$$HELM_CMD -f values.yml"; \
	fi; \
	if [ -f secrets.yml ]; then \
		$$HELM_CMD -f secrets.yml; \
	else \
		$$HELM_CMD; \
	fi

update_application:
	@HELM_CMD="helm upgrade $(APP) $(CHART) --namespace $(NS)";\
	if [ -f values.yml ]; then \
		HELM_CMD="$$HELM_CMD -f values.yml"; \
	fi; \
	if [ -f secrets.yml ]; then \
		$$HELM_CMD -f secrets.yml; \
	else \
		$$HELM_CMD; \
	fi
