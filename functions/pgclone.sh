#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
bandwidth () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: BW Limit Notice        📓 Reference: move.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💬 10MB is a safe limit. If exceeding 10MB and uploading straight for
24 hours, an upload ban will be triggered.

EOF
  read -p '↘️  Type a Speed from 1 - 1000 | Press [ENTER]: ' typed < /dev/tty
  if [[ "$typed" -ge "1" && "$typed" -le "1000" ]]; then echo "$typed" > /pg/var/move.bw && question1;
  else badinput && bandwidth; fi
}

bandwidthblitz () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: BW Limit Notice        📓 Reference: move.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💬 100MB = 1 Gig Speeds | 1000MB = 10 Gig Speeds - Remember that your
   upload speeds are still limited to your server's max upload connection

EOF
  read -p '↘️  Type a Speed from 1 - 1000 | Press [ENTER]: ' typed < /dev/tty
  if [[ "$typed" -ge "1" && "$typed" -le "1000" ]]; then echo "$typed" > /pg/var/blitz.bw && question1;
  else badinput && bandwidth; fi
}

statusmount () {
  mcheck5=$(cat /pg/rclone/blitz.conf | grep "$type")
  if [ "$mcheck5" != "" ]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚠️  System Message: Warning!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
NOTE: $type already exists! To proceed, we must delete the prior
configuration for you.

EOF
  read -p '↘️  Proceed? y or n | Press [ENTER]: ' typed < /dev/tty

  if [[ "$typed" == "Y" || "$typed" == "y" ]]; then a=b
elif [[ "$typed" == "N" || "$typed" == "n" ]]; then mountsmenu
  else
    badinput
    statusmount
  fi

  rclone config delete $type --config /pg/rclone/blitz.conf

  encheck=$(cat /pg/rclone/pgclone.transport)
  if [[ "$encheck" == "eblitz" || "$encheck" == "emove" ]]; then
    if [ "$type" == "gdrive" ]; then
    rclone config delete gcrypt --config /pg/rclone/blitz.conf; fi
    if [ "$type" == "tdrive" ]; then
    rclone config delete tcrypt --config /pg/rclone/blitz.conf; fi
  fi

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: $type deleted!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
read -p '↘️  Acknowledge Info | Press [ENTER] ' typed < /dev/tty
fi
}

tmgen() {

secret=$(cat /pg/rclone/pgclone.secret)
public=$(cat /pg/rclone/pgclone.public)

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Google Auth - Shared Drives | 📓 Reference: oauth.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Quitting? Type > exit
NOTE: Copy & Paste Url into Browser | Use Correct Google Account!

https://accounts.google.com/o/oauth2/auth?client_id=$public&redirect_uri=urn:ietf:wg:oauth:2.0:oob&scope=https://www.googleapis.com/auth/drive&response_type=code

EOF
  read -p '↘️  Token | PRESS [ENTER]: ' token < /dev/tty
  if [ "$token" = "exit" ]; then mountsmenu; fi
  curl --request POST --data "code=$token&client_id=$public&client_secret=$secret&redirect_uri=urn:ietf:wg:oauth:2.0:oob&grant_type=authorization_code" https://accounts.google.com/o/oauth2/token > /pg/var/pgtokentm.output
  cat /pg/var/pgtokentm.output | grep access_token | awk '{ print $2 }' | cut -c2- | rev | cut -c3- | rev > /pg/var/pgtokentm2.output
  primet=$(cat /pg/var/pgtokentm2.output)
  curl -H "GData-Version: 3.0" -H "Authorization: Bearer $primet" https://www.googleapis.com/drive/v3/teamdrives > /pg/rclone/teamdrive.output
  tokenscript

  name=$(sed -n ${typed}p /pg/rclone/teamdrive.name)
  id=$(sed -n ${typed}p /pg/rclone/teamdrive.id)
echo "$name" > /pg/rclone/pgclone.teamdrive
echo "$id" > /pg/rclone/pgclone.teamid
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
😂 What a Lame Shared Drive Name: $name
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  read -p '↘️  Acknowledge Info | PRESS [ENTER] ' temp < /dev/tty
}

