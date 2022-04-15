# VPN and Pod Gateway

This is a very crucial set of steps to get correct, so that we can ensure traffic from the Torrenting and PVR containers (Sonarr, Radarr, QBittorrent, etc.) goes through a dedicated gateway with an anonymous VPN backing it. 

This tutorial defaults to using Wireguard with Private Internet Access.

## Create K8s Namespaces

Pod Gateway related resources will require two namespaces to function properly in this stack.

* `vpn` Namespace - Contains pods that will be routed through the Pod Gateway for ALL egress traffic
* `pod-gateway` Namespace - Contains resources that will be running the actual Pod Gateway

```shell
kubectl apply -f vpn-namespace/namespace.yml
kubectl apply -f pod-gateway/namespace.yml
```

## Acquire PIA Wireguard Details

Now that it's fully supported by Private Internet Access, this stack uses Wireguard. Wireguard is newer, smaller, faster, and doesn't carry all of the baggage that comes with OpenVPN connections. Setting up a Wireguard connection is a bit different than a simple username/password combo however. We'll use not only our username/password, but also a locally generated public / private keypair to perform a secure key exchange with the Wireguard server(s).

```shell
git clone https://github.com/pia-foss/manual-connections
cd manual-connections && sudo PIA_USER=<your PIA username> PIA_PASS=<your PIA password> bash get_region.sh && cd ..
```

You should see output similar to this:
```
Meta Services 149.57.16.33      -     baltimore402
WireGuard     149.57.16.54      -     baltimore402
OpenVPN TCP   149.57.16.58      -     baltimore402
OpenVPN UDP   149.57.16.55      -     baltimore402

Checking login credentials...OK!

PIA_TOKEN=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ+1234567890=
```

Take note of the _Wireguard_ entry's `IP Address` and `Server Hostname`, as well as the `PIA_TOKEN` outputs. 

In the case of the above sample output, those would be `149.57.16.54`, `baltimore402`, and `abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ+1234567890=` respectively.

We'll use those to get the required values for a WireGuard configuration file that the K8s at Home Wireguard container requires to establish a VPN connection.

## Generate Wireguard Configuration as Secret

The K8s at Home Wireguard container can be given the name of a Secret (located in the same Namespace), which is used to read-in a pre-built `wg0.conf` configuration file for Wireguard. It expects this configuration file to exist under a Key of `vpnConfigfile`. 

Running the following script will take your PIA details from the prior step, generate a public/private key-pair, call a PIA HTTPS endpoint to get the required access credentials for VPN connectivity, generate a `wg0.conf` file for Wireguard on-the-fly, and store that `wg0.conf` file as the value of a Kubernetes Secret.

```shell
  WG_HOSTNAME=<your PIA Wireguard server hostname> \
  WG_SERVER_IP=<your PIA Wireguard server IP address> \
  PIA_TOKEN=<your PIA_TOKEN> \
  sudo ./scripts/bootstrap-pod-gateway.sh
```

## Deploy the actual Pod Gateway

Now that we have all of our PIA Wireguard prep out of the way, it's time to deploy and fire-up the actual Pod Gateway containers.

We do this simply with Helm:

`helm install pod-gateway k8s-at-home/pod-gateway -n pod-gateway -f pod-gateway/values.yaml`

## Troubleshooting

### Webhook doesn't seem to be triggering

Make sure you've created your 'vpn' namespace with the `routed-gateway: "true"` label. It's easy to quickly crate the namespace using `kubectl create ns` and completely forget about the label in the process. Without that label, the webhook will never pickup any triggers.