# Drone Config

## Drone CI 設定 K6 測試
1. 編輯 `.drone.yml` (將需要之steps新增於其他設定之後)
2. 修改執行 K6 之執行檔至需要自動化之分支
3. Commit 確認測試可正確執行
4. 設定 Cronjob
   1. 透過UI

   2. 透過CLI
      * 安裝 Drone CLI
      * 透過 `https://$(drone-server)/account` 查詢 token
      * `export DRONE_SERVER=https://$(drone-server)/`
      * `export DRONE_TOKEN=$your_token`
      * 確認已連上 Drone `drone info`
      * 新增 Cronjob 
        * `drone cron add "專案名稱" "Cronjob名稱" "排程" --branch "分支"`
        * example: `drone cron add "organization/repo-name" "cron-name" "0 0 */8 * * *"`
      * 確認已新增 `drone cron ls TWCC-BAAS/auto-testing-scripts`
   3. 其他設定: [https://docs.drone.io/cron/](https://docs.drone.io/cron/)