# Velero

Velero is a tool to back up and restore your Kubernetes cluster resources and persistent volumes.

1. Install velero
    * install cli 
      * Install by `brew`
        * Install HomeBrew [https://brew.sh/](https://brew.sh/)
        * `brew install velero`
      * Install by tar  
        * curl -LO https://github.com/vmware-tanzu/velero/releases/download/v1.5.3/velero-v1.5.3-linux-amd64.tar.gz
        * tar -C /usr/local/bin -xzvf velero-v1.5.3-linux-amd64.tar.gz
        * export PATH=$PATH:/usr/local/bin/velero-v1.5.3-linux-amd64/
    * Clone project
        * `git clone --single-branch --branch v1.5.3 https://github.com/vmware-tanzu/velero.git`
        * `cd velero`
    * Create file "credentials-velero"
        * ``` bash
          echo "[default]
          aws_access_key_id = minio
          aws_secret_access_key = minio123" > credentials-velero
          ```
          ``` bash
          echo "[default]
          aws_access_key_id = 328LWHCFU51FNDE6989X
          aws_secret_access_key = 8zhxXUKyxAwDa7pNMZUNoXdO4JGIEtRWnZ5PKlfW" > credentials-velero-twcc
          ```
          ``` bash
          cos.twcc.ai
          echo "[default]
          aws_access_key_id = RD2AL8UEDZXLKTEW5ZFX
          aws_secret_access_key = uMa5gTCWvaZbtDelWoNlZhRGhzSalCxGAi0BrytF" > credentials-velero-twcc
          ```
          ``` yaml
          kind: Secret
          apiVersion: v1
          metadata:
            name: cloud-credentials
            namespace: velero
          data:
            cloud: |-
               W2RlZmF1bHRdCmF3c19hY2Nlc3Nfa2V5X2lkPVJEMkFMOFVFRFpYTEtURVc1WkZYCmF3c19zZWNyZXRfYWNjZXNzX2tleT11TWE1Z1RDV3ZhWmJ0RGVsV29ObFpoUkdoelNhbEN4R0FpMEJyeXRG
          type: Opaque
          ```


    * Useing minio
      * `kubectl apply -f examples/minio/00-minio-deployment.yaml`
    * Istio Labeled
      * `kubectl create ns velero`
      * `kubectl label namespace velero istio-injection=enabled`
    * Install Using Helm
      * `helm repo add vmware-tanzu https://vmware-tanzu.github.io/helm-charts`
      * `helm install vmware-tanzu/velero --namespace velero --create-namespace -f values.yaml --generate-name --set cleanUpCRDs=true`
    * Installation config  
        ```
        velero install \
            --use-restic \
            --provider aws \
            --plugins velero/velero-plugin-for-aws:v1.0.0 \
            --bucket velero \
            --secret-file ./credentials-velero \
            --use-volume-snapshots=false \
            --default-volumes-to-restic \
            --backup-location-config region=minio,s3ForcePathStyle="true",s3Url=http://minio.velero.svc:9000
        ```
        ```
        velero install \
            --velero-pod-cpu-request 1600m \
            --velero-pod-mem-request 256Mi \
            --velero-pod-cpu-limit 4 \
            --velero-pod-mem-limit 1024Mi \
            --use-restic \
            --restic-pod-cpu-request 1600m \
            --restic-pod-mem-request "256Mi" \
            --restic-pod-cpu-limit "4" \
            --restic-pod-mem-limit "4096Mi" \
            --provider aws \
            --plugins velero/velero-plugin-for-aws:latest \
            --bucket k8s-prod-backup-test \
            --secret-file credentials-velero-twcc \
            --use-volume-snapshots=false \
            --default-volumes-to-restic \
            --backup-location-config region=default,s3ForcePathStyle="true",s3Url=https://cos.twcc.ai
        ```
    * Test example
      1. Create deployment
         1. `kubectl apply -f examples/nginx-app/base.yaml`
         2. `kubectl get deployments -l component=velero --namespace=velero`
         3. `kubectl get deployments --namespace=nginx-example`
      2. Backup
         1. `velero backup create nginx-backup --include-namespaces nginx-example --wait`

      3. Test disaster
         1. `kubectl delete namespaces nginx-example`
         2. `kubectl get deployments --namespace=nginx-example`

      4. Restore
         1. `velero restore get`
         2. `velero restore create --from-backup nginx-backup`
         3. Restoring to different namespace and useing certain namespace
            1. namespace-mappings
               1. `velero restore create --from-backup twcc-baas-backup-20201013105651 --namespace-mappings sonar:sonar-test-backup --include-namespaces sonar`
            2. include-resources
               1. `velero restore create --from-backup twcc-baas-backup-20201013105651 --include-namespaces sonar --include-resources PersistentVolume,PersistentVolumeClaims --include-cluster-resources=true`
            3. include-cluster-resources
               1. `velero restore create --from-backup only-sonar-pv --include-namespaces sonar --include-resources PersistentVolume --include-cluster-resources=true`
         4. More options: 
            1. [velero restore reference](https://velero.io/docs/v1.5/restore-reference/)
            2. [Resource filtering](https://velero.io/docs/v1.5/resource-filtering/#docs)
      5. Schedule
         1. `velero schedule create nginx-backup --include-namespaces nginx-example --schedule="@every 24h" --ttl 7200h0m0s`
         2. `velero schedule create twcc-baas-backup --schedule="0 0 */24 * *"`
         3. For 3ENV
            * `velero schedule create k8s-backup-daily --schedule="0 0 */24 * *"`
      6. Delete
         1. delete velero 
            ```
            kubectl delete namespace/velero clusterrolebinding/velero
            kubectl delete crds -l component=velero 
            ```


velero backup create sonar-test-backup --include-namespaces sonar --wait

velero restore create --from-backup sonar-test-backup --namespace-mappings sonar:sonar-test-backup --include-namespaces sonar


velero backup create gitops-test-backup --include-namespaces gitops --wait
velero restore create --from-backup gitops-test-backup --namespace-mappings gitops:test

1. Restic advance commands
  * `export RESTIC_REPOSITORY=https://cos.twcc.ai/demo-restic`
  * `export AWS_ACCESS_KEY_ID="328LWHCFU51FNDE6989X"`
  * `export AWS_SECRET_ACCESS_KEY="8zhxXUKyxAwDa7pNMZUNoXdO4JGIEtRWnZ5PKlfW"`
  * `export RESTIC_PASSWORD="I9n7G7G0ZpDWA3GOcJbIuwQCGvGUBkU5"`
  * `restic -r s3:cos.twcc.ai/temp-staging-backup/restic`


## Test TWCC Production Deployment (with storage test)

- `velero backup create test-storage-backup --include-namespaces test-storage --wait`
- `kubectl delete ns test-storage`
- `velero restore create --from-backup test-storage-backup --include-namespaces test-storage --exclude-resources pod -w`


## Test TWCC Production StatefulSet

- `helm repo add bitnami https://charts.bitnami.com/bitnami`
- `helm install my-release bitnami/wordpress -n test-sts`
- `velero backup create test-sts-backup --include-namespaces test-sts --wait`
- `helm uninstall my-release -n test-sts`
- `velero restore create --from-backup test-sts-backup --include-namespaces test-sts --exclude-resources pod -w`


## Velero with Istio Problem
1. istio sidecar inject twice: [https://github.com/istio/istio/issues/27675](https://github.com/istio/istio/issues/27675)