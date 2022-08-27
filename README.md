# Arm架构群晖安装Docker
* 可安装于ARM架构的群晖
* DSM7.0以上支持bridge模式

安装过程需开启群晖的SSH功能，并通过`sudo -i`切换到root用户

本文以armv8架构为例，且docker的工作目录为`/volume1/docker`

## 查询处理器架构
可通过`uname -m`命令查询，如DS118的处理器架构为aarch64

## 下载并安装docker最新版本
地址请前往[Docker](https://download.docker.com/linux/static/stable)根据架构替换最新版本下载地址（以下以armv8架构为例）
```
curl "https://download.docker.com/linux/static/stable/aarch64/docker-20.10.9.tgz" | tar -xz -C /usr/bin --strip-components=1
```

## 创建工作目录及配置文件
* 创建工作目录
```bash
mkdir -p /volume1/docker
mkdir -p /etc/docker
```

*创建配置文件
```bash
vi /etc/docker/daemon.json
```

* 按`I`进入编辑模式，键入以下内容（`--conf-path=`后面键入aria2配置文件路径，对应的aria2.conf文件内容也需要修改）
```bash
{
  "storage-driver": "vfs",
  "iptables": false,
  "data-root": "/volume1/docker"
}
```


## 运行docker
执行`sudo dockerd &`，如无意外，docker将顺利启动

## 启动时自动运行docker
创建计划任务

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

## 自动安装脚本
```bash
wget -qO- https://github.com/412999826/docker-arm-based-synology/raw/main/install.sh| bash
```
