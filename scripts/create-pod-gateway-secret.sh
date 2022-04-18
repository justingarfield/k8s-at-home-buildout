#!/bin/bash

###
# This script derived from https://github.com/pia-foss/manual-connections/blob/master/connect_to_wireguard_with_token.sh
###

# This function allows you to check if the required tools have been installed.
check_tool() {
  cmd=$1
  if ! command -v "$cmd" >/dev/null; then
    echo "$cmd could not be found"
    echo "Please install $cmd"
    exit 1
  fi
}

# Now we call the function to make sure we can use curl, jq and kubectl.
check_tool curl
check_tool jq
check_tool kubectl

# Check if terminal allows output, if yes, define colors for output
if [[ -t 1 ]]; then
  ncolors=$(tput colors)
  if [[ -n $ncolors && $ncolors -ge 8 ]]; then
    red=$(tput setaf 1) # ANSI red
    green=$(tput setaf 2) # ANSI green
    nc=$(tput sgr0) # No Color
  else
    red=''
    green=''
    nc='' # No Color
  fi
fi

# Check if the mandatory environment variables are set.
if [[ -z $WG_SERVER_IP ||
      -z $WG_HOSTNAME ||
      -z $PIA_TOKEN ]]; then
  echo -e "${red}This script requires 3 env vars:"
  echo "WG_SERVER_IP - IP that you want to connect to"
  echo "WG_HOSTNAME  - name of the server, required for ssl"
  echo "PIA_TOKEN    - your authentication token"
  exit 1
fi

# Create ephemeral wireguard keys, that we don't need to save to disk.
privKey=$(wg genkey)
export privKey
pubKey=$( echo "$privKey" | wg pubkey)
export pubKey

wireguard_json="$(curl -s -G \
  --connect-to "$WG_HOSTNAME::$WG_SERVER_IP:" \
  --cacert "./manual-connections/ca.rsa.4096.crt" \
  --data-urlencode "pt=${PIA_TOKEN}" \
  --data-urlencode "pubkey=$pubKey" \
  "https://${WG_HOSTNAME}:1337/addKey" )"

# Check if the API returned OK and stop this script if it didn't.
if [[ $(echo "$wireguard_json" | jq -r '.status') != "OK" ]]; then
  >&2 echo -e "${red}Server did not return OK. Stopping now.${nc}"
  exit 1
fi

# Create the WireGuard config based on the JSON received from the API
# This uses a PersistentKeepalive of 25 seconds to keep the NAT active
# on firewalls. You can remove that line if your network does not
# require it.
dnsServer=$(echo "$wireguard_json" | jq -r '.dns_servers[0]')
dnsSettingForVPN="DNS = $dnsServer"

wgConfig=$(echo "
[Interface]
Address = $(echo "$wireguard_json" | jq -r '.peer_ip')
PrivateKey = $privKey
$dnsSettingForVPN

[Peer]
PersistentKeepalive = 25
PublicKey = $(echo "$wireguard_json" | jq -r '.server_key')
AllowedIPs = 0.0.0.0/0
Endpoint = ${WG_SERVER_IP}:$(echo "$wireguard_json" | jq -r '.server_port')
")

kubectl -n pod-gateway create secret generic wireguard-config --from-literal=vpnConfigfile="$wgConfig"