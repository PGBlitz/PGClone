#!/bin/bash
# Title:      PGBlitz (Reference Title File)
# Authors:    Admin9705, Deiteq, and many PGBlitz Contributors
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
defaultvars() {
  touch /var/plexguide/rclone.gdrive
  touch /var/plexguide/rclone.gcrypt
}

# FOR START DEPLOYMENT END #####################################################

deploygcryptcheck() {
  type=gcrypt
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Conducting Validation Checks - $type
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  sleep 1
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Creating Test Directory - $type:/plexguide
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  sleep 1
  rclone mkdir --config /opt/appdata/plexguide/rclone.conf $type:/plexguide
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Checking Existance of $type:/plexguide
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  rcheck=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf $type: | grep -oP plexguide | head -n1)

  if [ "$rcheck" != "plexguide" ]; then
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔  System Message: Validation Checks Failed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

TIPS:
[ 1. ] Did you set up your gcrypt accordingly to the wiki?

[ 2. ] Did you ensure that the gcrypt overlapped on gdrive per the wiki?

EOF
    read -p '↘️  Acknowledge Info | Press [ENTER] ' typed2 </dev/tty
    question1
  else
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Validation Checks Passed - $type
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

  fi
}

deploygdrivecheck() {
  type=gdrive
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Conducting Validation Checks - $type
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  sleep 1
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Creating Test Directory - $type:/plexguide
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  sleep 1
  rclone mkdir --config /opt/appdata/plexguide/rclone.conf $type:/plexguide
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Checking Existance of $type:/plexguide
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  rcheck=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf $type: | grep -oP plexguide | head -n1)

  if [ "$rcheck" != "plexguide" ]; then
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔  System Message: Validation Checks Failed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

TIPS:
[ 1. ] Did you set up your $type accordingly to the wiki?

EOF
    read -p '↘️  Acknowledge Info | Press [ENTER] ' typed2 </dev/tty
    question1
  else
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Validation Checks Passed - $type
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

  fi
}

deploytdrivecheck() {
  type=tdrive
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Conducting Validation Checks - $type
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  sleep 1
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Creating Test Directory - $type:/plexguide
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  sleep 1
  rclone mkdir --config /opt/appdata/plexguide/rclone.conf $type:/plexguide
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Checking Existance of $type:/plexguide
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  rcheck=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf $type: | grep -oP plexguide | head -n1)

  if [ "$rcheck" != "plexguide" ]; then
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔  System Message: Validation Checks Failed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

TIPS:
[ 1. ] Did you set up your $type accordingly to the wiki?

EOF
    read -p '↘️  Acknowledge Info | Press [ENTER] ' typed2 </dev/tty
    question1
  else
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Validation Checks Passed - $type
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

  fi
}

deploygdsa01check() {
  type=GDSA01
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Conducting Validation Checks - $type
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  sleep 1
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Creating Test Directory - $type:/plexguide
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  sleep 1
  rclone mkdir --config /opt/appdata/plexguide/rclone.conf $type:/plexguide
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Checking Existance of $type:/plexguide
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  rcheck=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf $type: | grep -oP plexguide | head -n1)

  if [ "$rcheck" != "plexguide" ]; then
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔  System Message: Validation Checks Failed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

TIPS:
[ 1. ] Did you set up your keys and share out your emails per the blitz wiki?

EOF
    read -p '↘️  Acknowledge Info | Press [ENTER] ' typed2 </dev/tty
    question1
  else
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Validation Checks Passed - $type
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

  fi
}
# FOR FINAL DEPLOYMENT END #####################################################

tdrivecheck() {
  type=tdrive
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Conducting Validation Checks - $type
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  sleep 1
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Creating Test Directory - $type:/plexguide
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  sleep 1
  rclone mkdir --config /opt/appdata/plexguide/rclone.conf $type:/plexguide
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Checking Existance of $type:/plexguide
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  rcheck=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf $type: | grep -oP plexguide | head -n1)

  if [ "$rcheck" != "plexguide" ]; then
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔  System Message: Validation Checks Failed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

TIPS:
[ 1. ] Did you copy your username and password correctly?
[ 2. ] When you created the credentials, did you select "Other"?
[ 3. ] Did you enable your API?

EOF
    echo "Not Active" >/var/plexguide/gdrive.pgclone
    read -p '↘️  Acknowledge Info | Press [ENTER] ' typed2 </dev/tty
    question1
  else
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Validation Checks Passed - $type
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

  fi
  read -p '↘️  Acknowledge Info | Press [ENTER] ' typed2 </dev/tty
  EOF
}

