# Using Google Cloud

`google-cloud` script is useful for creating and managing Google Cloud compute instances
for deep learning.

It helps:

- Create and manage compute instances in Google Cloud;
- Install Python, PyTorch, and Jupyter Notebook;
- Install CUDA SDK for GPU-enabled instances;
- Connect instance to your GitHub account, so you can easily import and export your work.

In short it enabled you to kick-off your instance in few minutes skipping repetitve steps.

## Usage

Below are few example of using `google-cloud` script.

To create instance use `create` command:

```sh
google-cloud create instance-name --cpu 4 --ram 16 --gpu 1 --storage 100
```

Provide unique `instance-name` to the script. Also the following options apply:

- `--cpu` (or `-c`, default `2`) option provides number of CPUs (max. 16);
- `--gpu` (pr `-g`, default `0`) option indicates number of GPU processors for the server.
  GPUs are Tesla K80 series. There is no option to change them.
  Note, that you might need to contact Google to increase the quote of GPUs for your account;
- `--ram` (or `-r`, default `8`) option provides size of RAM (in GB);
- `--storage` (or `-s`, default `32`) option provides desired storage size (in GB).

To list all instances and get information about their names, general config, IP addresses,
and statuses use `list` command:

```sh
google-cloud list
```

After getting hardware, you need to install basic software. Do it with this script:

```sh
google-cloud install instance-name --gpu
```

The only option (`--gpu`), which you provide to this script indicates whether NVidia CUDA SDK
should be installed or not.

This script will install:

- CUDA SDK (if `--gpu` flag is present);
- Python 3.6 (via Anaconda);
- Pytorch framework;
- Jupyter Notebook;
- Connect to your GitHub account (if `gcloud/access_token` is provided);
- Clone Github repo (if `gcloud/repo` is provided).

After installing software you can access instance using `ssh` command:

```sh
google-cloud ssh instance-name
```
In order to save money, consider stopping instance when you don't work with it:

```sh
google-cloud stop instance-name
```

To start instance again:

```sh
google-cloud start instance-name
```

When you are done with your research, and upload your work to GitHub you can also delete
instance completely:

```sh
google-cloud delete instance-name
```

Note that deleting instance will delete all the data and it cannot be restored.

## Setup

### Update your $PATH

To make `google-cloud` more convenient to use, update your `$PATH` variable to include this directory.

```sh
# In .bashrc
export PATH="$PATH:/path/to/this/directory"
```

### Configure GitHub

If you plan to connect GitHub repository and be able to push/pull your work, you need to provide
additional information in `gcloud/github`.

Example structure for this file is following:

```sh
dimakura
deep_learning
mygithubtoken1234567890
```

- First line contains your username;
- Second line contains name of your repository;
- THe last line is a [Personal access token](https://github.com/settings/tokens).
