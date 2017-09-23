#!/bin/sh

source ./scripts/config.sh
source ./scripts/firewall.sh

echo "Creating $CPU_INSTANCE_NAME..."

gcloud beta compute --project $PROJECT\
       instances create $CPU_INSTANCE_NAME\
       --zone $ZONE\
       --machine-type $CPU_MACHINE_TYPE\
       --subnet "default"\
       --maintenance-policy "MIGRATE"\
       --service-account $SERVICE_ACCOUNT\
       --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring.write","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append"\
       --min-cpu-platform "Automatic"\
       --tags $HTTP_SERVER,$HTTPS_SERVER\
       --image $IMAGE\
       --image-project $IMAGE_PROJECT\
       --boot-disk-size $CPU_DISK_SIZE\
       --boot-disk-type "pd-standard"\
       --boot-disk-device-name $CPU_INSTANCE_NAME

allow_http
allow_https
