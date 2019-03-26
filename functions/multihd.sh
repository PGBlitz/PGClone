#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
multihdreadonly () {
  pgclonevars

  if [[ $(cat /var/plexguide/multihd.paths) != "" ]]; then
    while read p; do
       echo "$p=NC" >> /var/plexguide/.tmp.multihd; fi
    done </var/plexguide/multihd.paths

  fi

}
