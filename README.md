# Arm架构群晖安装Docker
* 可安装于ARM架构的群晖
* DSM7.0以上支持bridge模式

安装过程需开启群晖的SSH功能，并通过`sudo -i`切换到root用户

本文以armv8架构为例，且docker的工作目录为`/volume1/docker`

1. 通过`uname -m`命令查询处理器架构，如DS118的处理器架构为aarch64

2. 下载最新版本，地址请前往[Docker](https://download.docker.com/linux/static/stable)根据架构替换最新版本下载地址（以下以armv8架构为例）
```
curl "https://download.docker.com/linux/static/stable/aarch64/docker-20.10.9.tgz" | tar -xz -C /usr/bin --strip-components=1
```

3.创建工作目录及配置文件（"data-root"后面的工作目录可以根据需要更换）
```
mkdir -p /volume1/docker
mkdir -p /etc/docker
cat <<EOT > "/etc/docker/daemon.json
{
  "storage-driver": "vfs",
  "iptables": false,
  "data-root": "/volume1/docker"
}
EOT
```

4.运行docker
```
sudo dockerd &
```

5.创建计划任务，启动时自动运行docker
创建计划任务启动时自动配置防火墙
* 转到：DSM>控制面板>计划任务
* 新增>触发的任务>用户定义的脚本
  * 常规
    * 任务：活动软件
    * 用户：root
    * 事件：启动
    * 任务前：无
  * 任务设置
    * 运行命令：（请参阅下面的命令）
```
dockerd &
```
