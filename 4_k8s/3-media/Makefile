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

destroy_volumes: down ## Destroy persistent volume and persistent volume claim
	-$(DEL) 3-persistent-volume-claim.yml
	-$(DEL) 1-persistent-volume-ar.yml -n media
	-$(K) delete pv deluge-config -n media
	-$(K) delete pv jacket-config -n media
	-$(K) delete pv kavita-config -n media
	-$(K) delete pv komga-config -n media
	-$(K) delete pv nas-books -n media
	-$(K) delete pv nas-comics -n media
	-$(K) delete pv nas-downloads -n media
	-$(K) delete pv nas-movies -n media
	-$(K) delete pv nas-series -n media

create_volumes: ## Create persistent volume and persistent volume claim
	$(APPLY) 1-persistent-volume-ar.yml
	$(MAKE) create_namespace
	$(APPLY) 3-persistent-volume-claim.yml

create_namespace:
	$(APPLY) 2-namespace.yml

create: ## create status deployment
	$(MAKE) create_volumes
	$(MAKE) create_namespace
	$(MAKE) update

up: ## Scale deployment to 1
	for service in $(SERVICES); do \
		echo $$service; \
	done
	# $(K) scale --replicas=1 deployment.apps/deluge -n media
	# $(K) scale --replicas=1 deployment.apps/radar -n media
	# $(K) scale --replicas=1 deployment.apps/radar -n media

down: ## Scale deployment to 0
	for service in $(SERVICES); do \
		echo $$service; \
		$(K) scale --replicas=0 deployment.apps/$$service -n media; \
	done

update: ## Update status deployment
	$(APPLY) 4-torrent.yml
	$(APPLY) 5-radar.yml
	$(APPLY) 6-sonar.yml
	$(APPLY) 7-bazar.yml
	$(APPLY) 8-jacket.yml
	$(APPLY) 9-kavita.yml
