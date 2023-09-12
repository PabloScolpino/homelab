service=$1
count=$2
kubectl scale --replicas=$count deployment.apps/$service -n media
