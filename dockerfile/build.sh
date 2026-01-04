#!/bin/bash
SHELL_PATH=$(readlink -f "${BASH_SOURCE[0]}"); echo "SHELL_PATH=[$SHELL_PATH]"; SHELL_DIR=$(dirname $SHELL_PATH); echo "SHELL_DIR=[$SHELL_DIR]"
cd "$SHELL_DIR" || { echo "切换工作目录失败"; exit 1; }

# 获取文件
git clone https://github.com/faawrqweqw/netsim-studio.git

# ENV
TAG="build-$(date +%Y-%m-%d_%H-%M-%S)"

# build
echo "开始构建netsim-studio镜像..."
docker build -t taozig/netsim-studio:latest -f ./dockerfile --no-cache --pull ./
docker tag taozig/netsim-studio:latest taozig/netsim-studio:"${TAG}"

# 推送至dockerhub -- 暂无

echo "保存镜像到本地文件..."
docker save taozig/netsim-studio:"${TAG}" -o netsim-studio.tar