# Moodle configuration

https://github.com/bitnami/charts/tree/master/bitnami/moodle

# 1. Install

## 1.1. Add bitnami chart repository
    helm repo add bitnami https://charts.bitnami.com/bitnami

## 1.2. Install moodle
    kubectl apply -f 1-persistent-volume-ar-files-nas.yml -f 3-persistent-volume-claim.yml
    helm install kulturnetzd -f values.yml bitnami/moodle --namespace kulturnetzd

**Output**

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


## 1.3. Get the Moodle&trade; URL:

    export NODE_PORT=$(kubectl get --namespace kulturnetzd -o jsonpath="{.spec.ports[0].nodePort}" services kulturnetzd-moodle)
    export NODE_IP=$(kubectl get nodes --namespace kulturnetzd -o jsonpath="{.items[0].status.addresses[0].address}")
    echo "Moodle&trade; URL: http://$NODE_IP:$NODE_PORT/"

## 1.4. Get your Moodle&trade; login credentials by running:

    echo Username: admin
    echo Password: $(kubectl get secret --namespace kulturnetzd kulturnetzd-moodle -o jsonpath="{.data.moodle-password}" | base64 --decode)

# 2. Upgrade

    export MARIADB_ROOT_PASSWORD=$(kubectl get secret --namespace "kulturnetzd" kulturnetzd-mariadb -o jsonpath="{.data.mariadb-root-password}" | base64 --decode)
    export MARIADB_PASSWORD=$(kubectl get secret --namespace "kulturnetzd" kulturnetzd-mariadb -o jsonpath="{.data.mariadb-password}" | base64 --decode)

    helm upgrade kulturnetzd -f values.yml bitnami/moodle --namespace kulturnetzd \
      --set mariadb.auth.rootPassword=$MARIADB_ROOT_PASSWORD \
      --set mariadb.auth.password=$MARIADB_PASSWORD

# 3. Uninstall

    helm uninstall kulturnetzd --namespace kulturnetzd
    kubectl delete -f 3-persistent-volume-claim.yml
    kubectl delete -f 1-persistent-volume-ar-files-nas.yml
