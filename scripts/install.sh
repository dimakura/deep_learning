#!/bin/sh

readonly MINICONDA_LINK="https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh"
readonly MINICONDA_INSTALLER="miniconda.sh"
readonly CONDA_PATH="~/miniconda2/bin/conda"

run_ssh_command() {
  gcloud compute ssh $1 --command "$2"
}

install_conda() {
  run_ssh_command $1 "wget -q $MINICONDA_LINK -O $MINICONDA_INSTALLER"
  sleep 1
  run_ssh_command $1 "bash $MINICONDA_INSTALLER"
  sleep 1
  run_ssh_command $1 "$CONDA_PATH update conda"
}

install_theano() {
  run_ssh_command $1 "sudo apt-get update"
  run_ssh_command $1 "sudo apt-get install build-essential gfortran g++ python-dev"
  run_ssh_command $1 "$CONDA_PATH install numpy scipy mkl nose sphinx pydot-ng theano"
}

install_keras() {
  run_ssh_command $1 "$CONDA_PATH install h5py graphviz pydot keras"
  run_ssh_command $1 "mkdir ~/.keras"
  gcloud compute scp scripts/config/keras.json $1:~/.keras/keras.json
}

install_helpers() {
  run_ssh_command $1 "$CONDA_PATH install matplotlib jupyter"
}

initial_install() {
  install_conda $1
  install_theano $1
  install_keras $1
  install_helpers $1
}

cpu_initial_install() {
  initial_install $CPU_INSTANCE_NAME
}
