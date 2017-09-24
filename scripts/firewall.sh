#!/bin/sh

firewall_rule_exists() {
  gcloud compute firewall-rules describe $1 --verbosity none | grep "name: $1" | wc -l
}

allow_http() {
  if [ $(firewall_rule_exists $FWR_ALLOW_HTTP) == 0 ]; then
    gcloud compute firewall-rules create\
           $FWR_ALLOW_HTTP\
           --network=default\
           --allow=tcp:80,tcp:8888\
           --source-ranges=0.0.0.0/0\
           --target-tags=$HTTP_SERVER
  else
    echo "Firewall rule $FWR_ALLOW_HTTP exists"
  fi
}

allow_https() {
  if [ $(firewall_rule_exists $FWR_ALLOW_HTTPS) == 0 ]; then
    gcloud compute firewall-rules create\
           $FWR_ALLOW_HTTPS\
           --network=default\
           --allow=tcp:443,tcp:8888\
           --source-ranges=0.0.0.0/0\
           --target-tags=$HTTPS_SERVER
  else
    echo "Firewall rule $FWR_ALLOW_HTTPS exists"
  fi
}
