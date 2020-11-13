#!/bin/bash
#
# Title:      Reference Title File - PGBlitz
# Author(s):  Admin9705 & https://github.com/PGBlitz/PGClone/graphs/contributors
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
# NOTES
# Variables come from what's being called from deploytransfer.sh under functions
## BWLIMIT 9 and Lower Prevents Google 750GB Google Upload Ban
################################################################################
echo "Executing Transfer Process" >> /pg/logs/transfer.log
chmod 775 -R {{hdpath}}/transfer/
chown -R 1000:1000 {{hdpath}}/transfer/

touch /pg/logs/transfer.log
touch /pg/logs/.transfer_list
touch /pg/logs/.temp_list

basicpath="$(cat ${PGBLITZ_DIR}/var/server.hd.path)"
useragent="$(cat ${PGBLITZ_DIR}/var/uagent)"
bwg="$(cat ${PGBLITZ_DIR}/var/move.bw)"
bws="$(cat ${PGBLITZ_DIR}/var/blitz.bw)"

var3=$(cat ${PGBLITZ_DIR}/rclone/deployed.version)
if [[ "$var3" == "gd" ]]; then var4="gdrive"
elif [[ "$var3" == "gc" ]]; then var4="gdrive"
elif [[ "$var3" == "sd" ]]; then var4="sdrive"
elif [[ "$var3" == "sd" ]]; then var4="sdrive"; fi

filecount=$(wc -l /pg/logs/.transfer_list | awk '{print $1}')
echo "$filecount" > ${PGBLITZ_DIR}/var/filecount

if [[ "$filecount" -gt 8 ]]; then
echo "Max Files of [8] Files - Pending Transfer" >> /pg/logs/transfer.log
echo "Exiting Cycle" >> /pg/logs/transfer.log
exit; fi

find /pg/transfer/ -type f > /pg/logs/.temp_list

while read p; do
  sed -i "/^$p\b/Id" /pg/logs/.temp_list
done </pg/logs/.transfer_list

head -n +1 /pg/logs/.temp_list >> /pg/logs/.transfer_list
uploadfile=$(head -n +1 /pg/logs/.temp_list)

if [[ "$uploadfile" == "" ]]; then
echo "Nothing To Upload" >> /pg/logs/transfer.log
exit; fi

chown 1000:1000 "$uploadfile"
chmod 775 "$uploadfile"

  totalchar=$(echo "${basicpath}" | awk -F"/" '{print NF-1}')
  finalcount=$((totalchar + 3))

  echo "Preparing to Upload: $uploadfile" >> /pg/logs/transfer.log
  truepath=$(echo $uploadfile | cut -d'/' -f${finalcount}-)

if [[ "$var4" == "gdrive" ]]; then
  echo "Started Upload - $var3: $uploadfile" >> /pg/logs/transfer.log
  udrive=$(cat ${PGBLITZ_DIR}/rclone/deployed.version)

    rclone move "$uploadfile" "$udrive:/$truepath" \
    --config ${PGBLITZ_DIR}/rclone/blitz.conf \
    --log-file=/pg/logs/transfer.log \
    --log-level INFO --stats 5s --stats-file-name-length 0 \
    --tpslimit 6 \
    --checkers=20 \
    --min-age=30s \
    --bwlimit="$bwg"M \
    --user-agent="$useragent" \
    --drive-chunk-size={{dcs}} \
    --exclude="**_HIDDEN~" --exclude="*partial~"  \
    --exclude=".fuse_hidden**" --exclude="**.grab/**"
else
  echo "Started Shared Upload - $var3: $uploadfile" >> /pg/logs/transfer.log
  readykey=$(cat ${PGBLITZ_DIR}/rclone/currentkey)
  uread=$(cat ${PGBLITZ_DIR}/rclone/deployed.version)
  encryptbit=""
  if [[ "$uread" == "sc" ]]; then encryptbit="C"; fi

    rclone move "$uploadfile" "${readykey}${encryptbit}:/$truepath" \
    --config ${PGBLITZ_DIR}/rclone/blitz.conf \
    --log-file=/pg/logs/pgblitz.log \
    --log-level INFO --stats 5s --stats-file-name-length 0 \
    --tpslimit 12 \
    --checkers=20 \
    --min-age=30s \
    --transfers=16 \
    --bwlimit="$bws"M \
    --user-agent="$useragent" \
    --drive-chunk-size={{dcs}} \
    --exclude="**_HIDDEN~" --exclude=".unionfs/**" \
    --exclude="**partial~" --exclude=".unionfs-fuse/**" \
    --exclude=".fuse_hidden**" --exclude="**.grab/**"
fi

grep -v "$uploadfile" "/pg/logs/.transfer_list" | sponge "/pg/logs/.transfer_list"
exit
