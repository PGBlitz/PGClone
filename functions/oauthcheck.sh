#!/bin/bash
#
# Title:      Reference Title File - PGBlitz
# Author(s):  Admin9705 & https://github.com/PGBlitz/PGClone/graphs/contributors
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
oauthcheck () {
pgclonevars

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Conducting Validation Checks: $oauthcheck
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  rcheck=$(rclone lsd --config ${PGBLITZ_DIR}/rclone/.$oauthcheck $oauthcheck: | grep -oP plexguide | head -n1)
  if [[ "$rcheck" != "plexguide" ]]; then
    rclone mkdir --config ${PGBLITZ_DIR}/rclone/.$oauthcheck $oauthcheck:/plexguide
    rcheck=$(rclone lsd --config ${PGBLITZ_DIR}/rclone/.$oauthcheck $oauthcheck: | grep -oP plexguide | head -n1)
  fi

  if [ "$rcheck" != "plexguide" ]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔  Validation Checks Failed: $oauthcheck
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTES:
1. Did you set up your $oauthcheck accordingly to the wiki?
2. Is your project active?

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
rm -rf ${PGBLITZ_DIR}/rclone/.$oauthcheck 1>/dev/null 2>&1

    if [[ "$oauthcheck" == "gdrive" ]]; then rm -rf ${PGBLITZ_DIR}/rclone/.gd 1>/dev/null 2>&1; fi
    if [[ "$oauthcheck" == "sdrive" ]]; then rm -rf ${PGBLITZ_DIR}/rclone/.sd 1>/dev/null 2>&1; fi

    read -p '↘️  Acknowledge Info | Press [ENTER] ' typed2 < /dev/tty
    clonestart
else
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Validation Checks Passed - $oauthcheck
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  fi
}
