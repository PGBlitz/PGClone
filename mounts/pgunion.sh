#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Authors:    Admin9705, Deiteq, and many PGBlitz Contributors
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
sleep 2

hdpath="$(cat /var/plexguide/server.hd.path)"
mergerfs -o sync_read,auto_cache,dropcacheonclose=true,use_ino,allow_other,func.getattr=newest,category.create=ff,minfreespace=0,fsname=pgunion \
$hdpath/move=RW:$hdpath/downloads=RW:{{multihds}}/mnt/tdrive=NC:/mnt/gdrive=NC:/mnt/tcrypt=NC:/mnt/gcrypt=NC /mnt/unionfs
