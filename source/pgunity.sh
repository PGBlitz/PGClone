#!/bin/bash
#
# Title:      Reference Title File - PGBlitz
# Author(s):  Admin9705 & https://github.com/PGBlitz/PGClone/graphs/contributors
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
sleep 2

chown -R 1000:1000 "{{hdpath}}/downloads"
chmod -R 755 "{{hdpath}}/downloads"
chown -R 1000:1000 "{{hdpath}}/move"
chmod -R 755 "{{hdpath}}/move"

mergerfs -o func.getattr=newest,category.create=ff,direct_io,use_ino,atomic_o_trunc,big_writes,default_permissions,splice_move,splice_read,splice_write,allow_other,sync_read,minfreespace=0,umask=002,uid=1000,gid=1000,fsname=pgunity,nonempty \
{{hdpath}}/transfer=RW:{{multihds}}/pg/sd=NC:/pg/gd=NC:/pg/sc=NC:/pg/gc=NC /pg/unity
