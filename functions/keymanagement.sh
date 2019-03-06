#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

# BAD INPUT
badinput () {
echo
read -p '⛔️ ERROR - Bad Input! | Press [ENTER] ' typed < /dev/tty
}

glogin () {
gcloud auth login
gcloud info | grep Account: | cut -c 10- > /var/plexguide/project.account
account=$(cat /var/plexguide/project.account)
}
