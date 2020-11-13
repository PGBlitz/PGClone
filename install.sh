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
source ${PGBLITZ_DIR}/functions/functions.sh
source ${PGBLITZ_DIR}/functions/variables.sh
source ${PGBLITZ_DIR}/functions/mountnumbers.sh
source ${PGBLITZ_DIR}/functions/keys.sh
source ${PGBLITZ_DIR}/functions/keyback.sh
source ${PGBLITZ_DIR}/functions/pgclone.sh
source ${PGBLITZ_DIR}/functions/gaccount.sh
source ${PGBLITZ_DIR}/functions/publicsecret.sh
source ${PGBLITZ_DIR}/functions/transportselect.sh
source ${PGBLITZ_DIR}/functions/projectname.sh
source ${PGBLITZ_DIR}/functions/clonestartoutput.sh
source ${PGBLITZ_DIR}/functions/oauth.sh
source ${PGBLITZ_DIR}/functions/passwords.sh
source ${PGBLITZ_DIR}/functions/oauthcheck.sh
source ${PGBLITZ_DIR}/functions/keysbuild.sh
source ${PGBLITZ_DIR}/functions/emails.sh
source ${PGBLITZ_DIR}/functions/deploy.sh
source ${PGBLITZ_DIR}/functions/rcloneinstall.sh
source ${PGBLITZ_DIR}/functions/deploytransfer.sh
source ${PGBLITZ_DIR}/functions/deploysdrive.sh
source ${PGBLITZ_DIR}/functions/multihd.sh
source ${PGBLITZ_DIR}/functions/deploylocal.sh
source ${PGBLITZ_DIR}/functions/createsdrive.sh
source ${PGBLITZ_DIR}/functions/cloneclean.sh
source ${PGBLITZ_DIR}/functions/uagent.sh
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
