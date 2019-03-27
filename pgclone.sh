#!/bin/bash
#
# Title:      PGBlitz.com (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
source /opt/pgclone/functions/functions.sh
source /opt/pgclone/functions/variables.sh
source /opt/pgclone/functions/mountnumbers.sh
source /opt/pgclone/functions/keys.sh
source /opt/pgclone/functions/keyback.sh
source /opt/pgclone/functions/pgclone.sh
source /opt/pgclone/functions/gaccount.sh
source /opt/pgclone/functions/publicsecret.sh
source /opt/pgclone/functions/variables.sh
source /opt/pgclone/functions/transportselect.sh
source /opt/pgclone/functions/projectname.sh
source /opt/pgclone/functions/clonestartoutput.sh
source /opt/pgclone/functions/oauth.sh
source /opt/pgclone/functions/passwords.sh
source /opt/pgclone/functions/oauthcheck.sh
source /opt/pgclone/functions/keysbuild.sh
source /opt/pgclone/functions/emails.sh
source /opt/pgclone/functions/deploy.sh
source /opt/pgclone/functions/rcloneinstall.sh
source /opt/pgclone/functions/deploymove.sh
source /opt/pgclone/functions/deployblitz.sh
source /opt/pgclone/functions/multihd.sh
source /opt/pgclone/functions/deploylocal.sh
################################################################################
rcloneinstall

# (functions.sh) Ensures variables and folders exist
pgclonevars

# (functions.sh) User cannot proceed until they set transport and data type
mustset

# (functions.sh) Ensures that fuse is set correct for rclone
rcpiece

clonestart
