usage:

```shell
bash k8s_init.sh
```

you should edit the head of this script to customize your enviroment.

eg:

```shell
# 变量设置
## k8s版本，格式：v1.xx.x
K8S_VERSION=v1.29.9

## 主节点
MASTER_NAME=master
MASTER_IP=192.168.36.40

## 从节点
WORKER_NAMES=("worker1" "worker2")
WORKER_IPS=("192.168.36.41" "192.168.36.42")
```
