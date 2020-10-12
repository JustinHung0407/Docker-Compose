# Rook Operator

Rook turns distributed storage systems into self-managing,
self-scaling, self-healing storage services. 

1. Clone project
    * `git clone --single-branch --branch  release-1.4 https://github.com/rook/rook.git`
    * `cd rook/cluster/examples/kubernetes/ceph`
2. Apply 
    * `kubectl create -f common.yaml`
    * `kubectl create -f operator.yaml`
    * `kubectl create -f cluster-test.yaml`