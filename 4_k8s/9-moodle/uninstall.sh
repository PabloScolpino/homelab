helm uninstall kulturnetzd --namespace kulturnetzd
# kubectl delete -f 3-persistent-volume-claim.yml -f 1-persistent-volume-ar-files-nas.yml
kubectl delete -f 3-persistent-volume-claim.yml
kubectl delete -f 1-persistent-volume-ar-files-nas.yml
