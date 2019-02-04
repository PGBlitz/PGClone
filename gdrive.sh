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

################################ Forces RClone Installer ######## START
echo "15" > /var/plexguide/pg.rcloneprime

rcpiece () {
tee "/etc/fuse.conf" > /dev/null <<EOF
# /etc/fuse.conf - Configuration file for Filesystem in Userspace (FUSE)
# Set the maximum number of FUSE mounts allowed to non-root users.
# The default is 1000.
#mount_max = 1000
# Allow non-root users to specify the allow_other or allow_root mount options.
user_allow_other
EOF
}

core () {
    touch /var/plexguide/pg."${1}".stored
    start=$(cat /var/plexguide/pg."${1}")
    stored=$(cat /var/plexguide/pg."${1}".stored)
    if [ "$start" != "$stored" ]; then
      $1
      cat /var/plexguide/pg."${1}" > /var/plexguide/pg."${1}".stored;
    fi
}

createDefaultFolders() {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Create Default Folders?            📓 Reference: defaultFolders.plexguide.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Choosing yes will make the folders: tv, movies, music, ebooks, abooks
in the root of your google drive/team drive!

If you don't know what you're doing, or it's a new setup then leave as yes!

[1] Yes, use default folders
[2] No, don't use default folders (ADVANCED!)
[Z] Exit

EOF
read -p '↘️  Type Selection | Press [ENTER]: ' typed < /dev/tty

  if [ "$typed" == "1" ]; then
      echo "Yes" > /var/plexguide/pgclone.defaultFolders
  elif [ "$typed" == "2" ]; then
    echo "No" > /var/plexguide/pgclone.defaultFolders
  elif [[ "$typed" == "Z" || "$typed" == "z" ]]; then
   exit
  else
    badinput
    createDefaultFolders
    exit
  fi
    
    
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 Default Folders Set                📓 Reference: defaultFolders.plexguide.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
read -p '↘️  Acknowledge Info  | Press [ENTER] ' public < /dev/tty

}

rcloneprime () {
  curl https://rclone.org/install.sh | sudo bash -s beta
  rcpiece
}

core rcloneprime

# Fail Safe
file="/usr/bin/rclone"
if [ ! -e "$file" ]; then
tee <<-EOF

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "💪 RClone's Role Failed! Executing Backup Installer!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

EOF
  sleep 1
  ansible-playbook /opt/pgclone/pg.yml --tags rcloneinstall
  rcpiece
fi

################################ Forces RClone Installer ######## END

question1 () {
  touch /opt/appdata/plexguide/rclone.conf
  transport=$(cat /var/plexguide/pgclone.transport)
  defaultFolders=$(cat /var/plexguide/pgclone.defaultFolders)
  gstatus=$(cat /var/plexguide/gdrive.pgclone)
  tstatus=$(cat /var/plexguide/tdrive.pgclone)
  transportdisplay
  mkdir -p /opt/appdata/pgblitz/keys/processed/
  keynum=$(ls /opt/appdata/pgblitz/keys/processed/ | wc -l)
  bwdisplay=$(cat /var/plexguide/move.bw)
  bwdisplay2=$(cat /var/plexguide/blitz.bw)
  file="/var/plexguide/rclone/deploy.version"
    if [ ! -e "$file" ]; then echo "null" > /var/plexguide/project.final; fi

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
  elif [[ "$typed" == "Z" || "$typed" == "z" ]];

  # If a New Installer, User Cannot Exit!
  transport=$(cat /var/plexguide/pgclone.transport)
  if [ "$transport" == "NOT-SET" ]; then
  question1; fi

  then exit; fi
fi

if [[ "$transport" == "PG Local" ]]; then

  # If UnionFS is detected, we need to remove it
  file="/etc/systemd/system/unionfs.service"
  if [ -e "$file" ]; then
  echo ""
  read -p '↘️  unionfs.service Detected - Removing Now | [PRESS] ENTER ' typed < /dev/tty
  removepgservices; fi

  # If PGUnion.Serivce is detected, we need to remove it
  file="/etc/systemd/system/pgunion.service"
  if [ -e "$file" ]; then
  echo ""
  read -p '↘️  pgunion.service Detected - Removing Now | [PRESS] ENTER ' typed < /dev/tty
  removepgservices; fi

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 Welcome to PG Clone                 📓 Reference: pgclone.plexguide.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTE: When setting up your programs, use /mnt/unionfs. Data will go there;
but does not go anywhere!

[1] Data Transport Mode: Local HD
[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -p '↘️  Type Selection | Press [ENTER]: ' typed < /dev/tty

case $typed in
    1 )
        transportmode
        question1;;
    z )
        exit ;;
    Z )
        exit ;;
    * )
        question1 ;;
