#!/bin/bash
#
# Title:      PGBlitz.com (Reference Title File)
# Author(s):  Admin9705 & https://github.com/PGBlitz/PGBlitz.com/graphs/contributors
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
source /pg/pgclone/functions/functions.sh
source /pg/pgclone/functions/variables.sh
source /pg/pgclone/functions/mountnumbers.sh
source /pg/pgclone/functions/keys.sh
source /pg/pgclone/functions/keyback.sh
source /pg/pgclone/functions/pgclone.sh
source /pg/pgclone/functions/gaccount.sh
source /pg/pgclone/functions/publicsecret.sh
source /pg/pgclone/functions/variables.sh
source /pg/pgclone/functions/transportselect.sh
source /pg/pgclone/functions/projectname.sh
source /pg/pgclone/functions/clonestartoutput.sh
source /pg/pgclone/functions/oauth.sh
source /pg/pgclone/functions/passwords.sh
source /pg/pgclone/functions/oauthcheck.sh
source /pg/pgclone/functions/keysbuild.sh
source /pg/pgclone/functions/emails.sh
source /pg/pgclone/functions/deploy.sh
source /pg/pgclone/functions/rcloneinstall.sh
source /pg/pgclone/functions/deploymove.sh
source /pg/pgclone/functions/deployblitz.sh
source /pg/pgclone/functions/multihd.sh
source /pg/pgclone/functions/deploylocal.sh
source /pg/pgclone/functions/createsdrive.sh
source /pg/pgclone/functions/cloneclean.sh
source /pg/pgclone/functions/uagent.sh
################################################################################
rcloneinstall

# (functions.sh) Ensures variables and folders exist
pgclonevars

# (functions.sh) User cannot proceed until they set transport and data type
mustset

# (functions.sh) Ensures that fuse is set correct for rclone
rcpiece

clonestart
