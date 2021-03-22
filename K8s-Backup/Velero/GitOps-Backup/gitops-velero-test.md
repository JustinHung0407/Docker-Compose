# Velero

Velero is a tool to back up and restore your Kubernetes cluster resources and persistent volumes.

```
velero install \
    --use-restic \
    --provider aws \
    --plugins velero/velero-plugin-for-aws:v1.1.0 \
    --bucket k8s-prod-backup-test \
    --secret-file credentials-velero-twcc \
    --use-volume-snapshots=false \
    --default-volumes-to-restic \
    --backup-location-config region=default,s3ForcePathStyle="true",s3Url=https://cos.twcc.ai
```

1. Backup
   1. `velero backup create gitops-backup --include-namespaces gitops --wait`

2. Test disaster
   1. `kubectl delete namespaces gitops`
   2. `kubectl get deployments --namespace=gitops`

3. Restore
   1. `velero restore get`
   2. `velero restore create --from-backup gitops-backup --namespace-mappings gitops:gitops-restore --include-namespaces gitops --exclude-resources pod -w`
