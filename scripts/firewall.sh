#!/bin/sh

allow_http() {
  local cmd="gcloud compute firewall-rules describe $FWR_ALLOW_HTTP --verbosity none"
  if [ `$cmd | grep "name: $FWR_ALLOW_HTTP" | wc -l` == 0 ]; then
    gcloud compute --project=$PROJECT\
           firewall-rules create\
           $FWR_ALLOW_HTTP\
           --network=default\
           --allow=tcp:80\
           --source-ranges=0.0.0.0/0\
           --target-tags=$HTTP_SERVER
  else
    echo "$FWR_ALLOW_HTTP exists... skip"
  fi
}

allow_https() {
  local cmd="gcloud compute firewall-rules describe $FWR_ALLOW_HTTPS --verbosity none"
  if [ `$cmd | grep "name: $FWR_ALLOW_HTTPS" | wc -l` == 0 ]; then
    gcloud compute --project=$PROJECT\
           firewall-rules create\
           $FWR_ALLOW_HTTPS\
           --network=default\
           --allow=tcp:443\
           --source-ranges=0.0.0.0/0\
           --target-tags=$HTTPS_SERVER
  else
    echo "$FWR_ALLOW_HTTPS exists... skip"
  fi
}
