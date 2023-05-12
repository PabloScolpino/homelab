# kubernetes cluster server API endpoint
# ar.olumpos.net
# server=https://k8s.ar.olumpos.lan:6443
server=https://10.0.0.50:6443

# the name of the secret containing the service account token goes here
secret_name=github-actions-secret

ns_staging=nb-site-staging
ns_production=nb-site-production

ca=$(kubectl get secret/$secret_name --namespace=$ns_staging -o jsonpath='{.data.ca\.crt}')

token_staging=$(kubectl get secret/$secret_name --namespace=$ns_staging -o jsonpath='{.data.token}' | base64 --decode)
token_production=$(kubectl get secret/$secret_name --namespace=$ns_production -o jsonpath='{.data.token}' | base64 --decode)

echo "---
apiVersion: v1
kind: Config
clusters:
  - name: default-cluster
    cluster:
      certificate-authority-data: ${ca}
      server: ${server}
contexts:
  - name: staging-context
    context:
      cluster: default-cluster
      namespace: ${ns_staging}
      user: staging-user
  - name: production-context
    context:
      cluster: default-cluster
      namespace: ${ns_production}
      user: production-user
current-context: default-context
users:
  - name: staging-user
    user:
      token: ${token_staging}
  - name: production-user
    user:
      token: ${token_production}
" > nb-site-kubeconfig.yml
