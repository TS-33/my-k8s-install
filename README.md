usage:

```shell
bash k8s_init.sh
```



Wait for the script to finish executing .This will generate a worker_init.sh script, copy it to your worker node and run it.

等待脚本执行完成,将生成的worker_init.sh复制到worker节点并执行。

</br>

you should edit the head of this script to customize your enviroment.

请修改文件开头的“变量设置”部分以自定义你的环境

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
