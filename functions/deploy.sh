#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Authors:    Admin9705, Deiteq, and many PGBlitz Contributors
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
deploypgblitz() {
  deployblitzstartcheck # At Bottom - Ensure Keys Are Made

  # RCLONE BUILD
  echo "#------------------------------------------" >/opt/appdata/plexguide/rclone.conf
  echo "#PGClone| Visit https://pgblitz.com" >>/opt/appdata/plexguide/rclone.conf
  echo "#------------------------------------------" >>/opt/appdata/plexguide/rclone.conf

  cat /opt/appdata/plexguide/.gdrive >>/opt/appdata/plexguide/rclone.conf

  if [[ $(cat "/opt/appdata/plexguide/.gcrypt") != "NOT-SET" ]]; then
    echo ""
    cat /opt/appdata/plexguide/.gcrypt >>/opt/appdata/plexguide/rclone.conf
  fi

  cat /opt/appdata/plexguide/.tdrive >>/opt/appdata/plexguide/rclone.conf

  if [[ $(cat "/opt/appdata/plexguide/.tcrypt") != "NOT-SET" ]]; then
    echo ""
    cat /opt/appdata/plexguide/.tcrypt >>/opt/appdata/plexguide/rclone.conf
  fi

  cat /opt/appdata/plexguide/.keys >>/opt/appdata/plexguide/rclone.conf

  deploydrives
}

deploypgmove() {
  # RCLONE BUILD
  echo "#------------------------------------------" >/opt/appdata/plexguide/rclone.conf
  echo "#PGClone| Visit https://pgblitz.com" >>/opt/appdata/plexguide/rclone.conf
  echo "#------------------------------------------" >>/opt/appdata/plexguide/rclone.conf

  cat /opt/appdata/plexguide/.gdrive >/opt/appdata/plexguide/rclone.conf

  if [[ $(cat "/opt/appdata/plexguide/.gcrypt") != "NOT-SET" ]]; then
    echo ""
    cat /opt/appdata/plexguide/.gcrypt >>/opt/appdata/plexguide/rclone.conf
  fi
  deploydrives
}

deploydrives() {
  fail=0
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Conducting RClone Mount Checks ~ pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

  if [ -e "/var/plexguide/.drivelog" ]; then rm -rf /var/plexguide/.drivelog; fi
  touch /var/plexguide/.drivelog
  transport=$(cat /var/plexguide/pgclone.transport)

  if [[ "$transport" == "mu" ]]; then
    gdrivemod
    multihdreadonly
  elif [[ "$transport" == "me" ]]; then
    gdrivemod
    gcryptmod
    multihdreadonly
  elif [[ "$transport" == "bu" ]]; then
    gdrivemod
    tdrivemod
    gdsamod
    multihdreadonly
  elif [[ "$transport" == "be" ]]; then
    gdrivemod
    tdrivemod
    gdsamod
    gcryptmod
    tcryptmod
    gdsacryptmod
    multihdreadonly
  fi

  cat /var/plexguide/.drivelog
  logcheck=$(cat /var/plexguide/.drivelog | grep "Failed")

  if [[ "$logcheck" == "" ]]; then

    if [[ "$transport" == "mu" || "$transport" == "me" ]]; then executemove; fi
    if [[ "$transport" == "bu" || "$transport" == "be" ]]; then executeblitz; fi

  else

    if [[ "$transport" == "me" || "$transport" == "be" ]]; then
      emessage="
  NOTE1: User forgot to share out GDSA E-Mail to Team Drive
  NOTE2: Conducted a blitz key restore and keys are no longer valid
  "
    fi

    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 RClone Mount Checks - Failed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

CANNOT DEPLOY!

POSSIBLE REASONS:
1. GSuite Account is no longer valid or suspended
2. Client ID and/or Secret are invalid and/or no longer exist
$emessage
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    read -p '↘️  Acknowledge Info | Press [ENTER] ' typed2 </dev/tty
    clonestart
  fi
}

