#!/bin/sh

# Note that you should use `us-west1-b` or any other GPU-enabdled region.
# See https://cloud.google.com/compute/docs/gpus/ for more details.
#
# Use google cloud initialization to define default region, authenticate and set your project:
#
# ```shell
# gcloud init
# ```

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
readonly CPU_DISK_SIZE="32"
readonly CPU_MACHINE_TYPE="custom-1-2048"
readonly CPU_SERVICE_SCOPES=("https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring.write","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append")
readonly CPU_MAINTENANCE_POLICY="MIGRATE"

# GPU instance settings
readonly GPU_INSTANCE_NAME="fastai-gpu-instance"
readonly GPU_DISK_SIZE="48"
readonly GPU_MACHINE_TYPE="custom-1-4096"
readonly GPU_SERVICE_SCOPES=$CPU_SERVICE_SCOPES
readonly GPU_MAINTENANCE_POLICY="TERMINATE"
readonly GPU_CARD_TYPE="nvidia-tesla-k80"
readonly GPU_CARD_COUNT=1
