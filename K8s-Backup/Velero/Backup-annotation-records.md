# Backup scripts

// no need the following anymore after velero update to 1.5

### Gitea
`kubectl annotate pods gitea-gitea-54b9f7d579-db59q backup.velero.io/backup-volumes=gitea-data,gitea-config -n gitops`
`kubectl annotate pods gitea-mariadb-0 backup.velero.io/backup-volumes=data,config -n gitops`

### Drone
`kubectl annotate pods drone-744fc99c4d-84r6p backup.velero.io/backup-volumes=storage-volume -n drone`

### Argocd


### SonarQube
`kubectl annotate pods postgres-597789f944-7jftl backup.velero.io/backup-volumes=postgresdb -n sonar`

`kubectl annotate pods sonarqube-6644f5fbf5-5pmjp backup.velero.io/backup-volumes=sonarqube -n sonar`

### Grafana
`kubectl annotate pods --all backup.velero.io/backup-volumes=grafana-volume -n grafana`  Failed

### InfluxDB
`kubectl annotate pods influxdb-647c7db844-z96b8 backup.velero.io/backup-volumes=influxdb-data -n influxdb`