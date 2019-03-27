#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
pgclonevars () {

  variablet () {
    file="$1"
    if [ ! -e "$file" ]; then touch "$1"; fi
  }

  # rest standard
  mkdir -p /var/plexguide/rclone
  variable /var/plexguide/project.account "NOT-SET"
  variable /var/plexguide/rclone/deploy.version "null"
  variable /var/plexguide/pgclone.transport "NOT-SET"
  variable /var/plexguide/move.bw  "9"
  variable /var/plexguide/blitz.bw  "1000"
  variable /var/plexguide/pgclone.salt ""

  variable /var/plexguide/server.hd.path "/mnt"
  hdpath=$(cat /var/plexguide/server.hd.path)

  variable /var/plexguide/oauth.check ""
  oauthcheck=$(cat /var/plexguide/oauth.check)

  variable /var/plexguide/clone.password "NOT-SET"
  if [[ $(cat /var/plexguide/clone.password) == "NOT-SET" ]]; then pstatus="NOT-SET"
  else
    pstatus="ACTIVE"
    clonepassword=$(cat /var/plexguide/clone.password)
    clonesalt=$(cat /var/plexguide/pgclone.salt)
  fi

  variable /opt/appdata/plexguide/.gdrive "NOT-SET"
  if [[ $(cat /opt/appdata/plexguide/.gdrive) == "NOT-SET" ]]; then gstatus="NOT-SET"
  else gstatus="ACTIVE"; fi

  variable /opt/appdata/plexguide/.tdrive "NOT-SET"
  if [[ $(cat /opt/appdata/plexguide/.tdrive) == "NOT-SET" ]]; then tstatus="NOT-SET"
  else tstatus="ACTIVE"; fi

  variable /opt/appdata/plexguide/.tcrypt "NOT-SET"
  if [[ $(cat /opt/appdata/plexguide/.tcrypt) == "NOT-SET" ]]; then tcstatus="NOT-SET"
  else tcstatus="ACTIVE"; fi

  variable /opt/appdata/plexguide/.gcrypt "NOT-SET"
  if [[ $(cat /opt/appdata/plexguide/.gcrypt) == "NOT-SET" ]]; then gcstatus="NOT-SET"
  else gcstatus="ACTIVE"; fi

  transport=$(cat /var/plexguide/pgclone.transport)

  variable /var/plexguide/pgclone.teamdrive "NOT-SET"
  tdname=$(cat /var/plexguide/pgclone.teamdrive)

  variable /var/plexguide/pgclone.demo "OFF"
  demo=$(cat /var/plexguide/pgclone.demo)

  variable /var/plexguide/pgclone.teamid ""
  tdid=$(cat /var/plexguide/pgclone.teamid)

  variable /var/plexguide/rclone/deploy.version ""
  type=$(cat /var/plexguide/rclone/deploy.version)

  variable /var/plexguide/pgclone.public ""
  pgclonepublic=$(cat /var/plexguide/pgclone.public)

  mkdir -p /opt/appdata/plexguide/.blitzkeys
  displaykey=$(ls /opt/appdata/plexguide/.blitzkeys | wc -l)

  variable /var/plexguide/pgclone.secret ""
  pgclonesecret=$(cat /var/plexguide/pgclone.secret)

  if [[ "$pgclonesecret" == "" || "$pgclonepublic" == "" ]]; then pgcloneid="NOT-SET"; fi
  if [[ "$pgclonesecret" != "" && "$pgclonepublic" != "" ]]; then pgcloneid="ACTIVE"; fi

  variable /var/plexguide/pgclone.email "NOT-SET"
  pgcloneemail=$(cat /var/plexguide/pgclone.email)

  variable /var/plexguide/oauth.type "NOT-SET" #output for auth type
  oauthtype=$(cat /var/plexguide/oauth.type)

  variable /var/plexguide/pgclone.project "NOT-SET"
  pgcloneproject=$(cat /var/plexguide/pgclone.project)

  variable /var/plexguide/deployed.version ""
  dversion=$(cat /var/plexguide/deployed.version)

  variablet /var/plexguide/.tmp.multihd
  multihds=$(cat /var/plexguide/.tmp.multihd)

  if [[ "$dversion" == "mu" ]]; then dversionoutput="Unencrypted Move"
elif [[ "$dversion" == "me" ]]; then dversionoutput="Encrypted Move"
elif [[ "$dversion" == "bu" ]]; then dversionoutput="Unencrypted Blitz"
elif [[ "$dversion" == "be" ]]; then dversionoutput="Encrypted Blitz"
elif [[ "$dversion" == "le" ]]; then dversionoutput="Local HD/Mount"
else dversionoutput="None"; fi

# For PG Blitz Mounts
  variable /var/plexguide/vfs_bs "64"
  vfs_bs=$(cat /var/plexguide/vfs_bs)

  variable /var/plexguide/vfs_dcs "128"
  vfs_dcs=$(cat /var/plexguide/vfs_dcs)

  variable /var/plexguide/vfs_dct "2"
  vfs_dct=$(cat /var/plexguide/vfs_dct)

  variable /var/plexguide/vfs_cma "72"
  vfs_cma=$(cat /var/plexguide/vfs_cma)

  variable /var/plexguide/vfs_rcs "64"
  vfs_rcs=$(cat /var/plexguide/vfs_rcs)

  variable /var/plexguide/vfs_rcsl "5"
  vfs_rcsl=$(cat /var/plexguide/vfs_rcsl)

}
