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


K6 useful scripts
---
```
for (var p in res.headers) {
    if (res.headers.hasOwnProperty(p)) {
        console.log(p + " : " + res.headers[p]);
    }
}
```

Grafana dashboards
------------------
1. Dcadwallader: https://grafana.com/grafana/dashboards/2587
2. Stian Øvrevåge: https://grafana.com/grafana/dashboards/4411
3. Cyaiox: https://grafana.com/grafana/dashboards/8156
4. Smockvavelsky: https://grafana.com/grafana/dashboards/10553
5. k m: https://grafana.com/grafana/dashboards/10660

## Drone CI 設定 K6 測試
1. 編輯 `.drone.yml` (將需要之steps新增於其他設定之後) (Production為 .drone-prod.yml)
2. 修改執行 K6 之執行檔至需要自動化之分支
3. Commit 確認測試可正確執行
4. 設定 Cronjob
   1. 透過介面
    
      ![](https://static-web-f6bbcbf9.baas.tmpstg.twcc.tw/drone/cronjob.PNG)

   2. 透過CLI
      * 安裝 Drone CLI
      * 透過 `https://drone-836ed048.baas.tmpstg.twcc.tw/account` 查詢 token
      * `export DRONE_SERVER=https://drone-836ed048.baas.tmpstg.twcc.tw/`
      * `export DRONE_TOKEN=$your_token`
      * 確認已連上 Drone `drone info`
      * 新增 Cronjob 
        * `drone cron add "專案名稱" "Cronjob名稱" "排程" --branch "分支"`
        * example: `drone cron add "TWCC-BAAS/auto-testing-scripts" "gitops/k6/autotest/cron" @hourly --branch "gitops"`
        * `drone cron add "TWCC-BAAS/auto-testing-scripts" "Baas-K6-autotest-3hr" '0 0 */3 * * *' --branch "master"`
      * 確認已新增 `drone cron ls TWCC-BAAS/auto-testing-scripts`
   3. 其他設定: [https://docs.drone.io/cron/](https://docs.drone.io/cron/)