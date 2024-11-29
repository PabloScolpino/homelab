.PHONY: all help status scale
all: help

help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

K:=kubectl
APPLY:=$(K) apply -f
DEL:=$(K) delete -f
SCALE:=$(K) scale

check_pv:
	$(K) get pv
	$(K) get pvc --all-namespaces

forward_traefik: ## forward traefik dashboard
	$(eval PODNAME=$(shell sh -c "kubectl get pods --selector "app.kubernetes.io/name=traefik" --output=name -n kube-system  2>&1 | head -1"))
	@echo
	@echo "http://localhost:9000/dashboard/"
	@echo
	$(K) port-forward $(PODNAME) 9000:9000 -n kube-system

forward_jacket: ## forward traefik dashboard
	$(eval PODNAME=$(shell sh -c "kubectl get pods --selector "app=jacket" --output=name -n media 2>&1 | head -1"))
	@echo
	@echo "http://localhost:9117/"
	@echo
	@echo $(PODNAME)
	$(K) port-forward $(PODNAME) 9117:9117 -n media
