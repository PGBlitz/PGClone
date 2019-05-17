### Falls under PG Prune for Execution to Save Time & Sanity

# Outside Variables
dlpath=$(cat /var/plexguide/server.hd.path)
cleaner="$(cat /var/plexguide/cloneclean)"

# Starting Actions
touch /var/plexguide/logs/pgblitz.log
mkdir -p "$dlpath/move"

# Permissions
chown -R 1000:1000 "$dlpath/move"
chmod -R 775 "$dlpath/move"

# Remove empty directories
find "$dlpath/move/" -type d -mmin +2 -empty -exec rm -rf {} \;

# Removes garbage
find "$dlpath/downloads" -mindepth 2 -type d -cmin +$cleaner -empty -exec rm -rf {} \;
find "$dlpath/downloads" -mindepth 2 -type f -cmin +$cleaner -size +1M -exec rm -rf {} \;
