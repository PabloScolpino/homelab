kubectl apply -f 1-persistent-volume-ar-files-nas.yml -f 3-persistent-volume-claim.yml
helm install kulturnetzd -f values.yml bitnami/moodle --namespace kulturnetzd
