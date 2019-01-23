#!/bin/bash
#
# Title:      PGClone (A 100% PG Product)
# Author(s):  Admin9705
# URL:        https://plexguide.com - http://github.plexguide.com
# GNU:        General Public License v3.0
################################################################################
source /opt/pgclone/functions/functions.sh
source /opt/pgclone/functions/keys.sh
source /opt/pgclone/functions/keyback.sh
source /opt/pgclone/functions/pgclone.sh
################################################################################
question1 () {
  touch /opt/appdata/plexguide/rclone.conf
  transport=$(cat /var/plexguide/pgclone.transport)
  gstatus=$(cat /var/plexguide/gdrive.pgclone)
  tstatus=$(cat /var/plexguide/tdrive.pgclone)
  transportdisplay
  mkdir -p /opt/appdata/pgblitz/keys/processed/
  keynum=$(ls /opt/appdata/pgblitz/keys/processed/ | wc -l)
  bwdisplay=$(cat /var/plexguide/move.bw)
  bwdisplay2=$(cat /var/plexguide/blitz.bw)

if [ "$transport" == "NOT-SET" ]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 Welcome to PG Clone                 📓 Reference: pgclone.plexguide.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] Data Transport Mode: $transport
[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -p '↘️  Type Selection | Press [ENTER]: ' typed < /dev/tty

  if [ "$typed" == "1" ]; then
  transportmode
  question1
  elif [[ "$typed" == "Z" || "$typed" == "z" ]]; then exit; fi
fi

if [[ "$transport" == "PG Blitz /w No Encryption" || "$transport" == "PG Blitz /w Encryption" ]]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 Welcome to PG Clone                 📓 Reference: pgclone.plexguide.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] Data Transport Mode: $transport
[2] OAuth & Mounts
[3] Key Management:      $keynum Keys Deployed
[4] Throttle Limit:      $bwdisplay2 MB
[5] Deploy:              $transport
[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -p '↘️  Type Selection | Press [ENTER]: ' typed < /dev/tty

if [ "$typed" == "1" ]; then
transportmode
question1
elif [ "$typed" == "2" ]; then
mountsmenu
question1
elif [ "$typed" == "3" ]; then
keymenu
question1
elif [ "$typed" == "4" ]; then
bandwidthblitz
question1
elif [ "$typed" == "5" ]; then
    if [ "$transport" == "PG Blitz /w No Encryption" ]; then
      deploygdrivecheck
      deploytdrivecheck
      deploygdsa01check
      removemounts
      ufsbuilder
      ansible-playbook /opt/pgclone/gdrive.yml
      ansible-playbook /opt/pgclone/tdrive.yml
      ansible-playbook /opt/pgclone/unionfs.yml
      pgbdeploy
      question1
    elif [ "$transport" == "PG Blitz /w Encryption" ]; then
      deploygdrivecheck
      deploytdrivecheck
      deploygdsa01check
      removemounts
      ufsbuilder
      ansible-playbook /opt/pgclone/gdrive.yml
      ansible-playbook /opt/pgclone/tdrive.yml
      ansible-playbook /opt/pgclone/gcrypt.yml
      ansible-playbook /opt/pgclone/tcrypt.yml
      ansible-playbook /opt/pgclone/unionfs.yml
      pgbdeploy
      question1
    fi
elif [[ "$typed" == "Z" || "$typed" == "z" ]]; then
  exit
else
  badinput
  question1; fi
fi

if [[ "$transport" == "PG Move /w No Encryption" || "$transport" == "PG Move /w Encryption" ]]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 Welcome to PG Clone                 📓 Reference: pgclone.plexguide.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] Data Transport Mode: $transport
[2] OAuth & Mounts
[3] Throttle Limit:      $bwdisplay MB
[4] Deploy:              $transport
[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -p '↘️  Type Selection | Press [ENTER]: ' typed < /dev/tty

if [ "$typed" == "1" ]; then
transportmode
question1
elif [ "$typed" == "2" ]; then
mountsmenu
question1
elif [ "$typed" == "3" ]; then
bandwidth
question1
elif [ "$typed" == "4" ]; then
    if [ "$transport" == "PG Move /w No Encryption" ]; then
      mkdir -p /var/plexguide/rclone/
      echo "gdrive" > /var/plexguide/rclone/deploy.version
      deploygdrivecheck
      removemounts
      ansible-playbook /opt/pgclone/gdrive.yml
      ansible-playbook /opt/pgclone/unionfs.yml
      question1
    elif [ "$transport" == "PG Move /w Encryption" ]; then
      mkdir -p /var/plexguide/rclone/
      deploygdrivecheck
      deploygcryptcheck
      removemounts
      ansible-playbook /opt/pgclone/gdrive.yml
      ansible-playbook /opt/pgclone/gcrypt.yml
      ansible-playbook /opt/pgclone/unionfs.yml
      question1
    fi
elif [[ "$typed" == "Z" || "$typed" == "z" ]]; then
  exit
else
  badinput
  question1; fi
fi

inputphase
}
# Reminder for gdrive/tdrive / check rclone to set if active, below just placeholder
variable /var/plexguide/project.account "NOT-SET"
variable /var/plexguide/pgclone.project "NOT-SET"
variable /var/plexguide/pgclone.teamdrive ""
variable /var/plexguide/pgclone.public ""
variable /var/plexguide/pgclone.secret ""
variable /var/plexguide/pgclone.transport "PG Move /w No Encryption"
variable /var/plexguide/gdrive.pgclone "⚠️  Not Activated"
variable /var/plexguide/tdrive.pgclone "⚠️  Not Activated"
variable /var/plexguide/move.bw  "10"
variable /var/plexguide/blitz.bw  "1000"
variable /var/plexguide/pgclone.password ""
variable /var/plexguide/pgclone.salt ""

file="/var/plexguide/rclone/deploy.version"
  if [ ! -e "$file" ]; then echo "null" > /var/plexguide/project.final; fi

question1
