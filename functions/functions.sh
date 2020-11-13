#!/bin/bash
#
# Title:      Reference Title File - PGBlitz
# Author(s):  Admin9705 & https://github.com/PGBlitz/PGClone/graphs/contributors
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

# BAD INPUT
exitclone () {
  if [[ "$typed" == "exit" || "$typed" == "Exit" || "$typed" == "EXIT" ]]; then clonestart; fi
}

variable () {
  file="$1"
  if [ ! -e "$file" ]; then echo "$2" > $1; fi
}

mustset () {
pgclonevars

if [[ "$transport" == "NOT-SET" ]]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 Welcome to PG Clone ~ http://pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
NOTE: PG Clone is a service that automates mergerfs; with mount, rclone,
and key development to mount user drives and move/store data accordingly.
Visit the link above before starting this process!

[1] PG Clone Method: $transport
[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

  read -rp '↘️  Input Selection | Press [ENTER]: ' typed < /dev/tty

  case $typed in
      1 )
          transportselect ;;
      z )
          exit ;;
      Z )
          exit ;;
      * )
          mustset ;;
  esac
fi
}

setthrottleblitz () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: BW Limit Notice        📓 Reference: move.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💬 100MB = 1 Gig Speeds | 1000MB = 10 Gig Speeds - Remember that your
   upload speeds are still limited to your server's max upload connection

EOF
  read -rp '↘️  Type a Speed from 1 - 1000 | Press [ENTER]: ' typed < /dev/tty
  if [[ "$typed" -ge "1" && "$typed" -le "1000" ]]; then echo "$typed" > ${PGBLITZ_DIR}/var/blitz.bw
else setthrottleblitz; fi
}

setthrottlemove () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: BW Limit Notice        📓 Reference: move.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💬 10MB is a safe limit. If exceeding 10MB and uploading straight for
24 hours, an upload ban will be triggered.

EOF
  read -rp '↘️  Type a Speed from 1 - 1000 | Press [ENTER]: ' typed < /dev/tty
  if [[ "$typed" -ge "1" && "$typed" -le "1000" ]]; then echo "$typed" > ${PGBLITZ_DIR}/var/move.bw
else setthrottlemove; fi
}

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


removepgservices () {
  ansible-playbook ${PGBLITZ_DIR}/pgservices.yml
}

readrcloneconfig () {
  touch ${PGBLITZ_DIR}/rclone/blitz.conf
  mkdir -p ${PGBLITZ_DIR}/rclone/

  gdcheck=$(cat ${PGBLITZ_DIR}/rclone/blitz.conf | grep gdrive)
  if [ "$gdcheck" != "" ]; then echo "good" > ${PGBLITZ_DIR}/rclone/gdrive.status && gdstatus="good";
  else echo "bad" > ${PGBLITZ_DIR}/rclone/gdrive.status && gdstatus="bad"; fi

  gccheck=$(cat ${PGBLITZ_DIR}/rclone/blitz.conf | grep "remote = gd:/encrypt")
  if [ "$gccheck" != "" ]; then echo "good" > ${PGBLITZ_DIR}/rclone/gcrypt.status && gcstatus="good";
  else echo "bad" > ${PGBLITZ_DIR}/rclone/gcrypt.status && gcstatus="bad"; fi

  tdcheck=$(cat ${PGBLITZ_DIR}/rclone/blitz.conf | grep sdrive)
  if [ "$tdcheck" != "" ]; then echo "good" > ${PGBLITZ_DIR}/rclone/sdrive.status && tdstatus="good"
  else echo "bad" > ${PGBLITZ_DIR}/rclone/sdrive.status && tdstatus="bad"; fi

}

rcloneconfig () {
  rclone config --config ${PGBLITZ_DIR}/rclone/blitz.conf
}

keysprocessed () {
  mkdir -p ${PGBLITZ_DIR}/var/keys/processed
  ls -1 ${PGBLITZ_DIR}/var/keys/processed | wc -l > ${PGBLITZ_DIR}/var/project.keycount
}

deletemelateron () {
pgclonevars

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 PG Clone Key Management ~ http://pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] Google Account Login   [$pgcloneemail]
[2] Project Name           [$pgcloneproject]
[3] Build Service Keys     [$displaykey]
[4] E-Mail Generator

[A] Keys Backup  ~ NOT READY
[B] Keys Restore ~ NOT READY
[C] Keys Destroy
[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

read -rp '↘️  Input Selection | Press [ENTER]: ' typed < /dev/tty

case $typed in
    1 )
        glogin ;;
    2 )
        projectname ;;
    3 )
        projectnamecheck
        keystart
        gdsaemail ;;
    4 )
        projectnamecheck
        deployblitzstartcheck
        emailgen ;;
    c )
        deletekeys ;;
    C )
        deletekeys ;;
    z )
        clonestart ;;
    Z )
        clonestart ;;
    * )
        clonestart ;;
  esac
clonestart
}
