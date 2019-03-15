#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705 & PhysK
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

# Starting Actions
touch /var/plexguide/logs/pgblitz.log

# Inside Variables
ls -la /opt/appdata/pgblitz/keys/processed | awk '{print $9}' | grep gdsa > /opt/appdata/plexguide/key.list
keytotal=$(wc -l /opt/appdata/plexguide/key.list | awk '{ print $1 }')

keyfirst=$(cat /opt/appdata/plexguide/key.list | head -n1)
keylast=$(cat /opt/appdata/plexguide/key.list | tail -n1)

keycurrent=0
cyclecount=0

echo "" >> /var/plexguide/logs/pgblitz.log
echo "" >> /var/plexguide/logs/pgblitz.log
echo "----------------------------" >> /var/plexguide/logs/pgblitz.log
echo "PG Blitz Log - First Startup" >> /var/plexguide/logs/pgblitz.log

while [ 1 ]; do

  # Permissions
  chown -R 1000:1000 "{{hdpath}}/move"
  chmod -R 755 "{{hdpath}}/move"

  if [ "$keylast" == "$keyuse" ]; then keycurrent=0; fi

  let "keycurrent++"
  keyuse=$(sed -n ''$keycurrent'p' < /opt/appdata/plexguide/key.list)

    if [[ "{{type}}" == "gcrypt" ]]; then
    keytransfer="${keyuse}C"; else keytransfer="$keyuse"; fi

  rclone moveto "{{hdpath}}/downloads/" "{{hdpath}}/move/" \
  --config /opt/appdata/plexguide/rclone.conf \
  --log-file=/var/plexguide/logs/pgblitz.log \
  --log-level ERROR --stats 5s --stats-file-name-length 0 \
  --min-age 2m \
  --exclude="**_HIDDEN~" --exclude=".unionfs/**" \
  --exclude='**partial~' --exclude=".unionfs-fuse/**" \
  --exclude=".fuse_hidden**" \
  --exclude="**sabnzbd**" --exclude="**nzbget**" \
  --exclude="**qbittorrent**" --exclude="**rutorrent**" \
  --exclude="**deluge**" --exclude="**transmission**" \
  --exclude="**jdownloader**" --exclude="**makemkv**" \
  --exclude="**handbrake**" --exclude="**bazarr**" \
  --exclude="**ignore**"  --exclude="**inProgress**"

  let "cyclecount++"
  echo "----------------------------" >> /var/plexguide/logs/pgblitz.log
  echo "PG Blitz Log - Cycle $cyclecount" >> /var/plexguide/logs/pgblitz.log
  echo "" >> /var/plexguide/logs/pgblitz.log
  echo "Utilizing: $keytransfer" >> /var/plexguide/logs/pgblitz.log

  rclone moveto "{{hdpath}}/move" "$keytransfer:/" \
  --config /opt/appdata/plexguide/rclone.conf \
  --log-file=/var/plexguide/logs/pgblitz.log \
  --log-level INFO --stats 5s --stats-file-name-length 0 \
  --tpslimit 12 \
  --checkers=20 \
  --transfers=16 \
  --bwlimit {{bandwidth.stdout}}M \
  --max-size=300G \
  --drive-chunk-size=128M \
  --exclude="**_HIDDEN~" --exclude=".unionfs/**" \
  --exclude='**partial~' --exclude=".unionfs-fuse/**" \
  --exclude=".fuse_hidden**" \
  --exclude="**sabnzbd**" --exclude="**nzbget**" \
  --exclude="**qbittorrent**" --exclude="**rutorrent**" \
  --exclude="**deluge**" --exclude="**transmission**" \
  --exclude="**jdownloader**" --exclude="**makemkv**" \
  --exclude="**handbrake**" --exclude="**bazarr**" \
  --exclude="**ignore**"  --exclude="**inProgress**"

  echo "Cycle $cyclecount - Sleeping for 30 Seconds" >> /var/plexguide/logs/pgblitz.log
  cat /var/plexguide/logs/pgblitz.log | tail -200 > cat /var/plexguide/logs/pgblitz.log
  #sed -i -e "/Duplicate directory found in destination/d" /var/plexguide/logs/pgblitz.log
  sleep 30

# Remove empty directories
find "{{hdpath}}/downloads" -mindepth 2 -mmin +5 -type d -empty -exec rm -rf {} \;
find "{{hdpath}}/downloads" -mindepth 3 -mmin +360 -type d -size -100M -exec rm -rf {} \;
find "{{hdpath}}/move" -mindepth 2 -mmin +5 -type d -empty -delete
find "{{hdpath}}/move" -mindepth 2 -mmin +5 -type d -empty -delete

done
