#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
sleep 1

mergerfs -o defaults,sync_read,direct_io,use_ino,allow_other,func.getattr=newest,category.create=ff,minfreespace=0,nonempty,fsname=pgunion \
{{hdpath}}/move=RO:{{hdpath}}/downloads=RW:{{multihds}} /mnt/unionfs
