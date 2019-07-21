#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

cloneclean() {
    # Outside Variables
    hdpath="$(cat /var/plexguide/server.hd.path)"
    cleaner="$(cat /var/plexguide/cloneclean)"
    nzb="$(tree -d -L 1 /opt/appdata -I 'nzbhydra|nzbhydra2' | awk '{print $2}' | tail -n +2 | head -n -2 | grep nzb)"

    # alt nzb cleanup WIP, delete files < 4G
    find "$hdpath/downloads/$nzb" -mindepth 1 -type f -cmin +"$cleaner" -size -4G -exec rm -rf {} \;

    # Remove empty directories
    find "$hdpath/move" -mindepth 2 -type d -empty -delete
    #DO NOT decrease DEPTH on this, leave it at 3. Leave this alone!
    find "$hdpath/downloads" -mindepth 3 -type d \( ! -name syncthings ! -name .stfolder \) -empty -delete

    # Prevents category folders underneath the downloaders from being deleted, while removing empties from the import process.
    # This was done to address some apps having an issue if the category underneath the downloader is missing.
    find "$hdpath/downloads" -mindepth 2 -type d \( ! -name .stfolder ! -name **games** ! -name ebooks ! -name abooks ! -name sonarr** ! -name radarr** ! -name lidarr** ! -name **kids** ! -name tv** ! -name **movies** ! -name music** ! -name audio** ! -name anime** ! -name software ! -name xxx \) -empty -delete
}

cloneclean
