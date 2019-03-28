#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
sleep 2

chown -R 1000:1000 "{{hdpath}}/downloads"
chmod -R 755 "{{hdpath}}/downloads"
chown -R 1000:1000 "{{hdpath}}/move"
chmod -R 755 "{{hdpath}}/move"

mergerfs -o func.getattr=newest,category.create=ff,direct_io,use_ino,atomic_o_trunc,big_writes,default_permissions,splice_move,splice_read,splice_write,allow_other,sync_read,minfreespace=15,umask=002,uid=1000,gid=1000,fsname=pgunion,nonempty \
{{hdpath}}/move=RO:{{hdpath}}/downloads=RW:{{multihds}} /mnt/unionfs

# old mergerfs pg7 reference
###ExecStart=/usr/bin/mergerfs -o defaults,allow_other,direct_io,nonempty,use_ino,category.create=eplfs,moveonenospc=true,minfreespace=15G,fsname=pgPool {{mergerfs_path.stdout}} /mnt/unionfs
