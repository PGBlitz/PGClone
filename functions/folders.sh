#!/bin/bash
#
# Title:      Reference Title File - PGBlitz
# Author(s):  Admin9705 & https://github.com/PGBlitz/PGClone/graphs/contributors
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

make_folders () {

    fcreate () {
    if [[ ! -e "$1" ]]; then
        mkdir -p "$1"
        chown 1000:1000 "$1"
        chmod 0775 "$1"; fi
        echo "Generated Folder: $1"
  }
    if [ -z $standalone ]; then
        fcreate /pg/logs
        fcreate /pg/gc
        fcreate /pg/gd
        fcreate /pg/sc
        fcreate /pg/sd
        fcreate /pg/transfer
        fcreate /pg/transport
        fcreate /pg/unity
    fi
}
make_folders