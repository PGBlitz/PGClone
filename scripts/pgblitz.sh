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
echo "PG Blitz Log - First Startup" >> /var/plexguide/logs/pgblitz.log

chown -R 1000:1000 "{{hdpath}}/downloads"
chmod -R 775 "{{hdpath}}/downloads"
chown -R 1000:1000 "{{hdpath}}/move"
chmod -R 775 "{{hdpath}}/move"

startscript () {
while read p; do

  let "cyclecount++"
  echo "----------------------------" >> /var/plexguide/logs/pgblitz.log
  echo "PG Blitz Log - Cycle $cyclecount" >> /var/plexguide/logs/pgblitz.log
  echo "" >> /var/plexguide/logs/pgblitz.log
  echo "Utilizing: $p" >> /var/plexguide/logs/pgblitz.log

  rclone moveto "{{hdpath}}/downloads/" "{{hdpath}}/move/" \
  --config /opt/appdata/plexguide/rclone.conf \
  --log-file=/var/plexguide/logs/pgblitz.log \
  --log-level ERROR --stats 5s --stats-file-name-length 0 \
  --exclude="**_HIDDEN~" --exclude=".unionfs/**" \
  --exclude='**partial~' --exclude=".unionfs-fuse/**" \
  --exclude=".fuse_hidden**" \
  --exclude="**sabnzbd**" --exclude="**nzbget**" \
  --exclude="**qbittorrent**" --exclude="**rutorrent**" \
  --exclude="**deluge**" --exclude="**transmission**" \
  --exclude="**jdownloader**" --exclude="**makemkv**" \
  --exclude="**handbrake**" --exclude="**bazarr**" \
  --exclude="**ignore**"  --exclude="**inProgress**"

  chown -R 1000:1000 "{{hdpath}}/move"
  chmod -R 775 "{{hdpath}}/move"

  rclone moveto "{{hdpath}}/move" "${p}{{encryptbit}}:/" \
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
  cat /var/plexguide/logs/pgblitz.log | tail -200 > /var/plexguide/logs/pgblitz.log
  #sed -i -e "/Duplicate directory found in destination/d" /var/plexguide/logs/pgblitz.log
  sleep 2

  # Remove empty directories
  find "{{hdpath}}/downloads" -mindepth 2 -mmin +666 -type d -size -100M -exec rm -rf {} \;
  find "{{hdpath}}/move" -mindepth 2 -mmin +5 -type d -empty -delete

done </var/plexguide/.blitzfinal
}

# keeps the function in a loop
cheeseballs=0
while [[ "$cheeseballs" == "0" ]]; do startscript; done
