# Minikube

There are a handful of ways to spin-up local K8s clusters these days. Including one built-in to Docker Desktop that's a checkbox away. I chose to go with `minikube` however, as that's the official K8s local cluster from Google itself, and it also works with container runtimes other than Docker (in the event someone reading this doesn't want to use Docker as the CRI).

## Install Minikube via Script

For those seeking ultimate convenience, simply run the below script:

```shell
sudo ./scripts/bootstrap-minikube.sh
```

## Install Minikube Manually

For those wanting to understand everything step-by-step, or are having problems with the bash script, here's the low-down on what's happenin'...

### Download and Install the minikube binary

First we download the minikube binary itself, and then we install it to `/usr/local/bin/minikube`. This places it in a shared location, and causes root to have ownership over it.

```shell
mkdir -p ~/k8s-buildout
curl -L -o ~/k8s-buildout/minikube-linux-amd64 https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install ~/k8s-buildout/minikube-linux-amd64 /usr/local/bin/minikube
```

Next, we'll ensure that the default driver being used by minikube, is indeed, Docker. (If you prefer to use another CRI, you will want to supply its driver name here)

```shell
minikube config set driver docker
```

### Start minikube and install required features

Now we'll start minikube for the first time, passing it some parameters that you should only have to provide once. In this case we're going to instruct minikube's bootstrapper to:

* Install Kubernetes v1.23.3
* Install the Calico for our CNI
* Deploy nginx-ingress
* Deploy Kubernetes Dashboard

```shell
minikube start \
  --kubernetes-version=v1.23.3 \
  --cni calico \
  --addons ingress \
  --addons dashboard
```

If everything succeeded, you should now have a local minikube single-node cluster running.

# Setup repository for Helm and install it
curl https://baltocdn.com/helm/signing.asc | apt-key add - \
&& echo "deb https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list \
&& apt-get -qq update \
&& apt-get install -y \
  helm

## Install cert-manager

Multiple pods require that cert-manager be deployed inside the kubernetes cluster, as it will be needed to handle SSL/TLS certificates.

```shell
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version v1.8.0 --set installCRDs=true
```

Note: `--set installCRDs=true` is a VERY important part of the command above. Failure to include that switch will lead to a broken cert-manager deployment.

## Prepare Helm for the K8s at Home Charts

Most of this stack will be built using Helm Charts (and a few container images) provided by the K8s at Home project. To allow deployment of their charts, we need to add their chart repository to our Helm install.

```shell
helm repo add k8s-at-home https://k8s-at-home.com/charts/
helm repo update
```
