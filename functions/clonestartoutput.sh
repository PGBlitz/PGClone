#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Authors:    Admin9705, Deiteq, and many PGBlitz Contributors
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
rcstored="$(rclone --version | awk '{print $2}' | tail -n 3 | head -n 1 )"
sudocheck() {
  if [[ $EUID -ne 0 ]]; then
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  You Must Execute as a SUDO USER (with sudo) or as ROOT!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    exit 0
  fi
}
clonestartoutput() {
    pgclonevars
echo "ACTIVELY DEPLOYED: 	  $dversionoutput "
echo ""
    if [[ "$demo" == "ON " ]]; then mainid="********"; else mainid="$pgcloneemail"; fi
    if [[ "$transport" == "mu" ]]; then
        tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] Client ID & Secret       [ ${pgcloneid} ]
[2] GDrive                   [ $gstatus ]

EOF
    elif [[ "$transport" == "me" ]]; then
        tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] Client ID & Secret       [ ${pgcloneid} ]
[2] Passwords                [ $pstatus ]
[3] GDrive                   [ $gstatus ] - [ $gcstatus ]

EOF
    elif [[ "$transport" == "bu" ]]; then
        tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] Google Account Login     [ $mainid ]
[2] Project Name             [ $pgcloneproject ]
[3] Client ID & Secret       [ ${pgcloneid} ]
[4] TDrive Label             [ $tdname ]
[5] TDrive OAuth             [ $tstatus ]
[6] GDrive OAuth             [ $gstatus ] 
[7] Key Management           [ $displaykey ] Built
[8] TDrive	             ( E-Mail Share Generator )
EOF
    elif [[ "$transport" == "be" ]]; then
        tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] Google Account Login     [ $mainid ]
[2] Project Name             [ $pgcloneproject ]
[3] Client ID & Secret       [ ${pgcloneid} ]
[4] Passwords                [ $pstatus ]
[5] TDrive Label             [ $tdname ]
[6] TDrive | TCrypt          [ $tstatus ] - [ $tcstatus ]
[7] GDrive | GCrypt          [ $gstatus ] - [ $gcstatus ]
[8] Key Management           [ $displaykey ] Built
[9] TDrive	             ( E-Mail Share Generator )

EOF
    elif [[ "$transport" == "le" ]]; then
        tee <<-EOF
NOTE: The default drive is already factored in! Only additional locations
or hard drives are required to be added!
EOF
    fi
}
errorteamdrive() {
    if [[ "$tdname" == "NOT-SET" ]]; then
        tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Setup the TDrive Label First!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTE: Set up your TDrive Label prior to executing the TDrive OAuth.
Basically, we cannot authorize a TeamDrive without knowing which
TeamDrive is being utilized first!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
        read -rp '↘️  Acknowledge Info | Press [ENTER] ' typed </dev/tty
        clonestart
    fi
}
clonestart() {
    pgclonevars
    # pull throttle speeds based on role
    if [[ "$transport" == "mu" || "$transport" == "me" ]]; then
        output1="[C] Transport Select"
    fi
    if [[ "$transport" != "mu" && "$transport" != "me" && "$transport" != "bu" && "$transport" != "be" && "$transport" != "le" ]]; then
        rm -rf /var/plexguide/pgclone.transport 1>/dev/null 2>&1
        mustset
    fi
    if [[ "$transport" == "mu" ]]; then
        outputversion="Unencrypted Mounts"
        output="Gdrive"
    elif [[ "$transport" == "me" ]]; then
        outputversion="Encrypted Mounts"
        output="Gcrypt"
    elif [[ "$transport" == "bu" ]]; then
        outputversion="Unencrypted Mounts"
        output="TDrive"
    elif [[ "$transport" == "be" ]]; then
        outputversion="Encrypted Mounts"
        output="Tcrypt"
    elif [[ "$transport" == "le" ]]; then
        outputversion="Local Hard Drives"
    fi
    if [[ "$transport" == "le" ]]; then
        tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 Welcome to the Local-Edition || mergerfs $mgstored
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
        clonestartoutput
        tee <<-EOF

[1] Deploy               ( Local HD / Mounts )
[2] MultiHD              ( Add Mounts or Hard Drives )
[3] Transport            ( Change Transportion Mode )

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[Z] Exit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


EOF
        read -rp '↘️  Input Selection | Press [ENTER]: ' typed </dev/tty
        localstartoutput
    else
        tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 Welcome to rClone      rclone $rcstored
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
        clonestartoutput
        dockerstatus
        dockerstatusmounts
        tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[A] Deploy Docker Mounts     [ $dmstatus ]
[D] Deploy Docker Uploader   [ $dstatus ] - [ $output ]
[O] Options
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Z] Exit

