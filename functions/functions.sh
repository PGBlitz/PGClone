#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

# BAD INPUT
exitclone() {
  if [[ "$typed" == "exit" || "$typed" == "Exit" || "$typed" == "EXIT" || "$typed" == "z" || "$typed" == "Z" ]]; then clonestart; fi
}

variable() {
  file="$1"
  if [ ! -e "$file" ]; then echo "$2" >$1; fi
}

mustset() {
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

    read -rp '↘️  Input Selection | Press [ENTER]: ' typed </dev/tty

    case $typed in
    1)
      transportselect
      ;;
    z)
      exit
      ;;
    Z)
      exit
      ;;
    *)
      mustset
      ;;
    esac
  fi
}

setthrottleblitz() {
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: BW Limit Notice        📓 Reference: blitz.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💬  This restricts upload bandwidth, useful to prevent network saturation. 
    upload speeds are limited by your server's max upload connection and gdrive limits.

    We recommend setting this between 30-60% of your total server bandwidth,
    as you should reserve bandwidth for streaming.

This change will take effect immediately.

EOF
  read -rp '↘️  Type a Speed from 1 - 1000 | Press [ENTER]: ' typed </dev/tty
  if [[ "$typed" -ge "1" && "$typed" -le "1000" ]]; then
    echo "${typed}M" >/var/plexguide/blitz.bw
  else setthrottleblitz; fi
}

setthrottlemove() {
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: BW Limit Notice        📓 Reference: move.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💬 This restricts upload bandwidth. 

    [9] is default limit to allow up to 750gb a day.
    A higher value is not advised!
    Allowing more than 750gb in 24 hours, will cause a 24 hour ban.

This change will take effect immediately.

EOF
  read -rp '↘️  Type a Speed from 1 - 1000 | Press [ENTER]: ' typed </dev/tty
  if [[ "$typed" -ge "1" && "$typed" -le "1000" ]]; then
    echo "${typed}M" >/var/plexguide/move.bw
  else setthrottlemove; fi
}

rcpiece() {
  tee "/etc/fuse.conf" >/dev/null <<EOF
# /etc/fuse.conf - Configuration file for Filesystem in Userspace (FUSE)
# Set the maximum number of FUSE mounts allowed to non-root users.
# The default is 1000.
#mount_max = 1000
# Allow non-root users to specify the allow_other or allow_root mount options.
user_allow_other
EOF
}

removepgservices() {
  ansible-playbook /opt/pgclone/pgservices.yml
}

readrcloneconfig() {
  touch /opt/appdata/plexguide/rclone.conf
  mkdir -p /var/plexguide/rclone/

  gdcheck=$(cat /opt/appdata/plexguide/rclone.conf | grep gdrive)
  if [ "$gdcheck" != "" ]; then
    echo "good" >/var/plexguide/rclone/gdrive.status && gdstatus="good"
  else echo "bad" >/var/plexguide/rclone/gdrive.status && gdstatus="bad"; fi

  gccheck=$(cat /opt/appdata/plexguide/rclone.conf | grep "remote = gdrive:/encrypt")
  if [ "$gccheck" != "" ]; then
    echo "good" >/var/plexguide/rclone/gcrypt.status && gcstatus="good"
  else echo "bad" >/var/plexguide/rclone/gcrypt.status && gcstatus="bad"; fi

  tdcheck=$(cat /opt/appdata/plexguide/rclone.conf | grep tdrive)
  if [ "$tdcheck" != "" ]; then
    echo "good" >/var/plexguide/rclone/tdrive.status && tdstatus="good"
  else echo "bad" >/var/plexguide/rclone/tdrive.status && tdstatus="bad"; fi

}

rcloneconfig() {
  rclone config --config /opt/appdata/plexguide/rclone.conf
}

keysprocessed() {
  mkdir -p /opt/appdata/plexguide/keys/processed
  ls -1 /opt/appdata/plexguide/keys/processed | wc -l >/var/plexguide/project.keycount
}

deletemelateron() {
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

  read -rp '↘️  Input Selection | Press [ENTER]: ' typed </dev/tty

  case $typed in
  1)
    glogin
    ;;
  2)
    projectname
    ;;
  3)
    projectnamecheck
    keystart
    gdsaemail
    ;;
  4)
    projectnamecheck
    deployblitzstartcheck
    emailgen
    ;;
  c)
    deletekeys
    ;;
  C)
    deletekeys
    ;;
  z)
    clonestart
    ;;
  Z)
    clonestart
    ;;
  *)
    clonestart
    ;;
  esac
  clonestart
}
