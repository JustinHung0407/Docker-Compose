`istioctl install --set profile=demo --set values.global.imagePullPolicy=IfNotPresent --set meshConfig.outboundTrafficPolicy.mode=ALLOW_ANY`

### Egress settings

- Docs: [https://istio.io/latest/docs/tasks/traffic-management/egress/egress-control/]()
- Install `curl-ssl`
- Egress - ServiceEntry
```
kubectl apply -f - <<EOF
apiVersion: networking.istio.io/v1alpha3
kind: ServiceEntry
metadata:
  name: httpbin-ext
spec:
  hosts:
  - httpbin.org
  ports:
  - number: 80
    name: http
    protocol: HTTP
  resolution: DNS
  location: MESH_EXTERNAL
EOF
```
`kubectl exec "$SOURCE_POD" -c sleep -- curl -s http://192.168.2.51:8080/tsdbase/diagnose`




apiVersion: networking.istio.io/v1alpha3
kind: ServiceEntry
metadata:
  name: trial-ext
spec:
  hosts:
  - httpbin.org
  ports:
  - number: 80
    name: http
    protocol: HTTP
  resolution: DNS
  location: MESH_EXTERNAL