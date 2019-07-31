#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Authors:    Admin9705, Deiteq, and many PGBlitz Contributors
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
multihdreadonly() {

  # calls up standard variables
  pgclonevars

  # removes the temporary variable when starting
  rm -rf /var/plexguide/.tmp.multihd 1>/dev/null 2>&1

  # reads the list of paths
  while read p; do

    # prevents copying blanks areas
    if [[ "$p" != "" ]]; then
      echo -n "$p=NC:" >>/var/plexguide/.tmp.multihd
      chown -R 1000:1000 "$p"
      chmod -R 755 "$p"
    fi

  done </var/plexguide/multihd.paths

}
