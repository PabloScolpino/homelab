service=$1
kubectl scale --replicas=0 deployment.apps/$service -n media
kubectl delete pvc/${service}-config -n media
kubectl delete pv/${service}-config
