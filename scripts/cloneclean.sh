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
find "$dlpath/move/" -type d -mmin +2 -empty -exec rm -rf {} \;

# Removes garbage
find "$dlpath/downloads" -mindepth 2 -type d -cmin +$cleaner $(printf "! -name %s " $(cat /var/plexguide/exclude)) -empty -exec rm -rf {} \;
find "$dlpath/downloads" -mindepth 2 -type f -cmin +$cleaner $(printf "! -name %s " $(cat /var/plexguide/exclude)) -size -1000M -exec rm -rf {} \;
