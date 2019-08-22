#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705 & https://github.com/PGBlitz/PGBlitz.com/graphs/contributors
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
ansible-playbook /pg/pgclone/ymls/remove.yml

# gdrive deploys by standard
echo "gd" > /pg/var/deploy.version
echo "mu" > /pg/var/deployed.version
type=gd
ansible-playbook /pg/pgclone/ymls/mount.yml -e "\
  bs=$bs
  dcs=$dcs
  dct=$dct
  cma=$cma
  rcs=$rcs
  rcsl=$rcsl
  drive=gd"

# deploy only if pgmove is using encryption
if [[ "$transport" == "me" ]]; then
echo "me" > /pg/var/deployed.version
type=gc
ansible-playbook /pg/pgclone/ymls/crypt.yml -e "\
  bs=$bs
  dcs=$dcs
  dct=$dct
  cma=$cma
  rcs=$rcs
  rcsl=$rcsl
  drive=gc"
fi

# deploy union
ansible-playbook /pg/pgclone/ymls/pgunity.yml -e "\
  transport=$transport \
  multihds=$multihds
  type=$type
  dcs=$dcs
  hdpath=$hdpath"

# output final display
if [[ "$type" == "gdrive" ]]; then finaldeployoutput="PG Move - Unencrypted"
else finaldeployoutput="PG Move - Encrypted"; fi

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 DEPLOYED: $finaldeployoutput
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

read -rp '↘️  Acknowledge Info | Press [ENTER] ' typed < /dev/tty

}
