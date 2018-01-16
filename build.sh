#!/usr/bin/env bash

# scraping target on localhost:5000, using https://github.com/prometheus/client_ruby/tree/master/examples/rack
pushd /home/mtayer/dev/client_ruby/examples/rack
bundle exec unicorn -c ./unicorn.conf
popd

# prometheus on localhost:9090 (build using `promu build`)
/home/mtayer/dev/gopath/src/github.com/prometheus/prometheus/prometheus \
    --config.file /home/mtayer/dev/repo/scripts/data/prometheus.yml \
    --storage.tsdb.path=/tmp/prometheus \
    --web.enable-lifecycle

# alertmanager on localhost:9093 (build using `promu build`)
/home/mtayer/dev/gopath/src/github.com/prometheus/alertmanager/alertmanager \
    --config.file /home/mtayer/dev/repo/scripts/data/alertmanager.yml \
    --storage.path /tmp/alertmanager

# SMTP on localhost:25
sudo java -jar /home/mtayer/dev/FakeSMTP/target/fakeSMTP-2.1-SNAPSHOT.jar

# Trigger Alert
while true; do curl -k -s "http://localhost:5000/" > /dev/null ; done

What happens to firing alerts in prometheus after restart[1]?

# Fire long evaluating alert

What happens to firing alerts in prometheus after configuration reload?

What happens to firing alerts in prometheus after removing their definition and running configuration reload?

What happens to firing alerts in prometheus after removing their definition and restarting?

What happens to active alerts in alermanager after restart?


[1]

```
oc scale rc -n ${NS} dummy --replicas=10 # trigger an alert, see README.md
# List firing alerts
curl -k -s -H "Authorization: Bearer ${OPENSHIFT_MANAGEMENT_ADMIN_TOKEN}" "https://${OPENSHIFT_PROMETHEUS_METRICS_ROUTE}/api/v1/query?query=ALERTS" | jq ".data.result | length"
# Delete prometheus
oc delete pod -n openshift-metrics prometheus-0
# Watch alert
curl -k -s -H "Authorization: Bearer ${OPENSHIFT_MANAGEMENT_ADMIN_TOKEN}" "https://${OPENSHIFT_PROMETHEUS_METRICS_ROUTE}/api/v1/query?query=ALERTS" | jq ".data.result | length"
```
oc delete pod -n openshift-metrics prometheus-0