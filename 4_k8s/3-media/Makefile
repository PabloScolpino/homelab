.PHONY: all help destroy_volumes create_volumes create_namespace create scale update up down
all: help

help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

K:=kubectl
APPLY:=$(K) apply -f
DEL:=$(K) delete -f
SERVICES:=deluge radar sonar jacket kavita bazar

pv:
	$(K) get pv
	$(K) get pvc --namespace media

nfs_test:
	-$(K) delete -f nfs-test.yml -n media
	$(K) apply -f nfs-test.yml -n media

destroy_volumes: down ## Destroy persistent volume and persistent volume claim
	# -$(DEL) 3-persistent-volume-claim.yml
	# -$(DEL) 1-persistent-volume-ar.yml -n media
	-$(K) delete pv deluge-config -n media
	-$(K) delete pv jacket-config -n media
	-$(K) delete pv kavita-config -n media
	-$(K) delete pv nas-books -n media
	-$(K) delete pv nas-comics -n media
	-$(K) delete pv nas-downloads -n media
	-$(K) delete pv nas-movies -n media
	-$(K) delete pv nas-series -n media

create_volumes: ## Create persistent volume and persistent volume claim
	# Creating PV
	$(APPLY) 1-persistent-volume-ar.yml

	# Creating Namespace
	$(MAKE) create_namespace

	# Creating PVC
	$(APPLY) 3-persistent-volume-claim.yml

create_namespace:
	$(APPLY) 2-namespace.yml

create: ## create status deployment
	$(MAKE) create_volumes
	$(MAKE) create_namespace
	$(MAKE) update

up: ## Scale deployment to 1
	for service in $(SERVICES); do \
		$(K) scale --replicas=1 deployment.apps/$$service -n media; \
	done

down: ## Scale deployment to 0
	for service in $(SERVICES); do \
		$(K) scale --replicas=0 deployment.apps/$$service -n media; \
	done

update: ## Update status deployment
	$(APPLY) 4-torrent.yml
	$(APPLY) 5-radar.yml
	$(APPLY) 6-sonar.yml
	$(APPLY) 7-bazar.yml
	$(APPLY) 8-jacket.yml
	$(APPLY) 9-kavita.yml

torrent:
	# Delete deployments, service
	-$(DEL) 4-torrent.yml --namespace media

	# Try to delete the pod sooner
	# $(K) delete pod $$podname --grace-period=0 --force -n media; \
	for podname in `$(K) get pod -n media | grep deluge | cut -f1 -d' '`; do \
		echo $$podname; \
		$(K) delete pod $$podname -n media; \
	done

	# Delete PVC
	-$(K) delete pvc deluge-config --namespace media
	-$(K) delete pvc nas-downloads --namespace media
	# -$(DEL) 3-jacket-pvc.yml --namespace media

	# Delete PV
	-$(K) delete pv deluge-config
	-$(K) delete pv nas-downloads

	$(MAKE) create_volumes

	# Create deployment, service
	$(APPLY) 4-torrent.yml