EOF
        read -rp '↘️  Input Selection | Press [ENTER]: ' typed </dev/tty
        clonestartactions
    fi
}
dockerstatus() {
upper=$(docker ps --format '{{.Names}}' | grep "uploader")
if [[ "$upper" == "uploader" ]]; then
 dstatus="✅ DEPLOYED"
  else dstatus="⚠️ NOT DEPLOYED"; fi
}
dockerstatusmounts() {
dmount=$(docker ps --format '{{.Names}}' | grep "mount")
if [[ "$dmount" == "mount" ]]; then
 dmstatus="✅ DEPLOYED"
  else dmstatus="⚠️ NOT DEPLOYED"; fi
}
localstartoutput() {
    case $typed in
    1) executelocal ;;
    2) bash /opt/plexguide/menu/multihd/multihd.sh ;;
    3) transportselect ;;
    z) exit ;;
    Z) exit ;;
    *) clonestart ;;
    esac
    clonestart
}
clonestartactions() {
    if [[ "$transport" == "mu" ]]; then
        case $typed in
        1) keyinputpublic ;;
        2) publicsecretchecker && echo "gdrive" >/var/plexguide/rclone/deploy.version && oauth ;;
        z) exit ;;
        Z) exit ;;
        a) publicsecretchecker && deploydockermount ;;
        A) publicsecretchecker && deploydockermount ;;
        D) publicsecretchecker && deploydockeruploader ;;
        d) publicsecretchecker && deploydockeruploader ;;
        o) optionsmenumove ;;
        O) optionsmenumove ;;
        *) clonestart ;;
        esac

    elif [[ "$transport" == "me" ]]; then
        case $typed in
        1) keyinputpublic ;;
        2) publicsecretchecker && blitzpasswordmain ;;
        3) publicsecretchecker && passwordcheck && echo "gdrive" >/var/plexguide/rclone/deploy.version && oauth ;;
        z) exit ;;
        Z) exit ;;
        a) publicsecretchecker && passwordcheck && deploydockermount ;;
        A) publicsecretchecker && passwordcheck && deploydockermount ;;
        D) publicsecretchecker && passwordcheck && deploydockeruploader ;;
        d) publicsecretchecker && passwordcheck && deploydockeruploader ;;
        o) optionsmenumove ;;
        O) optionsmenumove ;;
        *) clonestart ;;
        esac

    elif [[ "$transport" == "bu" ]]; then
        case $typed in
        1) glogin ;;
        2) exisitingproject ;;
        3) keyinputpublic ;;
        4) publicsecretchecker && tlabeloauth ;;
        5) publicsecretchecker && tlabelchecker && echo "tdrive" >/var/plexguide/rclone/deploy.version && oauth ;;
        6) publicsecretchecker && echo "gdrive" >/var/plexguide/rclone/deploy.version && oauth ;;
        7) publicsecretchecker && tlabelchecker && projectnamecheck && keystart && gdsaemail ;;
        8) publicsecretchecker && tlabelchecker && projectnamecheck && deployblitzstartcheck && emailgen ;;
        z) exit ;;
        Z) exit ;;
        a) publicsecretchecker && tlabelchecker && deploydockermount ;;
        A) publicsecretchecker && tlabelchecker && deploydockermount ;;
        D) publicsecretchecker && tlabelchecker && deploydockeruploader ;;
        d) publicsecretchecker && tlabelchecker && deploydockeruploader ;;
        b) publicsecretchecker && keybackup ;;
        B) publicsecretchecker && keybackup ;;
        o) optionsmenu ;;
        O) optionsmenu ;;
        *) clonestart ;;
        esac

    elif [[ "$transport" == "be" ]]; then
        case $typed in
        1) glogin ;;
        2) exisitingproject ;;
        3) keyinputpublic ;;
        4) publicsecretchecker && blitzpasswordmain ;;
        5) publicsecretchecker && tlabeloauth ;;
        6) publicsecretchecker && passwordcheck && tlabelchecker && echo "tdrive" >/var/plexguide/rclone/deploy.version && oauth ;;
        7) publicsecretchecker && passwordcheck && echo "gdrive" >/var/plexguide/rclone/deploy.version && oauth ;;
        8) publicsecretchecker && passwordcheck && tlabelchecker && projectnamecheck && keystart && gdsaemail ;;
        9) publicsecretchecker && passwordcheck && tlabelchecker && projectnamecheck && deployblitzstartcheck && emailgen ;;
        z) exit ;;
        Z) exit ;;
        a) publicsecretchecker && passwordcheck && tlabelchecker && deploydockermount ;;
        A) publicsecretchecker && passwordcheck && tlabelchecker && deploydockermount ;;
        D) publicsecretchecker && passwordcheck && tlabelchecker && deploydockeruploader ;;
        d) publicsecretchecker && passwordcheck && tlabelchecker && deploydockeruploader ;;
        o) optionsmenu ;;
        O) optionsmenu ;;
        *) clonestart ;;
        esac
    fi
    clonestart
}
# For Blitz
optionsmenu() {
    pgclonevars
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 Options Interface
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] Transport Select             | INFO: Change Transport Type
[2] Multi-HD Option              | INFO: Add Multi-Points and Options
[3] Destroy All Service Keys     | WARN: Wipes All Keys for the Project
[4] Create New Project           | WARN: Resets Everything
[5] Demo Mode                    | Hide the E-Mail Address on the Front

