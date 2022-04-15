# VPN and Pod Gateway

This is a very crucial set of steps to get correct, so that we can ensure traffic from the Torrenting and PVR containers (Sonarr, Radarr, QBittorrent, etc.) goes through a dedicated gateway with an anonymous VPN backing it. 

This tutorial defaults to using Wireguard with Private Internet Access.

## Acquire PIA Wireguard Details

Inside a WSL terminal:
* `git clone https://github.com/pia-foss/manual-connections && cd manual-connections`
* `sudo PIA_USER=<your PIA username> PIA_PASS=<your PIA password> ./get_region.sh`
* `cd ..`
* Take note of the `PIA_TOKEN` output
* Take note of the `WireGuard` entry of the Server/Region/Latency output. You want the IP Address and hostname fields. (e.g. if you get back `WireGuard     37.19.198.136     -     newyork432`, then `37.19.198.136` is the IP Address, and `newyork432` is the hostname)

```shell
  WG_HOSTNAME=<your PIA Wireguard server hostname> \
  WG_SERVER_IP=<your PIA Wireguard server IP address> \
  PIA_TOKEN=<your PIA OAuth token> \
  sudo ./scripts/bootstrap-pod-gateway.sh
```

* `kubectl apply -f vpn-namespace/namespace.yml`
* `kubectl apply -f pod-gateway/namespace.yml`

* `helm install pod-gateway k8s-at-home/pod-gateway -n pod-gateway -f pod-gateway/values.yaml`

## Troubleshooting

### Webhook doesn't seem to be triggering

Make sure you've created your 'vpn' namespace with the `routed-gateway: "true"` label. It's easy to quickly crate the namespace using `kubectl create ns` and completely forget about the label in the process. Without that label, the webhook will never pickup any triggers.