tokenscript () {
  cat /pg/rclone/teamdrive.output | grep "id" | awk '{ print $2 }' | cut -c2- | rev | cut -c3- | rev > /pg/rclone/teamdrive.id
  cat /pg/rclone/teamdrive.output | grep "name" | awk '{ print $2 }' | cut -c2- | rev | cut -c2- | rev > /pg/rclone/teamdrive.name

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Listed Team Drives
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  A=0
  while read p; do
  ((A++))
  name=$(sed -n ${A}p /pg/rclone/teamdrive.name)
  echo "[$A] $p - $name"
done </pg/rclone/teamdrive.id

echo ""
read -p '↘️  Type Number | PRESS [ENTER]: ' typed < /dev/tty
if [[ "$typed" -ge "1" && "$typed" -le "$A" ]]; then a=b
else
  badinput
  tokenscript; fi
}

inputphase () {
deploychecks

if [[ "$transport" == "PG Move /w No Encryption" || "$transport" == "PG Move /w Encryption" ]]; then
  display=""
else
  if [ "$type" == "tdrive" ]; then
  display="TEAMDRIVE: $teamdrive
  ";fi; fi

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: PG Clone - $type     📓 Reference: oauth.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💬 PG is Deploying /w the Following Values:

🌅 ID
$public

💎 SECRET
$secret
$display
EOF

read -p '↘️  Proceed? y or n | Press [ENTER]: ' typed < /dev/tty

if [[ "$typed" == "Y" || "$typed" == "y" ]]; then a=b
elif [[ "$typed" == "N" || "$typed" == "n" ]]; then question1
else
  badinput
  inputphase
fi

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Google Auth          📓 Reference: oauth.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Quitting? Type > exit
NOTE: Copy & Paste Url into Browser | Use Correct Google Account!

https://accounts.google.com/o/oauth2/auth?client_id=$public&redirect_uri=urn:ietf:wg:oauth:2.0:oob&scope=https://www.googleapis.com/auth/drive&response_type=code

EOF
  read -p '↘️  Token | PRESS [ENTER]: ' token < /dev/tty
  if [ "$token" = "exit" ]; then mountsmenu; fi
  curl --request POST --data "code=$token&client_id=$public&client_secret=$secret&redirect_uri=urn:ietf:wg:oauth:2.0:oob&grant_type=authorization_code" https://accounts.google.com/o/oauth2/token > /pg/rclone/pgclone.info

  accesstoken=$(cat /pg/rclone/pgclone.info | grep access_token | awk '{print $2}')
  refreshtoken=$(cat /pg/rclone/pgclone.info | grep refresh_token | awk '{print $2}')
  rcdate=$(date +'%Y-%m-%d')
  rctime=$(date +"%H:%M:%S" --date="$givenDate 60 minutes")
  rczone=$(date +"%:z")
  final=$(echo "${rcdate}T${rctime}${rczone}")

  testphase
}

