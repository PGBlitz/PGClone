#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
clonestartoutput () {
pgclonevars

if [[ "$demo" == "ON " ]]; then mainid="********"; else mainid="$pgcloneemail"; fi

if [[ "$transport" == "mu" ]]; then
tee <<-EOF
[1] Client ID & Secret    [${pgcloneid}]
[2] GDrive                [$gstatus]
EOF
elif [[ "$transport" == "me" ]]; then
tee <<-EOF
[1] Client ID & Secret    [${pgcloneid}]
[2] Passwords             [$pstatus]
[3] GDrive                [$gstatus] - [$gcstatus]
EOF
elif [[ "$transport" == "bu" ]]; then
tee <<-EOF
[1] Google Account Login  [$mainid]
[2] Project Name          [$pgcloneproject]
[3] Client ID & Secret    [${pgcloneid}]
[4] TDrive Label          [$tdname]
[5] TDrive OAuth          [$tstatus]
[6] GDrive OAuth          [$gstatus]
[7] Key Management        [$displaykey] Built
EOF
elif [[ "$transport" == "be" ]]; then
tee <<-EOF
[1] Google Account Login  [$mainid]
[2] Project Name          [$pgcloneproject]
[3] Client ID & Secret    [${pgcloneid}]
[4] Passwords             [$pstatus]
[5] TDrive Label          [$tdname]
[6] TDrive | TCrypt       [$tstatus] - [$tcstatus]
[7] GDrive | GCrypt       [$gstatus] - [$gcstatus]
[8] Key Management        [$displaykey] Built
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
if [[ "$transport" == "mu" || "$transport" == "me" ]]; then
throttle=$(cat /var/plexguide/move.bw)
output1="[C] Transport Select"
else
throttle=$(cat /var/plexguide/blitz.bw)
output1="[C] Options"
fi

if [[ "$transport" != "mu" && "$transport" != "me" && "$transport" != "bu" && "$transport" != "me" ]]; then
rm -rf /var/plexguide/pgclone.transport 1>/dev/null 2>&1
mustset; fi

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 Welcome to PG Clone ~ http://pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
clonestartoutput

tee <<-EOF

[A] Deploy                [Not Deployed]
[B] Throttle              [${throttle} MB]
$output1
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
          publicsecretchecker
          echo "gdrive" > /var/plexguide/rclone/deploy.version
          oauth ;;
      z )
          exit ;;
      Z )
          exit ;;
      a )
          publicsecretchecker
          mountchecker
          deploypgmove
          ;; ## fill
      A )
          publicsecretchecker
          mountchecker
          deploypgmove
          ;; ## flll
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
          publicsecretchecker
          blitzpasswordmain ;;
      3 )
          publicsecretchecker
          passwordcheck
          echo "gdrive" > /var/plexguide/rclone/deploy.version
          oauth ;;
      z )
          exit ;;
      Z )
          exit ;;
      a )
          publicsecretchecker
          passwordcheck
          mountchecker
          deploypgmove
          ;; ## fill
      A )
          publicsecretchecker
          passwordcheck
          mountchecker
          deploypgmove
          ;; ## flll
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
            publicsecretchecker
            tlabeloauth ;;
        3 )
            publicsecretchecker
            tlabelchecker
            echo "tdrive" > /var/plexguide/rclone/deploy.version
            oauth ;;
        4 )
            publicsecretchecker
            echo "gdrive" > /var/plexguide/rclone/deploy.version
            oauth ;;
        5 )
            mountchecker
            keymanagementinterface ;;
        z )
            exit ;;
        Z )
            exit ;;
        a )
            publicsecretchecker
            tlabelchecker
            mountchecker
            deploypgblitz
            ;; ## fill
        A )
            publicsecretchecker
            tlabelchecker
            mountchecker
            deploypgblitz
            ;; ## flll
        b )
            setthrottleblitz ;;
        B )
            setthrottleblitz ;;
        c )
            optionsmenu ;;
        C )
            optionsmenu ;;
        * )
            clonestart ;;
      esac
elif [[ "$transport" == "be" ]]; then
  case $typed in
        1 )
            keyinputpublic ;;
        2 )
            publicsecretchecker
            blitzpasswordmain ;;
        3 )
            publicsecretchecker
            tlabeloauth ;;
        4 )
            publicsecretchecker
            passwordcheck
            tlabelchecker
            echo "tdrive" > /var/plexguide/rclone/deploy.version
            oauth ;;
        5 )
            publicsecretchecker
            passwordcheck
            echo "gdrive" > /var/plexguide/rclone/deploy.version
            oauth ;;

        6 )
            publicsecretchecker
            passwordcheck
            tlabelchecker
            mountchecker
            keymanagementinterface ;;
        z )
            exit ;;
        Z )
            exit ;;
        a )
            publicsecretchecker
            passwordcheck
            tlabelchecker
            mountchecker
            deploypgblitz
            ;; ## fill
        A )
            publicsecretchecker
            passwordcheck
            tlabelchecker
            mountchecker
            deploypgblitz
            ;; ## flll
        b )
            setthrottleblitz ;;
        B )
            setthrottleblitz ;;
        c )
            optionsmenu ;;
        C )
            optionsmenu ;;
        * )
            clonestart ;;
      esac
fi
clonestart
}

optionsmenu () {
pgclonevars
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 Options Interface ~ http://pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[A] Transport Select         | INFO: Change Transport Type
[B] Destroy All Service Keys | WARN: Wipes All Keys for the Project
[C] Create New Project       | WARN: Resets Everything!
[D] Demo Mode - ${demo}          | Hide the E-Mail Address on the Front
[Z] Exit

NOTE: When creating a NEW PROJECT (option C), the USER must create the
CLIENT ID and SECRET for that project! We will assist in creating the
project and enabling the API! Everything reets when complete!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -rp '↘️  Input Selection | Press [ENTER]: ' typed < /dev/tty

case $typed in
      1 )
          transportselect ;;
      2 )
          publicsecretchecker
          blitzpasswordmain ;;
      d )
          demomode ;;
      D )
          demomode ;;
      Z )
          clonestart ;;
      z )
          clonestart ;;
      * )
          optionsmenu ;;
esac
}

demomode () {
  if [[ "$demo" = "OFF" ]]; then echo "ON " > /var/plexguide/pgclone.demo
  else echo "OFF" > /var/plexguide/pgclone.demo; fi

pgclonevars
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 DEMO MODE IS NOW: $demo | PRESS [ENTER] to CONFIRM!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -rp '' typed < /dev/tty
optionsmenu

}
