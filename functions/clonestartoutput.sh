#!/bin/bash
#
# Title:      Reference Title File - PGBlitz
# Author(s):  Admin9705 & https://github.com/PGBlitz/PGClone/graphs/contributors
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
clonestartoutput () {
pgclonevars

echo "ACTIVELY DEPLOYED: [$dversionoutput]"
echo ""

if [[ "$demo" == "ON " ]]; then mainid="********"; else mainid="$pgcloneemail"; fi

if [[ "$transport" == "gd" ]]; then
tee <<-EOF
[1] Client ID & Secret    [${pgcloneid}]
[2] GDrive                [$gdstatus]
EOF
elif [[ "$transport" == "gc" ]]; then
tee <<-EOF
[1] Client ID & Secret    [${pgcloneid}]
[2] Passwords             [$pstatus]
[3] GDrive                [$gdstatus] - [$gcstatus]
EOF
elif [[ "$transport" == "sd" ]]; then
tee <<-EOF
[1] Google Account Login  [$mainid]
[2] Project Name          [$pgcloneproject]
[3] Client ID & Secret    [${pgcloneid}]
[4] SDrive Label          [$sdname]
[5] SDrive OAuth          [$sdstatus]
[6] GDrive OAuth          [$gdstatus]
[7] Key Management        [$displaykey] Built
[8] SDrive (E-Mail Share Generator)
EOF
elif [[ "$transport" == "sc" ]]; then
tee <<-EOF
[1] Google Account Login  [$mainid]
[2] Project Name          [$pgcloneproject]
[3] Client ID & Secret    [${pgcloneid}]
[4] Passwords             [$pstatus]
[5] SDrive Label          [$sdname]
[6] SDrive | SDrive       [$sdstatus] - [$scstatus]
[7] GDrive | GCrypt       [$gdstatus] - [$gcstatus]
[8] Key Management        [$displaykey] Built
[9] SDrive (E-Mail Share Generator)
EOF
elif [[ "$transport" == "le" ]]; then
tee <<-EOF
NOTE: The default drive is already factored in! Only additional locations
or hard drives are required to be added!
EOF
fi
}

errorteamdrive ()

{
if [[ "$sdname" == "NOT-SET" ]]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Setup the SDrive Label First! ~ http://pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTE: Set up your SDrive Label prior to executing the SDrive OAuth.
Basically, we cannot authorize a ShareDrive without knowing which
ShareDrive is being utilized first!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -rp '↘️  Acknowledge Info | Press [ENTER] ' typed < /dev/tty
clonestart
fi
}

clonestart () {
pgclonevars

# pull throttle speeds based on role
if [[ "$transport" == "gd" || "$transport" == "gc" ]]; then
throttle=$(cat /pg/var/move.bw)
output1="[C] Transport Select"
else
throttle=$(cat /pg/var/blitz.bw)
output1="[C] Options"
fi

if [[ "$transport" != "gd" && "$transport" != "gc" && "$transport" != "sd" && "$transport" != "sc" && "$transport" != "le" ]]; then
rm -rf /pg/rclone/pgclone.transport 1>/dev/null 2>&1
mustset; fi

    if [[ "$transport" == "gd" ]]; then outputversion="GDrive Unencrypted"
  elif [[ "$transport" == "gc" ]]; then outputversion="GDrive Encrypted"
  elif [[ "$transport" == "sd" ]]; then outputversion="SDrive Unencrypted"
  elif [[ "$transport" == "sc" ]]; then outputversion="SDrive Encrypted"
  elif [[ "$transport" == "le" ]]; then outputversion="Local Hard Drives"
  fi

if [[ "$transport" == "le" ]]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 Welcome to PG Clone ~ http://pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
clonestartoutput

tee <<-EOF

[1] Deploy     (Local HD/Mounts)
[2] MultiHD    (Add Mounts xor Hard Drives)
[3] Transport  (Change Transportion Mode)
[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -rp '↘️  Input Selection | Press [ENTER]: ' typed < /dev/tty

localstartoutput

else
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 Welcome to PG Clone ~ http://pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
clonestartoutput

tee <<-EOF

[A] Deploy $outputversion
[B] Throttle              [${throttle} MB]
[C] Options
[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -rp '↘️  Input Selection | Press [ENTER]: ' typed < /dev/tty
clonestartactions
fi
}

localstartoutput () {
  case $typed in
  1 )
      executelocal ;;
  2 )
      bash /pg/pgblitz/menu/pgcloner/multihd.sh ;;
  3 )
      transportselect ;;
  z )
      exit ;;
  Z )
      exit ;;
  * )
      clonestart ;;
  esac
