<!-- Test pod using alpine -->
namespace=default
kubectl run -it --rm --restart=Never alpine --image=alpine --namespace=$namespace sh

kubectl exec -i -t -n $namespace $pod_name -c gitea "--" sh -c "clear; (bash || ash || sh)"

<!-- Apply file to k8s -->
`cat << EOF | kubectl apply -f -`


<!-- Force Delete -->
kubectl delete pod $(kubectl get po -A |grep drone|awk '{print $2}') -n drone --grace-period=0 --force

kubectl delete pod --grace-period 0 --force -n <namespace> <pod_name>

kubectl get pod -n drone | grep ImagePullBackOff | awk '{print $1}' | xargs kubectl delete pod --grace-period 0 --force -n drone

<!-- Namespace terminating -->
```
kubectl get namespaces velero -o json | jq '.spec.finalizers = []' > velero-ns.json
```
```
kubectl proxy
```
``` bash
curl -k -H "Content-Type:application/json" -X PUT --data-binary @velero-ns.json http://127.0.0.1:8001/api/v1/namespaces/velero/finalize
```
or
``` json
"spec": {
        "finalizers": []
    }
```


<!-- Patch PVC -->
kubectl patch pv/<PersistentVolume name> -p '{"spec":{"persistentVolumeReclaimPolicy":"Retain"}}'


* Remove current spec.claimRef values to change the PV's status from Released to Available.
kubectl patch pv/<PersistentVolume name> --type json -p='[{"op": "remove", "path": "/spec/claimRef"}]' -n monitoring

<!-- kubelet -->
journalctl -u  kubelet -f 