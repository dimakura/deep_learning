# This script is designed to work with ubuntu 16.04 LTS

# Installation settings.
inst=$1 # instance name
gpu=$2  # is GPU present?
user=$3 # github username
repo=$4 # github repository name
gkey=$5 # github personal access key

# Upgrade system and install basic tools
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install tmux unzip git
sudo apt-get -y install build-essential gcc g++ make binutils
sudo apt-get -y install software-properties-common

# Use /tmp for installation
cd /tmp

# Installing CUDA 8.0
URL="https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64-deb"
if [ $gpu -eq 1 ]
then
  wget $URL -O cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64.deb
  sudo dpkg -i cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64.deb
  sudo apt-get update
  sudo apt-get install cuda
  echo "export PATH=\"/usr/local/cuda-8.0/bin:\$PATH\"" >> ~/.bashrc
  export PATH="/usr/local/cuda-8.0/bin:$PATH"
fi

# Installing Anaconda
wget https://repo.continuum.io/archive/Anaconda3-5.0.0.1-Linux-x86_64.sh -O Anaconda3-5.0.0.1-Linux-x86_64.sh
bash "Anaconda3-5.0.0.1-Linux-x86_64.sh" -b
echo "export PATH=\"$HOME/anaconda3/bin:\$PATH\"" >> ~/.bashrc
export PATH="$HOME/anaconda3/bin:$PATH"
conda upgrade -y --all

# Installing Torch
if [ $gpu -eq 1 ]
then
  conda install pytorch torchvision cuda80 -c soumith
else
  conda install pytorch torchvision -c soumith
fi

# Configure juputer
jupyter notebook --generate-config
jupass=`python -c "from notebook.auth import passwd; print(passwd())"`
echo "c.NotebookApp.password = u'"$jupass"'" >> $HOME/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.ip = '*'
c.NotebookApp.open_browser = False" >> $HOME/.jupyter/jupyter_notebook_config.py

# Create working directory
mkdir ~/work
cd ~/work

# Connect to GitHib
if ! [ -z $user ]
then
  ssh-keygen -b 4096 -t rsa -f ~/.ssh/id_rsa -q -N ""
  title="gcloud-$inst-key"
  key=$(cat ~/.ssh/id_rsa.pub)
  curl -u $user:$gkey -X POST -d "{\"title\":\"$title\",\"key\":\"$key\"}" https://api.github.com/user/keys
  sleep 2 # give github time to process information
  git clone git@github.com:$user/$repo.git
  cd $repo
  git fetch --all
fi
