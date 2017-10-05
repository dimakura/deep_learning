# Using Google Cloud

`google-cloud` script is useful for creating and managing compute instances for deep learning.

## Setup

Place this directory under your `$PATH`, so you can call `google-cloud` directly:

```sh
google-cloud list
```

In order to connect GitHub to your server you also need to provide
[Github personal token](https://github.com/settings/tokens) in `gcloud/.access_token`.

*Note*: If you provide personal GitHub token, This script posts a new SSH public key
of the instance to your GitHub account, but it will not be erase this key after this instance
is deleted. You should do it yourself from [GitHub keys page](https://github.com/settings/keys).


## Usage

Below are few example of using `google-cloud` script.

To create instance use `create` operation:

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
- Connect to your GitHub account (if `.access_token` is provided);
- Clone Github repo (if `.repo` is provided).

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
