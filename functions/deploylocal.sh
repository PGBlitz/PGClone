#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Authors:    Admin9705, Deiteq, and many PGBlitz Contributors
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
# NOTES
# Variable recall comes from /functions/variables.sh
################################################################################
executelocal() {
    # Reset Front Display
    rm -rf plexguide/deployed.version
    # Call Variables
    pgclonevars
	# update system to new packages
    ansible-playbook /opt/pgclone/ymls/update.yml
    # flush and clear service logs
    cleanlogs
    # to remove all service running prior to ensure a clean launch
    ansible-playbook /opt/pgclone/ymls/remove.yml
    # builds multipath
    multihdreadonly
    # deploy union
    multihds=$(cat /var/plexguide/.tmp.multihd)
    ansible-playbook /opt/pgclone/ymls/local.yml -e "multihds=$multihds"
    # stores deployed version
    echo "le" >/var/plexguide/deployed.version
}
