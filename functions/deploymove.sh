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

executemove() {
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
    # gdrive deploys by standard
    echo "gdrive" >/var/plexguide/deploy.version
    echo "mu" >/var/plexguide/deployed.version
    type=gdrive
    ansible-playbook /opt/pgclone/ymls/drive.yml -e "drive=gdrive"
    # deploy only if pgmove is using encryption
    if [[ "$transport" == "me" ]]; then
        echo "me" >/var/plexguide/deployed.version
        type=gcrypt
        ansible-playbook /opt/pgclone/ymls/drive.yml -e "drive=gcrypt"
    fi
    # deploy union
    ansible-playbook /opt/pgclone/ymls/uploader.yml
    # output final display
    if [[ "$type" == "gdrive" ]]; then
        finaldeployoutput="Move - Unencrypted"
    else finaldeployoutput="Move - Encrypted"; fi
    deploySuccess && deploymountSuccess
	
}