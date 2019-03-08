#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
oauth () {
pgclonevars

if [[ "$oauthtype" == "tlabel" ]]; then
  gtype="https://www.googleapis.com/drive/v3/teamdrives"
  storage="/var/plexguide/teamdrive.output"; fi

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Google Auth - ${name} ~ oauth.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Quitting? Type > exit
NOTE: Copy & Paste Url into Browser | Utilize the Correct Google Account!

https://accounts.google.com/o/oauth2/auth?client_id=$pgclonepublic&redirect_uri=urn:ietf:wg:oauth:2.0:oob&scope=https://www.googleapis.com/auth/drive&response_type=code

EOF
  read -p '↘️  Token | PRESS [ENTER]: ' token < /dev/tty

  if [[ "$token" = "exit" ]]; then mountsmenu; fi
  curl --request POST --data "code=${token}&client_id=${pgclonepublic}&client_secret=${pgclonesecret}&redirect_uri=urn:ietf:wg:oauth:2.0:oob&grant_type=authorization_code" https://accounts.google.com/o/oauth2/token > /var/plexguide/token.part1
  curl -H "GData-Version: 3.0" -H "Authorization: Bearer $(cat /var/plexguide/token.part1 | grep access_token | awk '{ print $2 }' | cut -c2- | rev | cut -c3- | rev)" $gtype > $storage

}
