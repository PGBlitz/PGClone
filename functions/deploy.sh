#!/bin/bash
#
# Title:      Docker Uploader 
# Author(s):  PhyskX
# CoAuthot:   MrDoob
# GNU:        General Public License v3.0
################################################################################
deploypgblitz() {
  deployblitzstartcheck 
  # At Bottom - Ensure Keys Are Made
  # RCLONE BUILD
  echo "#------------------------------------------" >/opt/appdata/plexguide/rclone.conf
  echo "# rClone.config created over rclone " >>/opt/appdata/plexguide/rclone.conf
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
  echo "# rClone.config created over rclone"  >>/opt/appdata/plexguide/rclone.conf
  echo "#------------------------------------------" >>/opt/appdata/plexguide/rclone.conf
  cat /opt/appdata/plexguide/.gdrive >/opt/appdata/plexguide/rclone.conf
  if [[ $(cat "/opt/appdata/plexguide/.gcrypt") != "NOT-SET" ]]; then
    echo ""
    cat /opt/appdata/plexguide/.gcrypt >>/opt/appdata/plexguide/rclone.conf
  fi
  deploydrives
}
removeoldui() {
UI=$(docker ps --format '{{.Names}}' | grep "pgui")
if [[ "$UI" == "pgui" ]]; then 
   docker stop pgui
   docker rm pgui
   rm -rf /opt/appdata/pgui/
fi
}
deploymounts() {
dmounts=$(docker ps --format '{{.Names}}' | grep "mounts")
if [[ "$dmounts" != "mounts" ]]; then
   ddmounts
else ddmountsredeploy; fi
}
ddmounts() {
	tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	🚀      Deploy of Docker Mounts
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	EOF
    removeoldui
	cleanlogs
	ansible-playbook /opt/pgclone/ymls/mounts.yml
  read -rp '↘️  Acknowledge Info | Press [ENTER] ' typed </dev/tty
  tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	💪     DEPLOYED sucessfully !
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
     The Mounts is under
     https://mounts.${domain}
     or
     http://${ip}:7755
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
    read -p '↘️  Acknowledge Info | Press [ENTER] ' typed2 </dev/tty
    clonestart
}
ddmountsredeploy() {
	tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	🚀      Redeploy of Docker Mounts
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	EOF
  read -rp '↘️  Acknowledge Info | Press [ENTER] ' typed </dev/tty
  removeoldui
  cleanlogs
  ansible-playbook /opt/pgclone/ymls/mounts.yml
  sleep 10
domain=$(cat /var/plexguide/server.domain)
ip=$(cat /var/plexguide/server.ip)
  tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	💪     DEPLOYED sucessfully !
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
     The Mounts is under
     https://mounts.${domain}
     or
     http://${ip}:7755
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
    read -p '↘️  Acknowledge Info | Press [ENTER] ' typed2 </dev/tty
    clonestart
}


### Docker Uploader Deploy start ##
deploydockermount() {
UI=$(docker ps --format '{{.Names}}' | grep "mounts")
if [[ "$UI" != "mounts" ]]; then 
nounionrunning
else deploymounts; fi
}
norcloneconf() {
rcc=/opt/appdata/plexguide/rclone.conf
if [[ ! -f "$rcc" ]]; then
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔ Fail Notice for deploy of Docker Mounts
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

 Sorry we can't  Deploy the Docker Mounts.
 we cant find any rclone.conf 

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔ Fail Notice for deploy of Docker Mounts 
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  read -rp '↘️  Acknowledge Info | Press [ENTER] ' typed </dev/tty
clonestart
fi
}
nounionrunning() {
rcc=/opt/appdata/plexguide/rclone.conf
if [[ ! -f "$rcc" ]]; then
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔ Fail Notice for deploy of Docker Uploader
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

 Sorry we can't  Deploy the Docker Uploader.
 No docker mounts are running , 
 please deploy first the docker mounts.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔ Fail Notice for deploy of Docker Uploader 
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  read -rp '↘️  Acknowledge Info | Press [ENTER] ' typed </dev/tty
clonestart
fi
}
deploydocker() {
upper=$(docker ps --format '{{.Names}}' | grep "uploader")
if [[ "$upper" != "uploader" ]]; then
   dduploader
else ddredeploy; fi
}
dduploader() {
	tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	🚀      Deploy of Docker Uploader
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	EOF
    removeoldui
	cleanlogs
	ansible-playbook /opt/pgclone/ymls/uploader.yml
  read -rp '↘️  Acknowledge Info | Press [ENTER] ' typed </dev/tty
  tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	💪     DEPLOYED sucessfully !
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
     The Uploader is under
     https://uploader.${domain}
     or
     http://${ip}:7777
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
    read -p '↘️  Acknowledge Info | Press [ENTER] ' typed2 </dev/tty
    clonestart
}
ddredeploy() {
	tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	🚀      Redeploy of Docker Uploader
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	EOF
  read -rp '↘️  Acknowledge Info | Press [ENTER] ' typed </dev/tty
  removeoldui
  cleanlogs
  ansible-playbook /opt/pgclone/ymls/uploader.yml
  sleep 10
domain=$(cat /var/plexguide/server.domain)
ip=$(cat /var/plexguide/server.ip)
  tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	💪     DEPLOYED sucessfully !
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
     The Uploader is under
     https://uploader.${domain}
     or
     http://${ip}:7777
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
    read -p '↘️  Acknowledge Info | Press [ENTER] ' typed2 </dev/tty
    clonestart
}
### Docker Uploader Deploy end ##
deploydrives() {
  fail=0
  tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Conducting RClone Mount Checks
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
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
doneokay() {
 echo
  read -p 'Confirm Info | PRESS [ENTER] ' typed </dev/tty
}
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
⛔ Fail Notice
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💬  There are [0] keys generated for Blitz! Create those first!

NOTE: 

Without any keys, Blitz cannot upload any data without the use
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
restartapps() {
  echo "restarting apps..."
  docker restart $(docker ps -a -q) >/dev/null
}
deploySuccess() {
domain=$(cat /var/plexguide/server.domain)
ip=$(cat /var/plexguide/server.ip)
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 DEPLOYED: $finaldeployoutput
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

rClone has been deployed sucessfully!
All services are active and running normally.

The Uploader is under

     https://uploader.${domain}

     or

     http://${ip}:7777

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  read -rp '↘️  Acknowledge Info | Press [ENTER] ' typed </dev/tty
}
deploymountSuccess() {
domain=$(cat /var/plexguide/server.domain)
ip=$(cat /var/plexguide/server.ip)
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 DEPLOYED: $finaldeployoutput
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

rClone has been deployed sucessfully!
All services are active and running normally.

The Uploader is under

     https://mounts.${domain}

     or

     http://${ip}:7755

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  read -rp '↘️  Acknowledge Info | Press [ENTER] ' typed </dev/tty
}