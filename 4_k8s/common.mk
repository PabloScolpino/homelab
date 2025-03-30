.PHONY: all help common install update upgrade
all: help

help:
	@awk 'BEGIN {FS = ":.*?## "; printf "\033[36m%-30s\033[0m %s\n", "Action", "Description"} /^[a-zA-Z0-9_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

K:=kubectl
APPLY:=$(K) apply -f
DELETE:=$(K) delete -f


list_volumes: ## Show volumes
	@echo
	# PersistentVolume
	$(K) get pv
	
	@echo
	# PersistentVolumeClaim
	@if [ -z "$(NS)" ]; then \
		$(K) get pvc --all-namespaces; \
	else \
		$(K) get pvc --namespace $(NS); \
	fi
