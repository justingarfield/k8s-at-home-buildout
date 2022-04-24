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

```bash
helm install lidarr k8s-at-home/lidarr -n jollyroger -f helm/lidarr.yml

---

LIDARR_POD_NAME=$(kubectl -n jollyroger get pods | grep lidarr | awk '{print $1}') \
&& kubectl -n jollyroger exec $LIDARR_POD_NAME -- sed -i 's/<UrlBase><\/UrlBase>/<UrlBase>\/lidarr<\/UrlBase>/g' /config/config.xml \
&& kubectl -n jollyroger rollout restart deployment/lidarr
```