esac
fi

if [[ "$transport" == "PG Blitz /w No Encryption" || "$transport" == "PG Blitz /w Encryption" ]]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 Welcome to PG Clone                 📓 Reference: pgclone.plexguide.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] Data Transport Mode:  $transport
[2] OAuth & Mounts
[3] Key Management:       $keynum Keys Deployed
[4] Throttle Limit:       $bwdisplay2 MB
[5] Make Default Folders: $defaultFolders
[6] Deploy:               $transport
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
createDefaultFolders
question1
elif [ "$typed" == "6" ]; then
    if [ "$transport" == "PG Blitz /w No Encryption" ]; then
      removepgservices
      deploygdrivecheck
      deploytdrivecheck
      deploygdsa01check
      ufsbuilder
      ansible-playbook /opt/pgclone/gdrive.yml
      ansible-playbook /opt/pgclone/tdrive.yml
      ansible-playbook /opt/pgclone/pgunion.yml
      pgbdeploy
      question1
    elif [ "$transport" == "PG Blitz /w Encryption" ]; then
      removepgservices
      deploygdrivecheck
      deploytdrivecheck
      deploygdsa01check
      ufsbuilder
      ansible-playbook /opt/pgclone/gdrive.yml
      ansible-playbook /opt/pgclone/tdrive.yml
      ansible-playbook /opt/pgclone/gcrypt.yml
      ansible-playbook /opt/pgclone/tcrypt.yml
      ansible-playbook /opt/pgclone/pgunion.yml
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

[1] Data Transport Mode:  $transport
[2] OAuth & Mounts
[3] Throttle Limit:       $bwdisplay MB
[4] Make Default Folders: $defaultFolders
[5] Deploy:               $transport
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
createDefaultFolders
question1
elif [ "$typed" == "5" ]; then
    if [ "$transport" == "PG Move /w No Encryption" ]; then
      mkdir -p /var/plexguide/rclone/
      echo "gdrive" > /var/plexguide/rclone/deploy.version
      removepgservices
      deploygdrivecheck
      ansible-playbook /opt/pgclone/gdrive.yml
      ansible-playbook /opt/pgclone/pgunion.yml
      question1
    elif [ "$transport" == "PG Move /w Encryption" ]; then
      mkdir -p /var/plexguide/rclone/
      removepgservices
      deploygdrivecheck
      deploygcryptcheck
      ansible-playbook /opt/pgclone/gdrive.yml
      ansible-playbook /opt/pgclone/gcrypt.yml
      ansible-playbook /opt/pgclone/pgunion.yml
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

mkdir -p /var/plexguide/rclone
# Reminder for gdrive/tdrive / check rclone to set if active, below just placeholder
variable /var/plexguide/project.account "NOT-SET"
variable /var/plexguide/pgclone.project "NOT-SET"
variable /var/plexguide/pgclone.teamdrive ""
variable /var/plexguide/pgclone.public ""
variable /var/plexguide/pgclone.secret ""
variable /var/plexguide/rclone/deploy.version "null"
variable /var/plexguide/pgclone.transport "PG Move /w No Encryption"
variable /var/plexguide/pgclone.defaultFolders "Yes"
variable /var/plexguide/gdrive.pgclone "⚠️  Not Activated"
variable /var/plexguide/tdrive.pgclone "⚠️  Not Activated"
variable /var/plexguide/move.bw  "9"
variable /var/plexguide/blitz.bw  "1000"
variable /var/plexguide/pgclone.password ""
variable /var/plexguide/pgclone.salt ""

question1
