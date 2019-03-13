#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
deploymove () {
pgclonevars

# to remove all service running prior to ensure a clean launch
ansible-playbook /opt/pgclone/ymls/remove.yml

# gdrive deploys by standard
ansible-playbook /opt/pgclone/ymls/mount.yml -e "drive=gdrive"

# deploy only if pgmove is using encryption
if [[ "$transport" == "ge" ]]; then
ansible-playbook /opt/pgclone/ymls/crypt.yml -e "drive=gcrypt"; fi

# deploy union
ansible-playbook /opt/pgclone/ymls/crypt.yml -e "transport=${transport}"; fi

# deploy move script

}
