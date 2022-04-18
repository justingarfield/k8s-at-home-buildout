#!/bin/bash

source "$(dirname "$0")/_bash-colors.sh"
source "$(dirname "$0")/_root-only.sh"
source "$(dirname "$0")/_sudouser-home.sh"
source "$(dirname "$0")/_stack-versions.sh"

helm repo add jetstack https://charts.jetstack.io \
  && helm repo update \
  && helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version v$CERTMANAGER_VERSION --set installCRDs=true