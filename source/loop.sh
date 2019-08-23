#!/bin/bash
#
# Title:      Reference Title File - PGBlitz
# Author(s):  Admin9705 & https://github.com/PGBlitz/PGClone/graphs/contributors
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
admin9705="9705"
sleep 2

echo "" >> /pg/logs/transfer.log
echo "" >> /pg/logs/transfer.log
echo "----------------------------" >> /pg/logs/transfer.log
echo "PGBlitz Log - First Startup" >> /pg/logs/transfer.log

while [[ "$admin9705" == "9705" ]]; do

let "cyclecount++"
echo "----------------------------" >> /pg/logs/transfer.log
echo "PG Blitz Log - Cycle $cyclecount" >> /pg/logs/transfer.log
echo "" >> /pg/logs/transfer.log
echo "Utilizing: $p" >> /pg/logs/transfer.log

   bash /pg/rclone/transfer.sh
   sleep 2
   primepath="$(cat /pg/var/hd.path)"
   find "$primepath/transfer" -mindepth 1 -type d -mmin +1 -empty -delete
done
