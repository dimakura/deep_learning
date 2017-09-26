#!/bin/sh

initial_install() {
  local status=$(instance_status $1)

  if [ -z $status ]; then
    echo "Instance $1 doesn't exist"
    exit 1
  else
    gcloud compute scp scripts/install_ubuntu.sh $1:~/install.sh
    gcloud compute ssh $1 --command "chmod +x ~/install.sh; gpu=$2 ~/install.sh"
  fi
}

cpu_initial_install() {
  initial_install $CPU_INSTANCE_NAME 0
}

gpu_initial_install() {
  initial_install $GPU_INSTANCE_NAME 1
}
