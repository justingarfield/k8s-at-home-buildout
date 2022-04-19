#!/bin/bash

# TODO: Probably don't even really need this anymore, now that things are split-out better

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