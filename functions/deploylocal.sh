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

    # flush and clear service logs
    cleanlogs
    # This must be called before docker apps are stopped!
    #prunedocker

    # to remove all service running prior to ensure a clean launch
    ansible-playbook /opt/pgclone/ymls/remove.yml

    cleanmounts

    # builds multipath
    multihdreadonly

    # deploy union
    multihds=$(cat /var/plexguide/.tmp.multihd)
    ansible-playbook /opt/pgclone/ymls/local.yml -e "multihds=$multihds"

    # stores deployed version
    echo "le" >/var/plexguide/deployed.version

    # check if services are active and running
    failed=false

    pgunioncheck=$(systemctl is-active pgunion)
    if [[ "$pgunioncheck" != "active" ]]; then failed=true; fi

    if [[ $failed == true ]]; then
        deployFail
    else
        restartapps
        deploySuccess
    fi
}
