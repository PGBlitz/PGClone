#!/bin/bash
#
# Title:      PlexGuide (Reference Title File)
# Author(s):  Admin9705
# URL:        https://plexguide.com - http://github.plexguide.com
# GNU:        General Public License v3.0
################################################################################
if pidof -o %PPID -x "$0"; then
   exit 1
fi
# Outside Variables
dlpath=$(cat /var/plexguide/server.hd.path)
ver=$(cat /var/plexguide/rclone/deploy.version)
sleep 10
while true
do

dlpath=$(cat /var/plexguide/server.hd.path)

## Sync, Sleep 2 Minutes, Repeat. BWLIMIT 9 Prevents Google 750GB Google Upload Ban

rclone moveto "$dlpath/downloads/" "$dlpath/move/" \
--config /opt/appdata/plexguide/rclone.conf \
--log-file=/opt/appdata/plexguide/pgblitz.log \
--log-level INFO --stats 5s \
--min-age=5s \
--exclude="**_HIDDEN~" --exclude=".unionfs/**" \
--exclude='**partial~' --exclude=".unionfs-fuse/**" \
--exclude="**sabnzbd**" --exclude="**nzbget**" \
--exclude="**qbittorrent**" --exclude="**rutorrent**" \
--exclude="**deluge**" --exclude="**transmission**" \
--exclude="**jdownloader**" --exclude="**makemkv**" \
--exclude="**handbrake**" --exclude="**bazarr**" \
--exclude="**ignore**"

rclone move "$dlpath/move/" "$ver:/" \
--config /opt/appdata/plexguide/rclone.conf \
--log-file=/opt/appdata/plexguide/rclone \
--log-level INFO --stats 5s \
--min-age=5s \
--bwlimit {{bandwidth.stdout}}M \
--tpslimit 6 \
--checkers=16 \
--max-size=300G \
--exclude="**_HIDDEN~" --exclude=".unionfs/**" \
--exclude="**partial~" --exclude=".unionfs-fuse/**"

sleep 5

# Remove empty directories
find "$dlpath/downloads" -mindepth 2 -mmin +5 -type d -empty -delete \
  ! -path **nzbget** ! -path **sabnzbd** ! -path **qbittorrent** ! -path **deluge** \
  ! -path **rutorrent** ! -path **transmission** ! -path **jdownloader** ! -path **makemkv** \
  ! -path **handbrake** ! -path **ignore** 
find "$dlpath/downloads" -mindepth 3 -mmin +5 -type d -empty -delete
find "$dlpath/move" -mindepth 2 -mmin +5 -type d -empty -delete

done
