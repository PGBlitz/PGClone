#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

# Outside Variables
dlpath=$(cat /var/plexguide/server.hd.path)
sleep 2


mergerfs -o defaults,sync_read,allow_other,category.action=all,category.create=ff,fsname=pgunion \
$dlpath/downloads=NC:$dlpath/move=RW:/mnt/tdrive=NC:/mnt/gdrive=NC:/mnt/tcrypt=NC:/mnt/gcrypt=NC /mnt/unionfs