mountsmenu () {

# Sets Display Status if Passwords are not set for the encryhpted edition
check5=$(cat /pg/rclone/pgclone.password)
check6=$(cat /pg/rclone/pgclone.salt)
if [[ "$check5" == "" || "$check6" == "" ]]; then passdisplay="⚠️  Not Activated"
else passdisplay="✅ Activated"; fi

projectid=$(cat /pg/rclone/pgclone.project)
secret=$(cat /pg/rclone/pgclone.secret)
public=$(cat /pg/rclone/pgclone.public)
teamdrive=$(cat /pg/rclone/pgclone.teamdrive)

if [ "$secret" == "" ]; then dsecret="NOT SET"; else dsecret="SET"; fi
if [ "$public" == "" ]; then dpublic="NOT SET"; else dpublic="SET"; fi
if [ "$teamdrive" == "" ]; then dteamdrive="NOT SET"; else dteamdrive=$teamdrive; fi

gdstatus=$(cat /pg/var/gd.pgclone)
sdstatus=$(cat /pg/var/sd.pgclone)

###### START
if [ "$transport" == "PG Move /w No Encryption" ]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 PG Clone - OAuth & Mounts          📓 Reference: pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💾 OAuth
[1] Client ID: $dpublic
[2] Secret ID: ${dsecret}

📁 RClone Configuration
[3] gdrive   : $gdstatus
[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

  read -p '↘️  Set Choice | Press [ENTER]: ' typed < /dev/tty

  if [ "$typed" == "1" ]; then
    publickeyinput
    mountsmenu
  elif [ "$typed" == "2" ]; then
    secretkeyinput
    mountsmenu
  elif [ "$typed" == "3" ]; then
    type=gdrive
    statusmount
    inputphase
    mountsmenu
  elif [[ "$typed" == "Z" || "$typed" == "z" ]]; then question1;
  else badinput
    mountsmenu; fi
fi
########## END

########## START
if [ "$transport" == "PG Move /w Encryption" ]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 PG Clone - OAuth & Mounts          📓 Reference: pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💾 OAuth
[1] Client ID: $dpublic
[2] Secret ID: ${dsecret}

💡 Required Tasks
[3] Passwords: $passdisplay

📁 RClone Configuration
[4] gdrive   : $gdstatus
[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

  read -p '↘️  Set Choice | Press [ENTER]: ' typed < /dev/tty

  if [ "$typed" == "1" ]; then
    publickeyinput
    mountsmenu
  elif [ "$typed" == "2" ]; then
    secretkeyinput
    mountsmenu
  elif [ "$typed" == "3" ]; then
    blitzpasswords
    mountsmenu
  elif [ "$typed" == "4" ]; then
    encpasswdcheck
    type=gdrive
    statusmount
    inputphase
    mountsmenu
  elif [[ "$typed" == "Z" || "$typed" == "z" ]]; then question1;
  else badinput
    mountsmenu; fi
fi
###### END

###### START
if [ "$transport" == "PG Blitz /w No Encryption" ]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 PG Clone - OAuth & Mounts          📓 Reference: pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💾 OAuth
[1] Client ID: $dpublic
[2] Secret ID: ${dsecret}

💡 Required Tasks
[3] TD Label : $dteamdrive

📁 RClone Configuration
[4] gdrive   : $gdstatus
[5] tdrive   : $sdstatus
[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

read -p '↘️  Set Choice | Press [ENTER]: ' typed < /dev/tty

if [ "$typed" == "1" ]; then
  publickeyinput
  mountsmenu
elif [ "$typed" == "2" ]; then
  secretkeyinput
  mountsmenu
elif [ "$typed" == "3" ]; then
  tmgen
  mountsmenu
elif [ "$typed" == "4" ]; then
  type=gdrive
  statusmount
  inputphase
  mountsmenu
elif [ "$typed" == "5" ]; then
  tmcheck=$(cat /pg/rclone/pgclone.teamdrive)
  if [ "$tmcheck" == "" ]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔ Warning! TeamDrive is blank! Must be Set Prior!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  read -p '↘️  Acknowledge Info | Press [ENTER] ' typed < /dev/tty
  mountsmenu; fi
  type=tdrive
  statusmount
  inputphase
  mountsmenu
elif [[ "$typed" == "Z" || "$typed" == "z" ]]; then question1;
else badinput
  mountsmenu; fi
fi
#################### END

##### START
if [ "$transport" == "PG Blitz /w Encryption" ]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 PG Clone - OAuth & Mounts          📓 Reference: pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💾 OAuth
[1] Client ID: $dpublic
[2] Secret ID: ${dsecret}

💡 Required Tasks
[3] TD Label : $dteamdrive
[4] Passwords: $passdisplay

📁 RClone Configuration
[5] gdrive   : $gdstatus
[6] tdrive   : $sdstatus
[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

read -p '↘️  Set Choice | Press [ENTER]: ' typed < /dev/tty

if [ "$typed" == "1" ]; then
  publickeyinput
  mountsmenu
elif [ "$typed" == "2" ]; then
  secretkeyinput
  mountsmenu
elif [ "$typed" == "3" ]; then
  tmgen
  mountsmenu
elif [ "$typed" == "4" ]; then
  blitzpasswords
  mountsmenu
elif [ "$typed" == "5" ]; then
  encpasswdcheck
  type=gdrive
  statusmount
  inputphase
  mountsmenu
elif [ "$typed" == "6" ]; then
  encpasswdcheck
  tmcheck=$(cat /pg/rclone/pgclone.teamdrive)
  if [ "$tmcheck" == "" ]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔ Warning! TeamDrive is blank! Must be Set Prior!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  read -p '↘️  Acknowledge Info | Press [ENTER] ' typed < /dev/tty
  mountsmenu; fi
  type=tdrive
  statusmount
  inputphase
  mountsmenu
elif [[ "$typed" == "Z" || "$typed" == "z" ]]; then question1;
else badinput
  mountsmenu; fi
fi
#################### END

}

encpasswdcheck () {
check5=$(cat /pg/rclone/pgclone.password)
check6=$(cat /pg/rclone/pgclone.salt)

if [[ "$check5" == "" || "$check6" == "" ]]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔ Warning! You Need to Setup Your Passwords for the Encrypted Edition
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  read -p '↘️  Acknowledge Info | Press [ENTER] ' typed < /dev/tty
  mountsmenu; fi
}

blitzpasswords () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 Primary Password                   📓 Reference: pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Quitting? Type > Exit

Please set a Primary Password for Encryption! Do not forget it! If you do,
you will be locked out from all your data!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -p ' ↘️  Type Prime PW | Press [ENTER]: ' bpassword < /dev/tty

if [ "$bpassword" == "" ]; then
  badinput
  blitzpasswords
elif [ "$bpassword" == "exit" ]; then mountsmenu; fi
blitzsalt
}

blitzsalt () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 SALT (Secondary Password)          📓 Reference: pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Quitting? Type > Exit

Please set a Secondary Password (SALT) for Encryption! Do not forget it!
If you do, you will be locked out from all your data!  SALT randomizes
your data to further protect you! It is not recommended to use the same
password, but may.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -p ' ↘️  Type SALT PW | Press [ENTER]: ' bsalt < /dev/tty

if [ "$bsalt" == "" ]; then
  badinput
  blitzsalt
elif [ "$bsalt" == "exit" ]; then mountsmenu; fi
blitzpfinal

}

blitzpfinal () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 Set Passwords?                     📓 Reference: pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Quitting? Type > Exit

Are you happy with the following info? Type y or n!

Primary  : $bpassword
Secondary: $bsalt

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

read -p '↘️  Type y or n | Press [ENTER]: ' typed < /dev/tty

if [ "$typed" == "n" ]; then mountsmenu;
elif [ "$typed" == "y" ]; then
echo $bpassword > /pg/rclone/pgclone.password
echo $bsalt > /pg/rclone/pgclone.salt
mountsmenu;
else
  badinput
  blitzpfinal; fi
}

publickeyinput () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Google OAuth Keys - Client ID        📓 Reference: oauth.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Quitting? Type > exit
NOTE: Visit reference for Google OAuth Keys!

EOF

read -p '↘️  Client ID  | Press [Enter]: ' public < /dev/tty
if [ "$public" = "exit" ]; then mountsmenu; fi
echo "$public" > /pg/rclone/pgclone.public

tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 Client ID Set                      📓 Reference: pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
read -p '↘️  Acknowledge Info  | Press [ENTER] ' public < /dev/tty
mountsmenu
}

