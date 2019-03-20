#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

# Outside Variables
dlpath=$(cat /var/plexguide/server.hd.path)
chown -R 1000:1000 "$dlpath/move"
chmod -R 775 "$dlpath/move"
chown -R 1000:1000 "$dlpath/pgblitz"
chmod -R 775 "$dlpath/pgblitz"
chown -R 1000:1000 "$dlpath/downloads"
chmod -R 775 "$dlpath/downloads"
sleep 2

mergerfs -o func.getattr=newest,category.create=ff,direct_io,use_ino,atomic_o_trunc,big_writes,default_permissions,splice_move,splice_read,splice_write,allow_other,sync_read,minfreespace=0,umask=002,gid=1000,uid=1000,fsname=pgunion \
$dlpath/downloads=RW:$dlpath/pgblitz/upload=NC:$dlpath/move=RW:/mnt/tdrive=NC:/mnt/gdrive=NC:/mnt/tcrypt=NC:/mnt/gcrypt=NC /mnt/unionfs
