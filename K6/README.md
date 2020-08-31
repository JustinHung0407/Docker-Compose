# K6
[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)
> **Local test only**

> not done yet

> more detail on https://github.com/loadimpact/k6/blob/master/docker-compose.yml

> https://github.com/jkehres/docker-compose-influxdb-grafana/blob/master/docker-compose.yml

> https://grafana.com/grafana/dashboards/12759

INTRODUCTION
------------
Open source load testing tool and SaaS for engineering teams

 * For a full description of the module, visit the project page: https://k6.io/

 * Dockerhub: https://hub.docker.com/r/loadimpact/k6

Usage
-----
* Step 1:\
    Start docker-compose
    * `docker-compose up -d`
* Step 2:\
    Start docker-compose
    * `docker-compose up -d`
* Step 3:\
    `docker-compose run -v $PWD/samples:/scripts k6 run /scripts/es6sample.js`
* Step 4:\

Grafana dashboards
------------------
1. Dcadwallader: https://grafana.com/grafana/dashboards/2587
2. Stian Øvrevåge: https://grafana.com/grafana/dashboards/4411
3. Cyaiox: https://grafana.com/grafana/dashboards/8156
4. Smockvavelsky: https://grafana.com/grafana/dashboards/10553
5. k m: https://grafana.com/grafana/dashboards/10660