secretkeyinput () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Google OAuth Keys - Secret Key       📓 Reference: oauth.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Quitting? Type > exit
NOTE: Visit reference for Google OAuth Keys!

EOF
read -p '↘️  Secret Key  | Press [Enter]: ' secret < /dev/tty
if [ "$secret" = "exit" ]; then mountsmenu; fi
echo "$secret" > /pg/rclone/pgclone.secret

tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 Secret ID Set                       📓 Reference: pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
read -p '↘️  Acknowledge Info  | Press [ENTER] ' public < /dev/tty

mountsmenu
}

projectmenu () {
projectid=$(cat /pg/rclone/pgclone.project)

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 GCloud Project Interface           📓 Reference: pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Project ID: $projectid

[1] Establish
[2] Create
[3] Destroy (NOT READY)
[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

read -p '↘️  Set Choice | Press [ENTER]: ' typed < /dev/tty

if [ "$typed" == "1" ]; then projectestablish;
elif [ "$typed" == "2" ]; then projectcreate;
elif [[ "$typed" == "z" || "$typed" == "Z" ]]; then question1;
else badinput
  projectmenu; fi
}

projectestablish () {

  gcloud projects list > /pg/var/projects.list
  projectcheck=(cat /pg/var/projects.list)
  if [ "$projectcheck" == "" ]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔  System Message: Error! There are no projects! Make one first!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  read -p ' ↘️  Acknowledge Info | Press [ENTER] ' typed < /dev/tty
  projectmenu
fi


tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 Established Projects               📓 Reference: pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Project ID: $projectid

EOF
  cat /pg/var/projects.list | cut -d' ' -f1 | tail -n +2
  cat /pg/var/projects.list | cut -d' ' -f1 | tail -n +2 > /pg/var/project.cut
  echo
  changeproject
  echo
  projectidset
  gcloud config set project $typed

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 System Message: Enabling Drive API ~ Project $typed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
gcloud services enable drive.googleapis.com --project $typed
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 System Message: Project Established ~ $typed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  echo $typed > /pg/rclone/pgclone.project
  read -p '↘️  Acknowledge Info | Press [ENTER] ' typed < /dev/tty
  projectmenu

}

transportdisplay () {
temp=$(cat /pg/rclone/pgclone.transport)
  if [ "$temp" == "umove" ]; then transport="PG Move /w No Encryption"
elif [ "$temp" == "emove" ]; then transport="PG Move /w Encryption"
elif [ "$temp" == "ublitz" ]; then transport="PG Blitz /w No Encryption"
elif [ "$temp" == "eblitz" ]; then transport="PG Blitz /w Encryption"
elif [ "$temp" == "solohd" ]; then transport="PG Local"
else transport="NOT-SET"; fi
}

transportmode () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌟 Select Transport Mode            📓 Reference: transport.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] PG Move  /w No Encryption | Upload 750GB Daily ~ Simple
[2] PG Move  /w Encryption    | Upload 750GB Daily ~ Simple
[3] PG Blitz /w No Encryption | Exceed 750GB Daily ~ Complex
[4] PG Blitz /w Encryption    | Exceed 750GB Daily ~ Complex
[5] PG Local                  | No GSuite - Stays Local
[Z] Exit

