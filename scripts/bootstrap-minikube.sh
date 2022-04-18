#!/bin/bash

source "$(dirname "$0")/_bash-colors.sh"
source "$(dirname "$0")/_root-only.sh"
source "$(dirname "$0")/_sudouser-home.sh"
source "$(dirname "$0")/_stack-versions.sh"

curl -L -o $SUDOUSER_HOME/minikube-linux-amd64 https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && install $SUDOUSER_HOME/minikube-linux-amd64 /usr/local/bin/minikube

minikube config set driver docker \
  && minikube start \
    --kubernetes-version=$KUBERNETES_VERSION \
    --cni calico \
    --addons ingress \
    --addons dashboard
