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

if [[ $(cat "/opt/appdata/plexguide/.gcrypt") != "NOT-SET" ]]; then
echo ""
cat /opt/appdata/plexguide/.gcrypt >> /opt/appdata/plexguide/rclone.conf; fi

cat /opt/appdata/plexguide/.tdrive >> /opt/appdata/plexguide/rclone.conf

if [[ $(cat "/opt/appdata/plexguide/.tcrypt") != "NOT-SET" ]]; then
echo ""
cat /opt/appdata/plexguide/.tcrypt >> /opt/appdata/plexguide/rclone.conf; fi

cat /opt/appdata/plexguide/.keys >> /opt/appdata/plexguide/rclone.conf

deployblitzcheck
}

deployblitzcheck () {

tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Conducting RClone Mount Checks [BLITZ] ~ pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
ginital=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf gdrive: | grep -oP plexguide | head -n1)
tinital=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf tdrive: | grep -oP plexguide | head -n1)
kinital=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf GDSA01: | grep -oP plexguide | head -n1)

# For Encryption
if [[ "$transport" == "be" ]]; then
  c1inital=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf gdrive: | grep -oP encrypt | head -n1)
  c2inital=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf gcrypt: | grep -oP plexguide | head -n1)
  c3inital=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf GDSA01C: | grep -oP plexguide | head -n1); fi

if [[ "$ginital" != "plexguide" ]]; then
  rclone mkdir --config /opt/appdata/plexguide/rclone.conf gdrive:/plexguide; fi
if [[ "$tinital" != "plexguide" ]]; then
  rclone mkdir --config /opt/appdata/plexguide/rclone.conf tdrive:/plexguide; fi
if [[ "$kinital" != "plexguide" ]]; then
  rclone mkdir --config /opt/appdata/plexguide/rclone.conf GDSA01C:/plexguide; fi

# For Encryption
if [[ "$transport" == "be" ]]; then
  if [[ "$c1inital" != "encrypt" && "transport" == "be" ]]; then
    rclone mkdir --config /opt/appdata/plexguide/rclone.conf gdrive:/encrypt; fi
  if [[ "$c2inital" != "plexguide" && "transport" == "be" ]]; then
    rclone mkdir --config /opt/appdata/plexguide/rclone.conf gcrypt:/plexguide; fi
  if [[ "$c3inital" != "plexguide" && "transport" == "be" ]]; then
    rclone mkdir --config /opt/appdata/plexguide/rclone.conf GDSA01C:/plexguide; fi; fi

gsecond=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf gdrive: | grep -oP plexguide | head -n1)
tsecond=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf tdrive: | grep -oP plexguide | head -n1)
ksecond=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf GDSA01: | grep -oP plexguide | head -n1)

# For Encryption
if [[ "$transport" == "be" ]]; then
  c1inital=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf gdrive: | grep -oP encrypt | head -n1)
  c2inital=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf gcrypt: | grep -oP plexguide | head -n1)
  c3inital=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf GDSA01C: | grep -oP plexguide | head -n1); fi

fail=0
echo ""
if [[ "$gsecond" == "plexguide" ]]; then echo "GDRIVE: Passed"; else echo "GDRIVE: Failed" && fail=1; fi
if [[ "$tsecond" == "plexguide" ]]; then echo "TDRIVE: Passed"; else echo "GDRIVE: Failed" && fail=1; fi
if [[ "$ksecond" == "plexguide" ]]; then echo "GDSA01: Passed"; else echo "GDSA01: Failed" && fail=1; fi

# For Encryption
if [[ "$transport" == "be" ]]; then
if [[ "$c1inital" == "encrypt" ]]; then echo "CRYPT1: Passed"; else echo "CRYPT1: Failed" && fail=1; fi
if [[ "$c2inital" == "plexguide" ]]; then echo "CRYPT2: Passed"; else echo "CRYPT2: Failed" && fail=1; fi
if [[ "$c3inital" == "plexguide" ]]; then echo "CRYPT3: Passed"; else echo "CRYPT3: Failed" && fail=1; fi; fi

if [[ "$fail" != "1" ]]; then
  echo ""

  # executes function when everything is good to deploy move
  executeblitz
else

if [[ "$transport" == "be" ]]; then
emessage="
CRYPT1 = Encrypt Folder Failed to Create @ GDRIVE
CRYPT2 = GCrypt is Failing
CRYPT3 = TCrypt is Failing
"; fi

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 RClone Mount Checks - Failed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

CANNOT DEPLOY PGBLITZ!

POSSIBLE REASONS:
1. GSuite Account is no longer valid or suspended
2. User forgot to share out GDSA E-Mail to Team Drive
3. Conducted a blitz key restore and keys are no longer valid
$emessage
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
🚀 Conducting RClone Mount [MOVE] Checks ~ pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

ginital=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf gdrive: | grep -oP plexguide | head -n1)

if [[ "$ginital" != "plexguide" ]]; then
  rclone mkdir --config /opt/appdata/plexguide/rclone.conf gdrive:/plexguide; fi

gsecond=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf gdrive: | grep -oP plexguide | head -n1)

# For Encryption
if [[ "$transport" == "me" ]]; then
c1inital=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf gdrive: | grep -oP encrypt | head -n1)
c2inital=$(rclone lsd --config /opt/appdata/plexguide/rclone.conf gcrypt: | grep -oP plexguide | head -n1); fi

# For Encryption
if [[ "$c1inital" != "encrypt" && "$transport" == "me" ]]; then
  rclone mkdir --config /opt/appdata/plexguide/rclone.conf gdrive:/encrypt; fi
if [[ "$c2inital" != "plexguide" && "$transport" == "me" ]]; then
  rclone mkdir --config /opt/appdata/plexguide/rclone.conf gcrypt:/plexguide; fi

if [[ "$gsecond" == "plexguide" ]]; then echo "GDRIVE: Passed"; else echo "GDRIVE: Failed" && fail=1; fi

# For Encryption
if [[ "$transport" == "me" ]]; then
if [[ "$c1inital" == "encrypt" ]]; then echo "CRYPT1: Passed"; else echo "CRYPT1: Failed" && fail=1; fi
if [[ "$c2inital" == "plexguide" ]]; then echo "CRYPT2: Passed"; else echo "CRYPT2: Failed" && fail=1; fi; fi

if [[ "$fail" != "1" ]]; then

  # executes function when everything is good to deploy move
  executemove
else
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 RClone Mount Checks - Failed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

CANNOT DEPLOY PGMOVE!

POSSIBLE REASONS:
1. GSuite Account is no longer valid or suspended
2. Keys are Invalid

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
