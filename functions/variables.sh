#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
pgclonevars () {
  mkdir -p /var/plexguide/rclone
  variable /var/plexguide/project.account "NOT-SET"
  variable /var/plexguide/pgclone.teamdrive ""
  variable /var/plexguide/rclone/deploy.version "null"
  variable /var/plexguide/pgclone.transport "NOT-SET"
  variable /var/plexguide/gdrive.pgclone "⚠️  Not Activated"
  variable /var/plexguide/tdrive.pgclone "⚠️  Not Activated"
  variable /var/plexguide/move.bw  "9"
  variable /var/plexguide/blitz.bw  "1000"
  variable /var/plexguide/pgclone.password ""
  variable /var/plexguide/pgclone.salt ""

  transport=$(cat /var/plexguide/pgclone.transport)

  variable /var/plexguide/pgclone.id "NOT-SET" # output for front interface, changes when users sets id/secret
  pgcloneid=$(cat /var/plexguide/pgclone.id)

  variable /var/plexguide/pgclone.public ""
  pgclonepublic=$(cat /var/plexguide/pgclone.public)

  variable /var/plexguide/pgclone.secret ""
  pgclonesecret=$(cat /var/plexguide/pgclone.secret)

  variable /var/plexguide/pgclone.email "NOT-SET"
  pgcloneemail=$(cat /var/plexguide/pgclone.email)

  variable /var/plexguide/oauth.type "NOT-SET" #output for auth type
  oauthtype=$(cat /var/plexguide/oauth.type)

  variable /var/plexguide/pgclone.project "NOT-SET"
  pgcloneproject=$(cat /var/plexguide/pgclone.project)

}