########################################################################################
gdrivemod() {
  initial=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf gdrive: | grep -oP plexguide | head -n1)

  if [[ "$initial" != "plexguide" ]]; then
    rclone mkdir --config /opt/appdata/plexguide/rclone.conf gdrive:/plexguide
    initial=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf gdrive: | grep -oP plexguide | head -n1)
  fi

  if [[ "$initial" == "plexguide" ]]; then echo "GDRIVE :  Passed" >>/var/plexguide/.drivelog; else echo "GDRIVE :  Failed" >>/var/plexguide/.drivelog; fi
}
tdrivemod() {
  initial=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf tdrive: | grep -oP plexguide | head -n1)

  if [[ "tinitial" != "plexguide" ]]; then
    rclone mkdir --config /opt/appdata/plexguide/rclone.conf gdrive:/plexguide
    initial=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf tdrive: | grep -oP plexguide | head -n1)
  fi

  if [[ "$initial" == "plexguide" ]]; then echo "TDRIVE :  Passed" >>/var/plexguide/.drivelog; else echo "TDRIVE :  Failed" >>/var/plexguide/.drivelog; fi
}
gcryptmod() {
  c1initial=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf gdrive: | grep -oP encrypt | head -n1)
  c2initial=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf gcrypt: | grep -oP plexguide | head -n1)

  if [[ "$c1initial" != "encrypt" ]]; then
    rclone mkdir --config /opt/appdata/plexguide/rclone.conf gdrive:/encrypt
    c1initial=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf gdrive: | grep -oP encrypt | head -n1)
  fi
  if [[ "$c2initial" != "plexguide" ]]; then
    rclone mkdir --config /opt/appdata/plexguide/rclone.conf gcrypt:/plexguide
    c2initial=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf gcrypt: | grep -oP plexguide | head -n1)
  fi

  if [[ "$c1initial" == "encrypt" ]]; then echo "GCRYPT1:  Passed" >>/var/plexguide/.drivelog; else echo "GCRYPT1:  Failed" >>/var/plexguide/.drivelog; fi
  if [[ "$c2initial" == "plexguide" ]]; then echo "GCRYPT2:  Passed" >>/var/plexguide/.drivelog; else echo "GCRYPT2:  Failed" >>/var/plexguide/.drivelog; fi
}
tcryptmod() {
  c1initial=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf tdrive: | grep -oP encrypt | head -n1)
  c2initial=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf tcrypt: | grep -oP plexguide | head -n1)

  if [[ "$c1initial" != "encrypt" ]]; then
    rclone mkdir --config /opt/appdata/plexguide/rclone.conf tdrive:/encrypt
    c1initial=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf tdrive: | grep -oP encrypt | head -n1)
  fi
  if [[ "$c2initial" != "plexguide" ]]; then
    rclone mkdir --config /opt/appdata/plexguide/rclone.conf tcrypt:/plexguide
    c2initial=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf tcrypt: | grep -oP plexguide | head -n1)
  fi

  if [[ "$c1initial" == "encrypt" ]]; then echo "TCRYPT1:  Passed" >>/var/plexguide/.drivelog; else echo "TCRYPT1:  Failed" >>/var/plexguide/.drivelog; fi
  if [[ "$c2initial" == "plexguide" ]]; then echo "TCRYPT2:  Passed" >>/var/plexguide/.drivelog; else echo "TCRYPT2:  Failed" >>/var/plexguide/.drivelog; fi
}
gdsamod() {
  initial=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf GDSA01: | grep -oP plexguide | head -n1)

  if [[ "$initial" != "plexguide" ]]; then
    rclone mkdir --config /opt/appdata/plexguide/rclone.conf GDSA01:/plexguide
    initial=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf GDSA01: | grep -oP plexguide | head -n1)
  fi

  if [[ "$initial" == "plexguide" ]]; then echo "GDSA01 :  Passed" >>/var/plexguide/.drivelog; else echo "GDSA01 :  Failed" >>/var/plexguide/.drivelog; fi
}
gdsacryptmod() {
  initial=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf GDSA01C: | grep -oP encrypt | head -n1)

  if [[ "$initial" != "plexguide" ]]; then
    rclone mkdir --config /opt/appdata/plexguide/rclone.conf GDSA01C:/plexguide
    initial=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf GDSA01C: | grep -oP plexguide | head -n1)
  fi

  if [[ "$initial" == "plexguide" ]]; then echo "GDSA01C:  Passed" >>/var/plexguide/.drivelog; else echo "GDSA01C:  Failed" >>/var/plexguide/.drivelog; fi
}
################################################################################
deployblitzstartcheck() {

  pgclonevars
  if [[ "$displaykey" == "0" ]]; then
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔ Fail Notice ~ pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💬  There are [0] keys generated for PG Blitz! Create those first!

NOTE: Without any keys, PG Blitz cannot upload any data without the use
of service accounts

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

    read -p '↘️  Acknowledge Info | Press [ENTER] ' typed </dev/tty
    clonestart
  fi
}
################################################################################
cleanlogs() {
  echo "Prune service logs..."
  journalctl --flush
  journalctl --rotate
  journalctl --vacuum-time=1s
  truncate -s 0 /var/plexguide/logs/*.log
}

prunedocker() {
  echo "Prune docker images and volumes..."
  docker system prune --volumes -f
}
################################################################################
createmountfolders() {
  mkdir /mnt/gdrive -p
  mkdir /mnt/tdrive -p
  mkdir /mnt/gcrypt -p
  mkdir /mnt/tcrypt -p

  chown 1000:1000 -R /mnt/gdrive >/dev/null
  chown 1000:1000 -R /mnt/tdrive >/dev/null
  chown 1000:1000 -R /mnt/gcrypt >/dev/null
  chown 1000:1000 -R /mnt/tcrypt >/dev/null
  chmod 755 -R /mnt/gdrive >/dev/null
  chmod 755-R /mnt/tdrive >/dev/null
  chmod 755 -R /mnt/gcrypt >/dev/null
  chmod 755 -R /mnt/tcrypt >/dev/null
}

cleanmounts() {
  echo "Unmount drives..."
  fusermount -uzq /mnt/gdrive >/dev/null
  fusermount -uzq /mnt/tdrive >/dev/null
  fusermount -uzq /mnt/gcrypt >/dev/null
  fusermount -uzq /mnt/tcrypt >/dev/null
  fusermount -uzq /mnt/unionfs >/dev/null
  pkill -f rclone* >/dev/null

  echo "checking for empty mounts..."

  mount="/mnt/unionfs/"
  cleanmount

  mount="/mnt/gdrive/"
  cleanmount

  mount="/mnt/tdrive/"
  cleanmount

  mount="/mnt/gcrypt/"
  cleanmount

  mount="/mnt/tcrypt/"
  cleanmount

}

cleanmount() {
  maxsize=1000000

  if [ -d "$mount" ]; then
    echo "Checking if $mount is not empty when unmounted..."
    if [[ "$(ls -a "$mount" | wc -l)" -ne 2 && "$(ls -a "$mount" | wc -l)" -ne 0 ]]; then

      if [[ "$(du -s "$mount" | cut -f1 | bc -l | rev | cut -c 2- | rev)" -lt $maxsize ]]; then
        echo "$mount is not empty when unmounted, fixing..."
        rsync -aq "$mount" /mnt/move/
        rm -rf "$mount"*
      else
        failclean
      fi
    fi
  fi
}

failclean() {
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔ Failure during $mount unmount ~ pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

There was a problem unmounting $mount. Please reboot your server and try
a redeploy of PGClone again. If this problem persists after a reboot, join
discord and ask for help.

⚠ Warning: Your apps have been stopped to prevent data loss. Please reboot
and redepoy PGClone to fix.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  read -p '↘️  Acknowledge Info | Press [ENTER] ' typed </dev/tty

  exit
}

restartapps() {
  echo "restarting apps..."
  docker restart $(docker ps -a -q) >/dev/null
}

deployFail() {
  # output final display

  if [[ "$transport" == "bu" ]]; then
    finaldeployoutput="Blitz"
  fi
  if [[ "$transport" == "be" ]]; then
    finaldeployoutput="Blitz: Encrypted"
  fi

  if [[ "$transport" == "mu" ]]; then
    finaldeployoutput="Move"
  fi
  if [[ "$transport" == "me" ]]; then
    finaldeployoutput="Move: Encrypted"
  fi

  erroroutput="$(journalctl -u gdrive -u gcrypt -u pgunion -u pgmove -b -q -p 6 --no-tail -e --no-pager --since "5 minutes ago" -n 20)"
  logoutput="$(tail -n 20 /var/plexguide/logs/*.log)"
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔ DEPLOY FAILED: $finaldeployoutput
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

An error has occurred when deploying PGClone.
Your apps are currently stopped to prevent data loss.

Things to try: If you just finished the initial setup, you likely made a typo
or other error when configuring PGClone. Please redo the pgclone config first
before reporting an issue.

If this issue still persists:
Please share this error on discord or the forums before proceeding.

If there error says the mount is not empty, then you need to reboot your
server and redeploy PGClone to fix.

Error details: 
$erroroutput
$logoutput

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔ DEPLOY FAILED: $finaldeployoutput
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  read -rp '↘️  Acknowledge Info | Press [ENTER] ' typed </dev/tty
  exit

}
deploySuccess() {

  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 DEPLOYED: $finaldeployoutput
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

PGClone has been deployed sucessfully!
All services are active and running normally.

EOF
  read -rp '↘️  Acknowledge Info | Press [ENTER] ' typed </dev/tty
}

buildrcloneenv() {
  uagent="$(cat /var/plexguide/uagent)"
  vfs_ll="$(cat /var/plexguide/vfs_ll)"
  vfs_bs="$(cat /var/plexguide/vfs_bs)"
  vfs_rcs="$(cat /var/plexguide/vfs_rcs)"
  vfs_rcsl="$(cat /var/plexguide/vfs_rcsl)"
  vfs_cma="$(cat /var/plexguide/vfs_cma)"
  vfs_cm="$(cat /var/plexguide/vfs_cm)"
  vfs_cms="$(cat /var/plexguide/vfs_cms)"
  vfs_dct="$(cat /var/plexguide/vfs_dct)"
  vfs_t="$(cat /var/plexguide/vfs_t)"
  vfs_mt="$(cat /var/plexguide/vfs_mt)"
  vfs_c="$(cat /var/plexguide/vfs_c)"

  echo "uagent=$uagent" >/opt/appdata/plexguide/rclone.env
  echo "vfs_ll=$vfs_ll" >>/opt/appdata/plexguide/rclone.env
  echo "vfs_bs=$vfs_bs" >>/opt/appdata/plexguide/rclone.env
  echo "vfs_rcs=$vfs_rcs" >>/opt/appdata/plexguide/rclone.env
  echo "vfs_rcsl=$vfs_rcsl" >>/opt/appdata/plexguide/rclone.env
  echo "vfs_cm=$vfs_cm" >>/opt/appdata/plexguide/rclone.env
  echo "vfs_cma=$vfs_cma" >>/opt/appdata/plexguide/rclone.env
  echo "vfs_cms=$vfs_cms" >>/opt/appdata/plexguide/rclone.env
  echo "vfs_dct=$vfs_dct" >>/opt/appdata/plexguide/rclone.env
  echo "vfs_t=$vfs_t" >>/opt/appdata/plexguide/rclone.env
  echo "vfs_mt=$vfs_mt" >>/opt/appdata/plexguide/rclone.env
  echo "vfs_c=$vfs_c" >>/opt/appdata/plexguide/rclone.env
}
