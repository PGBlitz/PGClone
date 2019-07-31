#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Authors:    Admin9705, Deiteq, and many PGBlitz Contributors
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
# NOTES
# Variables come from what's being called from deploymove.sh under functions
## BWLIMIT 9 and Lower Prevents Google 750GB Google Upload Ban
################################################################################
source /opt/pgclone/scripts/cloneclean.sh

if pidof -o %PPID -x "$0"; then
    exit 1
fi

touch /var/plexguide/logs/pgmove.log
truncate -s 0 /var/plexguide/logs/pgmove.log
echo "" >>/var/plexguide/logs/pgmove.log
echo "" >>/var/plexguide/logs/pgmove.log
echo "---Starting Move: $(date "+%Y-%m-%d %H:%M:%S")---" >>/var/plexguide/logs/pgmove.log
hdpath="$(cat /var/plexguide/server.hd.path)"
while true; do

    useragent="$(cat /var/plexguide/uagent)"
    bwlimit="$(cat /var/plexguide/move.bw)"
    vfs_dcs="$(cat /var/plexguide/vfs_dcs)"
    let "cyclecount++"

    if [[ $cyclecount -gt 4294967295 ]]; then
        cyclecount=0
    fi

    echo "" >>/var/plexguide/logs/pgmove.log
    echo "---Begin cycle $cyclecount: $(date "+%Y-%m-%d %H:%M:%S")---" >>/var/plexguide/logs/pgmove.log
    echo "Checking for files to upload..." >>/var/plexguide/logs/pgmove.log

    rsync "$hdpath/downloads/" "$hdpath/move/" \
        -aq --remove-source-files --link-dest="$hdpath/downloads/" \
        --exclude-from="/opt/appdata/plexguide/transport.exclude" \
        --exclude="**_HIDDEN~" --exclude=".unionfs/**" \
        --exclude="**partial~" --exclude=".unionfs-fuse/**" \
        --exclude=".fuse_hidden**" --exclude="**.grab/**" \
        --exclude="**sabnzbd**" --exclude="**nzbget**" \
        --exclude="**qbittorrent**" --exclude="**rutorrent**" \
        --exclude="**deluge**" --exclude="**transmission**" \
        --exclude="**jdownloader**" --exclude="**makemkv**" \
        --exclude="**handbrake**" --exclude="**bazarr**" \
        --exclude="**ignore**" --exclude="**inProgress**"

    if [[ $(find "$hdpath/move" -type f | wc -l) -gt 0 ]]; then

        rclone move "$hdpath/move/" "{{type}}:/" \
            --config=/opt/appdata/plexguide/rclone.conf \
            --log-file=/var/plexguide/logs/pgmove.log \
            --log-level=INFO --stats=5s --stats-file-name-length=0 \
            --max-size=300G \
            --tpslimit=10 \
            --checkers=16 \
            --no-traverse \
            --fast-list \
            --max-transfer 750G \
            --bwlimit="$bwlimit" \
            --drive-chunk-size="$vfs_dcs" \
            --user-agent="$useragent" \
            --exclude-from="/opt/appdata/plexguide/transport.exclude" \
            --exclude="**_HIDDEN~" --exclude=".unionfs/**" \
            --exclude="**partial~" --exclude=".unionfs-fuse/**" \
            --exclude=".fuse_hidden**" --exclude="**.grab/**" \
            --exclude="**sabnzbd**" --exclude="**nzbget**" \
            --exclude="**qbittorrent**" --exclude="**rutorrent**" \
            --exclude="**deluge**" --exclude="**transmission**" \
            --exclude="**jdownloader**" --exclude="**makemkv**" \
            --exclude="**handbrake**" --exclude="**bazarr**" \
            --exclude="**ignore**" --exclude="**inProgress**"

        echo "Upload has finished." >>/var/plexguide/logs/pgmove.log
    else
        echo "No files in $hdpath/move to upload." >>/var/plexguide/logs/pgmove.log
    fi
    echo "---Completed cycle $cyclecount: $(date "+%Y-%m-%d %H:%M:%S")---" >>/var/plexguide/logs/pgmove.log

    echo "$(tail -n 200 /var/plexguide/logs/pgmove.log)" >/var/plexguide/logs/pgmove.log

    sleep 30

    cloneclean
done
