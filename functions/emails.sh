#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
emails () {
mkdir -p /opt/appdata/pgblitz/keys/processed
path=/opt/appdata/pgblitz/keys/processed

#updated to cleaner method by PhysK
cat $path/* | grep client_email | awk '{print $2}' | sed 's/"//g' | sed 's/,//g' > /tmp/pgblitz.emails.list
touch /tmp/pgblitz.emails.list

emailcheck=$(cat /tmp/pgblitz.emails.list)
if [ "$emailcheck" == "" ]; then
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔ Warning! You Need to Generate Keys before Executing This!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -p '↘️  Acknowledge Info | Press [ENTER] ' typed < /dev/tty
keymenu
fi

echo
echo "Welcome to the PG Blitz - EMail Share Generator"
echo ""
echo "In GDRIVE, share the teamdrive with the following emails:"
echo ""
echo "NOTE 1: Make sure you SHARE with the CORRECT TEAM DRIVE!"
echo "NOTE 2: Save Time & Copy & Paste the E-Mails Into the G-Drive Share!"
echo "NOTE 3: change the default Role from Content-Manager to Contribution!"
echo "        if you don't do it,  you can lose data!"
echo
cat /tmp/pgblitz.emails.list
}
