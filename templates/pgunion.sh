#!/bin/bash
#
# Title:      PlexGuide (Reference Title File)
# Author(s):  Admin9705
# URL:        https://plexguide.com - http://github.plexguide.com
# GNU:        General Public License v3.0
################################################################################

# Outside Variables
dlpath=$(cat /var/plexguide/server.hd.path)
sleep 2

mergerfs -o defaults,sync_read,allow_other,direct_io,use_ino,func.getattr=newest,nonempty,security_capability=false,xattr=nosys,category.create=ff,minfreespace=5G,umask=002,fsname=pgUnion \
$dlpath/downloads=NC:$dlpath/move=RW:/mnt/pgblitz/upload=NC:/mnt/tdrive=NC:/mnt/gdrive=NC:/mnt/tcrypt=NC:/mnt/gcrypt=NC /mnt/unionfs
