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
  mkdir -p /pg/var/rclone /pg/logs
  touch /pg/logs/gd.log /pg/logs/sd.log /pg/logs/ge.log /pg/logs/se.log /pg/logs/pgblitz.log /pg/logs/pgmove.log

  variable /pg/var/project.account "NOT-SET"
  variable /pg/var/rclone/deploy.version "null"
  variable /pg/var/pgclone.transport "NOT-SET"
  variable /pg/var/move.bw  "9"
  variable /pg/var/blitz.bw  "1000"
  variable /pg/var/pgclone.salt ""

  variable /pg/var/server.hd.path "/mnt"
  hdpath=$(cat /pg/var/server.hd.path)

  variable /pg/var/oauth.check ""
  oauthcheck=$(cat /pg/var/oauth.check)

  variable /pg/var/pgclone.password "NOT-SET"
  if [[ $(cat /pg/var/pgclone.password) == "NOT-SET" ]]; then pstatus="NOT-SET"
  else
    pstatus="ACTIVE"
    clonepassword=$(cat /pg/var/pgclone.password)
    clonesalt=$(cat /pg/var/pgclone.salt)
  fi

  variable /pg/var/.gdrive "NOT-SET"
  if [[ $(cat /pg/var/.gdrive) == "NOT-SET" ]]; then gstatus="NOT-SET"
  else gstatus="ACTIVE"; fi

  variable /pg/var/.tdrive "NOT-SET"
  if [[ $(cat /pg/var/.tdrive) == "NOT-SET" ]]; then tstatus="NOT-SET"
  else tstatus="ACTIVE"; fi

  variable /pg/var/.tcrypt "NOT-SET"
  if [[ $(cat /pg/var/.tcrypt) == "NOT-SET" ]]; then tcstatus="NOT-SET"
  else tcstatus="ACTIVE"; fi

  variable /pg/var/.gcrypt "NOT-SET"
  if [[ $(cat /pg/var/.gcrypt) == "NOT-SET" ]]; then gcstatus="NOT-SET"
  else gcstatus="ACTIVE"; fi

  transport=$(cat /pg/var/pgclone.transport)

  variable /pg/var/pgclone.teamdrive "NOT-SET"
  tdname=$(cat /pg/var/pgclone.teamdrive)

  variable /pg/var/pgclone.demo "OFF"
  demo=$(cat /pg/var/pgclone.demo)

  variable /pg/var/pgclone.teamid ""
  tdid=$(cat /pg/var/pgclone.teamid)

  variable /pg/var/rclone/deploy.version ""
  type=$(cat /pg/var/rclone/deploy.version)

  variable /pg/var/pgclone.public ""
  pgclonepublic=$(cat /pg/var/pgclone.public)

  mkdir -p /pg/var/.blitzkeys
  displaykey=$(ls /pg/var/.blitzkeys | wc -l)

  variable /pg/var/pgclone.secret ""
  pgclonesecret=$(cat /pg/var/pgclone.secret)

  if [[ "$pgclonesecret" == "" || "$pgclonepublic" == "" ]]; then pgcloneid="NOT-SET"; fi
  if [[ "$pgclonesecret" != "" && "$pgclonepublic" != "" ]]; then pgcloneid="ACTIVE"; fi

  variable /pg/var/pgclone.email "NOT-SET"
  pgcloneemail=$(cat /pg/var/pgclone.email)

  variable /pg/var/oauth.type "NOT-SET" #output for auth type
  oauthtype=$(cat /pg/var/oauth.type)

  variable /pg/var/pgclone.project "NOT-SET"
  pgcloneproject=$(cat /pg/var/pgclone.project)

  variable /pg/var/deployed.version ""
  dversion=$(cat /pg/var/deployed.version)

  variablet /pg/var/.tmp.multihd
  multihds=$(cat /pg/var/.tmp.multihd)

  if [[ "$dversion" == "mu" ]]; then dversionoutput="Unencrypted Move"
elif [[ "$dversion" == "me" ]]; then dversionoutput="Encrypted Move"
elif [[ "$dversion" == "bu" ]]; then dversionoutput="Unencrypted Blitz"
elif [[ "$dversion" == "be" ]]; then dversionoutput="Encrypted Blitz"
elif [[ "$dversion" == "le" ]]; then dversionoutput="Local HD/Mount"
else dversionoutput="None"; fi

# For Clone Clean
  variable /pg/var/cloneclean "600"
  cloneclean=$(cat /pg/var/cloneclean)

# For PG Blitz Mounts
  variable /pg/var/vfs_bs "16"
  vfs_bs=$(cat /pg/var/vfs_bs)


  variable /pg/var/vfs_dcs "64"
  vfs_dcs=$(cat /pg/var/vfs_dcs)

  variable /pg/var/vfs_dct "2"
  vfs_dct=$(cat /pg/var/vfs_dct)

  variable /pg/var/vfs_cma "1"
  vfs_cma=$(cat /pg/var/vfs_cma)

  variable /pg/var/vfs_rcs "64"
  vfs_rcs=$(cat /pg/var/vfs_rcs)

  variable /pg/var/vfs_rcsl "2"
  vfs_rcsl=$(cat /pg/var/vfs_rcsl)

  variable /pg/var/vfs_cm "off"
  vfs_cm=$(cat /pg/var/vfs_cm)

  variable /pg/var/vfs_cms "100"
  vfs_cms=$(cat /pg/var/vfs_cms)

  randomagent=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1)

  variable /pg/var/uagent "$randomagent"
  uagent=$(cat /pg/var/uagent)
}
