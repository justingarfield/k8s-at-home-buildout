# QBittorrent

QBittorrent is a torrent client. Within this stack, it's responsible for downloading anything that the PVR software dispatches to it.

## Deploy and Configure qBittorent via Script

For those seeking ultimate convenience, simply run the below script:

```shell
sudo ./scripts/bootstrap-qbittorent.sh
```

## Deploy and Configure qBittorent Manually

For those wanting to understand everything step-by-step, or are having problems with the bash script, here's the low-down on what's happenin'...

```shell
helm install qbittorent k8s-at-home/qbittorent -n jollyroger
```

## FAQ

### Why QBittorrent and not Transmission/uTorrent/etc.?

QBittorrent has "just worked" for me so far, and until I have more time to investigate and put other torrent clients through their paces, I've just decided to stick with QBittorent for now.