[6] Create a TeamDrive

NOTE: When creating a NEW PROJECT, the USER must create the
CLIENT ID and SECRET for that project! We will assist in creating the
project and enabling the API! Everything resets when complete!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[Z] Exit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    read -rp '↘️  Input Selection | Press [ENTER]: ' typed </dev/tty

    case $typed in
    1)  transportselect && clonestart ;;
    2)  bash /opt/plexguide/menu/multihd/multihd.sh ;;
    3)  deletekeys ;;
    4)  projectnameset ;;
    5)  demomode ;;
    6)  ctdrive ;;
    Z)  clonestart ;;
    z)  clonestart ;;
    *)  optionsmenu ;;
    esac
    optionsmenu
}
# For Move
optionsmenumove() {
    pgclonevars
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 Options Interface
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] Transport Select           | INFO: Change Transport Type
[2] Multi-HD Option            | INFO: Add Multi-Points and Options

NOTE: When creating a NEW PROJECT, the USER must create the
CLIENT ID and SECRET for that project! We will assist in creating the
project and enabling the API! Everything resets when complete!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[Z] Exit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    read -rp '↘️  Input Selection | Press [ENTER]: ' typed </dev/tty

    case $typed in
    1) transportselect && clonestart ;;
    2) bash /opt/plexguide/menu/multihd/multihd.sh ;;
    Z) clonestart ;;
    z) clonestart ;;
    *) optionsmenu ;;
    esac
    optionsmenu
}
demomode() {
    if [[ "$demo" == "OFF" ]]; then
        echo "ON " >/var/plexguide/pgclone.demo
    else echo "OFF" >/var/plexguide/pgclone.demo; fi

    pgclonevars
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 DEMO MODE IS NOW: $demo | PRESS [ENTER] to CONFIRM!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    read -rp '' typed </dev/tty
    optionsmenu
}
