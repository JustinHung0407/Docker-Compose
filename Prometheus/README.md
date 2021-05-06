helm install --name prometheus-operator --set rbacEnable=true --namespace=monitoring stable/prometheus-operator



# Staging
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm install -f values.yaml metrics-tc prometheus-community/kube-prometheus-stack -n metrics-system