EOF
read -p '↘️  Set Choice | Press [ENTER]: ' typed < /dev/tty

  if [ "$typed" == "1" ]; then echo "umove" > /pg/rclone/pgclone.transport && echo;
elif [ "$typed" == "2" ]; then echo "emove" > /pg/rclone/pgclone.transport && echo;
elif [ "$typed" == "3" ]; then echo "ublitz" > /pg/rclone/pgclone.transport && echo;
elif [ "$typed" == "4" ]; then echo "eblitz" > /pg/rclone/pgclone.transport && echo;
elif [ "$typed" == "5" ]; then echo "solohd" > /pg/rclone/pgclone.transport && echo;
elif [[ "$typed" == "Z" || "$typed" == "z" ]]; then

# If a New Installer, User Cannot Exit & Must Select a Version
transport=$(cat /pg/rclone/pgclone.transport)
if [ "$transport" == "NOT-SET" ]; then
transportmode; fi

question1;
else
  badinput
  transportmode; fi
}

changeproject () {
  read -p '💬 Set/Change Project ID? (y/n)| Press [ENTER] ' typed < /dev/tty
  if [[ "$typed" == "n" || "$typed" == "N" ]]; then question1
elif [[ "$typed" == "y" || "$typed" == "Y" ]]; then a=b
else badinput
  echo ""
  changeproject; fi
}

