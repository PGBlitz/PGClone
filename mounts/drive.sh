#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

uagent="$(cat /var/plexguide/uagent)"
vfs_ll="$(cat /var/plexguide/vfs_ll)"
vfs_bs="$(cat /var/plexguide/vfs_bs)"
vfs_rcs="$(cat /var/plexguide/vfs_rcs)"
vfs_rcsl="$(cat /var/plexguide/vfs_rcsl)"
vfs_cma="$(cat /var/plexguide/vfs_cma)"
vfs_cm="$(cat /var/plexguide/vfs_cm)"
vfs_dct="$(cat /var/plexguide/vfs_dct)"

rclone mount {{drive}}: /mnt/{{drive}} \
    --config=/opt/appdata/plexguide/rclone.conf \
    --log-file=/var/plexguide/logs/rclone-{{drive}}.log \
    --log-level="$vfs_ll" \
    --uid=1000 --gid=1000 --umask=002 \
    --allow-other \
    --timeout=1h \
    --user-agent="$uagent" \
    --dir-cache-time="$vfs_dct" \
    --vfs-cache-mode="$vfs_cm" \
    --vfs-cache-max-age="$vfs_cma" \
    --vfs-read-chunk-size-limit="$vfs_rcsl" \
    --vfs-read-chunk-size="$vfs_rcs" \
    --BREAKME \
    --buffer-size="$vfs_bs"
