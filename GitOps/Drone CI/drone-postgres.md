# PostgreSQL
Usage of Kubernetes yaml
-----------------------
* Order
  1. postgres-secret
  2. postgres-storage
  3. postgres
  4. sonarqube-storage
  5. sonarqube
* Accessing into PostgreSQL
  * `psql -U admin postgres`
  * list database `\l`
  * connect to db `\c $dbname`
  * list table `\dt`
  * column `\d+`
  * [psql commands](https://medium.com/@lianankuan/%E5%AD%B8%E7%BF%92postgresql-rails%E7%9A%84%E9%96%8B%E7%99%BC%E7%BF%92%E6%85%A3-262be0e26b99)
  * Backup
    * `pg_dump -U [user] [[dbname] > [name.backup.sql]`
    * `pg_dump -U admin drone > 202104231430.drone.backup.sql`

  * Copy from pod 
    * `k cp gitops/drone-postgres-7d485cd5c9-sfnpj:/tmp/202104231430.drone.backup.sql 202104231430.drone.backup.sql`
  * Restore
    * `psql -U [user] [dbname] < [name.backup.sql]`
    * `psql -U admin sonar < sonar.backup.sql`