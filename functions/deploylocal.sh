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
executelocal () {
    
    # Reset Front Display
    rm -rf plexguide/deployed.version
    
    # Call Variables
    pgclonevars

    # flush and clear service logs
    journalctl --flush --rotate
    journalctl --vacuum-time=1s
    
    # to remove all service running prior to ensure a clean launch
    ansible-playbook /opt/pgclone/ymls/remove.yml
    
    # builds multipath
    multihdreadonly
    
    # deploy union
    multihds=$(cat /var/plexguide/.tmp.multihd)
    ansible-playbook /opt/pgclone/ymls/local.yml -e "multihds=$multihds hdpath=$hdpath"
    
    # stores deployed version
    echo "le" > /var/plexguide/deployed.version
    
    
    # check if services are active and running
    failed=false;
    
    pgunioncheck=$(systemctl is-active pgunion)
    if [[ "$pgunioncheck" != "active" ]]; then failed=true; fi
    
    if [[ $failed == true ]]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔ DEPLOY FAILED: PG Local Edition
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

An error has occurred when deploying PGClone.
Your apps are currently stopped to prevent data loss.

Things to try: If you just finished the initial setup, you likely made a typo
or other error when configuring PGClone. Please redo the pgclone config first
before reporting an issue.

If this issue still persists:

Please share this error on discord or the forums before proceeding.

Error:
EOF
        echo | journalctl -u pgunion -b -q -p 6 --no-tail -e --no-pager -S today
    else
        docker restart "$(docker ps -a -q)"
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 DEPLOYED: PG Local Edition
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
    fi
    read -rp '↘️  Acknowledge Info | Press [ENTER] ' typed < /dev/tty
    
}
