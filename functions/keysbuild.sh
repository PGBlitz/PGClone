#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
keystart () {
pgclonevars

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Key Builder ~ http://pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
QUESTION - Create how many keys for PGBlitz? (From 2 thru 20 )

MATH:
2  Keys = 1.5 TB Daily | 6  Keys = 4.5 TB Daily
10 Keys = 7.5 TB Daily | 20 Keys = 15  TB Daily

NOTE 1: Creating more keys DOES NOT SPEED up your transfers
NOTE 2: Realistic key generation for most are 6 keys
NOTE 3: Generating 100 keys over time, you must delete them all to create
        more, which is why making tons of keys is not ideal!

Quitting? Type >>> exit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  read -p '↘️  Type a Number [ 2 thru 20 ] | Press [ENTER]: ' typed < /dev/tty

exitclone

num=$typed
if [[ "$typed" -le "0" || "$typed" -ge "21" ]]; then keystart
elif [[ "$typed" -ge "1" && "$typed" -le "20" ]]; then keyphase2
else keystart; fi
}

keyphase2 () {
num=$typed

rm -rf /opt/appdata/plexguide/blitzkeys 1>/dev/null 2>&1
mkdir -p /opt/appdata/plexguide/blitzkeys

cat /opt/appdata/plexguide/.gdrive > /opt/appdata/plexguide/rclone.conf
if [ -e "/opt/appdata/plexguide/.tdrive" ]; then cat /opt/appdata/plexguide/.tdrive >> /opt/appdata/plexguide/.keytemp; fi
if [ -e "/opt/appdata/plexguide/.gcrypt" ]; then cat /opt/appdata/plexguide/.gcrypt >> /opt/appdata/plexguide/.keytemp; fi
if [ -e "/opt/appdata/plexguide/.tcrypt" ]; then cat /opt/appdata/plexguide/.tcrypt >> /opt/appdata/plexguide/.keytemp; fi

gcloud --account=${pgcloneemail} iam service-accounts list |  awk '{print $1}' | \
       tail -n +2 | cut -c2- | cut -f1 -d "?" | sort | uniq > /var/plexguide/.gcloudblitz

 rm -rf /var/plexguide/.blitzbuild 1>/dev/null 2>&1
 touch /var/plexguide/.blitzbuild
 while read p; do
   echo $p > /var/plexguide/.blitztemp
   blitzcheck=$(grep "blitz" /var/plexguide/.blitztemp)
   if [[ "$blitzcheck" != "" ]]; then echo $p >> /var/plexguide/.blitzbuild; fi
 done </var/plexguide/.gcloudblitz

keystotal=$(cat /var/plexguide/.blitzbuild | wc -l)
# do a 100 calculation - reminder

keysleft=$num
count=0
gdsacount=0
rm -rf /opt/appdata/plexguide/.keys 1>/dev/null 2>&1
touch /opt/appdata/plexguide/.keys
rm -rf /opt/appdata/plexguide/.blitzkeys
mkdir -p /opt/appdata/plexguide/.blitzkeys
echo "" > /opt/appdata/plexguide/.keys

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Key Generator ~ [$num] keys
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

gdsacount () {
  ((gcount++))
  if [[ "$gcount" -ge "1" && "$gcount" -le "9" ]]; then tempbuild=0${gcount}
else tempbuild=$gcount; fi
}

keycreate1 () {
    #echo $count # for tshoot
    gdsacount
    gcloud --account=${pgcloneemail} iam service-accounts create blitz0${count} --display-name “blitz0${count}”
    gcloud --account=${pgcloneemail} iam service-accounts keys create /opt/appdata/plexguide/.blitzkeys/GDSA0${tempbuild} --iam-account blitz0${count}@${pgcloneproject}.iam.gserviceaccount.com --key-file-type="json"
    if [[ "$gcount" -ge "1" && "$gcount" -le "9" ]]; then echo "blitz${count} is linked to GDSA0${tempbuild}"
    else echo "blitz0${count} is linked to GDSA${gcount}"; fi
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    keysleft=$((keysleft-1))
    flip=on
}

keycreate2 () {
    #echo $count # for tshoot
    gdsacount
    gcloud --account=${pgcloneemail} iam service-accounts create blitz${count} --display-name “blitz${count}”
    gcloud --account=${pgcloneemail} iam service-accounts keys create /opt/appdata/plexguide/.blitzkeys/GDSA${tempbuild} --iam-account blitz${count}@${pgcloneproject}.iam.gserviceaccount.com --key-file-type="json"
    gdsabuild
    if [[ "$gcount" -ge "1" && "$gcount" -le "9" ]]; then echo "blitz${count} is linked to GDSA0${tempbuild}"
    else echo "blitz${count} is linked to GDSA${gcount}"; fi
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    keysleft=$((keysleft-1))
    flip=on
}

keysmade=0
while [[ "$keysleft" -gt "0" ]]; do
  flip=off
  while [[ "$flip" == "off" ]]; do
    ((count++))
    if [[ "$count" -ge "1" && "$count" -le "9" ]]; then
      if [[ $(grep "0${count}" /var/plexguide/.blitzbuild) = "" ]]; then keycreate1; fi
    else
      if [[ $(grep "${count}" /var/plexguide/.blitzbuild) = "" ]]; then keycreate2; fi; fi
  done
done

}

gdsabuild () {
pgclonevars
####tempbuild is need in order to call the correct gdsa
tee >> /opt/appdata/plexguide/.keys <<-EOF
[GDSA${tempbuild}]
type = drive
scope = drive
service_account_file = /opt/appdata/plexguide/.blitzkeys/GDSA${tempbuild}
team_drive = ${tdid}

EOF

if [[ "$transport" == "be" ]]; then
encpassword=$(rclone obscure "${clonepassword}")
encsalt=$(rclone obscure "${clonesalt}")

tee >> /opt/appdata/plexguide/.keys <<-EOF
[GDSA${tempbuild}C]
type = crypt
remote = gdsa${tempbuild}:/encrypt
filename_encryption = standard
directory_name_encryption = true
password = $encpassword
password2 = $encsalt

EOF

fi
echo "" /opt/appdata/plexguide/.keys
emailgen

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Process Complete! Next > E-Mails Must be Shared with the Team Drive
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
read -rp '↘️  Ready? | Press [ENTER] ' typed < /dev/tty
emailgen
}
