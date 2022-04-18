#!/bin/bash

source "$(dirname "$0")/_bash-colors.sh"
source "$(dirname "$0")/_root-only.sh"

# Setup repository for Docker-related stuffs
apt-get -qq update \
apt-get install -y \
  ca-certificates \
  curl \
  gnupg \
  lsb-release \
&& curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
&& echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Download, install, and start Docker, Docker CLI, and Containerd
apt-get -qq update \
&& apt-get install -y \
  docker-ce=5:20.10.14~3-0~ubuntu-focal \
  docker-ce-cli=5:20.10.14~3-0~ubuntu-focal \
  containerd.io=1.5.11-1 \
&& service docker start