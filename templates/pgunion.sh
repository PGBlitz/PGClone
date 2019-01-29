#!/bin/bash
#
# Title:      PlexGuide (Reference Title File)
# Author(s):  Admin9705
# URL:        https://plexguide.com - http://github.plexguide.com
# GNU:        General Public License v3.0
################################################################################

# Outside Variables
dlpath=$(cat /var/plexguide/server.hd.path)
sleep 10

mergerfs -o symlinkify=true,symlinkify_timeout=90,atomic_o_trunc,big_writes,default_permissions,splice_move,splice_read,splice_write,auto_cache,sync_read,allow_other,use_ino,func.getattr=newest,nonempty,direct_io,security_capability=false,xattr=nosys,category.create=ff,minfreespace=0,umask=002,noatime,fsname=pgUnion /mnt/gdrive=NC:/mnt/tdrive=NC:/mnt/tcrypt=NC:/mnt/gcrypt=NC:$dlpath/downloads=NC:$dlpath/move=RW /mnt/unionfs