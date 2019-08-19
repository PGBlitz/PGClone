#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705 ~ Physik - FlickerRate
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
defaultvars () {
  touch /pg/var/rclone.gdrive
  touch /pg/var/rclone.gcrypt
}

# FOR START DEPLOYMENT END #####################################################

deploygcryptcheck () {
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
  rclone mkdir --config /pg/rclone/blitz.conf $type:/plexguide
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Checking Existance of $type:/plexguide
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  rcheck=$(rclone lsd --config /pg/rclone/blitz.conf $type: | grep -oP plexguide | head -n1)

  if [ "$rcheck" != "plexguide" ];then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔  System Message: Validation Checks Failed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

TIPS:
1. Did you set up your gcrypt accordingly to the wiki?
2. Did you ensure that the gcrypt overlapped on gdrive per the wiki?

EOF
    read -p '↘️  Acknowledge Info | Press [ENTER] ' typed2 < /dev/tty
    question1
else
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Validation Checks Passed - $type
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

fi
}

deploygdrivecheck () {
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
  rclone mkdir --config /pg/rclone/blitz.conf $type:/plexguide
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Checking Existance of $type:/plexguide
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  rcheck=$(rclone lsd --config /pg/rclone/blitz.conf $type: | grep -oP plexguide | head -n1)

  if [ "$rcheck" != "plexguide" ];then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔  System Message: Validation Checks Failed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

TIPS:
1. Did you set up your $type accordingly to the wiki?

EOF
    read -p '↘️  Acknowledge Info | Press [ENTER] ' typed2 < /dev/tty
    question1
else
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Validation Checks Passed - $type
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

fi
}

deploytdrivecheck () {
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
  rclone mkdir --config /pg/rclone/blitz.conf $type:/plexguide
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Checking Existance of $type:/plexguide
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  rcheck=$(rclone lsd --config /pg/rclone/blitz.conf $type: | grep -oP plexguide | head -n1)

  if [ "$rcheck" != "plexguide" ];then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔  System Message: Validation Checks Failed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

TIPS:
1. Did you set up your $type accordingly to the wiki?

EOF
    read -p '↘️  Acknowledge Info | Press [ENTER] ' typed2 < /dev/tty
    question1
else
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Validation Checks Passed - $type
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

fi
}

