### Falls under PG Prune for Execution to Save Time & Sanity

# Outside Variables
dlpath=$(cat /var/plexguide/server.hd.path)
cleaner="$(cat /var/plexguide/cloneclean)"

# Starting Actions
touch /var/plexguide/logs/pgblitz.log
mkdir -p "$dlpath/move"

# Repull excluded folder
wget -qN https://raw.githubusercontent.com/PGBlitz/PGClone/v8.6/functions/exclude -P /var/plexguide/

# Remove empty directories
find "$dlpath/move" -type d -mmin +2 -empty -exec rmdir {} \;
find "$dlpath/downloads" -mindepth 2 -type d -cmin +$cleaner -empty -exec rmdir {} \;

# nzb cleanup, delete files < 3G
find "$dlpath/downloads/sabnzbd" -mindepth 1 -type f -cmin +$cleaner -size -3G -exec rm -rf {} \;
find "$dlpath/downloads/nzbget" -mindepth 1 -type f -cmin +$cleaner -size -3G -exec rm -rf {} \;
