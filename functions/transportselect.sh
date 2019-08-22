#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705 & https://github.com/PGBlitz/PGBlitz.com/graphs/contributors
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
transportselect () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 Set PG Clone Method ~ http://pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
NOTE: Please visit the link and understand what your doing first!

[1] Move  Unencrypt: Data > GDrive | Novice  | 750GB Daily Transfer Max
[2] Move  Encrypted: Data > GDrive | Novice  | 750GB Daily Transfer Max
[3] Blitz Unencrypt: Data > SDrive | Complex | Exceed 750GB Transport Cap
[4] Blitz Encrypted: Data > SDrive | Complex | Exceed 750GB Transport Cap
[5] Local Edition  : Local HDs     | Easy    | Utilizes System's HD's Only

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

read -rp '↘️  Input Selection | Press [ENTER]: ' typed < /dev/tty

case $typed in
    1 )
    echo "mu" > /pg/rclone/pgclone.transport ;;
    2 )
    echo "me" > /pg/rclone/pgclone.transport ;;
    3 )
    echo "bu" > /pg/rclone/pgclone.transport ;;
    4 )
    echo "be" > /pg/rclone/pgclone.transport ;;
    5 )
    echo "le" > /pg/rclone/pgclone.transport ;;
    * )
        transportselect ;;
esac
}
