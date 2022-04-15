#!/bin/bash

#####################################################################################
#
# This script assumes that you:
#   * Are on Windows 10 Professional or Enterprise
#   * Are running this on a fresh Windows Subsystem for Linux - Ubuntu 20.04 instance
#   * **DO NOT** have Docker Desktop installed
#
# For more information see:
#   * https://docs.docker.com/engine/install/ubuntu/
#   * https://minikube.sigs.k8s.io/docs/start/
#
#####################################################################################

# Setup tooling we'll use w/ this stack
apt-get install -y \
  curl \
  jq \
  git \
  apt-transport-https \
  golang-go \
  wireguard-tools \
  conntrack

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

# Setup repository for Helm and install it
curl https://baltocdn.com/helm/signing.asc | apt-key add - \
&& echo "deb https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list \
&& apt-get -qq update \
&& apt-get install -y \
  helm

# Download, install, and start minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
&& install minikube-linux-amd64 /usr/local/bin/minikube

# Download, verify, and install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
&& curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check | grep 'kubectl: OK' &> /dev/null
if [ $? != 0 ]; then
   echo "kubectl binary does not match sha256 checksum. Bailing!"
   exit 1
fi

install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Download, extract, and install calicoctl
curl -L https://github.com/projectcalico/calico/releases/download/v3.20.0/release-v3.20.0.tgz -o calico-release-v3.20.0.tgz
tar -xvf calico-release-v3.20.0.tgz --occurrence release-v3.20.0/bin/calicoctl
install -o root -g root -m 0755 release-v3.20.0/bin/calicoctl /usr/local/bin/calicoctl
