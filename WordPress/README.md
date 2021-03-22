```
kind: Namespace
apiVersion: v1
metadata:
  name: test-sts
  labels:
    istio-injection: enabled
```
---
```
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: test
  namespace: test-sts
spec:
  gateways:
    - istio-system/default
    - mesh
  hosts:
    - test.test-sts.svc.cluster.local
    - test.baas.twcc.ai
  http:
    - route:
        - destination:
            host: wordpress-1615530763.test-sts.svc.cluster.local
            port:
              number: 80
```

