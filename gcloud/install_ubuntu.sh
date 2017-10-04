# This script is designed to work with ubuntu 16.04 LTS

# Upgrade system and install basic tools
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install tmux unzip git
sudo apt-get -y install build-essential gcc g++ make binutils
sudo apt-get -y install software-properties-common

# Is GPU present?
gpu=$1

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

# Prepare working directories
mkdir ~/work
