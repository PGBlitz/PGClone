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
echo "gdrive" > /var/plexguide/.drive
ansible-playbook /opt/pgclone/ymls/mount.yml

}
