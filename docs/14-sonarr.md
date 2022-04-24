# Sonarr

Sonarr...

## Optional

This module is optional for this stack.

## Expected Disk Usage

Overall, I would recommend setting aside **5GB** of disk space for Sonarr. This should give you enough breathing room to accomodate tracking somewhere in the ballpark of 2,500 television shows / 150,000 episodes.

| Area | Description |
|-|-|
| MediaCover folder | Anywhere from 165Kib to 2.5MiB per television show that Sonarr is tracking. This is where the poster images / fanart files are saved. |
| Logs folder | By default, a month of logs are kept/rotated. Expect to use around 50MiB to 100MiB for this folder under normal operation |
| Backups folder | By default, a backup will be taken every 7-days. Expect at least 200MB of files in here. |

_Note: All figures based on observations of a library consisting of 500 television shows / 32,000 episodes being tracked; with a total directory size of 775MB._

## Deploy and Configure Sonarr via Script

For those seeking ultimate convenience, simply run the below script:

```shell
sudo ./scripts/bootstrap-sonarr.sh
```

## Deploy and Configure Sonarr Manually

For those wanting to understand everything step-by-step, or are having problems with the bash script, here's the low-down on what's happenin'...

```shell
helm install sonarr k8s-at-home/sonarr -n jollyroger -f helm/sonarr.yml

---

SONARR_POD_NAME=$(kubectl -n jollyroger get pods | grep sonarr | awk '{print $1}') \
&& kubectl -n jollyroger exec $SONARR_POD_NAME -- sed -i 's/<UrlBase><\/UrlBase>/<UrlBase>\/sonarr<\/UrlBase>/g' /config/config.xml \
&& kubectl -n jollyroger rollout restart deployment/sonarr
```