clonestart
}

clonestartactions () {
if [[ "$transport" == "gd" ]]; then
  case $typed in
      1 )
          keyinputpublic ;;
      2 )
          publicsecretchecker
          echo "gd" > /pg/rclone/deploy.version
          oauth ;;
      z )
          exit ;;
      Z )
          exit ;;
      a )
          publicsecretchecker
          mountchecker
          deploygdrive
          ;; ## fill
      A )
          publicsecretchecker
          mountchecker
          deploygdrive
          ;; ## flll
      b )
          setthrottlemove ;;
      B )
          setthrottlemove ;;
      c )
          optionsmengu ;;
      C )
          optionsmengu ;;
      * )
          clonestart ;;
    esac
elif [[ "$transport" == "gc" ]]; then
  case $typed in
      1 )
          keyinputpublic ;;
      2 )
          publicsecretchecker
          blitzpasswordmain ;;
      3 )
          publicsecretchecker
          passwordcheck
          echo "gd" > /pg/rclone/deploy.version
          oauth ;;
      z )
          exit ;;
      Z )
          exit ;;
      a )
          publicsecretchecker
          passwordcheck
          mountchecker
          deploygdrive
          ;; ## fill
      A )
          publicsecretchecker
          passwordcheck
          mountchecker
          deploygdrive
          ;; ## flll
      b )
          setthrottlemove ;;
      B )
          setthrottlemove ;;
      c )
          optionsmengu ;;
      C )
          optionsmengu ;;
      * )
          clonestart ;;
    esac
elif [[ "$transport" == "sd" ]]; then
  case $typed in
        1 )
            glogin ;;
        2 )
            exisitingproject ;;
        3 )
            keyinputpublic ;;
        4 )
            publicsecretchecker
            tlabeloauth ;;
        5 )
            publicsecretchecker
            tlabelchecker
            echo "sd" > /pg/rclone/deploy.version
            oauth ;;
        6 )
            publicsecretchecker
            echo "gd" > /pg/rclone/deploy.version
            oauth ;;
        7 )
            publicsecretchecker
            tlabelchecker
            mountchecker
            projectnamecheck
            keystart
            gdsaemail ;;
        8 )
            publicsecretchecker
            tlabelchecker
            mountchecker
            projectnamecheck
            deployblitzstartcheck
            emailgen ;;
        z )
            exit ;;
        Z )
            exit ;;
        a )
            publicsecretchecker
            tlabelchecker
            mountchecker
            deploysdrive
            ;; ## fill
        A )
            publicsecretchecker
            tlabelchecker
            mountchecker
            deploysdrive
            ;; ## flll
        b )
            setthrottleblitz ;;
        B )
            setthrottleblitz ;;
        c )
            optionsmenu ;;
        C )
            optionsmenu ;;
        d )
            mountnumbers ;;
        D )
            mountnumbers ;;
        * )
            clonestart ;;
      esac
