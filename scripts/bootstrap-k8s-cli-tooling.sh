#!/bin/bash

source "$(dirname "$0")/_bash-colors.sh"
source "$(dirname "$0")/_sudouser-home.sh"
source "$(dirname "$0")/_stack-versions.sh"

# Download, verify, and install kubectl
KUBECTL_URI="https://dl.k8s.io/release/v$KUBERNETES_VERSION/bin/linux/amd64/kubectl"
KUBECTL_CHECKSUM_URI="https://dl.k8s.io/v$KUBERNETES_VERSION/bin/linux/amd64/kubectl.sha256"
HELM_REPO_SIGNING_KEY_URI="https://baltocdn.com/helm/signing.asc"
HELM_REPO_SOURCES_URI="https://baltocdn.com/helm/stable/debian/"
CALICO_RELEASE_URI="https://github.com/projectcalico/calico/releases/download/v$CALICO_VERSION/release-v$CALICO_VERSION.tgz"

curl -L $KUBECTL_URI -o ~/kubectl \
  && curl -L $KUBECTL_CHECKSUM_URI -o ~/kubectl.sha256

echo "$(cat ~/kubectl.sha256) kubectl" | sha256sum --check | grep 'kubectl: OK' &> /dev/null
if [ $? != 0 ]; then
   echo "kubectl binary does not match sha256 checksum. Bailing!"
   exit 1
fi

sudo install -o root -g root -m 0755 ~/kubectl /usr/local/bin/kubectl

# Setup repository for Helm and install it
curl $HELM_REPO_SIGNING_KEY_URI | \
  sudo apt-key add -

echo "deb $HELM_REPO_SOURCES_URI all main" | \
  sudo tee /etc/apt/sources.list.d/helm-stable-debian.list

sudo apt-get -qq update \
  && sudo apt-get install -y \
    helm

# Download, extract, and install calicoctl
curl -L $CALICO_RELEASE_URI -o ~/calico-release-v$CALICO_VERSION.tgz
tar -xvf ~/calico-release-v$CALICO_VERSION.tgz --occurrence release-v$CALICO_VERSION/bin/calicoctl

sudo install -o root -g root -m 0755 ~/release-v$CALICO_VERSION/bin/calicoctl /usr/local/bin/calicoctl

# Add K8s at Home chart repository to Helm
helm repo add k8s-at-home https://k8s-at-home.com/charts/
helm repo update