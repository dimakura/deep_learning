# Using Google Cloud

`google-cloud` script is useful for creating and managing compute instances for deep learning.

## Setup

Place this directory under your `$PATH`.

## Usage

```sh
# Create instance: 4 CPUs, 16GB of RAM, 1 GPU (Nvidia Tesla K80), and 100GB storage.
google-cloud create instance-name --cpu 4 --ram 16 --gpu 1 --storage 100

# List all instances
google-cloud list

# Install Pytorch on the instance. Drop `--gpu` flag, if you don't need CUDA.
google-cloud install instance-name --gpu

# SSH into instance
google-cloud ssh instance-name

# Stop instance
google-cloud stop instance-name

# Start instance
google-cloud start instance-name

# Delete instance
google-cloud delete instance-name
```
