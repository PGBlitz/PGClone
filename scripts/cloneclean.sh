#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

# Outside Variables
hdpath="$(cat /var/plexguide/server.hd.path)"
cleaner="$(cat /var/plexguide/cloneclean)"
nzb="$(tree -d -L 1 /opt/appdata -I 'nzbhydra|nzbhydra2' | awk '{print $2}' | tail -n +2 | head -n -2 | grep nzb)"

# alt nzb cleanup WIP, delete files < 4G
find $hdpath"/downloads/"$nzb -mindepth 1 -type f -cmin +$cleaner -size -4G -exec rm -rf {} \;

# Remove empty directories
find "$hdpath/move" -mindepth 2 -type d -empty -delete
#DO NOT decrease DEPTH on this, leave it at 3. Leave this alone!
find "$hdpath/downloads" -mindepth 3 -empty -delete
# Prevents category folders underneath the downloaders from being deleted, while removing empties from sonarr moving the files.
# This was done to address lazylibrarian having an issue if the ebooks/abooks category underneath the downloader is missing.
# If this causes issues, remove the names as needed, but keep ebooks and abooks being excluded.
find $hdpath"/downloads" -mindepth 2 -type d \( ! -name ebooks ! -name abooks ! -name tv** ! -name **movies** ! -name music** ! -name audio** ! -name anime** ! -name software ! -name xxx \) -empty -delete
