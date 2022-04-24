# Readarr

Readarr...

## Optional

This module is optional for this stack.

## Deploy and Configure Readarr via Script

For those seeking ultimate convenience, simply run the below script:

```shell
sudo ./scripts/bootstrap-readarr.sh
```

## Deploy and Configure Readarr Manually

For those wanting to understand everything step-by-step, or are having problems with the bash script, here's the low-down on what's happenin'...

```shell
helm install readarr k8s-at-home/readarr -n jollyroger -f helm/readarr.yml

---

READARR_POD_NAME=$(kubectl -n jollyroger get pods | grep readarr | awk '{print $1}') \
&& kubectl -n jollyroger exec $READARR_POD_NAME -- sed -i 's/<UrlBase><\/UrlBase>/<UrlBase>\/readarr<\/UrlBase>/g' /config/config.xml \
&& kubectl -n jollyroger rollout restart deployment/readarr
```
