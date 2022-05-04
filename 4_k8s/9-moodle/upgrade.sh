export MARIADB_ROOT_PASSWORD=$(kubectl get secret --namespace "kulturnetzd" kulturnetzd-mariadb -o jsonpath="{.data.mariadb-root-password}" | base64 --decode)
export MARIADB_PASSWORD=$(kubectl get secret --namespace "kulturnetzd" kulturnetzd-mariadb -o jsonpath="{.data.mariadb-password}" | base64 --decode)

helm upgrade kulturnetzd -f values.yml bitnami/moodle --namespace kulturnetzd \
  --set mariadb.auth.rootPassword=$MARIADB_ROOT_PASSWORD \
  --set mariadb.auth.password=$MARIADB_PASSWORD
