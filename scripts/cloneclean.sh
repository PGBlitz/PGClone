#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Authors:    Admin9705, Deiteq, and many PGBlitz Contributors
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

cloneclean() {
    # Outside Variables
    hdpath="$(cat /var/plexguide/server.hd.path)"
    cleaner="$(cat /var/plexguide/cloneclean)"

    find "$hdpath/downloads/nzbget" -mindepth 1 -type f -cmin +$cleaner -size -4G 2>/dev/null -exec rm -rf {} \;
    find "$hdpath/downloads/sabnzbd" -mindepth 1 -type f -cmin +$cleaner -size -4G 2>/dev/null -exec rm -rf {} \;

    # Remove empty directories
    find "$hdpath/move" -mindepth 2 -type d -empty -delete
    #DO NOT decrease DEPTH on this, leave it at 3. Leave this alone!
    find "$hdpath/downloads" -mindepth 3 -type d \( ! -name syncthings ! -name .stfolder \) -empty -delete

    # Prevents category folders underneath the downloaders from being deleted, while removing empties from the import process.
    # This was done to address some apps having an issue if the category underneath the downloader is missing.
    find "$hdpath/downloads" -mindepth 2 -type d \( ! -name .stfolder ! -name **games** ! -name ebooks ! -name abooks ! -name sonarr** ! -name radarr** ! -name lidarr** ! -name **kids** ! -name **tv** ! -name **movies** ! -name music** ! -name audio** ! -name anime** ! -name software ! -name xxx \) -empty -delete
}

cloneclean
