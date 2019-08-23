#!/bin/bash
#
# Title:      Reference Title File - PGBlitz
# Author(s):  Admin9705 & https://github.com/PGBlitz/PGClone/graphs/contributors
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
cloneclean () {
pgclonevars

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Clone Clean
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Clone Clean deletes garbage files in your downloads folder per every
[$cloneclean] minutes!

TORRENT USERS: Recommend that you set this number higher! If seeding,
Clone Clean will destory the seed files. Please set this number to a high
number of minutes. (IE - 1440 minutes = 1 day | 14440 minutes = 10 days)

WARNING: Do not set this too low because legitmate files!

Quitting? Type >>> exit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  read -p '↘️  Type Minutes (Minimum is 120) | PRESS [ENTER]: ' varinput < /dev/tty
  if [[ "$varinput" == "exit" || "$varinput" == "Exit" || "$varinput" == "EXIT" ]]; then clonestart; fi

  if [[ "$varinput" -lt "120" ]]; then cloneclean; fi

  echo "$varinput" > /pg/var/cloneclean
}
