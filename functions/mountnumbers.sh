#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
mountnumbers () {
pgclonevars

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
RClone Variable Name           Default ~ Current Settings
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] Buffer-Size                64        [$vfs_bs] MB
[2] Drive-Chunk-Size           128       [$vfs_dcs] MB
[3] Dir-Cache-Time             2         [$vfs_dct] Minutes
[4] VFS-Cache-Max-Age          72        [$vfs_cma] Hours
[5] VFS-Read-Chunk-Size        64        [$vfs_rcs] MB
[6] VFS-Read-Chunk-Size-Limit  5         [$vfs_rcsl] GB

NOTE1: Visit the URL! Bad settings causes mount performance issues!
NOTE2: Changed the Vaules? Must REDEPLOY to go into AFFECT!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

read -rp '↘️  Input Selection | Press [ENTER]: ' typed < /dev/tty

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
    d )
        mountnumbers ;;
    D )
        mountnumbers ;;
    z )
        clonestart ;;
    Z )
        clonestart ;;
    * )
        mountnumbers ;;
  esac

}
