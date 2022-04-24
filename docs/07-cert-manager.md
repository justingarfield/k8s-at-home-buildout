# cert-manager

There are some important CLI commands that you'll need throughout your use of Kubernetes, Calico, and Helm. These commands are how you can interact with the running cluster, its networking stack, and also deploy and manage charts.

## Install cert-manager via Script

For those seeking ultimate convenience, simply run the below script:

```shell
sudo ./scripts/bootstrap-cert-manager.sh
```

## Install cert-manager Manually

For those wanting to understand everything step-by-step, or are having problems with the bash script, here's the low-down on what's happenin'...

### Install cert-manager

Multiple pods require that cert-manager be deployed inside the kubernetes cluster, as it will be needed to handle SSL/TLS certificates.

```shell
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version v1.8.0 --set installCRDs=true
```

Note: `--set installCRDs=true` is a VERY important part of the command above. Failure to include that switch will lead to a broken cert-manager deployment.


## Provision Certs for K8s at Home Buildout

