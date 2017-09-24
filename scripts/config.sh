#!/bin/sh

# Google cloud settings
readonly IMAGE="ubuntu-1604-xenial-v20170919"
readonly IMAGE_PROJECT="ubuntu-os-cloud"

# Firewall settings
readonly FWR_ALLOW_HTTP="default-allow-http"
readonly FWR_ALLOW_HTTPS="default-allow-https"
readonly HTTP_SERVER="http-server"
readonly HTTPS_SERVER="https-server"

# CPU instance settings
readonly CPU_INSTANCE_NAME="fastai-cpu-instance"
readonly CPU_DISK_SIZE="20" # GB
readonly CPU_MACHINE_TYPE="custom-1-2048" # 1CPU, 2GB RAM
readonly CPU_SERVICE_SCOPES=("https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring.write","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append")

# GPU instance settings
readonly GPU_INSTANCE_NAME="fastai-gpu-instance"
