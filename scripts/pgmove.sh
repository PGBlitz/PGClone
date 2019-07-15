#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
# NOTES
# Variables come from what's being called from deploymove.sh under functions
## BWLIMIT 9 and Lower Prevents Google 750GB Google Upload Ban
################################################################################
if pidof -o %PPID -x "$0"; then
    exit 1
fi

touch /var/plexguide/logs/pgmove.log

echo "" >> /var/plexguide/logs/pgmove.log
echo "" >> /var/plexguide/logs/pgmove.log
echo "----------------------------" >> /var/plexguide/logs/pgmove.log
echo "PG Move Log - First Startup" >> /var/plexguide/logs/pgmove.log

sleep 10
while true
do
    cleaner="$(cat /var/plexguide/cloneclean)"
    useragent="$(cat /var/plexguide/uagent)"
    bwlimit="$(cat /var/plexguide/move.bw)"
    vfs_dcs="$(cat /var/plexguide/vfs_dcs)"
    
    rclone moveto "{{hdpath}}/downloads/" "{{hdpath}}/move/" \
    --config=/opt/appdata/plexguide/rclone.conf \
    --exclude="**_HIDDEN~" --exclude=".unionfs/**" \
    --exclude="**partial~" --exclude=".unionfs-fuse/**" \
    --exclude=".fuse_hidden**" --exclude="**.grab/**" \
    --exclude="**sabnzbd**" --exclude="**nzbget**" \
    --exclude="**qbittorrent**" --exclude="**rutorrent**" \
    --exclude="**deluge**" --exclude="**transmission**" \
    --exclude="**jdownloader**" --exclude="**makemkv**" \
    --exclude="**handbrake**" --exclude="**bazarr**" \
    --exclude="**ignore**"  --exclude="**inProgress**"
    
    chown -R 1000:1000 "{{hdpath}}/move"
    chmod -R 775 "{{hdpath}}/move"
    
    rclone move "{{hdpath}}/move/" "{{type}}:/" \
    --config=/opt/appdata/plexguide/rclone.conf \
    --log-file=/var/plexguide/logs/pgmove.log \
    --log-level=INFO --stats=5s --stats-file-name-length=0 \
    --max-size=300G \
    --tpslimit=10 \
    --checkers=16 \
    --no-traverse \
    --fast-list \
    --bwlimit="$bwlimit" \
    --drive-chunk-size=$vfs_dcs \
    --user-agent="$useragent" \
    --exclude="**_HIDDEN~" --exclude=".unionfs/**" \
    --exclude="**partial~" --exclude=".unionfs-fuse/**" \
    --exclude=".fuse_hidden**" --exclude="**.grab/**" \
    --exclude="**sabnzbd**" --exclude="**nzbget**" \
    --exclude="**qbittorrent**" --exclude="**rutorrent**" \
    --exclude="**deluge**" --exclude="**transmission**" \
    --exclude="**jdownloader**" --exclude="**makemkv**" \
    --exclude="**handbrake**" --exclude="**bazarr**" \
    --exclude="**ignore**"  --exclude="**inProgress**"
    
    sleep 30
    
    # Remove empty directories
    find "{{hdpath}}/move" -mindepth 2 -type d -empty -delete
    #DO NOT decrease DEPTH on this, leave it at 3. Leave this alone!
    find "{{hdpath}}/downloads" -mindepth 3 -empty -delete
    # Prevents category folders underneath the downloaders from being deleted, while removing empties from sonarr moving the files.
    # This was done to address lazylibrarian having an issue if the ebooks/abooks category underneath the downloader is missing.
    # If this causes issues, remove the names as needed, but keep ebooks and abooks being excluded.
    find "{{hdpath}}/downloads" -mindepth 2 -type d \( ! -name ebooks ! -name abooks ! -name tv** ! -name **movies** ! -name music** ! -name audio** ! -name anime** ! -name software ! -name xxx \)  -empty -delete

    echo "$(tail -n 200 /var/plexguide/logs/pgmove.log)" > /var/plexguide/logs/pgmove.log
done