elif [[ "$transport" == "sc" ]]; then
  case $typed in
        1 )
            glogin ;;
        2 )
            exisitingproject ;;
        3 )
            keyinputpublic ;;
        4 )
            publicsecretchecker
            blitzpasswordmain ;;
        5 )
            publicsecretchecker
            tlabeloauth ;;
        6 )
            publicsecretchecker
            passwordcheck
            tlabelchecker
            echo "sc" > /pg/rclone/deploy.version
            oauth ;;
        7 )
            publicsecretchecker
            passwordcheck
            echo "sc" > /pg/rclone/deploy.version
            oauth ;;

        8 )
            publicsecretchecker
            passwordcheck
            tlabelchecker
            mountchecker
            projectnamecheck
            keystart
            gdsaemail ;;
        9 )
            publicsecretchecker
            passwordcheck
            tlabelchecker
            mountchecker
            projectnamecheck
            deployblitzstartcheck
            emailgen ;;
        z )
            exit ;;
        Z )
            exit ;;
        a )
            publicsecretchecker
            passwordcheck
            tlabelchecker
            mountchecker
            deploysdrive
            ;; ## fill
        A )
            publicsecretchecker
            passwordcheck
            tlabelchecker
            mountchecker
            deploysdrive
            ;; ## flll
        b )
            setthrottleblitz ;;
        B )
            setthrottleblitz ;;
        c )
            optionsmenu ;;
        C )
            optionsmenu ;;
        d )
            mountnumbers ;;
        D )
            mountnumbers ;;
        * )
            clonestart ;;
      esac
fi
clonestart
}

# For Blitz
optionsmenu () {
pgclonevars
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 Options Interface ~ http://pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] Transport Select         | INFO: Change Transport Type
[2] RClone VFS Mount Setting | INFO: Change Varibles to for the Mount
[3] Multi-HD Option          | INFO: Add Multi-Points and Options
[4] Destroy All Service Keys | WARN: Wipes All Keys for the Project
[5] Create New Project       | WARN: Resets Everything
[6] Demo Mode - ${demo}          | Hide the E-Mail Address on the Front
[7] Clone Clean - Destroy Garbage Files every [$cloneclean] minutes
[8] Change User Agent - ${uagent}
[9] Create a TeamDrive
[Z] Exit

NOTE: When creating a NEW PROJECT (option C), the USER must create the
CLIENT ID and SECRET for that project! We will assist in creating the
project and enabling the API! Everything resets when complete!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -rp '↘️  Input Selection | Press [ENTER]: ' typed < /dev/tty

case $typed in
      1 )
          transportselect
          clonestart ;;
      2 )
          mountnumbers ;;
      3 )
          bash /pg/pgblitz/menu/pgcloner/multihd.sh ;;
      4 )
          deletekeys ;;
      5 )
          projectnameset ;;
      6 )
          demomode ;;
      7 )
          cloneclean ;;
      8 )
          uagent ;;
      9 )
          csdrive ;;
      Z )
          clonestart ;;
      z )
          clonestart ;;
      * )
          optionsmenu ;;
esac
optionsmenu
}

# For Move
optionsmengu () {
pgclonevars
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 Options Interface ~ http://pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] Transport Select         | INFO: Change Transport Type
[2] RClone VFS Mount Setting | INFO: Change Varibles to for the Mount
[3] Multi-HD Option          | INFO: Add Multi-Points and Options
[4] Clone Clean - Destroy Garbage Files Every [$cloneclean] Minutes
[5] Change User Agent - ${uagent}
[Z] Exit

NOTE: When creating a NEW PROJECT (option C), the USER must create the
CLIENT ID and SECRET for that project! We will assist in creating the
project and enabling the API! Everything resets when complete!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -rp '↘️  Input Selection | Press [ENTER]: ' typed < /dev/tty

case $typed in
      1 )
          transportselect
          clonestart ;;
      2 )
          mountnumbers ;;
      3 )
          bash /pg/pgblitz/menu/pgcloner/multihd.sh ;;
      4 )
          cloneclean ;;
      5 )
          uagent ;;
      Z )
          clonestart ;;
      z )
          clonestart ;;
      * )
          optionsmenu ;;
esac
optionsmenu
}

demomode () {
  if [[ "$demo" = "OFF" ]]; then echo "ON " > /pg/rclone/pgclone.demo
  else echo "OFF" > /pg/rclone/pgclone.demo; fi

pgclonevars
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 DEMO MODE IS NOW: $demo | PRESS [ENTER] to CONFIRM!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -rp '' typed < /dev/tty
optionsmenu

}
