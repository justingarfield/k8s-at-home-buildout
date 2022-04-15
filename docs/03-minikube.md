# Minikube

There are a handful of ways to spin-up local K8s clusters these days. Including one built-in to Docker Desktop that's a checkbox away. I chose to go with `minikube` however, as that's the official K8s local cluster from Google itself, and it also works with container runtimes other than Docker.

* Install 

* `helm repo add jetstack https://charts.jetstack.io`
* `helm repo update`
* `helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version v1.8.0 --set installCRDs=true`

* `bash scripts/bootstrap-minikube.sh`

* `helm repo add k8s-at-home https://k8s-at-home.com/charts/`
