# Cloud Operations

You can perform common cloud operations from command line using scripts in this directory.
The main script is `scripts/cloud` and general syntax for calling it is also very simple:

```shell
./script/cloud [INSTANCE_TYPE] [COMMAND_TYPE]
```

`[INSTANCE_TYPE]` can be one of the following:

* `cpu` for CPU based instances
* `gpu` for GPU based instances

`COMMAND_TYPE` can be one of the following:

* `create` create corresponding instance in the cloud
* `status` show instance status
* `start` start instance
* `stop` stop instance
* `delete` delete instance
