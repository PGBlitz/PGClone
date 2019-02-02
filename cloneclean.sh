### Falls under PG Prune for Execution to Save Time & Sanity

# Outside Variables
dlpath=$(cat /var/plexguide/server.hd.path)

# Starting Actions
touch /var/plexguide/logs/pgblitz.log
mkdir -p "$dlpath/move"

# Permissions
chown -R 1000:1000 "$dlpath/move"
chmod -R 755 "$dlpath/move"

# Execution
find "$dlpath/downloads" -mindepth 2 -mmin +5 -type d -empty -delete \
  ! -path **nzbget** ! -path **sabnzbd** ! -path **qbittorrent** ! -path **deluge** \
  ! -path **rutorrent** ! -path **transmission** ! -path **jdownloader** ! -path **makemkv** \
  ! -path **handbrake**
find "$dlpath/downloads" -mindepth 3 -mmin +5 -type d -empty -delete
find "$dlpath/move" -mindepth 2 -mmin +5 -type d -empty -delete
