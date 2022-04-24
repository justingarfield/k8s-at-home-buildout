# Radarr

Radarr...

## Optional

This module is optional for this stack.

## Expected Disk Usage

Overall, I would recommend setting aside **10GB** of disk space for Radarr. This should give you enough breathing room to accomodate tracking somewhere in the ballpark of 8,000 movies.

| Area | Description |
|-|-|
| MediaCover folder | Anywhere from 70Kib to 5MiB per movie that Radarr is tracking. This is where the poster images / fanart files are saved. |
| Logs folder | By default, a month of logs are kept/rotated. Expect to use around 50MiB to 100MiB for this folder under normal operation |
| Backups folder | By default, a backup will be taken every 7-days. Expect at least 200MB of files in here. |

_Note: All figures based on observations of a library consisting of 3250 movies being tracked; with a total directory size of 3.9GB._

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
