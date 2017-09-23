#!/bin/sh

# Google cloud settings
readonly ZONE="us-west1-b"
readonly SERVICE_ACCOUNT="720933418657-compute@developer.gserviceaccount.com"
readonly IMAGE="ubuntu-1604-xenial-v20170919"
readonly IMAGE_PROJECT="ubuntu-os-cloud"
readonly PROJECT="able-nature-146314"

# Firewall settings
readonly FWR_ALLOW_HTTP="default-allow-http"
readonly FWR_ALLOW_HTTPS="default-allow-https"
readonly HTTP_SERVER="http-server"
readonly HTTPS_SERVER="https-server"

# CPU instance settings
readonly CPU_INSTANCE_NAME="fastai-cpu-instance"
readonly CPU_DISK_SIZE="20" # GB
readonly CPU_MACHINE_TYPE="custom-1-2048" # 1CPU, 2GB RAM

# GPU instance settings
readonly GPU_INSTANCE_NAME="fastai-gpu-instance"
