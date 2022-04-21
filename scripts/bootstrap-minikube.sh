#!/bin/bash

source "$(dirname "$0")/_bash-colors.sh"
source "$(dirname "$0")/_root-only.sh"
source "$(dirname "$0")/_sudouser-home.sh"
source "$(dirname "$0")/_stack-versions.sh"

curl -L -o ~/minikube-linux-amd64 https://storage.googleapis.com/minikube/releases/v$MINIKUBE_VERSION/minikube-linux-amd64

# This step has to be called with sudo to install the binary to a shared location owned by root
sudo install ~/minikube-linux-amd64 /usr/local/bin/minikube

minikube config set driver docker \
  && minikube start \
    --kubernetes-version=v$KUBERNETES_VERSION \
    --cni calico \
    --addons ingress \
    --addons dashboard