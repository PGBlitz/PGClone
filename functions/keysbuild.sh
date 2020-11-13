#!/bin/bash
#
# Title:      Reference Title File - PGBlitz
# Author(s):  Admin9705 & https://github.com/PGBlitz/PGClone/graphs/contributors
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
if [[ "$typed" -le "0" || "$typed" -ge "51" ]]; then keystart
elif [[ "$typed" -ge "1" && "$typed" -le "50" ]]; then keyphase2
else keystart; fi
}

keyphase2 () {
num=$typed

rm -rf ${PGBLITZ_DIR}/var/blitzkeys 1>/dev/null 2>&1
mkdir -p ${PGBLITZ_DIR}/var/blitzkeys

cat ${PGBLITZ_DIR}/rclone/.gd > ${PGBLITZ_DIR}/rclone/blitz.conf
if [ -e "${PGBLITZ_DIR}/rclone/.sd" ]; then cat ${PGBLITZ_DIR}/rclone/.sd >> ${PGBLITZ_DIR}/var/.keytemp; fi
if [ -e "${PGBLITZ_DIR}/rclone/.gc" ]; then cat ${PGBLITZ_DIR}/rclone/.gc >> ${PGBLITZ_DIR}/var/.keytemp; fi
if [ -e "${PGBLITZ_DIR}/rclone/.sc" ]; then cat ${PGBLITZ_DIR}/rclone/.sc >> ${PGBLITZ_DIR}/var/.keytemp; fi

gcloud --account=${pgcloneemail} iam service-accounts list |  awk '{print $1}' | \
       tail -n +2 | cut -c2- | cut -f1 -d "?" | sort | uniq > ${PGBLITZ_DIR}/var/.gcloudblitz

 rm -rf ${PGBLITZ_DIR}/var/.blitzbuild 1>/dev/null 2>&1
 touch ${PGBLITZ_DIR}/var/.blitzbuild
 while read p; do
   echo $p > ${PGBLITZ_DIR}/var/.blitztemp
   blitzcheck=$(grep "blitz" ${PGBLITZ_DIR}/var/.blitztemp)
   if [[ "$blitzcheck" != "" ]]; then echo $p >> ${PGBLITZ_DIR}/var/.blitzbuild; fi
 done <${PGBLITZ_DIR}/var/.gcloudblitz

keystotal=$(cat ${PGBLITZ_DIR}/var/.blitzbuild | wc -l)
# do a 100 calculation - reminder

keysleft=$num
count=0
gdsacount=0
gcount=0
tempbuild=0
rm -rf ${PGBLITZ_DIR}/var/.keys 1>/dev/null 2>&1
touch ${PGBLITZ_DIR}/var/.keys
rm -rf ${PGBLITZ_DIR}/var/.blitzkeys
mkdir -p ${PGBLITZ_DIR}/var/.blitzkeys
echo "" > ${PGBLITZ_DIR}/var/.keys

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
    gcloud --account=${pgcloneemail} iam service-accounts keys create ${PGBLITZ_DIR}/var/.blitzkeys/GDSA${tempbuild} --iam-account blitz0${count}@${pgcloneproject}.iam.gserviceaccount.com --key-file-type="json"
    gdsabuild
    if [[ "$gcount" -ge "1" && "$gcount" -le "9" ]]; then echo "blitz0${count} is linked to GDSA${tempbuild}"
    else echo "blitz0${count} is linked to GDSA${gcount}"; fi
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    keysleft=$((keysleft-1))
    flip=on
}

