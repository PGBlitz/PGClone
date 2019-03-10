#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705 ~ Physik - FlickerRate
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
deploypgblitz () {

echo "RClone Rewrite | Visit https://pgblitz.com" > /opt/appdata/plexguide/rclone.conf
echo "" >> /opt/appdata/plexguide/rclone.conf
cat /opt/appdata/plexguide/.gdrive >> /opt/appdata/plexguide/rclone.conf
echo "" >> /opt/appdata/plexguide/rclone.conf
cat /opt/appdata/plexguide/.tdrive >> /opt/appdata/plexguide/rclone.conf
