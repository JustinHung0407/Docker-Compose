# Drone Config

## Drone CI 設定 K6 測試
1. 編輯 `.drone.yml` (將需要之steps新增於其他設定之後)
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
      * 確認已新增 `drone cron ls TWCC-BAAS/auto-testing-scripts`
   3. 其他設定: [https://docs.drone.io/cron/](https://docs.drone.io/cron/)


<!-- drone repo ls

export DRONE_SERVER=https://drone-836ed048.baas.tmpstg.twcc.tw/
export DRONE_TOKEN=foybfnmHZyp7jwCNrjMQvBEAe5NsHpMt -->