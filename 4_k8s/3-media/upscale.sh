count=1
kubectl scale --replicas=$count deployment.apps/deluge -n media
kubectl scale --replicas=$count deployment.apps/radar -n media
kubectl scale --replicas=$count deployment.apps/sonar -n media
kubectl scale --replicas=$count deployment.apps/bazar -n media
