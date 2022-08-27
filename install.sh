#!/bin/bash
set -e

ARCH=aarch64
DOCKER_VERSION=20.10.9
DOCKER_DIR=/volume1/@docker

echo "下载 docker $DOCKER_VERSION-$ARCH"
curl "https://download.docker.com/linux/static/stable/$ARCH/docker-$DOCKER_VERSION.tgz" | tar -xz -C /usr/bin --strip-components=1

echo "创建工作目录 $DOCKER_DIR"
mkdir -p "$DOCKER_DIR"

echo "创建 docker.json 配置文件"
mkdir -p /etc/docker
cat <<EOT > /etc/docker/daemon.json
{
  "storage-driver": "vfs",
  "iptables": false,
  "data-root": "$DOCKER_DIR"
}
EOT

echo "完成。 请添加计划任务并重启NAS."
