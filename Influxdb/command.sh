docker run -p 8086:8086 -v $PWD:/var/lib/influxdb influxdb:1.8.3-alpine

docker run -d -p 8086:8086 \
    -v $PWD:/var/lib/influxdb \
    influxdb

influx -username admin -password password

show databases #db

create database mydb

use mydb

show measurements #table

show series from meters

drop measurement meters

drop database mydb


Drop series FROM "successRate" WHERE "TestName" = 'GITOPS_HEALTH (Argocd))'

AWARD_WALLET_SIGN_CONTRACT_4_10

select * from successRate WHERE "TestName" = 'HARBOR_SYSTEM_HEALTH (Harbor)'
Drop series FROM "successRate" WHERE "TestName" = 'HARBOR_SYSTEM_HEALTH (Harbor)'
HARBOR_LOGIN (Harbor)


select * from checks where time >= '2020-11-04T00:00:00Z' and time <= '2020-11-04T23:59:59Z'
DROP * from db where time >= '2020-11-04T00:00:00Z' and time <= '2020-11-04T23:59:59Z'

SELECT percentile("value", 100) FROM "checks" WHERE time >= now() - 1h GROUP BY time(30s), "check"

DROP RETENTION POLICY "what_is_time" ON "NOAA_water_database"

## Check Disk Usage
`du -sh /var/lib/influxdb/data/<db name>`


## Backup && Restore 
influxd backup <path-to-backup>
influxd backup -database <mydatabase> <path-to-backup>