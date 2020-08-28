import http from 'k6/http';
import { sleep } from 'k6';
export let options = {
    vus: 10,
    duration: '30s',
};
export default function () {
    http.get('http://test.k6.io');
    sleep(1);
}

export default function () {
    var url = 'http://test.k6.io/login';
    var payload = JSON.stringify({
        email: 'aaa',
        password: 'bbb',
    });

    var params = {
        headers: {
            'Content-Type': 'application/json',
        },
    };

    http.post(url, payload, params);
}


// k6 run script.js