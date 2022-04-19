# Jackett

Jackett acts as a Cache / RSS Feed / Search Engine between the PVR software and any configured Trackers / Indexers.

## Deploy and Configure Jackett via Script

For those seeking ultimate convenience, simply run the below script:

```shell
sudo ./scripts/bootstrap-jackett.sh
```

## Deploy and Configure Jackett Manually

For those wanting to understand everything step-by-step, or are having problems with the bash script, here's the low-down on what's happenin'...

```shell
helm install jackett k8s-at-home/jackett -n jollyroger
```

## FAQ

### Why Jackett and not Prowlarr?

Prowlarr is still being very actively developed, and at the time of this writing has many major issues that Jackett does not. In favor of "something that's stable", I still use Jackett in my stack. I will most likely switch to Prowlarr down the road, but I'm still not satisfied with it yet.