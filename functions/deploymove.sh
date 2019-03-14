#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
executemove () {
pgclonevars

# to remove all service running prior to ensure a clean launch
ansible-playbook /opt/pgclone/ymls/remove.yml

# gdrive deploys by standard
echo "gdrive" > /var/plexguide/deploy.version
type=gdrive
ansible-playbook /opt/pgclone/ymls/mount.yml -e "drive=gdrive"

# deploy only if pgmove is using encryption
if [[ "$transport" == "me" ]]; then
type=gcrypt
ansible-playbook /opt/pgclone/ymls/crypt.yml -e "drive=gcrypt"; fi

# deploy union
ansible-playbook /opt/pgclone/ymls/pgunion.yml -e "\
  transport=$transport \
  type=$type
  hdpath=$hdpath"

# deploy move script

}
