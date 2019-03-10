#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
deploypgblitz () {
echo "#------------------------------------------" >> /opt/appdata/plexguide/rclone.conf
echo "#RClone Rewrite | Visit https://pgblitz.com" > /opt/appdata/plexguide/rclone.conf
echo "#------------------------------------------" >> /opt/appdata/plexguide/rclone.conf

cat /opt/appdata/plexguide/.gdrive >> /opt/appdata/plexguide/rclone.conf

if [ -e "/opt/appdata/plexguide/.gcrypt" ]; then
cat /opt/appdata/plexguide/.gcrypt >> /opt/appdata/plexguide/rclone.conf; fi

cat /opt/appdata/plexguide/.tdrive >> /opt/appdata/plexguide/rclone.conf

if [ -e "/opt/appdata/plexguide/.tcrypt" ]; then
cat /opt/appdata/plexguide/.tcrypt >> /opt/appdata/plexguide/tclone.conf; fi

cat /opt/appdata/plexguide/.keys >> /opt/appdata/plexguide/rclone.conf
