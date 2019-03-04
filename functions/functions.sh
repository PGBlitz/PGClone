#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

# BAD INPUT
badinput () {
echo
read -p '⛔️ ERROR - Bad Input! | Press [ENTER] ' typed < /dev/tty
}

badinput1 () {
echo
read -p '⛔️ ERROR - Bad Input! | Press [ENTER] ' typed < /dev/tty
question1
}

variable () {
  file="$1"
  if [ ! -e "$file" ]; then echo "$2" > $1; fi
}

clonestartoutput () {
pgclonevars
if [[ "$transport" == "mu" ]]; then
tee <<-EOF
[1] Client ID & Secret: [Fill Me]
[2] GDrive OAuth:       [Fill Me]
EOF
elif [[ "$transport" == "me" ]]; then
tee <<-EOF
[1] Client ID & Secret: [Fill Me]
[2] GDrive OAuth:       [Fill Me]
[3] TDrive OAuth:       [Fill Me]
[4] TDrive Label:       [None]
[5] Passwords:          [Not Set]
EOF
elif [[ "$transport" == "bu" ]]; then
tee <<-EOF
[1] Client ID & Secret: [Fill Me]
[2] GDrive OAuth:       [Fill Me]
[3] TDrive OAuth:       [Fill Me]
[4] TDrive Label:       [None]
[5] Key Management:     [0] Built
EOF
elif [[ "$transport" == "be" ]]; then
tee <<-EOF
[1] Client ID & Secret: [Fill Me]
[2] GDrive OAuth:       [Fill Me]
[3] TDrive OAuth:       [Fill Me]
[4] TDrive Label:       [None]
[5] Passwords:          [Not Set]
[6] Key Management:     [0] Built
EOF
fi
}

clonestart () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 Welcome to PG Clone ~ http://pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
clonestartoutput

tee <<-EOF

[A] Deploy              [PG Move /w No Encryption]
[B] Throttle            [9 MB]
[C] Change              Switch Transport Method
[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -p '↘️  Input Selection | Press [ENTER]: ' typed < /dev/tty
}

removepgservices () {
  ansible-playbook /opt/pgclone/pgservices.yml
}

readrcloneconfig () {
  touch /opt/appdata/plexguide/rclone.conf
  mkdir -p /var/plexguide/rclone/

  gdcheck=$(cat /opt/appdata/plexguide/rclone.conf | grep gdrive)
  if [ "$gdcheck" != "" ]; then echo "good" > /var/plexguide/rclone/gdrive.status && gdstatus="good";
  else echo "bad" > /var/plexguide/rclone/gdrive.status && gdstatus="bad"; fi

  gccheck=$(cat /opt/appdata/plexguide/rclone.conf | grep "remote = gdrive:/encrypt")
  if [ "$gccheck" != "" ]; then echo "good" > /var/plexguide/rclone/gcrypt.status && gcstatus="good";
  else echo "bad" > /var/plexguide/rclone/gcrypt.status && gcstatus="bad"; fi

  tdcheck=$(cat /opt/appdata/plexguide/rclone.conf | grep tdrive)
  if [ "$tdcheck" != "" ]; then echo "good" > /var/plexguide/rclone/tdrive.status && tdstatus="good"
  else echo "bad" > /var/plexguide/rclone/tdrive.status && tdstatus="bad"; fi

}

rcloneconfig () {
  rclone config --config /opt/appdata/plexguide/rclone.conf
}

keysprocessed () {
  mkdir -p /opt/appdata/pgblitz/keys/processed
  ls -1 /opt/appdata/pgblitz/keys/processed | wc -l > /var/plexguide/project.keycount
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

  read -p '↘️  Input Selection | Press [ENTER]: ' typed < /dev/tty

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

pgclonevars () {
  mkdir -p /var/plexguide/rclone
  variable /var/plexguide/project.account "NOT-SET"
  variable /var/plexguide/pgclone.project "NOT-SET"
  variable /var/plexguide/pgclone.teamdrive ""
  variable /var/plexguide/pgclone.public ""
  variable /var/plexguide/pgclone.secret ""
  variable /var/plexguide/rclone/deploy.version "null"
  variable /var/plexguide/pgclone.transport "NOT-SET"
  variable /var/plexguide/gdrive.pgclone "⚠️  Not Activated"
  variable /var/plexguide/tdrive.pgclone "⚠️  Not Activated"
  variable /var/plexguide/move.bw  "9"
  variable /var/plexguide/blitz.bw  "1000"
  variable /var/plexguide/pgclone.password ""
  variable /var/plexguide/pgclone.salt ""

  transport=$(cat /var/plexguide/pgclone.transport)
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

# part of this file / function mustset
transportselect () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 Set PG Clone Method ~ http://pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
NOTE: Please visit the link and understand what your doing first!

[1] Move  Unencrypt: Data > GDrive | Easy    | 750GB Daily Transfer Max
[2] Move  Encrypted: Data > GDrive | Easy    | 750GB Daily Transfer Max
[3] Blitz Unencrypt: Data > TDrive | Complex | Exceed 750GB Transport Cap
[4] Blitz Encrypted: Data > TDrive | Complex | Exceed 750GB Transport Cap
[5] PGDrive Mode   : Read Only     | Novice  | No Upload Data Transfer
[6] Local Edition  : Local HDs     | Simple  | No GDrive/TDrive Usage
[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

read -p '↘️  Input Selection | Press [ENTER]: ' typed < /dev/tty

case $typed in
    1 )
    echo "mu" > /var/plexguide/pgclone.transport ;;
    2 )
    echo "me" > /var/plexguide/pgclone.transport ;;
    3 )
    echo "bu" > /var/plexguide/pgclone.transport ;;
    4 )
    echo "be" > /var/plexguide/pgclone.transport ;;
    5 )
    echo "pd" > /var/plexguide/pgclone.transport ;;
    6 )
    echo "le" > /var/plexguide/pgclone.transport ;;
    z )
        mustset ;;
    Z )
        mustset ;;
    * )
        mustset ;;
esac
}
