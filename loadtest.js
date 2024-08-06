import http from 'k6/http';
import { check, sleep } from 'k6';

export let options = {
  stages: [
    { duration: '30s', target: 5000 }, // Ramp-up to 5000 users over 30 seconds
    { duration: '1m', target: 5000 },   // Stay at 5000 users for 1 minute
    { duration: '30s', target: 0 },   // Ramp-down to 0 users over 30 seconds
  ],
};

export default function () {
  let res = http.get('http://nginx'); // Target Nginx service
  check(res, {
    'is status 200': (r) => r.status === 200,
    'response time < 500ms': (r) => r.timings.duration < 500,
  });
  sleep(1);
}
