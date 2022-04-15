#!/bin/bash

minikube config set driver docker \
&& minikube start \
  --kubernetes-version=v1.23.3 \
  --cni calico \
  --addons ingress \
  --addons dashboard \
&& kubectl cluster-info