#!/bin/sh

source ./scripts/config.sh
source ./scripts/firewall.sh

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

start_instance() {
  local instance_name=$1
  local status=$(instance_status $instance_name)
  if [ $status == 'TERMINATED' ]; then
    echo "Starting $instance_name..."
    gcloud compute instances start $instance_name
    instance_status $instance_name
  else
    echo "Instance $instance_name is already started (status=$status)."
    exit 1
  fi
}

stop_instance() {
  local instance_name=$1
  local status=$(instance_status $instance_name)
  if [ $status == 'RUNNING' ]; then
    echo "Stopping $instance_name..."
    gcloud compute instances stop $instance_name
    instance_status $instance_name
  else
    echo "Instance $instance_name is already stopped (status=$status)."
    exit 1
  fi
}

delete_instance() {
  local instance_name=$1
  local status=$(instance_status $instance_name)
  if [ -z $status ]; then
    echo "Instance doesn't exists $instance_name"
    exit 1
  else
    echo "Deleting instance $instance_name..."
    gcloud compute instances delete $instance_name --delete-disks all
  fi
}

ssh_instance() {
  local instance_name=$1
  local status=$(instance_status $instance_name)
  if [ -z $status ]; then
    echo "Instance doesn't exists $instance_name"
    exit 1
  elif [ $status != 'RUNNING' ]; then
    echo "Instance $instance_name isn't running but $status"
    exit 1
  else
    echo "Accessing $instance_name..."
    gcloud compute ssh $instance_name
  fi
}

# CPU instance functions

cpu_instance_status() {
  instance_status $CPU_INSTANCE_NAME
}

create_cpu_instance() {
  local status=$(cpu_instance_status)

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
    allow_http
    allow_https
  else
    echo "Instance $CPU_INSTANCE_NAME already exists and has status $status"
    exit 1
  fi
}

start_cpu_instance() {
  start_instance $CPU_INSTANCE_NAME
}

stop_cpu_instance() {
  stop_instance $CPU_INSTANCE_NAME
}

delete_cpu_instance() {
  delete_instance $CPU_INSTANCE_NAME
}

ssh_cpu_instance() {
  ssh_instance $CPU_INSTANCE_NAME
}

# GPU instance functions

gpu_instance_status() {
  instance_status $GPU_INSTANCE_NAME
}
