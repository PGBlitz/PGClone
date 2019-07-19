#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
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
    # This must be called before docker apps are stopped!
    #prunedocker

    # to remove all service running prior to ensure a clean launch
    ansible-playbook /opt/pgclone/ymls/remove.yml

    cleanmounts

    # gdrive deploys by standard
    echo "tdrive" >/var/plexguide/deploy.version
    echo "bu" >/var/plexguide/deployed.version
    type=gdrive
    encryptbit=""
    ansible-playbook /opt/pgclone/ymls/mount.yml -vvv -e "drive=gdrive"

    type=tdrive
    ansible-playbook /opt/pgclone/ymls/mount.yml -vvv -e "drive=tdrive"

    # deploy only if using encryption
    if [[ "$transport" == "be" ]]; then
        ansible-playbook /opt/pgclone/ymls/crypt.yml -vvv -e "drive=gcrypt"

        echo "be" >/var/plexguide/deployed.version
        type=tcrypt
        encryptbit="C"
        ansible-playbook /opt/pgclone/ymls/crypt.yml -e "drive=tcrypt"
    fi

    # builds the list
    ls -la /opt/appdata/plexguide/.blitzkeys/ | awk '{print $9}' | tail -n +4 | sort | uniq >/var/plexguide/.blitzlist
    rm -rf /var/plexguide/.blitzfinal 1>/dev/null 2>&1
    touch /var/plexguide/.blitzbuild
    while read p; do
        echo $p >/var/plexguide/.blitztemp
        blitzcheck=$(grep "GDSA" /var/plexguide/.blitztemp)
        if [[ "$blitzcheck" != "" ]]; then echo $p >>/var/plexguide/.blitzfinal; fi
    done </var/plexguide/.blitzlist

    # deploy union
    ansible-playbook /opt/pgclone/ymls/pgunion.yml -e "transport=$transport type=$type multihds=$multihds encryptbit=$encryptbit"

    # output final display
    if [[ "$type" == "tdrive" ]]; then
        finaldeployoutput="PG Blitz - Unencrypted"
    else finaldeployoutput="PG Blitz - Encrypted"; fi

    # check if services are active and running
    failed=false

    gdrivecheck=$(systemctl is-active gdrive)
    gcryptcheck=$(systemctl is-active gcrypt)
    tdrivecheck=$(systemctl is-active tdrive)
    tcryptcheck=$(systemctl is-active tcrypt)
    pgunioncheck=$(systemctl is-active pgunion)
    pgblitzcheck=$(systemctl is-active pgblitz)

    if [[ "$gdrivecheck" != "active" || "$tdrivecheck" != "active" || "$pgunioncheck" != "active" || "$pgblitzcheck" != "active" ]]; then failed=true; fi
    if [[ "$gcryptcheck" != "active" || "$tcryptcheck" != "active" ]] && [[ "$transport" == "be" ]]; then failed=true; fi

    if [[ $failed == true ]]; then
        erroroutput="$(journalctl -u gdrive -u gcrypt -u pgunion -u pgmove -b -q -p 6 --no-tail -e --no-pager --since "5 minutes ago" -n 20)"
        logoutput="$(tail -n 20 /var/plexguide/logs/*.log)"
        tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔ DEPLOY FAILED: $finaldeployoutput
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

An error has occurred when deploying PGClone.
Your apps are currently stopped to prevent data loss.

Things to try: If you just finished the initial setup, you likely made a typo
or other error when configuring PGClone. Please redo the pgclone config first
before reporting an issue.

If this issue still persists:

Please share this error on discord or the forums before proceeding.

Error details: 
$erroroutput
$logoutput

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔ DEPLOY FAILED: $finaldeployoutput
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    else
        restartapps
        tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 DEPLOYED: $finaldeployoutput
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

PGClone has been deployed sucessfully!
All services are active and running normally.

EOF
    fi

    read -rp '↘️  Acknowledge Info | Press [ENTER] ' typed </dev/tty

}
