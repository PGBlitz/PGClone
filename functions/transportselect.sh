#!/bin/bash
#
# Title:      Reference Title File - PGBlitz
# Author(s):  Admin9705 & https://github.com/PGBlitz/PGClone/graphs/contributors
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
transportselect () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 Set PGClone Method ~ http://pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
NOTE: Please visit the link and understand what your doing first!

[1] Blitz GDrive - Unencrypt | Easy    | 750GB Daily Transfer Max
[2] Blitz GDrive - Encrypted | Novice  | 750GB Daily Transfer Max
[3] Blitz SDrive - Unencrypt | Complex | Exceed 750GB Daily Max Cap
[4] Blitz SDrive - Encrypted | Complex | Exceed 750GB Daily Max Cap
[5] Blitz Local  - Local HDs | Easy    | Utilizes Server HD's Only

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

read -rp '↘️  Input Selection | Press [ENTER]: ' typed < /dev/tty

case $typed in
    1 )
    echo "gd" > /pg/rclone/pgclone.transport ;;
    2 )
    echo "gc" > /pg/rclone/pgclone.transport ;;
    3 )
    echo "sd" > /pg/rclone/pgclone.transport ;;
    4 )
    echo "sc" > /pg/rclone/pgclone.transport ;;
    5 )
    echo "le" > /pg/rclone/pgclone.transport ;;
    * )
        transportselect ;;
esac
}
