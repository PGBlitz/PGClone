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
sleep 10
while true
do
dlpath=$(cat /var/plexguide/server.hd.path)

## Sync, Sleep 2 Minutes, Repeat. BWLIMIT 9 Prevents Google 750GB Google Upload Ban

rclone moveto --min-age=2m \
      --config /opt/appdata/plexguide/rclone.conf \
      --transfers=16 \
      --max-transfer=100G \
      --exclude="**_HIDDEN~" --exclude=".unionfs/**" \
      --exclude='**partial~' --exclude=".unionfs-fuse/**" \
      --exclude="sabnzbd/**" --exclude="nzbget/**" \
      --exclude="qbittorrent/**" --exclude="rutorrent/**" \
      --exclude="deluge/**" --exclude="transmission/**" \
      --max-size=99G \
      --drive-chunk-size=128M \
      "$dlpath/downloads/" "$dlpath/move/"         

rclone move --config /opt/appdata/plexguide/rclone.conf --bwlimit {{bandwidth.stdout}}M \
  --tpslimit 6 --exclude='**partial~' --exclude="**_HIDDEN~" --exclude=".unionfs/**" \
  --exclude=".unionfs-fuse/**" --checkers=16 --max-size 99G --log-file=/opt/appdata/plexguide/rclone \
  --log-level INFO --stats 5s $dlpath/move {{ver.stdout}}:/
sleep 10
done
