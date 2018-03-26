#!/usr/bin/with-contenv sh
# su -s /bin/sh -c "\
#   /usr/local/bin/subliminal \
#   --addic7ed '${ADDIC7ED_USERNAME}' '${ADDIC7ED_PASSWORD}' \
#   --opensubtitles '${OPENSUBS_USERNAME}' '${OPENSUBS_PASSWORD}' \
#   download \
#   --age 2h \
#   --language en \
#   --provider addic7ed \
#   --provider opensubtitles \
#   --verbose \
#   /movies \
#   /series \
# 2>&1" "$(id -nu user)"
s6-envuidgid "$(id -nu user)" \
  "/usr/local/bin/subliminal \
  --addic7ed '${ADDIC7ED_USERNAME}' '${ADDIC7ED_PASSWORD}' \
  --opensubtitles '${OPENSUBS_USERNAME}' '${OPENSUBS_PASSWORD}' \
  download \
  --age 2h \
  --language en \
  --provider addic7ed \
  --provider opensubtitles \
  --verbose \
  /movies \
  /series" \
 2>&1 | s6-log -bv /var/log/subliminal