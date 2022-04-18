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

You'll probably need to wait ~5 minutes for this to complete. If everything succeeds, you should now have a local minikube single-node cluster running. The output should look something like this:

```shell
somedude@DESKTOP-K8E1N21:~$ minikube start \
>   --kubernetes-version=v1.23.3 \
>   --cni calico \
>   --addons ingress \
>   --addons dashboard
😄  minikube v1.25.2 on Ubuntu 20.04
✨  Using the docker driver based on user configuration
👍  Starting control plane node minikube in cluster minikube
🚜  Pulling base image ...
🔥  Creating docker container (CPUs=2, Memory=3100MB) ...
🐳  Preparing Kubernetes v1.23.3 on Docker 20.10.12 ...
    ▪ kubelet.housekeeping-interval=5m
    ▪ Generating certificates and keys ...
    ▪ Booting up control plane ...
    ▪ Configuring RBAC rules ...
🔗  Configuring Calico (Container Networking Interface) ...
🔎  Verifying Kubernetes components...
    ▪ Using image kubernetesui/dashboard:v2.3.1
    ▪ Using image gcr.io/k8s-minikube/storage-provisioner:v5
    ▪ Using image k8s.gcr.io/ingress-nginx/kube-webhook-certgen:v1.1.1
    ▪ Using image k8s.gcr.io/ingress-nginx/kube-webhook-certgen:v1.1.1
    ▪ Using image kubernetesui/metrics-scraper:v1.0.7
    ▪ Using image k8s.gcr.io/ingress-nginx/controller:v1.1.1
🔎  Verifying ingress addon...
🌟  Enabled addons: storage-provisioner, default-storageclass, dashboard, ingress
🏄  Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default
```