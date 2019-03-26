#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
multihdreadonly () {
  pgclonevars

  rm -rf /var/plexguide/.tmp.multihd 1>/dev/null 2>&1
  if [[ $(cat /var/plexguide/multihd.paths) != "" ]]; then
    while read p; do
       echo -n "$p=NC:" >> /var/plexguide/.tmp.multihd
    done </var/plexguide/multihd.paths
  fi

}
