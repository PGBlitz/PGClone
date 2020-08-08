#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Authors:    Admin9705, Deiteq, and many PGBlitz Contributors
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

### NOTE TO DELETE KEYS THAT EXIST WHEN BACKING UP
keybackup() {
  tree -d -L 1 /mnt/gdrive/plexguide/backup | awk '{print $2}' | tail -n +2 | head -n -2 >/tmp/server.list
  servers=$(cat /tmp/server.list)
  server_id=$(cat /var/plexguide/server.id)

  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Server Name for Backup
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📂 Current [${server_id}] & Prior Servers Detected:

$servers

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  read -p '🌍 Type Server Name | Press [ENTER]: ' server </dev/tty
  echo $server >/tmp/server.select
  idbackup=$(cat /tmp/server.select)

  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Backing Up to GDrive - $idbackup
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTE: Standby, takes a minute!

EOF
  mkdir -p /tmp/backup/
  tar --warning=no-file-changed --ignore-failed-read --absolute-names --warning=no-file-removed -C /opt/appdata/plexguide/ -czf /tmp/backup/plexguide-backup.tar.gz ./

  rclone moveto /tmp/backup/ gdrive:/plexguide/system/$idbackup \
   --config=/opt/appdata/plexguide/rclone.conf \
   --stats-one-line \
   --log-level=INFO --stats=5s --stats-file-name-length=0 \
   --tpslimit=10 \
   --checkers=4 \
   --transfers=4 \
   --no-traverse \
   --fast-list \
   --exclude="*traefik.check*" \
   --user-agent="key_backup:pts"

  rm -rf /tmp/backup/*
   
 tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Backup Complete!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

  read -p '🌍 Acknowledge Info | Press [ENTER] ' typed2 </dev/tty
  clonestart
}


########################### 
####restore keys rclone.conf GDSA keys
########################### 

# keyrestore() {
  # tree -d -L 1 /mnt/gdrive/plexguide/backup | awk '{print $2}' | tail -n +2 | head -n -2 >/tmp/server.list
  # servers=$(cat /tmp/server.list)
  # server_id=$(cat /var/plexguide/server.id)

  # tee <<-EOF

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 🚀 System Message: Server Name for Restore
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# 📂 Current [${server_id}] & Prior Servers Detected:

# $servers

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# EOF
  # read -p '🌍 Type Server Name | Press [ENTER]: ' server </dev/tty
  # echo $server >/tmp/server.select
  # idbackup=$(cat /tmp/server.select)

  # tee <<-EOF

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 🚀 System Message: Restore from GDrive - $idbackup
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# NOTE: Standby, takes a minute!

# EOF
  # rclone copyto gdrive:/plexguide/system/$idbackup /tmp/backup/ \
   # --config=/opt/appdata/plexguide/rclone.conf \
   # --stats-one-line \
   # --log-level=INFO --stats=5s --stats-file-name-length=0 \
   # --tpslimit=10 \
   # --checkers=4 \
   # --transfers=4 \
   # --no-traverse \
   # --fast-list \
   # --exclude="*traefik.check*" \
   # --user-agent="key_backup:pts"
  # mkdir -p /tmp/backup/ 
  # mkdir -p /opt/appdata/plexguide/
  # tar -C /opt/appdata/plexguide/ -xvf /tmp/backup/plexguide-backup.tar.gz
  # chown -cR 1000:1000 /opt/appdata/plexguide/*
  # rm -rf /tmp/backup/*

 # tee <<-EOF
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 🚀 System Message: Key Restoration Complete!
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# NOTE: When conducting a restore, no need to share out emails and etc! Just
# redeploy rClone!

# EOF
  # read -p '🌍 Acknowledge Info | Press [ENTER] ' typed2 </dev/tty
  # clonestart
# }
