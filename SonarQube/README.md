# SonarQube
[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)
> **Local test only**

INTRODUCTION
------------
The Administration Menu module displays the entire administrative menu tree

 * For a full description of the module, visit the project page: https://www.sonarqube.org/

 * Dockerhub: https://hub.docker.com/_/sonarqube

Usage of Docker-Compose
-----
* Step 1:\
change memory setting for Elasticsearch
    * `vim /etc/sysctl.conf`
    * `add or modify "vm.max_map_count=655360"`
    * `sysctl -p`
* Step 2:\
    Start docker-compose
    * `docker-compose up -d`
* Step 3:\
    SonarQube would have fail starting due to db not found
    * `Open pgadmin4 and create database named "sonar"`
    * restart SonarQube

Usage of Kubernetes yaml
-----------------------
* `kubectl apply -f K8s-deployment/local/xyz.yaml`
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
  * [psql commands](https://medium.com/@lianankuan/%E5%AD%B8%E7%BF%92postgresql-rails%E7%9A%84%E9%96%8B%E7%99%BC%E7%BF%92%E6%85%A3-262be0e26b99)
  * Backup
    * `pg_dump -U [user] [[dbname] > [name.backup.sql]`
    * `pg_dump -U admin sonar > sonar.backup.sql`

  * Copy from pod 
    * `k cp sonar/postgres-7c5c68569c-2vpbw:/backup/sonar.backup.sql sonar.back.sql`
  * Restore
    * `psql -U [user] [dbname] < [name.backup.sql]`
    * `psql -U admin sonar < sonar.backup.sql`

Configuration
-------------
* Java Gradle Config
    ```
    plugins {
        id 'java'
        id "org.sonarqube" version "2.8"
        id 'jacoco'
    }
    ```
    ```
    sonarqube {
        properties {
            property "sonar.projectName", "Java :: GitOps :: SonarQube Scanner for Gradle"
            property 'sonar.host.url', 'https://sonarqube-416612ff.baas.tmpstg.twcc.tw/'
            property "sonar.projectKey", "org.sonarqube:gitops-sonar-test"
            property "sonar.scm.disabled", "true"
            property "sonar.sourceEncoding", "UTF-8"
            property "sonar.coverage.jacoco.xmlReportPaths", "${project.buildDir}/reports/jacoco/jococoTestReport/test/jacocoTestReport.xml"
            property "sonar.java.coveragePlugin", "jacoco"
            property "sonar.junit.reportPaths", "${project.buildDir}/reports/jacoco/jococoHTML/"
        }
    }
    ```
    ```
    jacoco {
        toolVersion = "0.8.5"
        reportsDir = file("$buildDir/reports/jacoco/jococoTestReport")
    }

    jacocoTestReport {
        reports {
            xml.enabled = true
            csv.enabled = true
            html.destination file("$buildDir/reports/jacoco/jacocoHTML")
        }
    }

    jacocoTestReport {
        dependsOn test // tests are required to run before generating the report
    }

    test {
        useJUnitPlatform()
        finalizedBy jacocoTestReport
    }
    ```


* Go Gradle Config
  * https://docs.sonarqube.org/latest/analysis/languages/go/?src=sidebar
  * Go test config
    ```
    sonarqube {
    properties {
        property 'sonar.sources', '.'
        property 'sonar.exclusions', '**/*_test.go,**/generate_source.go,**/*_generated.go,**/build/**,**/.gogradle/**'
        property 'sonar.tests', '.'
        property 'sonar.test.inclusions', '**/*_test.go'
        property 'sonar.test.exclusions', '**/build/**,**/.gogradle/**'
        property 'sonar.go.tests.reportPaths', "${project.projectDir}/.gogradle/reports/test-report.out"
        property 'sonar.go.coverage.reportPaths', "${project.projectDir}/.gogradle/reports/coverage/profiles/github.com%2FSonarSource%2Fsonar-go%2Fuast-generator-go.out"
    }
    }
    ```
* JavaScript LCOV Config
  * https://docs.sonarqube.org/latest/analysis/languages/javascript/
  * https://docs.sonarqube.org/pages/viewpage.action?pageId=5312326
  * https://sergimansilla.com/blog/test-coverage-node/
  * `sonar.javascript.lcov.reportPaths`

Backup and Restore
------
Using database's tools for backup and restore
* Stop the server.
* Restore the backup.
* Drop the Elasticsearch indexes by deleting the contents of $SQ_HOME/data/es6 directory.
* Restart the server.