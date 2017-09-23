#!/bin/sh

source ./scripts/config.sh
source ./scripts/firewall.sh
source ./scripts/instance.sh

create_cpu_instance
allow_http
allow_https
