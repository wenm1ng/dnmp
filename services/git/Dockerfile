# 使用基础镜像
FROM ubuntu:latest

# 安装Git
RUN apt-get update && apt-get install -y git

# 设置工作目录
WORKDIR /data/www

# 设置Git全局配置
RUN git config --global user.email "wenming"
RUN git config --global user.name "Awenming001"