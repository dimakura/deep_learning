#!/bin/sh

readonly MINICONDA_LINK="https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh"
readonly MINICONDA_INSTALLER="miniconda.sh"

# install_conda() {
#   # 35.197.99.135
# }

run_ssh_command() {
  gcloud compute ssh $1 --command "$2"
}

install_conda() {
  run_ssh_command $1 "wget -q $MINICONDA_LINK -O $MINICONDA_INSTALLER"
  run_ssh_command $1 "bash $MINICONDA_INSTALLER"
  run_ssh_command $1 "~/miniconda3/bin/conda update conda"
}

initial_install() {
  install_conda $1
}

cpu_initial_install() {
  initial_install $CPU_INSTANCE_NAME
}
