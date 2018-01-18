#!/usr/bin/env sh

# takes only one argument: sonarr or radarr, depending on which app is being
# backed up
# api docs: https://github.com/Sonarr/Sonarr/wiki/Command#backup

if [ "$#" -ne 1 ] || [ "$1" != 'sonarr' ] || [ "$1" != 'radarr' ]; then
  echo 'This script only take one argument: "sonarr" or "radarr".'
  exit 1
fi

if [ "$1" = 'sonarr' ]; then
  dir_name='sonarr'
  url_path='series'
elif [ "$1" = 'radarr' ]; then
  dir_name='radarr'
  url_path='movies'
fi

scheme="http"
hostname="downloader"

api_key() {
  xmllint --xpath "/Config/ApiKey/text()" /live_data/"${dir_name}"/config.xml
}

trigger_backup() {
  curl \
    -H "X-Api-Key: $(api_key)" \
    -H 'Content-type: application/json' \
    -X POST \
    --data '{"name": "Backup"}' \
    "${scheme}://${hostname}/${url_path}/api/command"
}

trigger_backup
