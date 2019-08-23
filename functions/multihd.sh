#!/bin/bash
#
# Title:      Reference Title File - PGBlitz
# Author(s):  Admin9705 & https://github.com/PGBlitz/PGClone/graphs/contributors
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
multihdreadonly () {

  # calls up standard variables
  pgclonevars

  # removes the temporary variable when starting
  rm -rf /pg/var/.tmp.multihd 1>/dev/null 2>&1

    # reads the list of paths
    while read p; do

       # prevents copying blanks areas
       if [[ "$p" != "" ]]; then
         echo -n "$p=NC:" >> /pg/var/.tmp.multihd
         chown -R 1000:1000 "$p"
         chmod -R 755 "$p"
       fi

    done </pg/var/multihd.paths

}
