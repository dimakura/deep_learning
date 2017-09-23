#!/bin/sh

# This returns status of the instance. Possible values for status are:
#
# - (empty response) -- there is no such instance
# - PROVISIONING
# - STAGING
# - RUNNING
# - STOPPING
# - TERMINATED
instance_status() {
  gcloud compute instances describe $1 | grep "^status:*" | cut -d' ' -f 2
}

create_cpu_instance() {
  local status=$(instance_status $CPU_INSTANCE_NAME)

  if [ -z $status ]; then
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
  else
    echo "Instance $CPU_INSTANCE_NAME already exists and has status $status"
  fi
}
