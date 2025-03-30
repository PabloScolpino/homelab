include common.mk

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
