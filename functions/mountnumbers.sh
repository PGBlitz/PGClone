#!/bin/bash
#
# Title:      Reference Title File - PGBlitz
# Author(s):  Admin9705 & https://github.com/PGBlitz/PGClone/graphs/contributors
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
mountnumbers () {
    pgclonevars

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
RClone Mount Settings ~ clonesettings.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTE 1: Read the wiki on how changing the settings impact stability and
performance! After changing the settings, you must redeploy the mounts!

NOTE 2: You will be editing a JSON file! Only change what's within the
quotations! If you mess things up, your mounts can deploy incorrectly!

NOTE 3: To RESET the JSON change the defaults setting to "yes" in all
lower case.

NOTE 4: Final Note, to SAVE... Press CTRL + X and select "YES" to save
the settings!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

    read -rp '↘️  Input Selection | Press [ENTER]: ' fluffycat < /dev/tty

nano /pg/rclone/pgclone.json

}
