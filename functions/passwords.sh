#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
blitzpasswordmain () {
pgclonevars

clonepassword57=$(cat /var/plexguide/clone.password)
clonesalt57=$(cat /var/plexguide/clone.salt)

if [[ "$pstatus" != "NOT-SET" ]]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 PG Clone - Change Values? ~ pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Password (Primary)
$clonepassword57

Password (SALT/Secondary)
$clonesalt57

Change the Stored Values?
[1] No [2] Yes

WARNING: Changing the values will RESET & DELETE the following:
1. GDrive
2. TDrive
3. Service Keys

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -p '↘️  Input Value | Press [Enter]: ' typed < /dev/tty
case $typed in
2 )
    rm -rf /var/plexguide/clone.password 1>/dev/null 2>&1
    rm -rf /var/plexguide/clone.salt 1>/dev/null 2>&1

    rm -rf /opt/appdata/plexguide/.gcrypt 1>/dev/null 2>&1
    rm -rf /opt/appdata/plexguide/.gdrive 1>/dev/null 2>&1
    rm -rf /opt/appdata/plexguide/.tcrypt 1>/dev/null 2>&1
    rm -rf /opt/appdata/plexguide/.tdrive 1>/dev/null 2>&1
    rm -rf /var/plexguide/pgclone.teamdrive 1>/dev/null 2>&1
    ;;
1 )
    clonestart ;;
* )
    blitzpasswordmain ;;
esac
fi

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 Primary Password ~ pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Set a Primary Password for data encryption! DO NOT forget the password!
If you do, we are UNABLE to recover all of your DATA! That is the primary
risk of encryption; forgetfulness will cost you!

Quitting? Type >>> exit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -p '↘️  Type Main Password | Press [ENTER]: ' typed < /dev/tty

  if [[ "$typed" == "exit" || "$typed" == "Exit" || "$typed" == "EXIT" ]]; then clonestart; fi
  if [[ "$typed" == "" ]]; then blitzpasswordmain; fi
  primarypassword=$typed
  blitzpasswordsalt
}

blitzpasswordsalt () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 SALT (SALT Password) ~ pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
NOTE: We do not recommended using the same password! SALT adds randomness
to your original password.

Set a SALT password for data encryption! DO NOT forget the password!
If you do, we are UNABLE to recover all of your DATA! That is the primary
risk of encryption; forgetfulness will cost you!

Quitting? Type >>> exit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -p '↘️  Type SALT Password | Press [ENTER]: ' typed < /dev/tty

  if [[ "$typed" == "exit" || "$typed" == "Exit" || "$typed" == "EXIT" ]]; then clonestart; fi
  if [[ "$typed" == "" ]]; then blitzpasswordsalt; fi

secondarypassword=$typed
blitzpasswordfinal

}

blitzpasswordfinal () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 Set Passwords ~ pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Set the Following Passwords? Type y or n!

Primary: $primarypassword
SALT   : $secondarypassword

Quitting? Type >>> exit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

read -p '↘️  Type y or n | Press [ENTER]: ' typed < /dev/tty

if [[ "$typed" == "n" ]]; then blitzpasswordmain;
elif [[ "$typed" == "y" ]]; then
echo $primarypassword > /var/plexguide/clone.password
echo $secondarypassword > /var/plexguide/clone.salt
else blitzpasswordfinal; fi

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 Process Complete ~ pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💬  Password & SALT are now SET! Do not forget the data!

NOTE: If you set this up again, ensure to reuse the same passwords in
order to read the data!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -p '↘️  Acknowledge Info | Press [ENTER] ' typed < /dev/tty
clonestart
}

passwordcheck () {
pgclonevars

if [[ "$pstatus" == "NOT-SET" ]]; then

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 Password Notice ~ pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💬  Utilizing Encryption requires setting passwords first!

NOTE: When setting the passwords, they act as a private key in order
to encrypt your data!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -p '↘️  Acknowledge Info | Press [ENTER] ' typed < /dev/tty
clonestart; fi
}
