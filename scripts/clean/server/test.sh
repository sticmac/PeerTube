#!/bin/sh

set -eu

for i in $(seq 1 6); do
  dropdb --if-exists "peertube_test$i"
  rm -rf "./test$i"
  rm -f "./config/local-test.json"
  rm -f "./config/local-test-$i.json"
  createdb -O peertube "peertube_test$i"
  redis-cli KEYS "bull-localhost:900$i*" | grep -v empty | xargs --no-run-if-empty redis-cli DEL
done
