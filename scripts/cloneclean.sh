#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

# Outside Variables
hdpath=$(cat /var/plexguide/server.hd.path)
cleaner="$(cat /var/plexguide/cloneclean)"
nzb="$(tree -d -L 1 /opt/appdata -I nzbhydra | awk '{print $2}' | tail -n +2 | head -n -2 | grep nzb )"
## Need to exclude nzbhydra2 
## done 

# nzb cleanup, delete files < 10G
find "$hdpath/downloads/"$nzb -mindepth 1 -type f -cmin +$cleaner -size -10G 2>/dev/null -exec rm -rf {} \;

#find "$hdpath/downloads/sabnzbd" -mindepth 1 -type f -cmin +$cleaner -size -10G 2>/dev/null -exec rm -rf {} \;

# alt nzb cleanup WIP, delete files < 3G
#find "{{hdpath}}/downloads/"$nzb -mindepth 1 -type f -cmin +$cleaner -size -3G -exec rm -rf {} \;

# Remove empty directories
find "$hdpath/move" -type d -mmin +2 -empty -exec rmdir {} \;
find "$hdpath/downloads" -mindepth 1 -type d -mmin +2 -empty -exec rmdir {} \;
