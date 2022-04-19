#!/bin/bash

source "$(dirname "$0")/_bash-colors.sh"
source "$(dirname "$0")/_root-only.sh"
source "$(dirname "$0")/_sudouser-home.sh"
source "$(dirname "$0")/_stack-versions.sh"

# Setup repository for Helm and install it
curl https://baltocdn.com/helm/signing.asc | apt-key add - \
&& echo "deb https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list \
&& apt-get -qq update \
&& apt-get install -y \
  helm

# Download, verify, and install kubectl
curl -L "https://dl.k8s.io/release/v$KUBERNETES_VERSION/bin/linux/amd64/kubectl" -o $SUDOUSER_HOME/kubectl \
&& curl -L "https://dl.k8s.io/v$KUBERNETES_VERSION/bin/linux/amd64/kubectl.sha256" -o $SUDOUSER_HOME/kubectl.sha256

echo "$(cat $SUDOUSER_HOME/kubectl.sha256) kubectl" | sha256sum --check | grep 'kubectl: OK' &> /dev/null
if [ $? != 0 ]; then
   echo "kubectl binary does not match sha256 checksum. Bailing!"
   exit 1
fi

install -o root -g root -m 0755 $SUDOUSER_HOME/kubectl /usr/local/bin/kubectl

# Download, extract, and install calicoctl
curl -L https://github.com/projectcalico/calico/releases/download/v$CALICO_VERSION/release-v$CALICO_VERSION.tgz -o calico-release-v$CALICO_VERSION.tgz
tar -xvf calico-release-v$CALICO_VERSION.tgz --occurrence release-v$CALICO_VERSION/bin/calicoctl
install -o root -g root -m 0755 release-v$CALICO_VERSION/bin/calicoctl /usr/local/bin/calicoctl