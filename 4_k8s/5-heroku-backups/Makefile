NAMESPACES:=marianosaba publicationmapper
include ../common_ns.mk

common:
	$(foreach ns,$(NAMESPACES),$(MAKE) create_namespace NS=$(ns);)
	$(MAKE) install_marianosaba
	$(MAKE) install_publicationmapper

install: ## Install the application
	$(MAKE) common

update: install ## Update the application

_create_secret_cloudinary:
	-$(K) create secret generic cloudinary-credentials \
		--from-literal=api-key="changeme" \
		--from-literal=api-secret="changeme" \
		--from-literal=cloud-name="changeme" \
		--namespace=$(NS)

	$(K) modify-secret cloudinary-credentials --namespace $(NS)

create_secret_cloudinary_all: ## Create the secret for cloudinary
	$(foreach ns,$(NAMESPACES),$(MAKE) _create_secret_cloudinary NS=$(ns);)

_create_secret_postgres:
	-$(K) create secret generic postgres \
		--from-literal=database-url="postgresql://username:password@host:port/database" \
		--namespace=$(NS)

	$(K) modify-secret postgres --namespace $(NS)

create_secret_postgres_all: ## Create the secret for postgres
	$(foreach ns,$(NAMESPACES),$(MAKE) _create_secret_postgres NS=$(ns);)

create_secret_backup_all: ## Create the secret for backup for all namespaces
	$(foreach ns,$(NAMESPACES),$(MAKE) create_secret_backup NS=$(ns);)


debug_prebackup:
	$(MAKE) create_backup

_list_backups:
	@echo "Listing backups from S3 storage..."
	@export RESTIC_REPOSITORY=s3:s3.us-west-004.backblazeb2.com/backup-$(NS) && \
	export RESTIC_PASSWORD=$$(kubectl get secret backup -n $(NS) -o jsonpath='{.data.password}' | base64 -d) && \
	export AWS_ACCESS_KEY_ID=$$(kubectl get secret backup -n $(NS) -o jsonpath='{.data.keyID}' | base64 -d) && \
	export AWS_SECRET_ACCESS_KEY=$$(kubectl get secret backup -n $(NS) -o jsonpath='{.data.applicationKey}' | base64 -d) && \
	restic snapshots

list_backups:
	# $(foreach ns,$(NAMESPACES),$(MAKE) _list_backups NS=$(ns);)
	$(MAKE) _list_backups NS=marianosaba

install_marianosaba:
	$(K) apply -k marianosaba/

install_publicationmapper:
	$(K) apply -k publicationmapper/
