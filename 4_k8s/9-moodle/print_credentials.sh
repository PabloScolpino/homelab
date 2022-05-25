echo Username: admin
echo Password: $(kubectl get secret --namespace kulturnetzd kulturnetzd-moodle -o jsonpath="{.data.moodle-password}" | base64 --decode)
