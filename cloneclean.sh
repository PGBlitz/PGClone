### Falls under PG Prune for Execution to Save Time & Sanity

# Outside Variables
dlpath=$(cat /var/plexguide/server.hd.path)

# Starting Actions
touch /opt/appdata/plexguide/pgblitz.log
mkdir -p "$dlpath/pgblitz/upload"
mkdir -p "$dlpath/move"

# Permissions
chown -R 1000:1000 "$dlpath/move"
chown -R 1000:1000 "$dlpath/pgblitz/upload"
chmod -R 755 "$dlpath/move"
chown -R 755 "$dlpath/pgblitz/upload"

# Execution
find "$dlpath/downloads" -mindepth 2 ! -path **nzbget** ! -path **sabnzbd** ! -path **qbittorrent** ! -path **deluge** ! -path **rutorrent** ! -path **transmission** ! -path **jdownloader** ! -path **makemkv** ! -path **handbrake** -mmin +5 -type d -empty -delete
find "$dlpath/downloads" -mindepth 3 -mmin +5 -type d -empty -delete
find "$dlpath/move" -mindepth 2 -mmin +5 -type d -empty -delete
find "$dlpath/pgblitz/upload" -mindepth 1 -mmin +5 -type d -empty -delete
