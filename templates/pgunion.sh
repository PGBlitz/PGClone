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

mergerfs -o atomic_o_trunc,big_writes,default_permissions,splice_move,splice_read,splice_write,allow_other,direct_io,use_ino,sync_read,dropcacheonclose=true,security_capability=false,xattr=nosys,statfs_ignore=ro,category.action=all,category.create=ff,fsname=pgunion \
$dlpath/downloads=NC:$dlpath/move=RW:/mnt/tdrive=NC:/mnt/gdrive=NC:/mnt/tcrypt=NC:/mnt/gcrypt=NC /mnt/unionfs
