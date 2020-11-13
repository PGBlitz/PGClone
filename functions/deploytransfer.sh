#!/bin/bash
#
# Title:      Reference Title File - PGBlitz
# Author(s):  Admin9705 & https://github.com/PGBlitz/PGClone/graphs/contributors
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
# NOTES
# Variable recall comes from /functions/variables.sh
################################################################################
executetransport () {

# Reset Front Display
rm -rf  ${PGBLITZ_DIR}/rclone/deployed.version

# Call Variables
pgclonevars

# to remove all service running prior to ensure a clean launch
ansible-playbook ${PGBLITZ_DIR}/ymls/remove.yml

########################################################### GDRIVE START
echo "gd" > ${PGBLITZ_DIR}/rclone/deployed.version
type=gd
ansible-playbook ${PGBLITZ_DIR}/ymls/mount.yml -e "\
  bs=$bs
  dcs=$dcs
  dct=$dct
  cma=$cma
  rcs=$rcs
  rcsl=$rcsl
  drive=gd"
########################################################### GDRIVE END

########################################################### SDRIVE END
if [[ "$transport" == "gc" || "$transport" == "sc" || "$transport" == "sd" ]]; then
type=sd
echo "sd" > ${PGBLITZ_DIR}/rclone/deployed.version
encryptbit=""
ansible-playbook ${PGBLITZ_DIR}/ymls/mount.yml -e "\
  bs=$bs
  dcs=$dcs
  dct=$dct
  cma=$cma
  rcs=$rcs
  rcsl=$rcsl
  cm="writes"
  drive=sd"
fi
########################################################### SDRIVE END

########################################################### ENCRYTPION START
if [[ "$transport" == "gc" || "$transport" == "sc" ]]; then
echo "gc" > ${PGBLITZ_DIR}/rclone/deployed.version
type=gc
ansible-playbook ${PGBLITZ_DIR}/ymls/crypt.yml -e "\
  bs=$bs
  dcs=$dcs
  dct=$dct
  cma=$cma
  rcs=$rcs
  rcsl=$rcsl
  drive=gc"
fi

if [[ "$transport" == "sc" ]]; then
echo "sc" > ${PGBLITZ_DIR}/rclone/deployed.version
type=sc
encryptbit="C"
ansible-playbook ${PGBLITZ_DIR}/ymls/crypt.yml -e "\
  bs=$bs
  dcs=$dcs
  dct=$dct
  cma=$cma
  rcs=$rcs
  rcsl=$rcsl
  drive=sc"
fi
########################################################### ENCRYTPION END

# builds the list
if [[ "$transport" == "sd" || "$transport" == "sc" ]]; then
  ls -la ${PGBLITZ_DIR}/var/.blitzkeys/ | awk '{print $9}' | tail -n +4 | sort | uniq > ${PGBLITZ_DIR}/var/.blitzlist
  rm -rf ${PGBLITZ_DIR}/var/.blitzfinal 1>/dev/null 2>&1
  touch ${PGBLITZ_DIR}/var/.blitzbuild
  while read p; do
    echo $p > ${PGBLITZ_DIR}/var/.blitztemp
    blitzcheck=$(grep "GDSA" ${PGBLITZ_DIR}/var/.blitztemp)
    if [[ "$blitzcheck" != "" ]]; then echo $p >> ${PGBLITZ_DIR}/var/.blitzfinal; fi
  done <${PGBLITZ_DIR}/var/.blitzlist
fi

# deploy union
ansible-playbook ${PGBLITZ_DIR}/ymls/pgunity.yml -e "\
  transport=$transport
  encryptbit=$encryptbit
  multihds=$multihds
  type=$type
  dcs=$dcs
  hdpath=$hdpath"

# output final display
if [[ "$type" == "gd" ]]; then finaldeployoutput="GDrive Unencrypted"
elif [[ "$type" == "gc" ]]; then finaldeployoutput="GDrive Encrypted"
elif [[ "$type" == "sd" ]]; then finaldeployoutput="SDrive Unencrypted"
elif [[ "$type" == "sc" ]]; then finaldeployoutput="SDrive Encrypted"; fi
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 DEPLOYED: $finaldeployoutput
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

read -rp '↘️  Acknowledge Info | Press [ENTER] ' typed < /dev/tty

}
