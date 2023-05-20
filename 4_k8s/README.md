# Traefik

## Access the dashboard

    kubectl port-forward $(kubectl get pods --selector "app.kubernetes.io/name=traefik" --output=name -n kube-system) 9000:9000 -n kube-system
