# Radarr

Radarr...

## Optional

This module is optional for this stack.

## Deploy and Configure Radarr via Script

For those seeking ultimate convenience, simply run the below script:

```shell
sudo ./scripts/bootstrap-radarr.sh
```

## Deploy and Configure Radarr Manually

For those wanting to understand everything step-by-step, or are having problems with the bash script, here's the low-down on what's happenin'...

```shell
helm install radarr k8s-at-home/radarr -n jollyroger -f helm/radarr.yml

---

RADARR_POD_NAME=$(kubectl -n jollyroger get pods | grep radarr | awk '{print $1}') \
&& kubectl -n jollyroger exec $RADARR_POD_NAME -- sed -i 's/<UrlBase><\/UrlBase>/<UrlBase>\/radarr<\/UrlBase>/g' /config/config.xml \
&& kubectl -n jollyroger rollout restart deployment/radarr
```
