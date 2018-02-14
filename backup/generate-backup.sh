#!/usr/bin/env sh

# takes only one argument: sonarr or radarr, depending on which app is being
# backed up
# api docs: https://github.com/Sonarr/Sonarr/wiki/Command#backup

err_exit() {
  echo 'This script only take one argument: "sonarr", "radarr", or "hydra".'
  exit 1
}

if [ "$#" -ne 1 ]; then
  err_exit
fi

if [ "$1" = 'sonarr' ]; then
  dir_name='sonarr'
  url_path='series'
  trigger_ar_backup
elif [ "$1" = 'radarr' ]; then
  dir_name='radarr'
  url_path='movies'
  trigger_ar_backup
elif [ "$1" = 'hydra' ]; then
  dir_name='hydra'
  url_path='aggregator/nzb'
  trigger_hydra_backup
else
  err_exit
fi

scheme="http"
hostname="proxy"

api_key() {
  xmllint --xpath "/Config/ApiKey/text()" /live_data/"${dir_name}"/config.xml
}

trigger_ar_backup() {
  curl \
    --silent \
    --show-error \
    --header "X-Api-Key: $(api_key)" \
    --header 'Content-type: application/json' \
    --request POST \
    --data '{"name": "Backup"}' \
    "${scheme}://${hostname}/${url_path}/api/command"
}

trigger_hydra_backup() {
  curl \
    --silent \
    --show-error \
    --remote-name \
    --remote-header-name \
    "${scheme}://${hostname}/${url_path}/internalapi/backup"
}
