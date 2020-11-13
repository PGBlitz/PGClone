#!/bin/bash
#
# Title:      Reference Title File - PGBlitz
# Author(s):  Admin9705 & https://github.com/PGBlitz/PGClone/graphs/contributors & PhysK
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

# Starting Actions
touch /pg/logs/pgblitz.log

echo "" >> /pg/logs/pgblitz.log
echo "" >> /pg/logs/pgblitz.log
echo "----------------------------" >> /pg/logs/pgblitz.log
echo "PG Blitz Log - First Startup" >> /pg/logs/pgblitz.log
chown -R 1000:1000 "{{hdpath}}/downloads"
chmod -R 775 "{{hdpath}}/downloads"
chown -R 1000:1000 "{{hdpath}}/move"
chmod -R 775 "{{hdpath}}/move"

startscript () {
while read p; do

# Repull excluded folder
 wget -qN https://raw.githubusercontent.com/PGBlitz/PGClone/v8.6/functions/exclude -P /pg/var/

  cleaner="$(cat /pg/var/cloneclean)"
  useragent="$(cat /pg/var/uagent)"

  let "cyclecount++"
  echo "----------------------------" >> /pg/logs/pgblitz.log
  echo "PG Blitz Log - Cycle $cyclecount" >> /pg/logs/pgblitz.log
  echo "" >> /pg/logs/pgblitz.log
  echo "Utilizing: $p" >> /pg/logs/pgblitz.log

  rclone moveto "{{hdpath}}/downloads/" "{{hdpath}}/transfer/" \
  --config /pg/rclone/blitz.conf \
  --log-file=/pg/logs/pgblitz.log \
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

  rclone moveto "{{hdpath}}/move" "${p}{{encryptbit}}:/" \
  --config /pg/rclone/blitz.conf \
  --log-file=/pg/logs/pgblitz.log \
  --log-level INFO --stats 5s --stats-file-name-length 0 \
  --tpslimit 12 \
  --checkers=20 \
  --transfers=16 \
  --bwlimit {{bandwidth.stdout}}M \
  --user-agent="$useragent" \
  --drive-chunk-size={{dcs}} \
  --exclude="**_HIDDEN~" --exclude=".unionfs/**" \
  --exclude="**partial~" --exclude=".unionfs-fuse/**" \
  --exclude=".fuse_hidden**" --exclude="**.grab/**"  \
  --exclude="**sabnzbd**" --exclude="**nzbget**" \
  --exclude="**qbittorrent**" --exclude="**rutorrent**" \
  --exclude="**deluge**" --exclude="**transmission**" \
  --exclude="**jdownloader**" --exclude="**makemkv**" \
  --exclude="**handbrake**" --exclude="**bazarr**" \
  --exclude="**ignore**"  --exclude="**inProgress**"

  echo "Cycle $cyclecount - Sleeping for 30 Seconds" >> /pg/logs/pgblitz.log
  cat /pg/logs/pgblitz.log | tail -200 > /pg/logs/pgblitz.log
  #sed -i -e "/Duplicate directory found in destination/d" /pg/logs/pgblitz.log
  sleep 30

  #Quick fix
  # Remove empty directories
  #find "$dlpath/downloads/" -mindepth 2 -type d -empty -exec rm -rf {} \;
  #find "$dlpath/move/" -type d -empty -exec rm -rf {} \;
  #find "$dlpath/move/" -mindepth 2 -type f -cmin +5 -size +1M -exec rm -rf {} \;

  # Remove empty directories
  find "{{hdpath}}/transfer/" -mindepth 2 -type d -mmin +2 -empty -exec rm -rf {} \;

  # Removes garbage | torrent folder excluded
  find "{{hdpath}}/downloads" -mindepth 2 -type d -cmin +$cleaner  $(printf "! -name %s " $(cat /pg/var/exclude)) -empty -exec rm -rf {} \;
  find "{{hdpath}}/downloads" -mindepth 2 -type f -cmin +$cleaner  $(printf "! -name %s " $(cat /pg/var/exclude)) -size +1M -exec rm -rf {} \;

done </pg/var/.blitzfinal
}

# keeps the function in a loop
cheeseballs=0
while [[ "$cheeseballs" == "0" ]]; do startscript; done
