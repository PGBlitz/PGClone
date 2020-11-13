#!/bin/bash
#
# Title:      PGBlitz.com (Reference Title File - PGBlitz)
# Author(s):  Admin9705 & https://github.com/PGBlitz/PGClone/graphs/contributors
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
set_location () {
    
    if [[ "${PGBLITZ:0:1}" == / ]]; then
        mkdir -p $PGBLITZ_DIR
    elif [[ ! -z $PGBLITZ_DIR ]]; then
        export PGBLITZ_DIR=/${PGBLITZ_DIR}
        mkdir -p $PGBLITZ_DIR
    else
        export PGBLITZ_DIR=/pg/pgclone
        mkdir -p $PGBLITZ_DIR
    fi
}

set_location
################################################################################
source ./functions/functions.sh
source ./functions/variables.sh
source ./functions/mountnumbers.sh
source ./functions/keys.sh
source ./functions/keyback.sh
source ./functions/pgclone.sh
source ./functions/gaccount.sh
source ./functions/publicsecret.sh
source ./functions/transportselect.sh
source ./functions/projectname.sh
source ./functions/clonestartoutput.sh
source ./functions/oauth.sh
source ./functions/passwords.sh
source ./functions/oauthcheck.sh
source ./functions/keysbuild.sh
source ./functions/emails.sh
source ./functions/deploy.sh
source ./functions/rcloneinstall.sh
source ./functions/deploytransfer.sh
source ./functions/deploysdrive.sh
source ./functions/multihd.sh
source ./functions/deploylocal.sh
source ./functions/createsdrive.sh
source ./functions/cloneclean.sh
source ./functions/uagent.sh
################################################################################

# (folders.sh) Create folders if running in "standalone" mode
make_folders

rcloneinstall

# (functions.sh) Ensures variables and folders exist
pgclonevars

# (functions.sh) User cannot proceed until they set transport and data type
mustset

# (functions.sh) Ensures that fuse is set correct for rclone
rcpiece

clonestart