projectidset () {
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Type the Project Name to Utilize
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  cat /pg/var/projects.list | cut -d' ' -f1 | tail -n +2
  cat /pg/var/projects.list | cut -d' ' -f1 | tail -n +2 > /pg/var/project.cut
  echo ""
  read -p '↘️  Type Project Name | Press [ENTER]: ' typed < /dev/tty
  echo ""
  list=$(cat /pg/var/project.cut | grep $typed)

  if [ "$typed" != "$list" ]; then
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔  System Message: Error! Type Exact of the Project Name Listed!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  read -p ' ↘️  Acknowledge Info | Press [ENTER] ' typed < /dev/tty
  projectidset
  fi
}

testphase () {
  echo "" > /pg/rclone/test.conf
  echo "[$type]" >> /pg/rclone/test.conf
  echo "client_id = $public" >> /pg/rclone/test.conf
  echo "client_secret = $secret" >> /pg/rclone/test.conf
  echo "type = drive" >> /pg/rclone/test.conf
  echo -n "token = {\"access_token\":${accesstoken}\"token_type\":\"Bearer\",\"refresh_token\":${refreshtoken}\"expiry\":\"${final}\"}" >> /pg/rclone/test.conf
  echo "" >> /pg/rclone/test.conf
  if [ "$type" == "tdrive" ]; then
  teamid=$(cat /pg/rclone/pgclone.teamid)
  echo "team_drive = $teamid" >> /pg/rclone/test.conf; fi
  echo ""

## Adds Encryption to the Test Phase if Move or Blitz Encrypted is On
encheck=$(cat /pg/rclone/pgclone.transport)
if [[ "$encheck" == "eblitz" || "$encheck" == "emove" ]]; then

  if [ "$type" == "gdrive" ]; then entype="gcrypt";
  else entype="tcrypt"; fi

  PASSWORD=`cat /pg/rclone/pgclone.password`
  SALT=`cat /pg/rclone/pgclone.salt`
  ENC_PASSWORD=`rclone obscure "$PASSWORD"`
  ENC_SALT=`rclone obscure "$SALT"`
  echo "" >> /pg/rclone/test.conf
  echo "[$entype]" >> /pg/rclone/test.conf
  echo "type = crypt" >> /pg/rclone/test.conf
  echo "remote = $type:/encrypt" >> /pg/rclone/test.conf
  echo "filename_encryption = standard" >> /pg/rclone/test.conf
  echo "directory_name_encryption = true" >> /pg/rclone/test.conf
  echo "password = $ENC_PASSWORD" >> /pg/rclone/test.conf
  echo "password2 = $ENC_SALT" >> /pg/rclone/test.conf;

fi
testphase2
}

testphase2 () {
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
  rclone mkdir --config /pg/rclone/test.conf $type:/plexguide
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Checking Existance of $type:/plexguide
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  rcheck=$(rclone lsd --config /pg/rclone/test.conf $type: | grep -oP plexguide | head -n1)

  if [ "$rcheck" != "plexguide" ];then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔  System Message: Validation Checks Failed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

TIPS:
1. Did you copy your username and password correctly?
2. When you created the credentials, did you select "Other"?
3. Did you enable your API?

FOR ENCRYPTION (IF SELECTED)
1. Did You Set a Password?

EOF
    echo "⚠️  Not Activated" > /pg/var/$type.pgclone
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
echo "✅ Activated" > /pg/var/$type.pgclone

## Copy the Test File to the Real RClone Conf
cat /pg/rclone/test.conf >> /pg/rclone/blitz.conf

## Back to the Main Mount Menu
mountsmenu

EOF
}

deploychecks () {
secret=$(cat /pg/rclone/pgclone.secret)
public=$(cat /pg/rclone/pgclone.public)
teamdrive=$(cat /pg/rclone/pgclone.teamdrive)

if [ "$secret" == "" ]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔  ERROR: Secret Key Is Blank! Unable to Deploy!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
read -p '↘️  Acknowledge Info | Press [Enter] ' typed < /dev/tty
question1; fi

if [ "$public" == "" ]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔  ERROR: Client ID Is Blank! Unable to Deploy!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
read -p '↘️  Acknowledge Info | Press [Enter] ' typed < /dev/tty
question1; fi
}
