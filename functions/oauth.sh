#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
oauth () {
pgclonevars

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Google Auth - ${type} ~ oauth.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

https://accounts.google.com/o/oauth2/auth?client_id=$pgclonepublic&redirect_uri=urn:ietf:wg:oauth:2.0:oob&scope=https://www.googleapis.com/auth/drive&response_type=code

Copy & Paste the URL into Browser! Ensure to utilize and login with
the correct Google Account!

PUTTY USERS: Just select and highlight! DO NOT RIGHT CLICK! When you paste
into the browser, it will just work!

Quitting? Type >>> exit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  read -p '↘️  Token | PRESS [ENTER]: ' token < /dev/tty
  if [[ "$token" == "exit" || "$token" == "Exit" || "$token" == "EXIT" ]]; then clonestart; fi
  curl --request POST --data "code=$token&client_id=$pgclonepublic&client_secret=$pgclonesecret&redirect_uri=urn:ietf:wg:oauth:2.0:oob&grant_type=authorization_code" https://accounts.google.com/o/oauth2/token > /pg/rclone/pgclone.info

  accesstoken=$(cat /pg/rclone/pgclone.info | grep access_token | awk '{print $2}')
  refreshtoken=$(cat /pg/rclone/pgclone.info | grep refresh_token | awk '{print $2}')
  rcdate=$(date +'%Y-%m-%d')
  rctime=$(date +"%H:%M:%S" --date="$givenDate 60 minutes")
  rczone=$(date +"%:z")
  final=$(echo "${rcdate}T${rctime}${rczone}")

########################
rm -rf /pg/rclone/.${type} 1>/dev/null 2>&1
echo "" > /pg/rclone/.${type}
echo "[$type]" >> /pg/rclone/.${type}
echo "client_id = $pgclonepublic" >> /pg/rclone/.${type}
echo "client_secret = $pgclonesecret" >> /pg/rclone/.${type}
echo "type = drive" >> /pg/rclone/.${type}
echo -n "token = {\"access_token\":${accesstoken}\"token_type\":\"Bearer\",\"refresh_token\":${refreshtoken}\"expiry\":\"${final}\"}" >> /pg/rclone/.${type}
echo "" >> /pg/rclone/.${type}
if [ "$type" == "tdrive" ]; then
teamid=$(cat /pg/var/pgclone.teamid)
echo "team_drive = $teamid" >> /pg/rclone/.sd; fi
echo ""

echo ${type} > /pg/var/oauth.check
oauthcheck

## Adds Encryption to the Test Phase if Move or Blitz Encrypted is On
if [[ "$transport" == "be" || "$transport" == "me" ]]; then

if [ "$type" == "gdrive" ]; then entype="gcrypt";
else entype="tcrypt"; fi

PASSWORD=`cat /pg/var/pgclone.password`
SALT=`cat /pg/var/pgclone.salt`
ENC_PASSWORD=`rclone obscure "$PASSWORD"`
ENC_SALT=`rclone obscure "$SALT"`

rm -rf /pg/var/.${entype} 1>/dev/null 2>&1
echo "" >> /pg/var/.${entype}
echo "[$entype]" >> /pg/var/.${entype}
echo "type = crypt" >> /pg/var/.${entype}
echo "remote = $type:/encrypt" >> /pg/var/.${entype}
echo "filename_encryption = standard" >> /pg/var/.${entype}
echo "directory_name_encryption = true" >> /pg/var/.${entype}
echo "password = $ENC_PASSWORD" >> /pg/var/.${entype}
echo "password2 = $ENC_SALT" >> /pg/var/.${entype};
fi

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 Process Complete ~ pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💬  [${type}] is now established!

NOTE: If you change projects or use a different login, rerun this again!
If not, nothing will work!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -p '↘️  Acknowledge Info | Press [ENTER] ' typed < /dev/tty
clonestart

}
# (BELOW - SET TEAMDRIVE NAME)##################################################
tlabeloauth () {
pgclonevars
  gtype="https://www.googleapis.com/drive/v3/teamdrives"
  storage="/pg/var/teamdrive.output"

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Google Auth - Team Drive Label ~ oauth.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

https://accounts.google.com/o/oauth2/auth?client_id=${pgclonepublic}&redirect_uri=urn:ietf:wg:oauth:2.0:oob&scope=https://www.googleapis.com/auth/drive&response_type=code

Copy & Paste the URL into Browser! Ensure to utilize and login with
the correct Google Account!

PUTTY USERS: Just select and highlight! DO NOT RIGHT CLICK! When you paste
into the browser, it will just work!

Quitting? Type >>> exit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  read -p '↘️  Token | PRESS [ENTER]: ' token < /dev/tty

  if [[ "$token" = "exit" || "$token" == "Exit" || "$token" == "EXIT" ]]; then clonestart; fi
  curl --request POST --data "code=${token}&client_id=${pgclonepublic}&client_secret=${pgclonesecret}&redirect_uri=urn:ietf:wg:oauth:2.0:oob&grant_type=authorization_code" https://accounts.google.com/o/oauth2/token > /pg/var/token.part1
  curl -H "GData-Version: 3.0" -H "Authorization: Bearer $(cat /pg/var/token.part1 | grep access_token | awk '{ print $2 }' | cut -c2- | rev | cut -c3- | rev)" $gtype > $storage

  teamdriveselect
}

