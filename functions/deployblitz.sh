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
executeblitz() {
    # Reset Front Display
    rm -rf plexguide/deployed.version
    # Call Variables
    pgclonevars
    # flush and clear service logs
    cleanlogs
    # to remove all service running prior to ensure a clean launch
    ansible-playbook /opt/pgclone/ymls/remove.yml
    cleanmounts
    buildrcloneenv
    # gdrive deploys by standard
    echo "tdrive" >/var/plexguide/deploy.version
    echo "bu" >/var/plexguide/deployed.version
    type=gdrive
    encryptbit=""
    ansible-playbook /opt/pgclone/ymls/drive.yml -e "drive=gdrive"
    type=tdrive
    ansible-playbook /opt/pgclone/ymls/drive.yml -e "drive=tdrive"
    # deploy only if using encryption
    if [[ "$(cat /var/plexguide/pgclone.transport)" == "be"  ]]; then
        ansible-playbook /opt/pgclone/ymls/drive.yml -e "drive=gcrypt"
        echo "be" >/var/plexguide/deployed.version
        type=tcrypt
        encryptbit="C"
        ansible-playbook /opt/pgclone/ymls/drive.yml -e "drive=tcrypt"
    fi
    # builds the list
    ls -la /opt/appdata/plexguide/.blitzkeys/ | awk '{print $9}' | tail -n +4 | sort | uniq >/var/plexguide/.blitzlist
    rm -rf /var/plexguide/.blitzfinal 1>/dev/null 2>&1
    touch /var/plexguide/.blitzbuild
    while read p; do
        echo $p >/var/plexguide/.blitztemp
        if [[ "$(grep "GDSA" /var/plexguide/.blitztemp)" != "" ]]; then echo $p >>/var/plexguide/.blitzfinal; fi
    done </var/plexguide/.blitzlist
    # deploy union
    ansible-playbook /opt/pgclone/ymls/pgunion.yml -e "transport=$transport type=$type multihds=$multihds encryptbit=$encryptbit"
    ansible-playbook /opt/pgclone/ymls/uploader.yml
    # check if services are active and running
    failed=false

    gdrivecheck=$(systemctl is-active gdrive)
    gcryptcheck=$(systemctl is-active gcrypt)
    tdrivecheck=$(systemctl is-active tdrive)
    tcryptcheck=$(systemctl is-active tcrypt)
    pgunioncheck=$(systemctl is-active pgunion)

    if [[ "$gdrivecheck" != "active" || "$tdrivecheck" != "active" || "$pgunioncheck" != "active" ]]; then failed=true; fi
    if [[ "$gcryptcheck" != "active" || "$tcryptcheck" != "active" ]] && [[ "$transport" == "be" ]]; then failed=true; fi
    if [[ $failed == true ]]; then
        deployFail
    else
        restartapps
        deploySuccess
    fi
}
