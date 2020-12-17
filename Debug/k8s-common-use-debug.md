<!-- Test pod using alpine -->
kubectl run -it --rm --restart=Never alpine --image=alpine --namespace=$namespace sh

kubectl exec -i -t -n $namespace $pod_name -c gitea "--" sh -c "clear; (bash || ash || sh)"

<!-- Apply file to k8s -->
`cat << EOF | kubectl apply -f -`


<!-- Force Delete -->
kubectl delete pod $(kubectl get po -A |grep drone|awk '{print $2}') -n drone --grace-period=0 --force

kubectl delete pod --grace-period 0 --force -n <namespace> <pod_name>

kubectl get pod -n drone | grep ImagePullBackOff | awk '{print $1}' | xargs kubectl delete pod --grace-period 0 --force -n drone