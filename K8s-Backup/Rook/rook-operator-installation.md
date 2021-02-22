# Rook Operator

Rook turns distributed storage systems into self-managing,
self-scaling, self-healing storage services. 

[https://rook.github.io/docs/rook/master/ceph-quickstart.html#storage]()

1. Clone project
    * `git clone --single-branch --branch master https://github.com/rook/rook.git`
    * `cd rook/cluster/examples/kubernetes/ceph`
2. Apply 
    * Operator: `kubectl create -f crds.yaml -f common.yaml -f operator.yaml`
    * CR: `kubectl create -f cluster-test.yaml`

4. Teardown
   1. [https://github.com/rook/rook/blob/master/Documentation/ceph-teardown.md]()
   2. [https://cloud.tencent.com/developer/article/1741307]()


<!-- Namespace terminating -->
```
kubectl get namespaces rook-ceph -o json | jq '.spec.finalizers = []' > rook-ceph-ns.json
```
```
kubectl proxy
```
``` bash
curl -k -H "Content-Type:application/json" -X PUT --data-binary @rook-ceph-ns.json http://127.0.0.1:8001/api/v1/namespaces/rook-ceph/finalize
```