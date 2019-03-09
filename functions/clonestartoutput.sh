#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
clonestartoutput () {
pgclonevars
if [[ "$transport" == "mu" ]]; then
tee <<-EOF
[1] Client ID & Secret  [${pgcloneid}]
[2] GDrive              [$gstatus]
EOF
elif [[ "$transport" == "me" ]]; then
tee <<-EOF
[1] Client ID & Secret  [${pgcloneid}]
[2] Passwords           [$pstatus]
[3] GDrive              [$gstatus] - [$gcstatus]
EOF
elif [[ "$transport" == "bu" ]]; then
tee <<-EOF
[1] Client ID & Secret  [${pgcloneid}]
[2] TDrive Label        [$tdname]
[3] GDrive OAuth        [$gstatus]
[4] TDrive OAuth        [$tstatus]
[5] Key Management      [0] Built
EOF
elif [[ "$transport" == "be" ]]; then
tee <<-EOF
[1] Client ID & Secret  [${pgcloneid}]
[2] TDrive Label        [$tdname]
[3] Passwords           [$pstatus]
[4] GDrive | GCrypt     [$gstatus] - [$gcstatus]
[5] TDrive | TCrypt     [$tstatus] - [$tcstatus]
[6] Key Management      [0] Built
EOF
fi
}

errorteamdrive ()

{
if [[ "$tdname" == "NOT-SET" ]]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Setup the TDrive Label First! ~ http://pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTE: Set up your TDrive Label prior to executing the TDrive OAuth.
Basically, we cannot authorize a TeamDrive without knowing which
TeamDrive is being utilized first!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -rp '↘️  Acknowledge Info | Press [ENTER] ' typed < /dev/tty
clonestart
fi
}

clonestart () {
pgclonevars

# pull throttle speeds based on role
if [[ "$transport" == "mu" || "$transport" == "me" ]]; then throttle=$(cat /var/plexguide/move.bw)
else throttle=$(cat /var/plexguide/blitz.bw); fi

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 Welcome to PG Clone ~ http://pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
clonestartoutput

tee <<-EOF

[A] Deploy              [PG Move /w No Encryption]
[B] Throttle            [${throttle} MB]
[C] Change              Switch Transport Method
[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -rp '↘️  Input Selection | Press [ENTER]: ' typed < /dev/tty
clonestartactions
}

clonestartactions () {
if [[ "$transport" == "mu" ]]; then
  case $typed in
      1 )
          keyinputpublic ;;
      2 )
          echo "gdrive" > /var/plexguide/rclone/deploy.version
          oauth ;;
      z )
          exit ;;
      Z )
          exit ;;
      b )
          setthrottlemove ;;
      B )
          setthrottlemove ;;
      c )
          transportselect ;;
      C )
          transportselect ;;
      * )
          clonestart ;;
    esac
elif [[ "$transport" == "me" ]]; then
  case $typed in
      1 )
          keyinputpublic ;;
      2 )
          blitzpasswordmain ;;
      3 )
          echo "gdrive" > /var/plexguide/rclone/deploy.version
          oauth ;;
      z )
          exit ;;
      Z )
          exit ;;
      b )
          setthrottlemove ;;
      B )
          setthrottlemove ;;
      c )
          transportselect ;;
      C )
          transportselect ;;
      * )
          clonestart ;;
    esac
elif [[ "$transport" == "bu" ]]; then
  case $typed in
        1 )
            keyinputpublic ;;
        2 )
            tlabeloauth ;;
        3 )
            echo "gdrive" > /var/plexguide/rclone/deploy.version
            oauth ;;
        4 )
            echo "tdrive" > /var/plexguide/rclone/deploy.version
            oauth ;;
        5 )
            keymanagementinterface ;;
        z )
            exit ;;
        Z )
            exit ;;
        b )
            setthrottleblitz ;;
        B )
            setthrottleblitz ;;
        c )
            transportselect ;;
        C )
            transportselect ;;
        * )
            clonestart ;;
      esac
elif [[ "$transport" == "be" ]]; then
  case $typed in
        1 )
            keyinputpublic ;;
        2 )
            tlabeloauth ;;
        3 )
            blitzpasswordmain ;;
        4 )
            echo "gdrive" > /var/plexguide/rclone/deploy.version
            oauth ;;
        5 )
            echo "tdrive" > /var/plexguide/rclone/deploy.version
            oauth ;;
        6 )
            keymanagementinterface ;;
        z )
            exit ;;
        Z )
            exit ;;
        b )
            setthrottleblitz ;;
        B )
            setthrottleblitz ;;
        c )
            transportselect ;;
        C )
            transportselect ;;
        * )
            clonestart ;;
      esac
else
  echo "NOT-SET" > /var/plexguide/pgclone.transport
  transportselect
fi
clonestart
}