keycreate2 () {
    #echo $count # for tshoot
    gdsacount
    gcloud --account=${pgcloneemail} iam service-accounts create blitz${count} --display-name “blitz${count}”
    gcloud --account=${pgcloneemail} iam service-accounts keys create ${PGBLITZ_DIR}/var/.blitzkeys/GDSA${tempbuild} --iam-account blitz${count}@${pgcloneproject}.iam.gserviceaccount.com --key-file-type="json"
    gdsabuild
    if [[ "$gcount" -ge "1" && "$gcount" -le "9" ]]; then echo "blitz${count} is linked to GDSA${tempbuild}"
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
      if [[ $(grep "0${count}" ${PGBLITZ_DIR}/var/.blitzbuild) = "" ]]; then keycreate1; fi
    else
      if [[ $(grep "${count}" ${PGBLITZ_DIR}/var/.blitzbuild) = "" ]]; then keycreate2; fi; fi
  done
done

}

gdsabuild () {
pgclonevars
####tempbuild is need in order to call the correct gdsa
tee >> ${PGBLITZ_DIR}/var/.keys <<-EOF
[GDSA${tempbuild}]
type = drive
scope = drive
service_account_file = ${PGBLITZ_DIR}/var/.blitzkeys/GDSA${tempbuild}
team_drive = ${sdid}

EOF

if [[ "$transport" == "sc" || "$transport" == "sd" ]]; then
encpassword=$(rclone obscure "${clonepassword}")
encsalt=$(rclone obscure "${clonesalt}")

tee >> ${PGBLITZ_DIR}/var/.keys <<-EOF
[GDSA${tempbuild}C]
type = crypt
remote = GDSA${tempbuild}:/encrypt
filename_encryption = standard
directory_name_encryption = true
password = $encpassword
password2 = $encsalt

EOF

fi
#echo "" ${PGBLITZ_DIR}/var/.keys
}

gdsaemail () {
tee <<-EOF
EOF

read -rp '↘️  Process Complete! Ready to Share E-Mails? | Press [ENTER] ' typed < /dev/tty
emailgen
}

deletekeys () {
pgclonevars
gcloud --account=${pgcloneemail} iam service-accounts list > ${PGBLITZ_DIR}/var/.deletelistpart1

  if [[ $(cat ${PGBLITZ_DIR}/var/.deletelistpart1) == "" ]]; then

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Error! Nothing To Delete!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTE: No Accounts for Project ~ $pgcloneproject
are detected! Exiting!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -p '↘️  Acknowledge Info! | PRESS [ENTER] ' token < /dev/tty
clonestart; fi

  rm -rf ${PGBLITZ_DIR}/var/.listpart2 1>/dev/null 2>&1
  while read p; do
  echo $p > ${PGBLITZ_DIR}/var/.listpart1
  writelist=$(grep pg-bumpnono-143619 ${PGBLITZ_DIR}/var/.listpart1)
  if [[ "$writelist" != "" ]]; then echo $writelist >> ${PGBLITZ_DIR}/var/.listpart2; fi
done <${PGBLITZ_DIR}/var/.deletelistpart1

cat ${PGBLITZ_DIR}/var/.listpart2 |  awk '{print $2}' | \
    sort | uniq > ${PGBLITZ_DIR}/var/.gcloudblitz

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Keys to Delete?
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
cat ${PGBLITZ_DIR}/var/.gcloudblitz
tee <<-EOF

Delete All Keys for Project ~ ${pgcloneproject}?

WARNING: If Plex, Emby, and/or JellyFin are using these keys, stop the
containers! Deleting keys in use by this project will result in those
containers losing metadata (due to being unable to access teamdrives)!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

read -p '↘️  Type y or n | PRESS [ENTER]: ' typed < /dev/tty
case $typed in
    y )
        yesdeletekeys ;;
    Y )
        yesdeletekeys ;;
    N )
        clonestart ;;
    n )
        clonestart ;;
    * )
        deletekeys ;;
esac
}

yesdeletekeys () {
rm -rf ${PGBLITZ_DIR}/var/.blitzkeys/* 1>/dev/null 2>&1
echo ""
while read p; do
gcloud --account=${pgcloneemail} iam service-accounts delete $p --quiet
done <${PGBLITZ_DIR}/var/.gcloudblitz

echo
read -p '↘️  Process Complete! | PRESS [ENTER]: ' token < /dev/tty
clonestart
}
