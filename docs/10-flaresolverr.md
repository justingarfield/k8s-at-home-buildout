# Flaresolverr

Flaresolverr is responsible for automatically solving Cloudflare Captchas. A lot of trackers / indexers put Cloudflare in-front of their instances now, and software like Jackett will need something like this to lean-on in-order to query those sites.

## Optional

This module is optional for this stack. Not every indexer / tracker uses Cloudflare protection. If you only have Jackett pointing to sites not using Cloudflare, then there's no reason to provision this.

## Deploy and Configure flaresolverr via Script

For those seeking ultimate convenience, simply run the below script:

```shell
sudo ./scripts/bootstrap-flaresolverr.sh
```

## Deploy and Configure flaresolverr Manually

For those wanting to understand everything step-by-step, or are having problems with the bash script, here's the low-down on what's happenin'...

```shell
helm install flaresolverr k8s-at-home/flaresolverr -n jollyroger
```

## FAQ
