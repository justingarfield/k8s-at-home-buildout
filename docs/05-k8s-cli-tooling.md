# Kubernetes CLI Tooling

There are some important CLI commands that you'll need throughout your use of Kubernetes, Calico, and Helm. These commands are how you can interact with the running cluster, its networking stack, and also deploy and manage charts.

## Install K8s CLI Tooling via Script

For those seeking ultimate convenience, simply run the below script:

```shell
sudo ./scripts/bootstrap-k8s-cli-tooling.sh
```

## Install K8s CLI Tooling Manually

For those wanting to understand everything step-by-step, or are having problems with the bash script, here's the low-down on what's happenin'...

# Setup repository for Helm and install it

```shell
curl https://baltocdn.com/helm/signing.asc | apt-key add -
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list \
apt-get update
apt-get install helm
```

## Prepare Helm for the K8s at Home Charts

Most of this stack will be built using Helm Charts (and a few container images) provided by the K8s at Home project. To allow deployment of their charts, we need to add their chart repository to our Helm install.

```shell
helm repo add k8s-at-home https://k8s-at-home.com/charts/
helm repo update
```