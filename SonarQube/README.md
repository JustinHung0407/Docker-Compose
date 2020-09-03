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
* `kubectl apply -f`


Backup and Restore
------
Using database's tools for backup and restore
* Stop the server.
* Restore the backup.
* Drop the Elasticsearch indexes by deleting the contents of $SQ_HOME/data/es6 directory.
* Restart the server.