import http from "k6/http";
import { sleep, check } from "k6";
import { Counter } from "k6/metrics";

export const requests = new Counter("http_reqs");

export const options = {
  stages: [{ target: 3, duration: "10s" }],
  thresholds: {
    requests: ["count < 100"],
  },
};

export default function () {
  const res = http.get("http://test.k6.io");

  sleep(1);

  const checkRes = check(res, {
    "status is 200": (r) => r.status === 200,
    "response body": (r) => r.body.indexOf("Feel free to browse") !== -1,
  });
}

// k6 run --out influxdb=https://admin:password@influxdb-658b6983.baas.tmpstg.twcc.tw/db script.js
