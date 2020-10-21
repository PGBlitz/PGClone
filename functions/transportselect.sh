#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Authors:    Admin9705, Deiteq, and many PGBlitz Contributors
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
transportselect() {
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 Set Clone Method 
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] TDrive-Unencrypt: Data > Complex | Exceed 750GB Transport Cap
[2] TDrive-Encrypted: Data > Complex | Exceed 750GB Transport Cap

[3] Local Edition   : Local HDs      | Easy  Utilizes System's HD's Only

[Z] EXIT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

    read -rp '↘️  Input Selection | Press [ENTER]: ' typed </dev/tty

    case $typed in
    1)
        echo "bu" >/var/plexguide/pgclone.transport
        echo "Blitz" >/var/plexguide/pg.transport
        ;;
    2)
        echo "be" >/var/plexguide/pgclone.transport
        echo "Blitz Encrypted" >/var/plexguide/pg.transport
        ;;
    3)
        echo "le" >/var/plexguide/pgclone.transport
        echo "Local Edition" >/var/plexguide/pg.transport
        ;;
	z) exit ;;
    Z) exit ;;
    *) transportselect ;;
    esac
}
