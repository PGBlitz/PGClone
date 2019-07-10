#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705 & PhysK
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

# Starting Actions
touch /var/plexguide/logs/pgblitz.log

echo "" >> /var/plexguide/logs/pgblitz.log
echo "" >> /var/plexguide/logs/pgblitz.log
echo "----------------------------" >> /var/plexguide/logs/pgblitz.log
echo "Starting Blitz" >> /var/plexguide/logs/pgblitz.log

startscript () {
    while read p; do

        # Update the vars
        cleaner="$(cat /var/plexguide/cloneclean)"
        useragent="$(cat /var/plexguide/uagent)"
        bwlimit="$(cat /var/plexguide/blitz.bw)"
        vfs_dcs="$(cat /var/plexguide/vfs_dcs)"

        let "cyclecount++"
        echo "----------------------------" >> /var/plexguide/logs/pgblitz.log
        echo "Starting Cycle $cyclecount" >> /var/plexguide/logs/pgblitz.log
        echo "" >> /var/plexguide/logs/pgblitz.log
        echo "Utilizing: $p" >> /var/plexguide/logs/pgblitz.log

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

        # Set permissions since this script runs as root, any created folders are owned by root.
        chown -R 1000:1000 "{{hdpath}}/move"
        chmod -R 775 "{{hdpath}}/move"

        rclone moveto "{{hdpath}}/move" "${p}{{encryptbit}}:/" \
        --config=/opt/appdata/plexguide/rclone.conf \
        --log-file=/var/plexguide/logs/pgblitz.log \
        --log-level=INFO --stats=5s --stats-file-name-length=0 \
        --max-size=300G \
        --tpslimit=10 \
        --checkers=16 \
        --transfers=8 \
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

        echo "Completed Cycle $cyclecount - Sleeping for 30 Seconds" >> /var/plexguide/logs/pgblitz.log
        cat /var/plexguide/logs/pgblitz.log | tail -n 200 > /var/plexguide/logs/pgblitz.log
        #sed -i -e "/Duplicate directory found in destination/d" /var/plexguide/logs/pgblitz.log
        sleep 30

    # Remove empty directories
    find "{{hdpath}}/move" -mindepth 2 -type d -mmin +2 -empty -exec rmdir \{} \;
    find "{{hdpath}}/downloads" -mindepth 2 -type d -cmin +$cleaner -empty -exec rmdir \{} \;

    done </var/plexguide/.blitzfinal
}

# keeps the function in a loop
cheeseballs=0
while [[ "$cheeseballs" == "0" ]]; do startscript; done
