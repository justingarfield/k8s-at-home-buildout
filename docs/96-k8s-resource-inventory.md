# Resource Inventory

## K8s Resource Types Deployed

* Deployments
* Pods
* Services
* Endpoints
* Init Containers
* Containers
* Issuers
* ClusterIssuers
* Certificate
* CertificateRequest

## Exposed Endpoints

* Sonarr
* Radarr
* Readarr
* Lidarr
* Jackett
* QBittorrent
* FlareSolverr

## File/Folder Locations

These are the default file locations for the VM Filesystems, Container Filesystems, etc. used throughout this stack.

| Disk Resource  | Location | Notes |
|-|-|-|
| Minikube Filesystem | `/var/lib/docker/minikube` | Location when using Docker in WSL |
| WSL Filesystem | `%LOCALAPPDATA%\Packages\CanonicalGroupLimited.Ubuntu20.04<some additional naming here>\LocalState\ext4.vhdx` | Defaults to 256GB maximum. Can be extended. |