#!/usr/bin/with-contenv sh
# shellcheck shell=sh

exec s6-envuidgid -u user -g user \
  /usr/local/bin/subliminal \
  --addic7ed "${ADDIC7ED_USERNAME}" "${ADDIC7ED_PASSWORD}" \
  --opensubtitles "${OPENSUBS_USERNAME}" "${OPENSUBS_PASSWORD}" \
  --cache-dir /var/cache/subliminal \
  download \
  --force \
  --language en \
  --provider addic7ed \
  --provider opensubtitles \
  --refiner metadata \
  --refiner omdb \
  --refiner tvdb \
  --verbose \
  /movies \
  /series \
 2>&1 | s6-log -v /var/log/subliminal
