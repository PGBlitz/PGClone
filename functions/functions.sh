#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Authors:    Admin9705, Deiteq, and many PGBlitz Contributors
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
💪 Welcome to rClone  
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
NOTE: rClone is a service that automates mergerfs; with mount, rclone,
and key development to mount user drives and move/store data accordingly.
Visit the link above before starting this process!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[1] rClone Method: [ $transport ]

[Z] Exit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

    read -rp '↘️  Input Selection | Press [ENTER]: ' typed </dev/tty

    case $typed in
    1) transportselect ;;
    z) exit ;;
    Z) exit ;;
    *) mustset ;;
    esac
  fi
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
  ansible-playbook /opt/pgclone/ymls/remove.yml
}

keysprocessed() {
  mkdir -p /opt/appdata/plexguide/keys/processed
  ls -1 /opt/appdata/plexguide/keys/processed | wc -l >/var/plexguide/project.keycount
}

ShortNotice() {

    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✔️ Settings have been updated!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    read -rp '↘️  Press [ENTER] to continue ' typed </dev/tty
}