deletekeys2() {
  choicedel=$(cat /var/plexguide/gdsa.cut)
  if [ "$choicedel" != "" ]; then
    echo ""
    echo "Deleting All Previous Service Accounts & Keys!"
    echo ""

    while read p; do
      gcloud iam service-accounts delete $p --quiet
    done </var/plexguide/gdsa.cut

    rm -rf /opt/appdata/plexguide/keys/processed/* 1>/dev/null 2>&1
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 SYSTEM MESSAGE: Prior Service Accounts & Keys Deleted
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    sleep 2
    keymenu
  else
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 SYSTEM MESSAGE: No Prior Service Accounts or Keys!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    sleep 2
  fi
  question1
}

deletekeys() {
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 ID: Key Gen Information
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  gcloud iam service-accounts list --filter="GDSA" >/var/plexguide/gdsa.list
  cat /var/plexguide/gdsa.list | awk '{print $2}' | tail -n +2 >/var/plexguide/gdsa.cut
  cat /var/plexguide/gdsa.cut
  tee <<-EOF

Items listed are all service accounts that have been created! Proceeding
onward will destroy all service accounts and current keys!

EOF
  read -p '🌍 Proceed? y or n | Press [ENTER]: ' typed </dev/tty

  if [[ "$typed" == "Y" || "$typed" == "y" ]]; then
    deletekeys2
  elif [[ "$typed" == "N" || "$typed" == "n" ]]; then
    question1
  else
    badinput
    deletekeys
  fi
}
gdsabuild() {
  ## what sets if encrypted is on or not
  downloadpath=$(cat /var/plexguide/server.hd.path)
  tempbuild=$(cat /var/plexguide/json.tempbuild)
  path=/opt/appdata/plexguide/keys
  rpath=/opt/appdata/plexguide/rclone.conf
  tdrive=$(cat /opt/appdata/plexguide/rclone.conf | grep team_drive | head -n1)
  tdrive="${tdrive:13}"

  if [[ "$(cat /var/plexguide/pgclone.transport)" == "be" ]]; then
    # PASSWORD=$(cat /var/plexguide/pgclone.password)
    # SALT=$(cat /var/plexguide/pgclone.salt)
    ENC_PASSWORD=$(rclone obscure "$(cat /var/plexguide/pgclone.password)")
    ENC_SALT=$(rclone obscure "$(cat /var/plexguide/pgclone.salt)")

    mkdir -p $downloadpath/move/$tempbuild
    echo "" >>$rpath
    echo "[$tempbuild]" >>$rpath
    echo "type = drive" >>$rpath
    echo "client_id =" >>$rpath
    echo "client_secret =" >>$rpath
    echo "scope = drive" >>$rpath
    echo "root_folder_id =" >>$rpath
    echo "service_account_file = /opt/appdata/plexguide/keys/processed/$tempbuild" >>$rpath
    echo "team_drive = $tdrive" >>$rpath

    echo "" >>$rpath
    echo "[${tempbuild}C]" >>$rpath
    echo "type = crypt" >>$rpath
    echo "remote = $tempbuild:/encrypt" >>$rpath
    echo "filename_encryption = standard" >>$rpath
    echo "directory_name_encryption = true" >>$rpath
    echo "password = $ENC_PASSWORD" >>$rpath
    echo "password2 = $ENC_SALT" >>$rpath
  fi
  
  if [[ "$(cat /var/plexguide/pgclone.transport)" == "bu" ]]; then
  ####tempbuild is need in order to call the correct gdsa
    mkdir -p $downloadpath/move/$tempbuild
    echo "" >>$rpath
    echo "[$tempbuild]" >>$rpath
    echo "type = drive" >>$rpath
    echo "client_id =" >>$rpath
    echo "client_secret =" >>$rpath
    echo "scope = drive" >>$rpath
    echo "root_folder_id =" >>$rpath
    echo "service_account_file = /opt/appdata/plexguide/keys/processed/$tempbuild" >>$rpath
    echo "team_drive = $tdrive" >>$rpath
  fi

}
deploykeys3() {
 kread=$(gcloud --account=${pgcloneemail} iam service-accounts list | awk '{print $1}' | tail -n +2 | cut -c7- | cut -f1 -d "?" | sort | uniq | head -n 1 >/var/plexguide/.gcloudposs)
 keyposs=$(cat /var/plexguide/.gcloudposs )

FIRSTV=$keyposs
SECONDV=1
keysposscount=$(expr $FIRSTV - $SECONDV)
#echo $keysposscount

  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 SYSTEM MESSAGE: Key Number Selection! (From 6 thru 20 )
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
QUESTION - Create how many keys for TDrive? 

MATH:
Min  6 Keys = 4.5TB Daily
Max 20 Keys = 15 TB Daily

Possible $keysposscount before you hit the 100 SAC's

NOTE 1: Creating more keys DOES NOT SPEED up your transfers
NOTE 2: Realistic key generation for most are 6 - 8 keys
NOTE 3: maximum of SAC is 100 , remove unused keys !!

💬 # of Keys Generated Sets Your Daily Upload Limit!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  read -p '↘️  Type a Number [ 1 thru 20 ] | Press [ENTER]: ' typed </dev/tty

  num=$typed
  echo ""
 if [[ "$typed" -le "6" || "$typed" -ge "21" ]]; then
    echo "Creating $typed Keys" && keys=$typed
  fi
  sleep 2
  echo ""
   if [[ "$typed" -le "0" || "$typed" -ge "21" ]]; then deploykeys3; fi
  num=$keys
  count=0
  project=$(cat /var/plexguide/pgclone.project)

  ##wipe previous keys stuck there
  mkdir -p /opt/appdata/plexguide/keys/processed/
  rm -rf /opt/appdata/plexguide/keys/processed/* 1>/dev/null 2>&1

  ## purpose of the rewrite is to save gdrive and tdrive info and toss old GDSAs
  cat /opt/appdata/plexguide/rclone.conf | grep -w "\[tdrive\]" -A 5 >/opt/appdata/plexguide/tdrive.info
  cat /opt/appdata/plexguide/rclone.conf | grep -w "\[gdrive\]" -A 4 >/opt/appdata/plexguide/gdrive.info
  cat /opt/appdata/plexguide/rclone.conf | grep -w "\[tcrypt\]" -A 6 >/opt/appdata/plexguide/tcrypt.info
  cat /opt/appdata/plexguide/rclone.conf | grep -w "\[gcrypt\]" -A 6 >/opt/appdata/plexguide/gcrypt.info

  echo "#### rclone rewrite generated by rClone" >/opt/appdata/plexguide/rclone.conf
  echo "" >>/opt/appdata/plexguide/rclone.conf
  echo "" >>/opt/appdata/plexguide/rclone.conf
  cat /opt/appdata/plexguide/gdrive.info >>/opt/appdata/plexguide/rclone.conf
  echo "" >>/opt/appdata/plexguide/rclone.conf
  cat /opt/appdata/plexguide/tdrive.info >>/opt/appdata/plexguide/rclone.conf
  echo "" >>/opt/appdata/plexguide/rclone.conf
  cat /opt/appdata/plexguide/tcrypt.info >>/opt/appdata/plexguide/rclone.conf
  echo "" >>/opt/appdata/plexguide/rclone.conf
  cat /opt/appdata/plexguide/gcrypt.info >>/opt/appdata/plexguide/rclone.conf

  while [ "$count" != "$keys" ]; do
    ((count++))
    rand=$(echo $((1 + RANDOM * RANDOM)))

    if [ "$count" -ge 1 -a "$count" -le 9 ]; then
      gcloud iam service-accounts create gdsa$rand --display-name “gdsa0$count”
      gcloud iam service-accounts keys create /opt/appdata/plexguide/keys/processed/gdsa0$count --iam-account gdsa$rand@$project.iam.gserviceaccount.com --key-file-type="json"
      echo "gdsa0$count" >/var/plexguide/json.tempbuild
      gdsabuild
      echo ""
    else
      gcloud iam service-accounts create gdsa$rand --display-name “gdsa$count”
      gcloud iam service-accounts keys create /opt/appdata/plexguide/keys/processed/gdsa$count --iam-account gdsa$rand@$project.iam.gserviceaccount.com --key-file-type="json"
      echo "gdsa$count" >/var/plexguide/json.tempbuild
      gdsabuild
      echo ""
    fi
  done

  echo "no" >/var/plexguide/project.deployed

  tee <<-EOF
  
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 SYSTEM MESSAGE: Key Generation Complete!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💬 Use the E-Mail Generator Next! Do Not Forget!

EOF
  read -p '↘️  Acknowledge Info | Press [ENTER] ' typed </dev/tty
}

deploykeys2() {
  deploykeys3
}

deploykeys() {
  gcloud iam service-accounts list --filter="gdsa" >/var/plexguide/gdsa.list
  cat /var/plexguide/gdsa.list | awk '{print $2}' | tail -n +2 >/var/plexguide/gdsa.cut
  deploykeys2
}

projectid() {
  # gcloud projects list >/var/plexguide/projects.list
  gcloud projects list | cut -d' ' -f1 | tail -n +2 >/var/plexguide/project.cut
  projectlist=$(gcloud projects list | cut -d' ' -f1 | tail -n +2)
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Projects Interface Menu
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

$projectlist

EOF

  read -p '↘️  Type EXACT Project Name to Utilize | Press [ENTER]: ' typed2 </dev/tty
  list=$(cat /var/plexguide/project.cut | grep $typed2)
  if [ "$list" == "" ]; then
    badinput && projectid
  fi
  gcloud config set project $typed2
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Standby - Enabling Your API
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  gcloud services enable drive.googleapis.com --project $typed2
  echo $typed2 >/var/plexguide/project.final
  echo
  read -p '🌍 Process Complete | Press [ENTER] ' typed2 </dev/tty

}

ufsbuilder() {
  downloadpath=$(cat /var/plexguide/server.hd.path)
  ls -la /opt/appdata/plexguide/keys/processed | awk '{ print $9}' | tail -n +4 >/tmp/pg.gdsa.ufs
  rm -rf /tmp/pg.gdsa.build 1>/dev/null 2>&1

  encryption="off"
  ##### Encryption Portion ### END
  file="/var/plexguide/unionfs.pgpath"
  if [ -e "$file" ]; then rm -rf /var/plexguide/unionfs.pgpath && touch /var/plexguide/unionfs.pgpath; fi

  while read p; do
    mkdir -p $downloadpath/move/$p
    echo -n "$downloadpath/move/$p=RO:" >>/var/plexguide/unionfs.pgpath
  done </tmp/pg.gdsa.ufs
  builder=$(cat /var/plexguide/unionfs.pgpath)
}

blitzchecker() {
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Conducting RClone Validation Checks
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  sleep 1
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Creating Test Directory - GDSA01:/plexguide
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  sleep 1
  rclone mkdir --config /opt/appdata/plexguide/rclone.conf GDSA01:/plexguide
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Checking Existance of GDSA01:/plexguide
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  rcheck=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf GDSA01: | grep -oP plexguide | head -n1)

  if [ "$rcheck" != "plexguide" ]; then
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: RClone Validation Check Failed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

TIPS:
1. Did you share out your emails to your teamdrives?

EOF
    read -p '↘️  Acknowledge Info | Press [ENTER] ' typed2 </dev/tty
    question1
  fi
}

rchecker() {
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Conducting RClone Validation Checks
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  sleep 1
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Creating Test Directory - tdrive:/plexguide
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  sleep 1
  rclone mkdir --config /opt/appdata/plexguide/rclone.conf tdrive:/plexguide
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Checking Existance of tdrive:/plexguide
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  rcheck=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf tdrive: | grep -oP plexguide | head -n1)

  if [ "$rcheck" != "plexguide" ]; then
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: RClone Validation Check Failed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

TIPS:
1. Did you set your tdrive correctly along with your teamdrive?

EOF
    rchecker=fail
    read -p '↘️  Acknowledge Info | Press [ENTER] ' typed2 </dev/tty
    question1
  fi
}

pgbdeploy() {
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Blitz Deployed!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  read -p '↘️  Acknowledge Info | Press [ENTER] ' typed2 </dev/tty
}

keymenu() {
  gcloud info | grep Account: | cut -c 10- >/var/plexguide/project.account
  account=$(cat /var/plexguide/project.account)
  project=$(cat /var/plexguide/pgclone.project)

  if [ "$account" == "NOT-SET" ]; then
    display5="[NOT-SET]"
  else
    display5="$account"
  fi

  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Blitz Key Generation 
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] Google Account Login: [ $display5 ]
[2] Project Options     : [ $project ]
[3] Create Service Keys
[4] EMail Generator

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[A] Backup  Keys
[C] Destory All Prior Service Accounts
[Z] Exit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

  read -p '↘️  Type Choice | Press [ENTER]: ' typed </dev/tty

  if [ "$typed" == "1" ]; then
    gcloud auth login
    gcloud info | grep Account: | cut -c 10- >/var/plexguide/project.account
    account=$(cat /var/plexguide/project.account)
    keymenu
  elif [ "$typed" == "2" ]; then
    projectmenu
    keymenu
  elif [ "$typed" == "3" ]; then
    rchecker
    if [ $rchecker=fail ]; then
      deploykeys
      keymenu
    fi
  elif [ "$typed" == "4" ]; then
    bash /opt/pgclone/emails.sh && echo
    read -p '↘️  Confirm Info | Press [ENTER]: ' typed </dev/tty
    keymenu
  elif [[ "$typed" == "Z" || "$typed" == "z" ]]; then
    question1
  elif [[ "$typed" == "C" || "$typed" == "c" ]]; then
    deletekeys
    keymenu
  elif [[ "$typed" == "A" || "$typed" == "a" ]]; then
    keybackup
    keymenu
  else
    badinput
    keymenu
  fi
}
