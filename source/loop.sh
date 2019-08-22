#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
loop90210="90210"
sleep 20

while [[ "$loop90210" == "90210" ]]; do
   bash /pg/rclone/transfer.sh
   sleep 5
done