deploygdsa01check () {
type=gdsa01
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
  rclone mkdir --config /pg/rclone/blitz.conf $type:/plexguide
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Checking Existance of $type:/plexguide
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  rcheck=$(rclone lsd --config /pg/rclone/blitz.conf $type: | grep -oP plexguide | head -n1)

  if [ "$rcheck" != "plexguide" ];then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔  System Message: Validation Checks Failed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

TIPS:
1. Did you set up your keys and share out your emails per the blitz wiki?

EOF
    read -p '↘️  Acknowledge Info | Press [ENTER] ' typed2 < /dev/tty
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

tdrivecheck () {
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
  rclone mkdir --config /pg/rclone/blitz.conf $type:/plexguide
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Checking Existance of $type:/plexguide
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  rcheck=$(rclone lsd --config /pg/rclone/blitz.conf $type: | grep -oP plexguide | head -n1)

  if [ "$rcheck" != "plexguide" ];then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔  System Message: Validation Checks Failed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

TIPS:
1. Did you copy your username and password correctly?
2. When you created the credentials, did you select "Other"?
3. Did you enable your API?

EOF
    echo "Not Active" > /pg/var/gd.pgclone
    read -p '↘️  Acknowledge Info | Press [ENTER] ' typed2 < /dev/tty
    question1
else
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Validation Checks Passed - $type
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

fi
read -p '↘️  Acknowledge Info | Press [ENTER] ' typed2 < /dev/tty
EOF
}

deletekeys2 () {
choicedel=$(cat /pg/var/gdsa.cut)
if [ "$choicedel" != "" ]; then
  echo ""
  echo "Deleting All Previous Service Accounts & Keys!"
  echo ""

  while read p; do
  gcloud iam service-accounts delete $p --quiet
  done </pg/var/gdsa.cut

rm -rf /pg/var/keys/processed/* 1>/dev/null 2>&1
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

deletekeys () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 ID: PG Key Gen Information
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
gcloud iam service-accounts list --filter="GDSA" > /pg/var/gdsa.list
cat /pg/var/gdsa.list | awk '{print $2}' | tail -n +2 > /pg/var/gdsa.cut
cat /pg/var/gdsa.cut
tee <<-EOF

Items listed are all service accounts that have been created! Proceeding
onward will destroy all service accounts and current keys!

EOF
read -p '🌍 Proceed? y or n | Press [ENTER]: ' typed < /dev/tty

if [[ "$typed" == "Y" || "$typed" == "y" ]]; then deletekeys2
elif [[ "$typed" == "N" || "$typed" == "n" ]]; then question1
else
  badinput
  deletekeys
fi
}

gdsabuild () {

  ## what sets if encrypted is on or not
  encheck=$(cat /pg/rclone/pgclone.transport)
  bencrypted=no
  if [ "$encheck" == "eblitz" ]; then bencrypted=yes; fi

  downloadpath=$(cat /pg/var/server.hd.path)
  tempbuild=$(cat /pg/var/json.tempbuild)
  path=/pg/var/keys
  rpath=/pg/rclone/blitz.conf
  tdrive=$( cat /pg/rclone/blitz.conf | grep team_drive | head -n1 )
  tdrive="${sd:13}"

  if [ "$bencrypted" == "yes" ]; then
  PASSWORD=$(cat /pg/rclone/pgclone.password)
  SALT=$(cat /pg/rclone/pgclone.salt)
  ENC_PASSWORD=`rclone obscure "$PASSWORD"`
  ENC_SALT=`rclone obscure "$SALT"`; fi

  ####tempbuild is need in order to call the correct gdsa
  mkdir -p $downloadpath/move/$tempbuild
  echo "" >> $rpath
  echo "[$tempbuild]" >> $rpath
  echo "type = drive" >> $rpath
  echo "client_id =" >> $rpath
  echo "client_secret =" >> $rpath
  echo "scope = drive" >> $rpath
  echo "root_folder_id =" >> $rpath
  echo "service_account_file = /pg/var/keys/processed/$tempbuild" >> $rpath
  echo "team_drive = $tdrive" >> $rpath

  if [ "$bencrypted" == "yes" ]; then
  echo "" >> $rpath
  echo "[${tempbuild}C]" >> $rpath
  echo "type = crypt" >> $rpath
  echo "remote = $tempbuild:/encrypt" >> $rpath
  echo "filename_encryption = standard" >> $rpath
  echo "directory_name_encryption = true" >> $rpath
  echo "password = $ENC_PASSWORD" >> $rpath
  echo "password2 = $ENC_SALT" >> $rpath; fi
}

deploykeys3 () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 SYSTEM MESSAGE: Key Number Selection!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] Create 2 Keys:  Daily Limit - 1.5  TB
[2] Create 4 Keys:  Daily Limit - 3.0  TB
[3] Create 6 Keys:  Daily Limit - 4.5  TB  <--- Realistic
[4] Create 8 Keys:  Daily Limit - 6.0  TB
[5] Create 10 Keys: Daily Limit - 7.5  TB
[6] Create 20 Keys: Daily Limit - 15   TB  <--- only GCE-FEEDER !

💬 # of Keys Generated Sets Your Daily Upload Limit!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  read -p '↘️  Type Choice | Press [ENTER]: ' typed < /dev/tty

  echo ""
  echo "NOTE: Please Wait"
  echo ""
  if [ "$typed" == "1" ]; then echo "Creating 2 Keys - Daily Upload Limit Set to 1.5TB" && keys=2;
elif [ "$typed" == "2" ]; then echo "Creating 4 Keys - Daily Upload Limit Set to 3.0TB" && keys=4;
elif [ "$typed" == "3" ]; then echo "Creating 6 Keys - Daily Upload Limit Set to 4.5TB" && keys=6;
elif [ "$typed" == "4" ]; then echo "Creating 8 Keys - Daily Upload Limit Set to 6.0TB" && keys=8;
elif [ "$typed" == "5" ]; then echo "Creating 10 Keys - Daily Upload Limit Set to 7.5TB" && keys=10;
elif [ "$typed" == "6" ]; then echo "Creating 20 Keys - Daily Upload Limit Set to 15.0TB" && keys=20;
  fi
  sleep 2
  echo ""

  if [[ "$typed" -le "0" && "$typed" -ge 7 ]]; then deploykeys3; fi

  num=$keys
  count=0
  project=$(cat /pg/rclone/pgclone.project)

  ##wipe previous keys stuck there
  mkdir -p /pg/var/keys/processed/
  rm -rf /pg/var/keys/processed/* 1>/dev/null 2>&1

  ## purpose of the rewrite is to save gdrive and tdrive info and toss old GDSAs
      cat /pg/rclone/blitz.conf | grep -w "\[tdrive\]" -A 5 > /pg/var/tdrive.info
      cat /pg/rclone/blitz.conf | grep -w "\[gdrive\]" -A 4 > /pg/var/gdrive.info
      cat /pg/rclone/blitz.conf | grep -w "\[tcrypt\]" -A 6 > /pg/var/tcrypt.info
      cat /pg/rclone/blitz.conf | grep -w "\[gcrypt\]" -A 6 > /pg/var/gcrypt.info

      echo "#### rclone rewrite generated by pgblitz.com" > /pg/rclone/blitz.conf
      echo "" >> /pg/rclone/blitz.conf
      echo "" >> /pg/rclone/blitz.conf
      cat /pg/var/gdrive.info >> /pg/rclone/blitz.conf
      echo "" >> /pg/rclone/blitz.conf
      cat /pg/var/tdrive.info >> /pg/rclone/blitz.conf
      echo "" >> /pg/rclone/blitz.conf
      cat /pg/var/tcrypt.info >> /pg/rclone/blitz.conf
      echo "" >> /pg/rclone/blitz.conf
      cat /pg/var/gcrypt.info >> /pg/rclone/blitz.conf

    while [ "$count" != "$keys" ]; do
    ((count++))
    rand=$(echo $((1 + RANDOM * RANDOM)))

    if [ "$count" -ge 1 -a "$count" -le 9 ]; then
      gcloud iam service-accounts create gdsa$rand --display-name “gdsa0$count”
      gcloud iam service-accounts keys create /pg/var/keys/processed/gdsa0$count --iam-account gdsa$rand@$project.iam.gserviceaccount.com --key-file-type="json"
      echo "gdsa0$count" > /pg/var/json.tempbuild
      gdsabuild
      echo ""
    else
      gcloud iam service-accounts create gdsa$rand --display-name “gdsa$count”
      gcloud iam service-accounts keys create /pg/var/keys/processed/gdsa$count --iam-account gdsa$rand@$project.iam.gserviceaccount.com --key-file-type="json"
      echo "gdsa$count" > /pg/var/json.tempbuild
      gdsabuild
      echo ""
    fi
    done

  echo "no" > /pg/var/project.deployed

tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 SYSTEM MESSAGE: Key Generation Complete!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💬 Use the E-Mail Generator Next! Do Not Forget!

EOF
read -p '↘️  Acknowledge Info | Press [ENTER] ' typed < /dev/tty
}

deploykeys2 () {
deploykeys3
}

deploykeys () {
  gcloud iam service-accounts list --filter="GDSA" > /pg/var/gdsa.list
  cat /pg/var/gdsa.list | awk '{print $2}' | tail -n +2 > /pg/var/gdsa.cut
deploykeys2
}

projectid () {
gcloud projects list > /pg/var/projects.list
cat /pg/var/projects.list | cut -d' ' -f1 | tail -n +2 > /pg/var/project.cut
projectlist=$(cat /pg/var/project.cut)
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Projects Interface Menu            📓 Reference: project.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

$projectlist

EOF

read -p '↘️  Type EXACT Project Name to Utilize | Press [ENTER]: ' typed2 < /dev/tty
  list=$(cat /pg/var/project.cut | grep $typed2)
  if [ "$list" == "" ]; then
  badinput && projectid; fi
  gcloud config set project $typed2
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Standby - Enabling Your API
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  gcloud services enable drive.googleapis.com --project $typed2
  echo $typed2 > /pg/var/project.final
echo
read -p '🌍 Process Complete | Press [ENTER] ' typed2 < /dev/tty

}

ufsbuilder () {
  downloadpath=$(cat /pg/var/server.hd.path)
  ls -la /pg/var/keys/processed | awk '{ print $9}' | tail -n +4 > /tmp/pg.gdsa.ufs
  rm -rf /tmp/pg.gdsa.build 1>/dev/null 2>&1
  #echo -n "/pg/sd=RO:" > /tmp/pg.gdsa.build
  #echo -n "/pg/gd=RO:" >> /tmp/pg.gdsa.build
  ##### Encryption Portion ### Start
  #tcrypt=$(grep "tcrypt" /pg/rclone/blitz.conf)
  #gcrypt=$(grep "gcrypt" /pg/rclone/blitz.conf)

  #if [ "$tcrypt" == "[tcrypt]" ]  && [ "$gcrypt" == "[gcrypt]" ]; then
  #    encryption="on"
  #  else
      encryption="off"
  #fi

  #if [ "$encryption" == "on" ]; then
  #  echo -n "/pg/gc=RO:" >> /tmp/pg.gdsa.build
  #fi
  ##### Encryption Portion ### END
  file="/pg/var/unionfs.pgpath"
  if [ -e "$file" ]; then rm -rf /pg/var/unionfs.pgpath && touch /pg/var/unionfs.pgpath; fi

  while read p; do
  mkdir -p $downloadpath/move/$p
  echo -n "$downloadpath/move/$p=RO:" >> /pg/var/unionfs.pgpath
  done </tmp/pg.gdsa.ufs
  builder=$(cat /pg/var/unionfs.pgpath)
}

blitzchecker () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Conducting RClone Validation Checks
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  sleep 1
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Creating Test Directory - gdsa01:/plexguide
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  sleep 1
  rclone mkdir --config /pg/rclone/blitz.conf gdsa01:/plexguide
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Checking Existance of gdsa01:/plexguide
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  rcheck=$(rclone lsd --config /pg/rclone/blitz.conf gdsa01: | grep -oP plexguide | head -n1)

  if [ "$rcheck" != "plexguide" ];then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: RClone Validation Check Failed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

TIPS:
1. Did you share out your emails to your teamdrives?

EOF
    read -p '↘️  Acknowledge Info | Press [ENTER] ' typed2 < /dev/tty
    question1
  fi
}

rchecker () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Conducting RClone Validation Checks
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  sleep 1
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Creating Test Directory - sd:/plexguide
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  sleep 1
  rclone mkdir --config /pg/rclone/blitz.conf sd:/plexguide
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Checking Existance of sd:/plexguide
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  rcheck=$(rclone lsd --config /pg/rclone/blitz.conf sd: | grep -oP plexguide | head -n1)

  if [ "$rcheck" != "plexguide" ];then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: RClone Validation Check Failed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

TIPS:
1. Did you set your tdrive correctly along with your teamdrive?

EOF
rchecker=fail
    read -p '↘️  Acknowledge Info | Press [ENTER] ' typed2 < /dev/tty
    question1
  fi
}

pgbdeploy () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: PG Blitz Deployed!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    read -p '↘️  Acknowledge Info | Press [ENTER] ' typed2 < /dev/tty
}

keymenu () {
gcloud info | grep Account: | cut -c 10- > /pg/var/project.account
account=$(cat /pg/var/project.account)
project=$(cat /pg/rclone/pgclone.project)

if [ "$account" == "NOT-SET" ]; then
  display5="[NOT-SET]"
else
  display5="$account"; fi

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 PG Blitz Key Generation             📓 Reference: pgblitz.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] Google Account Login: $display5
[2] Project Options     : [$project]
[3] Create Service Keys
[4] EMail Generator
[Z] Exit

[A] Backup  Keys
[B] Restore Keys
[C] Destory All Prior Service Accounts
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

read -p '↘️  Type Choice | Press [ENTER]: ' typed < /dev/tty

if [ "$typed" == "1" ]; then
  gcloud auth login
  gcloud info | grep Account: | cut -c 10- > /pg/var/project.account
  account=$(cat /pg/var/project.account)
  keymenu
elif [ "$typed" == "2" ]; then
  projectmenu
  keymenu
elif [ "$typed" == "3" ]; then
  rchecker
  if [ $rchecker=fail ]; then
  deploykeys
  keymenu; fi
elif [ "$typed" == "4" ]; then
  bash /pg/pgclone/emails.sh && echo
  read -p '↘️  Confirm Info | Press [ENTER]: ' typed < /dev/tty
  keymenu
elif [[ "$typed" == "Z" || "$typed" == "z" ]]; then
  question1
elif [[ "$typed" == "C" || "$typed" == "c" ]]; then
  deletekeys
  keymenu
elif [[ "$typed" == "A" || "$typed" == "a" ]]; then
  keybackup
  keymenu
elif [[ "$typed" == "B" || "$typed" == "b" ]]; then
  keyrestore
  keymenu
else
  badinput
  keymenu; fi
}
