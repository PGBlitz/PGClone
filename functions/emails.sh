#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Authors:    Admin9705, Deiteq, and many PGBlitz Contributors
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
emailgen() {

  rm -rf /var/plexguide/.emailbuildlist 1>/dev/null 2>&1
  rm -rf /var/plexguide/.emaillist 1>/dev/null 2>&1

  ls -la /opt/appdata/plexguide/.blitzkeys | awk '{print $9}' | tail -n +4 >/var/plexguide/.emailbuildlist
  while read p; do
    cat /opt/appdata/plexguide/.blitzkeys/$p | grep client_email | awk '{print $2}' | sed 's/"//g' | sed 's/,//g' >>/var/plexguide/.emaillist
  done </var/plexguide/.emailbuildlist

  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 EMail Share Generator
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

PURPOSE: Share out the service accounts for the TeamDrives. 
Failing to do so will result in Blitz Failing!

Shortcut to Google Team Drives 

NOTE 1: Share the E-Mails with the CORRECT TEAMDRIVE: $tdname
NOTE 2: SAVE TIME! Copy & Paste the all the E-Mails into the share!"

EOF
  cat /var/plexguide/.emaillist
  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  read -rp '↘️  Completed? | Press [ENTER] ' typed </dev/tty
  clonestart

}
