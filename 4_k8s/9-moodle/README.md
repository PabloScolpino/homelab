# Moodle configuration

moodle-do-not-reply@olumpos.net
eR6b>DRe

https://github.com/bitnami/charts/tree/master/bitnami/moodle

# Instructions

    helm repo add bitnami https://charts.bitnami.com/bitnami
    kubectl --
    helm install kulturnetzd -f values.yml bitnami/moodle --namespace kulturnetzd


# Install Output
NAME: kulturnetzd
LAST DEPLOYED: Mon May  2 23:21:40 2022
NAMESPACE: kulturnetzd
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
CHART NAME: moodle
CHART VERSION: 12.1.10
APP VERSION: 3.11.5** Please be patient while the chart is being deployed **

1. Get the Moodle&trade; URL:

  Or running:

  export NODE_PORT=$(kubectl get --namespace kulturnetzd -o jsonpath="{.spec.ports[0].nodePort}" services kulturnetzd-moodle)
  export NODE_IP=$(kubectl get nodes --namespace kulturnetzd -o jsonpath="{.items[0].status.addresses[0].address}")
  echo "Moodle&trade; URL: http://$NODE_IP:$NODE_PORT/"

2. Get your Moodle&trade; login credentials by running:

  echo Username: admin
  echo Password: $(kubectl get secret --namespace kulturnetzd kulturnetzd-moodle -o jsonpath="{.data.moodle-password}" | base64 --decode)
