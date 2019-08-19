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
  mkdir -p /pg/logs /pg/rclone
  touch /pg/logs/gd.log /pg/logs/sd.log /pg/logs/ge.log /pg/logs/se.log /pg/logs/pgblitz.log /pg/logs/pgmove.log

  variable /pg/var/project.account "NOT-SET"
  variable /pg/rclone/deploy.version "null"
  variable /pg/rclone/pgclone.transport "NOT-SET"
  variable /pg/var/move.bw  "9"
  variable /pg/var/blitz.bw  "1000"
  variable /pg/rclone/pgclone.salt ""

  variable /pg/var/server.hd.path "/mnt"
  hdpath=$(cat /pg/var/server.hd.path)

  variable /pg/rclone/oauth.check ""
  oauthcheck=$(cat /pg/rclone/oauth.check)

  variable /pg/rclone/pgclone.password "NOT-SET"
  if [[ $(cat /pg/rclone/pgclone.password) == "NOT-SET" ]]; then pstatus="NOT-SET"
  else
    pstatus="ACTIVE"
    clonepassword=$(cat /pg/rclone/pgclone.password)
    clonesalt=$(cat /pg/rclone/pgclone.salt)
  fi

  variable /pg/rclone/.gd "NOT-SET"
  if [[ $(cat /pg/rclone/.gd) == "NOT-SET" ]]; then gstatus="NOT-SET"
  else gstatus="ACTIVE"; fi

  variable /pg/rclone/.sd "NOT-SET"
  if [[ $(cat /pg/rclone/.sd) == "NOT-SET" ]]; then sdstatus="NOT-SET"
  else sdstatus="ACTIVE"; fi

  variable /pg/rclone/.sc "NOT-SET"
  if [[ $(cat /pg/rclone/.sc) == "NOT-SET" ]]; then scstatus="NOT-SET"
  else scstatus="ACTIVE"; fi

  variable /pg/rclone/.gc "NOT-SET"
  if [[ $(cat /pg/rclone/.gc) == "NOT-SET" ]]; then gcstatus="NOT-SET"
  else gcstatus="ACTIVE"; fi

  transport=$(cat /pg/rclone/pgclone.transport)

  variable /pg/rclone/pgclone.teamdrive "NOT-SET"
  tdname=$(cat /pg/rclone/pgclone.teamdrive)

  variable /pg/rclone/pgclone.demo "OFF"
  demo=$(cat /pg/rclone/pgclone.demo)

  variable /pg/rclone/pgclone.teamid ""
  tdid=$(cat /pg/rclone/pgclone.teamid)

  variable /pg/rclone/deploy.version ""
  type=$(cat /pg/rclone/deploy.version)

  variable /pg/rclone/pgclone.public ""
  pgclonepublic=$(cat /pg/rclone/pgclone.public)

  mkdir -p /pg/var/.blitzkeys
  displaykey=$(ls /pg/var/.blitzkeys | wc -l)

  variable /pg/rclone/pgclone.secret ""
  pgclonesecret=$(cat /pg/rclone/pgclone.secret)

  if [[ "$pgclonesecret" == "" || "$pgclonepublic" == "" ]]; then pgcloneid="NOT-SET"; fi
  if [[ "$pgclonesecret" != "" && "$pgclonepublic" != "" ]]; then pgcloneid="ACTIVE"; fi

  variable /pg/rclone/pgclone.email "NOT-SET"
  pgcloneemail=$(cat /pg/rclone/pgclone.email)

  variable /pg/var/oauth.type "NOT-SET" #output for auth type
  oauthtype=$(cat /pg/var/oauth.type)

  variable /pg/rclone/pgclone.project "NOT-SET"
  pgcloneproject=$(cat /pg/rclone/pgclone.project)

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
