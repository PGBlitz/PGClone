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
    
    rclone moveto "{{hdpath}}/downloads/" "{{hdpath}}/move/" \
    --config /opt/appdata/plexguide/rclone.conf \
    --log-file=/var/plexguide/logs/pgmove.log \
    --log-level ERROR --stats 5s --stats-file-name-length 0 \
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
    --config /opt/appdata/plexguide/rclone.conf \
    --log-file=/var/plexguide/logs/pgmove.log \
    --log-level INFO --stats 5s --stats-file-name-length 0 \
    --bwlimit {{bandwidth.stdout}}M \
    --tpslimit 6 \
    --checkers=16 \
    --max-size=300G \
    --drive-chunk-size={{vfs_dcs}} \
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
    find "{{hdpath}}/move/" -mindepth 2 -type d -mmin +2 -empty -exec rm -rf {} \;
    
    # Removes garbage | torrent folder excluded
    find "{{hdpath}}/downloads" -mindepth 2 -type d -cmin +$cleaner  $(printf "! -name %s " $(cat /var/plexguide/exclude)) -empty -exec rm -rf {} \;
    find "{{hdpath}}/downloads" -mindepth 2 -type f -cmin +$cleaner  $(printf "! -name %s " $(cat /var/plexguide/exclude)) -size +1M -exec rm -rf {} \;
    
done
