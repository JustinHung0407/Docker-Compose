# Keycloak

Usage of Kubernetes yaml
-----------------------

* Accessing into PostgreSQL
  * `psql -U admin postgres`
  * list database `\l`
  * connect to db `\c $dbname`
  * list table `\dt`
  * [psql commands](https://medium.com/@lianankuan/%E5%AD%B8%E7%BF%92postgresql-rails%E7%9A%84%E9%96%8B%E7%99%BC%E7%BF%92%E6%85%A3-262be0e26b99)
  * Backup
    * `pg_dump -U [user] [[dbname] > [name.backup.sql]`
    * `pg_dump -U keycloak keycloak > keycloak-20201229.backup.sql`
    * `k cp keycloak/keycloak-sample-postgresql-0:/bitnami/postgresql/keycloak-20201229.backup.sql keycloak-20201229.backup.sql`

  * Copy from pod 
    * `k cp sonar/postgres-7c5c68569c-h8pfr:/backup/sonar.backup.sql sonar.back.sql`
  * Restore
    * `psql -U [user] [dbname] < [name.backup.sql]`
    * `psql -U admin sonar < sonar.backup.sql`
