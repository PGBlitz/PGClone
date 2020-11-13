#!/bin/bash
#
# Title:      Reference Title File - PGBlitz
# Author(s):  Admin9705 & https://github.com/PGBlitz/PGClone/graphs/contributors
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
  touch /pg/logs/gd.log /pg/logs/sd.log /pg/logs/ge.log /pg/logs/se.log /pg/logs/pgblitz.log /pg/logs/transport.log

  variable ${PGBLITZ_DIR}/var/project.account "NOT-SET"
  variable ${PGBLITZ_DIR}/rclone/deploy.version "null"
  variable ${PGBLITZ_DIR}/rclone/pgclone.transport "NOT-SET"
  variable ${PGBLITZ_DIR}/var/move.bw  "9"
  variable ${PGBLITZ_DIR}/var/blitz.bw  "1000"
  variable ${PGBLITZ_DIR}/rclone/pgclone.salt ""
  variable ${PGBLITZ_DIR}/var/multihd.paths ""

  variable ${PGBLITZ_DIR}/var/server.hd.path "/pg"
  hdpath=$(cat ${PGBLITZ_DIR}/var/server.hd.path)

  variable ${PGBLITZ_DIR}/rclone/oauth.check ""
  oauthcheck=$(cat ${PGBLITZ_DIR}/rclone/oauth.check)

  variable ${PGBLITZ_DIR}/rclone/pgclone.password "NOT-SET"
  if [[ $(cat ${PGBLITZ_DIR}/rclone/pgclone.password) == "NOT-SET" ]]; then pstatus="NOT-SET"
  else
    pstatus="ACTIVE"
    clonepassword=$(cat ${PGBLITZ_DIR}/rclone/pgclone.password)
    clonesalt=$(cat ${PGBLITZ_DIR}/rclone/pgclone.salt)
  fi

  variable ${PGBLITZ_DIR}/rclone/.gd "NOT-SET"
  if [[ $(cat ${PGBLITZ_DIR}/rclone/.gd) == "NOT-SET" ]]; then gdstatus="NOT-SET"
  else gdstatus="ACTIVE"; fi

  variable ${PGBLITZ_DIR}/rclone/.sd "NOT-SET"
  if [[ $(cat ${PGBLITZ_DIR}/rclone/.sd) == "NOT-SET" ]]; then sdstatus="NOT-SET"
  else sdstatus="ACTIVE"; fi

  variable ${PGBLITZ_DIR}/rclone/.sc "NOT-SET"
  if [[ $(cat ${PGBLITZ_DIR}/rclone/.sc) == "NOT-SET" ]]; then scstatus="NOT-SET"
  else scstatus="ACTIVE"; fi

  variable ${PGBLITZ_DIR}/rclone/.gc "NOT-SET"
  if [[ $(cat ${PGBLITZ_DIR}/rclone/.gc) == "NOT-SET" ]]; then gcstatus="NOT-SET"
  else gcstatus="ACTIVE"; fi

  transport=$(cat ${PGBLITZ_DIR}/rclone/pgclone.transport)

  variable ${PGBLITZ_DIR}/rclone/pgclone.teamdrive "NOT-SET"
  sdname=$(cat ${PGBLITZ_DIR}/rclone/pgclone.teamdrive)

  variable ${PGBLITZ_DIR}/rclone/pgclone.demo "OFF"
  demo=$(cat ${PGBLITZ_DIR}/rclone/pgclone.demo)

  variable ${PGBLITZ_DIR}/rclone/pgclone.teamid ""
  sdid=$(cat ${PGBLITZ_DIR}/rclone/pgclone.teamid)

  variable ${PGBLITZ_DIR}/rclone/deploy.version ""
  type=$(cat ${PGBLITZ_DIR}/rclone/deploy.version)

  variable ${PGBLITZ_DIR}/rclone/pgclone.public ""
  pgclonepublic=$(cat ${PGBLITZ_DIR}/rclone/pgclone.public)

  mkdir -p ${PGBLITZ_DIR}/var/.blitzkeys
  displaykey=$(ls ${PGBLITZ_DIR}/var/.blitzkeys | wc -l)

  variable ${PGBLITZ_DIR}/rclone/pgclone.secret ""
  pgclonesecret=$(cat ${PGBLITZ_DIR}/rclone/pgclone.secret)

  if [[ "$pgclonesecret" == "" || "$pgclonepublic" == "" ]]; then pgcloneid="NOT-SET"; fi
  if [[ "$pgclonesecret" != "" && "$pgclonepublic" != "" ]]; then pgcloneid="ACTIVE"; fi

  variable ${PGBLITZ_DIR}/rclone/pgclone.email "NOT-SET"
  pgcloneemail=$(cat ${PGBLITZ_DIR}/rclone/pgclone.email)

  variable ${PGBLITZ_DIR}/var/oauth.type "NOT-SET" #output for auth type
  oauthtype=$(cat ${PGBLITZ_DIR}/var/oauth.type)

  variable ${PGBLITZ_DIR}/rclone/pgclone.project "NOT-SET"
  pgcloneproject=$(cat ${PGBLITZ_DIR}/rclone/pgclone.project)

  variable ${PGBLITZ_DIR}/rclone/deployed.version ""
  dversion=$(cat ${PGBLITZ_DIR}/rclone/deployed.version)

  variablet ${PGBLITZ_DIR}/var/.tmp.multihd
  multihds=$(cat ${PGBLITZ_DIR}/var/.tmp.multihd)

  if [[ "$dversion" == "gd" ]]; then dversionoutput="GDrive Unencrypted"
elif [[ "$dversion" == "gc" ]]; then dversionoutput="GDrive Encrypted"
elif [[ "$dversion" == "sd" ]]; then dversionoutput="SDrive Unencrypted"
elif [[ "$dversion" == "sc" ]]; then dversionoutput="SDrive Encrypted"
elif [[ "$dversion" == "le" ]]; then dversionoutput="Local HD/Mount"
else dversionoutput="None"; fi

# For Clone Clean
  variable ${PGBLITZ_DIR}/var/cloneclean "600"
  cloneclean=$(cat ${PGBLITZ_DIR}/var/cloneclean)

# Copy JSON if Missing
  if [ ! -e "${PGBLITZ_DIR}/rclone/pgclone.json" ]; then cp ${PGBLITZ_DIR}/pgclone.json ${PGBLITZ_DIR}/rclone/pgclone.json; fi

# For PG Blitz Mounts
  bs=$(jq -r '.bs' ${PGBLITZ_DIR}/rclone/pgclone.json)
  dcs=$(jq -r '.dcs' ${PGBLITZ_DIR}/rclone/pgclone.json)
  dct=$(jq -r '.dct' ${PGBLITZ_DIR}/rclone/pgclone.json)
  cma=$(jq -r '.cma' ${PGBLITZ_DIR}/rclone/pgclone.json)
  rcs=$(jq -r '.rcs' ${PGBLITZ_DIR}/rclone/pgclone.json)
  rcsl=$(jq -r '.rcsl' ${PGBLITZ_DIR}/rclone/pgclone.json)
  cm=$(jq -r '.cm' ${PGBLITZ_DIR}/rclone/pgclone.json)
  cms=$(jq -r '.cms' ${PGBLITZ_DIR}/rclone/pgclone.json)

  randomagent=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1)
  variable ${PGBLITZ_DIR}/var/uagent "$randomagent"
  uagent=$(cat ${PGBLITZ_DIR}/var/uagent)
}
