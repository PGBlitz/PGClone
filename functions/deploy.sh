#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
deploypgblitz () {
  deployblitzstartcheck
# RCLONE BUILD
echo "#------------------------------------------" > /opt/appdata/plexguide/rclone.conf
echo "#RClone Rewrite | Visit https://pgblitz.com" >> /opt/appdata/plexguide/rclone.conf
echo "#------------------------------------------" >> /opt/appdata/plexguide/rclone.conf

cat /opt/appdata/plexguide/.gdrive >> /opt/appdata/plexguide/rclone.conf

if [ -e "/opt/appdata/plexguide/.gcrypt" ]; then
cat /opt/appdata/plexguide/.gcrypt >> /opt/appdata/plexguide/rclone.conf; fi

cat /opt/appdata/plexguide/.tdrive >> /opt/appdata/plexguide/rclone.conf

if [ -e "/opt/appdata/plexguide/.tcrypt" ]; then
cat /opt/appdata/plexguide/.tcrypt >> /opt/appdata/plexguide/tclone.conf; fi

cat /opt/appdata/plexguide/.keys >> /opt/appdata/plexguide/rclone.conf

deployblitzcheck
}

deployblitzcheck () {

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Conducting RClone Mount Checks ~ pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

ginital=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf gdrive: | grep -oP plexguide | head -n1)
tinital=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf tdrive: | grep -oP plexguide | head -n1)
kinital=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf GDSA01: | grep -oP plexguide | head -n1)

if [[ "$ginital" != "plexguide" ]]; then
  rclone mkdir --config /opt/appdata/plexguide/rclone.conf gdrive:/plexguide; fi
if [[ "$tinital" != "plexguide" ]]; then
  rclone mkdir --config /opt/appdata/plexguide/rclone.conf tdrive:/plexguide; fi
if [[ "$kinital" != "plexguide" ]]; then
  rclone mkdir --config /opt/appdata/plexguide/rclone.conf GDSA01:/plexguide; fi

gsecond=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf gdrive: | grep -oP plexguide | head -n1)
tsecond=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf tdrive: | grep -oP plexguide | head -n1)
ksecond=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf GDSA01: | grep -oP plexguide | head -n1)

fail=0
if [[ "$gsecond" == "plexguide" ]]; then echo "GDRIVE: Passed"; else echo "GDRIVE: Failed" && fail=1; fi
if [[ "$tsecond" == "plexguide" ]]; then echo "TDRIVE: Passed"; else echo "GDRIVE: Failed" && fail=1; fi
if [[ "$ksecond" == "plexguide" ]]; then echo "GDSA01: Passed"; else echo "GDSA01: Failed" && fail=1; fi

if [[ "$fail" == "0" ]]; then
  echo ""
  read -p '↘️  BLITZ DEPLOY NOT READY ~ PASSED TEST | Press [ENTER] ' typed2 < /dev/tty
  #pgblitzpass
else
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 RClone Mount Checks - Failed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

POSSIBLE REASONS:
1. GSuite Account is no longer valid or suspended
2. User forgot to share out GDSA E-Mail to Team Drive
3. Conducted a Blitz Key restore and keys are no longer valid

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -p '↘️  Acknowledge Info | Press [ENTER] ' typed2 < /dev/tty
clonestart
fi
}

########################################################################################

deploypgmove () {
# RCLONE BUILD
echo "#------------------------------------------" > /opt/appdata/plexguide/rclone.conf
echo "#RClone Rewrite | Visit https://pgblitz.com" >> /opt/appdata/plexguide/rclone.conf
echo "#------------------------------------------" >> /opt/appdata/plexguide/rclone.conf

cat /opt/appdata/plexguide/.gdrive > /opt/appdata/plexguide/rclone.conf

if [[ $(cat "/opt/appdata/plexguide/.gcrypt") != "NOT-SET" ]]; then
echo ""
cat /opt/appdata/plexguide/.gcrypt >> /opt/appdata/plexguide/rclone.conf; fi
deploymovecheck
}

deploymovecheck () {

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Conducting RClone Mount Checks ~ pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

ginital=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf gdrive: | grep -oP plexguide | head -n1)

if [[ "$ginital" != "plexguide" ]]; then
  rclone mkdir --config /opt/appdata/plexguide/rclone.conf gdrive:/plexguide; fi

gsecond=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf gdrive: | grep -oP plexguide | head -n1)

if [[ "$gsecond" == "plexguide" ]]; then echo "GDRIVE: Passed"; else echo "GDRIVE: Failed"; fi

if [[ "$gsecond" == "plexguide" ]]; then
  echo ""
  read -p '↘️  PG MOVE DEPLOYMENT NOT READY | Press [ENTER]' typed2 < /dev/tty
  #pgblitzpass
else
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 RClone Mount Checks - Failed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

POSSIBLE REASONS:
1. GSuite Account is no longer valid or suspended
2. User forgot to share out GDSA E-Mail to Team Drive
3. Conducted a Blitz Key restore and keys are no longer valid

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -p '↘️  Acknowledge Info | Press [ENTER] ' typed2 < /dev/tty
clonestart
fi
}

deployblitzstartcheck () {

pgclonevars
if [[ "$displaykey" == "0" ]]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 Fail Notice ~ pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💬  There are [0] keys generated for PG Blitz! Create those first!

NOTE: Without any keys, PG Blitz cannot upload any data without the use
of service accounts

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

read -p '↘️  Acknowledge Info | Press [ENTER] ' typed < /dev/tty
clonestart
fi

}
