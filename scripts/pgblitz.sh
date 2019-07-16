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
echo "--------------Starting Blitz--------------" >> /var/plexguide/logs/pgblitz.log

startscript () {
    while read p; do
        
        # Update the vars
        cleaner="$(cat /var/plexguide/cloneclean)"
        useragent="$(cat /var/plexguide/uagent)"
        bwlimit="$(cat /var/plexguide/blitz.bw)"
        vfs_dcs="$(cat /var/plexguide/vfs_dcs)"
        
        let "cyclecount++"
        echo "--------------cycle $cyclecount: $p--------------" >> /var/plexguide/logs/pgblitz.log
        echo "Checking for files to upload..." >> /var/plexguide/logs/pgblitz.log

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
        
        move_size=$(du -s -B K "{{hdpath}}/move" | cut -f1 | bc -l | rev | cut -c 2- | rev)
        if [[ $move_size -gt 60 ]]; then
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
            
        else
            echo "No files in {{hdpath}}/move to upload." >> /var/plexguide/logs/pgblitz.log
        fi

        echo "Completed Cycle $cyclecount - $(date "+%Y-%m-%d %H:%M:%S")" >> /var/plexguide/logs/pgblitz.log
        echo "$(tail -n 200 /var/plexguide/logs/pgblitz.log)" > /var/plexguide/logs/pgblitz.log
        #sed -i -e "/Duplicate directory found in destination/d" /var/plexguide/logs/pgblitz.log
        sleep 30
        
        # Remove empty directories
        find "{{hdpath}}/move" -mindepth 2 -type d -empty -delete
        #DO NOT decrease DEPTH on this, leave it at 3. Leave this alone!
        find "{{hdpath}}/downloads" -mindepth 3 -empty -delete
        # Prevents category folders underneath the downloaders from being deleted, while removing empties from sonarr moving the files.
        # This was done to address lazylibrarian having an issue if the ebooks/abooks category underneath the downloader is missing.
        # If this causes issues, remove the names as needed, but keep ebooks and abooks being excluded.
        find "{{hdpath}}/downloads" -mindepth 2 -type d \( ! -name ebooks ! -name abooks ! -name tv** ! -name **movies** ! -name music** ! -name audio** ! -name anime** ! -name software ! -name xxx \)  -empty -delete
        
    done </var/plexguide/.blitzfinal
}

# keeps the function in a loop
cheeseballs=0
while [[ "$cheeseballs" == "0" ]]; do startscript; done
