#!/bin/bash
echo "Installing..."
docker-compose up -d
sudo chown -R 472:472 /srv/docker/grafana/data
echo "Grafana: http://localhost:3000 - admin/admin"
echo "Current database list"
curl -G http://localhost:8086/query?pretty=true --data-urlencode "db=glances" --data-urlencode "q=SHOW DATABASES"
# echo "Create a new database ?"
# echo "curl -XPOST 'http://localhost:8086/query' --data-urlencode 'q=CREATE DATABASE mydb'"