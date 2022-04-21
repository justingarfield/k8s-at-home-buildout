# Sonarr

Sonarr...

## Optional

This module is optional for this stack.

## Deploy and Configure Sonarr via Script

For those seeking ultimate convenience, simply run the below script:

```shell
sudo ./scripts/bootstrap-sonarr.sh
```

## Deploy and Configure Sonarr Manually

For those wanting to understand everything step-by-step, or are having problems with the bash script, here's the low-down on what's happenin'...

```shell
helm install sonarr k8s-at-home/sonarr -n jollyroger
```
