SECRET_NAME=ghcr-credentials
NAMESPACE=anascolpino
DOCKER_REGISTRY_SERVER=ghcr.io
DOCKER_USER=PabloScolpino
DOCKER_PASSWORD=$1
DOCKER_EMAIL=pabloscolpino@gmail.com

kubectl create secret docker-registry $SECRET_NAME \
  --namespace=$NAMESPACE \
  --docker-server=$DOCKER_REGISTRY_SERVER \
  --docker-username=$DOCKER_USER \
  --docker-password=$DOCKER_PASSWORD \
  --docker-email=$DOCKER_EMAIL
