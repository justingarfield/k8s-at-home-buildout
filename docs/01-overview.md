# Overview


## Software and Tools

The following list of Software and Tools will be installed using the provided scripts:

| Name                | Version | Always Installed?    | Notes                         |
|---------------------|---------|----------------------|-------------------------------|
| minikube            | v1.25.2 | Yes                  |                               |
| \|-- kubernetes     | v1.23.3 | Yes                  |                               |
| \|-- dashboard      |         | Yes                  |                               |
| \|-- ingress        |         | Yes                  |                               |
| \|-- calico         | v3.20.0 | Yes                  |                               |
| helm                |         | Yes                  |                               |
| git                 |         | Yes                  | Used for cloning GitHub repos |
| kubectl             |         | Yes                  |                               |
| calicoctl           | v3.20.0 | Yes                  |                               |
| curl                |         | Yes                  |                               |
| jq                  |         | Yes                  |                               |
| apt-transport-https |         | Yes                  |                               |
| golang-go           |         | Yes                  |                               |
| wireguard-tools     |         | Yes                  |                               |
| conntrack           |         | Yes                  |                               |
| ca-certificates     |         | Yes                  |                               |
| gnupg               |         | Yes                  |                               |
| lsb-release         |         | Yes                  |                               |
| docker-ce           |         | Yes                  |                               |
| docker-ce-cli       |         | Yes                  |                               |
| containerd.io       |         | Yes                  |                               |
| libelf-dev          |         | No - Win 10 WSL only | Used to recompile WSL Kernel  |
| build-essential     |         | No - Win 10 WSL only | Used to recompile WSL Kernel  |
| pkg-config          |         | No - Win 10 WSL only | Used to recompile WSL Kernel  |
| bison               |         | No - Win 10 WSL only | Used to recompile WSL Kernel  |
| flex                |         | No - Win 10 WSL only | Used to recompile WSL Kernel  |
| libssl-dev          |         | No - Win 10 WSL only | Used to recompile WSL Kernel  |
| bc                  |         | No - Win 10 WSL only | Used to recompile WSL Kernel  |