teamdriveselect () {
  cat /pg/var/teamdrive.output | grep "id" | awk '{ print $2 }' | cut -c2- | rev | cut -c3- | rev > /pg/var/teamdrive.id
  cat /pg/var/teamdrive.output | grep "name" | awk '{ print $2 }' | cut -c2- | rev | cut -c2- | rev > /pg/var/teamdrive.name

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Listed Team Drives
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  A=0
  while read p; do
  ((A++))
  name=$(sed -n ${A}p /pg/var/teamdrive.name)
  echo "[$A] $p - $name"
done </pg/var/teamdrive.id

if [[ $(cat /pg/var/teamdrive.name) == "" ]]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 No Team Drives Exist or Bad Token!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTE1: Create a Team Drive First or Share on to this account and retry the
process again!

NOTE2: If a bad token, ensure that you are using the correct account when
signing in (and/or conducting a proper copy and paste of the token)!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -p '↘️  Acknowlege Info | Press [ENTER] ' typed < /dev/tty
clonestart
fi

echo ""
read -p '↘️  Type Number | Press [ENTER]: ' typed < /dev/tty
if [[ "$typed" -ge "1" && "$typed" -le "$A" ]]; then a=b
else teamdriveselect; fi

  name=$(sed -n ${typed}p /pg/var/teamdrive.name)
  id=$(sed -n ${typed}p /pg/var/teamdrive.id)
  echo "$name" > /pg/var/pgclone.teamdrive
  echo "$id" > /pg/var/pgclone.teamid

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Process Complete! TeamDrive [$name]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTE: Do not share out your teamdrives to others! The usage counts against
you and if others share your content, you have no control (and your team
drive can be shutdown!)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  read -p '↘️  Acknowledge Info | PRESS [ENTER] ' temp < /dev/tty
}

mountchecker () {
pgclonevars
  if [[ "$transport" == "mu" ]]; then
    if [[ "$gstatus" != "ACTIVE" ]]; then mountfail; fi
elif [[ "$transport" == "me" ]]; then
  if [[ "$gstatus" != "ACTIVE" || "$gcstatus" != "ACTIVE" ]]; then mountfail; fi
elif [[ "$transport" == "bu" ]]; then
  if [[ "$gstatus" != "ACTIVE" || "$tstatus" != "ACTIVE" ]]; then mountfail; fi
elif [[ "$transport" == "be" ]]; then
  if [[ "$gstatus" != "ACTIVE" || "$tstatus" != "ACTIVE" || "$tstatus" != "ACTIVE" || "$tcstatus" != "ACTIVE" ]]; then mountfail; fi
fi
}

mountfail () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 Fail Notice ~ pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💬  All Mounts Must Be Active!

NOTE: If any mount says [NOT-SET]; that process must be completed first!
We will continue to block this process until completed!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -p '↘️  Acknowledge Info | Press [ENTER] ' typed < /dev/tty
clonestart
}

tlabelchecker () {
pgclonevars
if [[ "$tdname" == "NOT-SET" ]]; then

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 Fail Notice ~ oauth.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💬  Team Drive Label Not Set!

NOTE: Unless we know your Team Drive name, we have no way of configuring
the Team Drive! Please complete this first!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -p '↘️  Acknowledge Info | Press [ENTER] ' typed < /dev/tty
clonestart
fi
}
