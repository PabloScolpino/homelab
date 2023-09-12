kubectl apply -f 1-persistent-volume-ar.yml
kubectl apply -f 3-persistent-volume-claim.yml

service=$1
kubectl scale --replicas=1 deployment.apps/$service -n media
