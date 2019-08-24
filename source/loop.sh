#!/bin/bash
#
# Title:      Reference Title File - PGBlitz
# Author(s):  Admin9705 & https://github.com/PGBlitz/PGClone/graphs/contributors
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
admin9705="9705"
sleep 2

echo "" > /pg/logs/transfer.log
echo "" >> /pg/logs/transfer.log
echo "----------------------------" >> /pg/logs/transfer.log
echo "PGBlitz Log - First Startup" >> /pg/logs/transfer.log
rm -rf /pg/logs/.transfer_list
rm -rf /pg/logs/.temp_list

var1=$(cat /pg/rclone/deployed.version)
if [[ "$var1" == "gd" ]]; then var2="GDrive Unencrypted"
elif [[ "$var1" == "gc" ]]; then var2="GDrive Encrypted"
elif [[ "$var1" == "sd" ]]; then var2="SDrive Unencrypted"
elif [[ "$var1" == "sc" ]]; then var2="SDrive Encrypted"; fi

while [[ "$admin9705" == "9705" ]]; do

  let cyclecount++
  echo "$cyclecount"
  echo "----------------------------" >> /pg/logs/transfer.log
  echo "PG Blitz Log - Cycle $cyclecount - $var2" >> /pg/logs/transfer.log
  echo "" >> /pg/logs/transfer.log
  echo "Utilizing: $p" >> /pg/logs/transfer.log

  bash /pg/rclone/transfer.sh

  # cat /pg/logs/transfer.log | tail -200 > /pg/logs/transfer.log
  echo "Cycle $cyclecount - Sleeping 5 Seconds" >> /pg/logs/transfer.log
  sleep 2
  primepath="$(cat /pg/var/hd.path)"
  find "$primepath/transfer" -mindepth 1 -type d -mmin +1 -empty -delete

done
