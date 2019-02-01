#!/bin/bash
#
# Title:      PlexGuide (Reference Title File)
# Author(s):  Admin9705 & PhysK
# URL:        https://plexguide.com - http://github.plexguide.com
# GNU:        General Public License v3.0
################################################################################
source /opt/pgclone/functions/pgblitz.sh

#starter
#stasks

# Outside Variables
dlpath=$(cat /var/plexguide/server.hd.path)

# Starting Actions
mkdir -p /$dlpath/pgblitz/upload
touch /opt/appdata/plexguide/pgblitz.log

# Inside Variables
ls -la /opt/appdata/pgblitz/keys/processed | awk '{print $9}' | grep gdsa > /opt/appdata/plexguide/key.list
keytotal=$(wc -l /opt/appdata/plexguide/key.list | awk '{ print $1 }')

keyfirst=$(cat /opt/appdata/plexguide/key.list | head -n1)
keylast=$(cat /opt/appdata/plexguide/key.list | tail -n1)

keycurrent=0
cyclecount=0

echo "" >> /opt/appdata/plexguide/pgblitz.log
echo "" >> /opt/appdata/plexguide/pgblitz.log
echo "----------------------------" >> /opt/appdata/plexguide/pgblitz.log
echo "PG Blitz Log - First Startup" >> /opt/appdata/plexguide/pgblitz.log

while [ 1 ]; do

  dlpath=$(cat /var/plexguide/server.hd.path)
  mkdir -p /$dlpath/pgblitz/upload

  # Permissions
  chown -R 1000:1000 "$dlpath/move"
  chown -R 1000:1000 "$dlpath/pgblitz/upload"
  chmod -R 755 "$dlpath/move"
  chown -R 755 "$dlpath/pgblitz/upload"

  if [ "$keylast" == "$keyuse" ]; then keycurrent=0; fi

  let "keycurrent++"
  keyuse=$(sed -n ''$keycurrent'p' < /opt/appdata/plexguide/key.list)

  encheck=$(cat /var/plexguide/pgclone.transport)
    if [ "$encheck" == "eblitz" ]; then
    keytransfer="${keyuse}C"; else keytransfer="$keyuse"; fi

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

  rclone moveto "$dlpath/move/" "$dlpath/pgblitz/upload" \
  --config /opt/appdata/plexguide/rclone.conf \
  --log-file=/opt/appdata/plexguide/pgblitz.log \
  --log-level INFO --stats 5s \
  --min-age=5s \
  --exclude="**_HIDDEN~" --exclude=".unionfs/**" \
  --exclude='**partial~' --exclude=".unionfs-fuse/**"           

  let "cyclecount++"
  echo "----------------------------" >> /opt/appdata/plexguide/pgblitz.log
  echo "PG Blitz Log - Cycle $cyclecount" >> /opt/appdata/plexguide/pgblitz.log
  echo "" >> /opt/appdata/plexguide/pgblitz.log
  echo "Utilizing: $keytransfer" >> /opt/appdata/plexguide/pgblitz.log

  rclone moveto "$dlpath/pgblitz/upload" "$keytransfer:/" \
  --config /opt/appdata/plexguide/rclone.conf \
  --log-file=/opt/appdata/plexguide/pgblitz.log \
  --log-level INFO --stats 5s \
  --tpslimit 12 \
  --checkers=20 \
  --min-age=5s \
  --transfers=16 \
  --bwlimit {{bandwidth.stdout}}M \
  --max-size=300G \
  --drive-chunk-size=128M \
  --exclude="**_HIDDEN~" --exclude=".unionfs/**" \
  --exclude="**partial~" --exclude=".unionfs-fuse/**"

  echo "Cycle $cyclecount - Sleeping for 30 Seconds" >> /opt/appdata/plexguide/pgblitz.log
  cat /opt/appdata/plexguide/pgblitz.log | tail -200 > cat /opt/appdata/plexguide/pgblitz.log
  #sed -i -e "/Duplicate directory found in destination/d" /opt/appdata/plexguide/pgblitz.log
  sleep 30

# Remove empty directories
find "$dlpath/downloads" -mindepth 2 -mmin +5 -type d -empty -delete \
  ! -path **nzbget** ! -path **sabnzbd** ! -path **qbittorrent** ! -path **deluge** \
  ! -path **rutorrent** ! -path **transmission** ! -path **jdownloader** ! -path **makemkv** \
  ! -path **handbrake** ! -path **ignore**
find "$dlpath/downloads" -mindepth 3 -mmin +5 -type d -empty -delete
find "$dlpath/move" -mindepth 2 -mmin +5 -type d -empty -delete
find "$dlpath/pgblitz/upload" -mindepth 1 -mmin +5 -type d -empty -delete

done
