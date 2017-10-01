# Original version from https://github.com/fastai/courses/blob/master/setup/install-gpu.sh

# This script is designed to work with ubuntu 16.04 LTS

# ensure system is updated and has basic build tools
sudo apt-get update
sudo apt-get --assume-yes upgrade
sudo apt-get --assume-yes install tmux build-essential gcc g++ make binutils unzip git
sudo apt-get --assume-yes install software-properties-common

# download and install GPU drivers
if [ ${gpu} = 1 ]; then
  wget "http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_9.0.176-1_amd64.deb" -O "cuda-repo-ubuntu1604_9.0.176-1_amd64.deb"
  sudo dpkg -i cuda-repo-ubuntu1604_9.0.176-1_amd64.deb
  sudo apt-get update
  sudo apt-get -y install cuda
  sudo modprobe nvidia
  nvidia-smi
fi

# install Anaconda for current user
mkdir downloads
cd downloads
wget "https://repo.continuum.io/archive/Anaconda2-4.2.0-Linux-x86_64.sh" -O "Anaconda2-4.2.0-Linux-x86_64.sh"
bash "Anaconda2-4.2.0-Linux-x86_64.sh" -b

echo "export PATH=\"$HOME/anaconda2/bin:\$PATH\"" >> ~/.bashrc
export PATH="$HOME/anaconda2/bin:$PATH"
conda install -y bcolz
conda upgrade -y --all

# install and configure theano
pip install theano
if [ ${gpu} = 1 ]; then
  echo "[global]
device = gpu
floatX = float32
[cuda]
root = /usr/local/cuda" > ~/.theanorc
else
  echo "[global]
device = cpu
floatX = float32" > ~/.theanorc
fi

# install and configure keras
pip install keras==1.2.2
mkdir ~/.keras
echo '{
    "image_dim_ordering": "th",
    "epsilon": 1e-07,
    "floatx": "float32",
    "backend": "theano"
}' > ~/.keras/keras.json

# install cudnn libraries
if [ ${gpu} = 1 ]; then
  wget "http://files.fast.ai/files/cudnn.tgz" -O "cudnn.tgz"
  tar -zxf cudnn.tgz
  cd cuda
  sudo cp lib64/* /usr/local/cuda/lib64/
  sudo cp include/* /usr/local/cuda/include/
fi

# configure jupyter and prompt for password
jupyter notebook --generate-config
jupass=`python -c "from notebook.auth import passwd; print(passwd())"`
echo "c.NotebookApp.password = u'"$jupass"'" >> $HOME/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.ip = '*'
c.NotebookApp.open_browser = False" >> $HOME/.jupyter/jupyter_notebook_config.py

# clone the fast.ai course repo
cd ~
# ssh-keygen -t rsa -b 4096 -f .ssh/id_rsa -q -C "dimakura@gmail.com" -P ""
git clone https://github.com/dimakura/fast.ai.git
cd ~/fast.ai/
git fetch --all
mkdir ~/fast.ai/data
