#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

# Outside Variables
hdpath=$(cat /var/plexguide/server.hd.path)
sleep 2

chown -R 1000:1000 "{{hdpath}}/downloads"
chmod -R 755 "{{hdpath}}/downloads"
chown -R 1000:1000 "{{hdpath}}/move"
chmod -R 755 "{{hdpath}}/move"

mergerfs -o func.getattr=newest,category.create=ff,direct_io,use_ino,atomic_o_trunc,big_writes,default_permissions,splice_move,splice_read,splice_write,allow_other,sync_read,security_capability=false,xattr=nosys,minfreespace=0,noatime,umask=0002,fsname=pgunion \
$hdpath/downloads=RW:$hdpath/move=RW:/mnt/tdrive=NC:/mnt/gdrive=NC:/mnt/tcrypt=NC:/mnt/gcrypt=NC /mnt/unionfs
