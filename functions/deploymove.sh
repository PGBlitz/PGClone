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
executemove () {

# Reset Front Display
rm -rf plexguide/deployed.version

# Call Variables
pgclonevars

# to remove all service running prior to ensure a clean launch
ansible-playbook /opt/pgclone/ymls/remove.yml

# gdrive deploys by standard
echo "gdrive" > /var/plexguide/deploy.version
echo "mu" > /var/plexguide/deployed.version
type=gdrive
ansible-playbook /opt/pgclone/ymls/mount.yml -e "\
  vfs_bs=$vfs_bs
  vfs_dcs=$vfs_dcs
  vfs_dct=$vfs_dct
  vfs_cm=$vfs_cm
  vfs_cma=$vfs_cma
  vfs_cms=$vfs_cms
  vfs_rcs=$vfs_rcs
  vfs_rcsl=$vfs_rcsl
  vfs_ll=$vfs_ll
  drive=gdrive"

# deploy only if pgmove is using encryption
if [[ "$transport" == "me" ]]; then
echo "me" > /var/plexguide/deployed.version
type=gcrypt
ansible-playbook /opt/pgclone/ymls/crypt.yml -e "\
  vfs_bs=$vfs_bs
  vfs_dcs=$vfs_dcs
  vfs_dct=$vfs_dct
  vfs_cm=$vfs_cm
  vfs_cma=$vfs_cma
  vfs_cms=$vfs_cms
  vfs_rcs=$vfs_rcs
  vfs_rcsl=$vfs_rcsl
  vfs_ll=$vfs_ll
  drive=gcrypt"
fi

# deploy union
ansible-playbook /opt/pgclone/ymls/pgunion.yml -e "\
  transport=$transport \
  multihds=$multihds
  type=$type
  vfs_dcs=$vfs_dcs
  hdpath=$hdpath"  

# output final display
if [[ "$type" == "gdrive" ]]; then finaldeployoutput="PG Move - Unencrypted"
else finaldeployoutput="PG Move - Encrypted"; fi

# check if services are active and running
failed=false;

gdrivecheck=$(systemctl is-active gdrive)
gcryptcheck=$(systemctl is-active gcrypt)
pgunioncheck=$(systemctl is-active pgunion)

if [[ "$gdrivecheck" != "active" || "$pgunioncheck" != "active" ]]; then failed=true; fi
if [[ "$gcryptcheck" != "active" && "$transport" == "me" ]]; then failed=true; fi

if [[ $failed == true ]]; then 
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

Error:
EOF
echo | journalctl -u gdrive -u tdrive -u tcrypt -u gcrypt -u pgunion -b -q -p 5 --no-tail -e --no-pager -S today
else
        docker restart $(docker ps -a -q)
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 DEPLOYED: $finaldeployoutput
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

read -rp '↘️  Acknowledge Info | Press [ENTER] ' typed < /dev/tty

}
