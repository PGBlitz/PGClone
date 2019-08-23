#!/bin/bash
#
# Title:      Reference Title File - PGBlitz
# Author(s):  Admin9705 & https://github.com/PGBlitz/PGClone/graphs/contributors
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

# BAD INPUT
badinput () {
echo
read -p '⛔️ ERROR - Bad Input! | Press [ENTER] ' typed < /dev/tty
}

glogin () {

emailaccount=$(cat /pg/var/project.email)

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 Set E-Mail Address ~ http://pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
What email address from the Google Console do you want to be associated
with from your Google GSuite? Ensure that it exists!

Quitting? Type >>> exit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

read -p '↘️  Input E-Mail | Press [ENTER]: ' typed < /dev/tty

if [[ "$typed" == "" ]]; then glogin; fi
if [[ "$typed" == "Exit" || "$typed" == "exit" || "$typed" == "EXIT" ]]; then clonestart; fi

gcloud auth login --account = $typed
gcloud info | grep Account: | cut -c 10- > /pg/var/project.account
account=$(cat /pg/var/project.account)

testcheck=$(gcloud auth list | grep "$typed")
if [[ "$testcheck" == "" ]]; then
echo
echo "INFO CHECK: E-Mail Address Failed!"
read -p '↘️  Acknowledge Info | Press [ENTER] ' typed < /dev/tty
glogin
fi

echo "$typed" > /pg/rclone/pgclone.email
}
