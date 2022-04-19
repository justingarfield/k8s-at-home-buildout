# Lidarr

Lidarr...

## Optional

This module is optional for this stack.

## Deploy and Configure Lidarr via Script

For those seeking ultimate convenience, simply run the below script:

```shell
sudo ./scripts/bootstrap-lidarr.sh
```

## Deploy and Configure Lidarr Manually

For those wanting to understand everything step-by-step, or are having problems with the bash script, here's the low-down on what's happenin'...

```shell
helm install lidarr k8s-at-home/lidarr -n jollyroger
```
