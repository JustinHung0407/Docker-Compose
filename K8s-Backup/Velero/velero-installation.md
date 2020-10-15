# Velero

Velero is a tool to back up and restore your Kubernetes cluster resources and persistent volumes.

1. Install velero
    * install cli 
      * Install by `brew`
        * Install HomeBrew [https://brew.sh/](https://brew.sh/)
        * `brew install velero`
      * Install by tar  
        * curl -LO https://github.com/heptio/velero/releases/download/v1.5.1/velero-v1.5.1-linux-amd64.tar.gz
        * tar -C /usr/local/bin -xzvf velero-v1.5.1-linux-amd64.tar.gz
        * export PATH=$PATH:/usr/local/bin/velero-v1.5.1-linux-amd64/
    * Clone project
        * `git clone --single-branch --branch v1.5.1 https://github.com/vmware-tanzu/velero.git`
        * `git clone https://github.com/heptio/velero`
        * `cd velero`
    * Create file "credentials-velero"
        * ```
          echo "[default]
          aws_access_key_id = minio
          aws_secret_access_key = minio123" > credentials-velero
          ```
    * Useing minio
      * `kubectl apply -f examples/minio/00-minio-deployment.yaml`
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
            --use-restic \
            --provider aws \
            --plugins velero/velero-plugin-for-aws:latest \
            --bucket temp-staging-backup \
            --secret-file ./credentials-velero-twcc \
            --use-volume-snapshots=false \
            --default-volumes-to-restic \
            --backup-location-config region=us-east-1,s3ForcePathStyle="true",s3Url=https://cos.twcc.ai
        ```
    * Test example
      1. Create deployment
         1. `kubectl apply -f examples/nginx-app/base.yaml`
         2. `kubectl get deployments -l component=velero --namespace=velero`
         3. `kubectl get deployments --namespace=nginx-example`
      2. Annotate
         1. `kubectl annotate pod/nginx-deployment-65fb6d9c4-8rzvp backup.velero.io/backup-volumes=nginx-pvc -n nginx-example`
         2. `kubectl annotate pods --all backup.velero.io/backup-volumes=drone-pvc -n drone`

      3. Backup
         1. `velero backup create nginx-backup --selector app=nginx --wait`
         2. `velero backup describe nginx-backup`
         3. `velero backup create nginx-backup --include-namespaces nginx-example --wait`
         4. Backup automatically
            1. `velero backup create twcc-baas --default-volumes-to-restic --wait`

      4. Test disaster
         1. `kubectl delete namespace nginx-example`
         2. `kubectl get deployments --namespace=nginx-example`

      5. Restore
         1. `velero restore get`
         2. `velero restore create --from-backup nginx-backup`
         4. Restoring to different namespace and useing certain namespace
            1. `velero restore create --from-backup twcc-baas-backup-20201013105651 --namespace-mappings sonar:sonar-test-backup --include-namespaces sonar`
         5. More options: [velero restore reference](https://velero.io/docs/v1.5/restore-reference/)

      6. Schedule
         1. `velero schedule create nginx-backup --include-namespaces nginx-example --schedule "@every 24h"`
         2. `velero schedule create twcc-baas-backup --schedule "0 0 */24 * *"`