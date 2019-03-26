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
executeblitz () {

# Reset Front Display
rm -rf plexguide/deployed.version

# Call Variables
pgclonevars

# to remove all service running prior to ensure a clean launch
ansible-playbook /opt/pgclone/ymls/remove.yml

# gdrive deploys by standard
echo "tdrive" > /var/plexguide/deploy.version
echo "bu" > /var/plexguide/deployed.version
type=gdrive
encryptbit=""
ansible-playbook /opt/pgclone/ymls/mount.yml -e "\
  vfs_bs=$vfs_bs
  vfs_dcs=$vfs_dcs
  vfs_dct=$vfs_dct
  vfs_cma=$vfs_cma
  vfs_rcs=$vfs_rcs
  vfs_rcsl=$vfs_rcsl
  drive=gdrive"

type=tdrive
ansible-playbook /opt/pgclone/ymls/mount.yml -e "\
  vfs_bs=$vfs_bs
  vfs_dcs=$vfs_dcs
  vfs_dct=$vfs_dct
  vfs_cma=$vfs_cma
  vfs_rcs=$vfs_rcs
  vfs_rcsl=$vfs_rcsl
  drive=tdrive"

# deploy only if pgmove is using encryption
if [[ "$transport" == "be" ]]; then
ansible-playbook /opt/pgclone/ymls/crypt.yml -e "\
  vfs_bs=$vfs_bs
  vfs_dcs=$vfs_dcs
  vfs_dct=$vfs_dct
  vfs_cma=$vfs_cma
  vfs_rcs=$vfs_rcs
  vfs_rcsl=$vfs_rcsl
  drive=gcrypt"

echo "be" > /var/plexguide/deployed.version
type=tcrypt
encryptbit="C"
ansible-playbook /opt/pgclone/ymls/crypt.yml -e "\
  vfs_bs=$vfs_bs
  vfs_dcs=$vfs_dcs
  vfs_dct=$vfs_dct
  vfs_cma=$vfs_cma
  vfs_rcs=$vfs_rcs
  vfs_rcsl=$vfs_rcsl
  drive=tcrypt"
fi

# builds the list
ls -la /opt/appdata/plexguide/.blitzkeys/ | awk '{print $9}' | tail -n +4 | sort | uniq > /var/plexguide/.blitzlist
rm -rf /var/plexguide/.blitzfinal 1>/dev/null 2>&1
touch /var/plexguide/.blitzbuild
while read p; do
  echo $p > /var/plexguide/.blitztemp
  blitzcheck=$(grep "GDSA" /var/plexguide/.blitztemp)
  if [[ "$blitzcheck" != "" ]]; then echo $p >> /var/plexguide/.blitzfinal; fi
done </var/plexguide/.blitzlist

# deploy union
ansible-playbook /opt/pgclone/ymls/pgunion.yml -e "\
  transport=$transport \
  type=$type
  multihds=$multihds
  encryptbit=$encryptbit
  hdpath=$hdpath"

# output final display
if [[ "$type" == "tdrive" ]]; then finaldeployoutput="PG Blitz - Unencrypted"
else finaldeployoutput="PG Blitz - Encrypted"; fi

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 DEPLOYED: $finaldeployoutput
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

read -rp '↘️  Acknowledge Info | Press [ENTER] ' typed < /dev/tty

}
