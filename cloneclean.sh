### Falls under PG Prune for Execution to Save Time & Sanity

# Outside Variables
dlpath=$(cat /var/plexguide/server.hd.path)

# Starting Actions
touch /var/plexguide/logs/pgblitz.log
mkdir -p "$dlpath/move"

# Permissions
chown -R 1000:1000 "$dlpath/move"
chmod -R 775 "$dlpath/move"

# Execution
find "{{hdpath}}/downloads" -mindepth 2 -mmin +666 -type d -size -100M -exec rm -rf {} \;
find "{{hdpath}}/move" -mindepth 2 -mmin +5 -type d -empty -delete
