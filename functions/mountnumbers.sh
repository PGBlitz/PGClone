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
VFS RClone Mount Settings ~ vfs.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

RClone Variable Name           Default ~ Current Settings

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

read -rp '↘️  Input Selection | Press [ENTER]: ' fluffycat < /dev/tty

case $fluffycat in
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
        a=b ;;
    Z )
        a=b ;;
    * )
        mountnumbers ;;
  esac

}

mountset () {

mountselection="$fluffycat"

if [[ "$mountselection" == "1" ]]; then
  name="Buffer-Size"
  endinfo="MB"
  start1="8"
  end1="1024"
  note1="
NOTE2: Utilizes RAM for each deployed stream. Increasing the size improves
the load time/performance; but if the server runs out of RAM due to the
settings being too high, the mounts can crash and dismount!"
fi

if [[ "$mountselection" == "2" ]]; then
  name="Drive-Chunk-Size"
  endinfo="MB"
  start1="8"
  end1="1024"
  note1="
NOTE2: Impacts the chunk size of the files being broken up to stream!

NOTE3: Input must be one of the following numbers below (power of 2)!
[8] [16] [32] [64] [128] [256] [512] [1024]"
fi

if [[ "$mountselection" == "3" ]]; then
  name="Dir-Cache-Time"
  endinfo="Minutes"
  start1="1"
  end1="1024"
  note1="
NOTE2: Impacts the refresh rate of the files being seen! Setting this high
will result in low refresh rates of the mounts! This can be bad when a file
is uploaded, but a program delays seeing the file for over 5 minutes!"
fi

if [[ "$mountselection" == "4" ]]; then
  name="VFS-Cache-Max-Age"
  endinfo="Hours"
  start1="1"
  end1="96"
  note1="
NOTE2: Impacts how long a file remains to be seen after a refresh!"
fi

if [[ "$mountselection" == "5" ]]; then
  name="VFS-Read-Chunk-Size"
  endinfo="MB"
  start1="8"
  end1="1024"
  note1="
NOTE2: No Info Yet!"
fi

if [[ "$mountselection" == "6" ]]; then
  name="VFS-Read-Chunk-Size-Limit"
  endinfo="GB"
  start1="1"
  end1="100"
  note1="
NOTE2: No Info Yet!"
fi

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Setting Variable >>> $name
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Type a Number from [$start1] through [$end1] ($endinfo)

NOTE1: Read the wiki on how changing these numbers impact the server!
Nothing takes affect until PGMove/PGBlitz is deployed/redeployed again!
$note1

Quitting? Type >>> exit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

read -rp '↘️  Input Selection | Press [ENTER]: ' typed < /dev/tty
if [[ "$typed" == "exit" || "$typed" == "Exit" || "$typed" == "EXIT" ]]; then mountnumbers; fi

# This Select Requires Answers to be In the Power of Two
if [[ "$mountselection" == "2" ]]; then
  if [[ "$typed" != "8" && "$typed" != "16" && "$typed" != "32" && "$typed" != "64" && "$typed" != "128" && "$typed" != "256" && "$typed" != "512" && "$typed" != "1024" ]]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Power of Two Notice
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTE: Drive-Chunk-Size must set by a power of two!
[8] [16] [32] [64] [128] [256] [512] [1024]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  read -rp '↘️  Acknowledge Info | Press [ENTER] ' typed < /dev/tty
mountset
fi; fi


if [[ "$typed" -lt "$start1" || "$typed" -gt "$end1" ]]; then mountset; else

  if [[ "$mountselection" == "1" ]]; then echo "$typed" > /var/plexguide/vfs_bs; fi
  if [[ "$mountselection" == "2" ]]; then echo "$typed" > /var/plexguide/vfs_dcs; fi
  if [[ "$mountselection" == "3" ]]; then echo "$typed" > /var/plexguide/vfs_dct; fi
  if [[ "$mountselection" == "4" ]]; then echo "$typed" > /var/plexguide/vfs_cma; fi
  if [[ "$mountselection" == "5" ]]; then echo "$typed" > /var/plexguide/vfs_rcs; fi
  if [[ "$mountselection" == "6" ]]; then echo "$typed" > /var/plexguide/vfs_rcsl; fi

fi

mountnumbers
}
