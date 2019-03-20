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
[Z] Exit

NOTE1: Visit the URL! Bad settings causes mount performance issues!
NOTE2: Changed the Vaules? Must REDEPLOY to go into AFFECT!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

read -rp '↘️  Input Selection | Press [ENTER]: ' typed < /dev/tty

case $typed in
    1 )
        mountset ;;
    2 )
        mountset ;;
    3 )
        mountset ;;
    4 )
        mountset ;;
    5 )
        mountset ;;
    6 )
        mountset ;;
    z )
        clonestart ;;
    Z )
        clonestart ;;
    * )
        mountnumbers ;;
  esac

}

mountset () {
mountselection=${typed}

if [[ "$mountselection" == "1" ]]; then
  name="Buffer-Size"
  endinfo="MB"
  start1="16"
  end1="1024"
  note1="
This setting utilize RAM for each stream. Increasing the size improves
load time and performance; but if the server runs out of RAM due to this
being too high, it is possible for the mounts to crash and dismount!"
fi

tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Setting Variable ~ $name $endinfo
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Please type a range from $start1 through $end1! Please ensure to read the
wiki on how changing these numbers impact the server! Nothing takes
affect until PGMove/PGBlitz is deployed/redeployed!
$note1

Quitting? Type >>> exit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

read -rp '↘️  Input Selection | Press [ENTER]: ' typed < /dev/tty

if [[ "$typed" == "exit" || "$typed" == "Exit" || "$typed" == "EXIT" ]]; then mountnumbers; fi

if [[ "$typed" -lt "$start" || "$typed" -gt "$end1" ]]; then mountset; else
  if [[ "$mountselection" == "1" ]]; then echo "$typed" > /var/plexguide/vfs_bs; fi
fi

mountnumbers
}
